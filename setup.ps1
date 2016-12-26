#Set the following line manually to make our script accessable
#Set-ExecutionPolicy Unrestricted


Write-Host '#########################Set-ExecutionPolicy Unrestricted#########################'

param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}

Write-Host '#########################Now running as Administrator#########################'

# Install Choco
'Install Chocolate package manager'
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install needed packages for general purposes
Write-Host '#########################Install packages for general purposes#########################'
choco upgrade googlechrome -y
choco upgrade 7zip.install -y
choco upgrade notepadplusplus -y
choco upgrade paint.net -y
choco upgrade pidgin -y
choco upgrade keepass -y
choco upgrade libreoffice -y
choco upgrade thunderbird -y
choco upgrade everything -y

# Install needed packages for development
Write-Host '#########################Install packages for development#########################'
choco upgrade heidisql -y
choco upgrade mysql.workbench -y
choco upgrade phpstorm -y
choco upgrade virtualbox -y
choco upgrade vagrant -y
choco upgrade vim -y
choco upgrade git -y
choco upgrade git-credential-winstore -y
choco upgrade filezilla -y
choco upgrade putty -y
choco upgrade pgadmin4 -y
choco upgrade nodejs -y
choco upgrade python -y
choco upgrade poshgit -y


# Install chrome extensions
Write-Host '#########################Install chrome extensions#########################'
choco upgrade postman -y
choco upgrade adblockpluschrome -y

# Reload path 
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$env:path += ";" + (Get-Item "Env:ProgramFiles").Value + "\Git\bin"
$env:path += ";" + (Get-Item "Env:ProgramFiles").Value + "\Git\usr\bin"

######################################################
# Configure Git globals
######################################################
Write-Host "#########################Configuring Git globals#########################"
$userName = Read-Host 'Enter your name for git configuration'
$userEmail = Read-Host 'Enter your email for git configuration'

& 'C:\Program Files (x86)\Git\bin\git' config --global user.email $userEmail
& 'C:\Program Files (x86)\Git\bin\git' config --global user.name $userName

######################################################
# Install npm packages
######################################################
Write-Host ""#########################Install NPM packages"#########################"
npm install -g gulp bower
Write-Host

Write-Host '#########################Now updating and configuring vim#########################'
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
vim +PluginInstall +qall

Write-Host '#########################Starting chrome and calling puphpet.com, go ahead and download your VM#########################'
start chrome "https://puphpet.com/"

# List all packages that just have been installed / upgraded
choco list -lo

Write-Host '#########################Downloading .vimrc and PHPStormSettings and move them to ~/temp#########################'

New-Item -ItemType Directory -Force -Path $ENV:UserProfile\temp
(Invoke-WebRequest -OutFile "$ENV:UserProfile\temp\.vimrc" -UseBasicParsing -URI "https://raw.githubusercontent.com/Xatenev/x-settings/master/.vimrc").Content
(Invoke-WebRequest -OutFile "$ENV:UserProfile\temp\PHPStormSettings" -UseBasicParsing -URI "https://github.com/Xatenev/x-settings/blob/master/PhpStormSettings?raw=true").Content

######################################################
# Generate public/private rsa key pair
######################################################
Write-Host "'#########################Generating public/private rsa key pair'#########################"
Set-Location $home
$dirssh = "$home\.ssh"
mkdir $dirssh
$filersa = $dirssh + "\id_rsa"
ssh-keygen -t rsa -f $filersa -q -C $userEmail


Write-Host '#########################Setup has finished succesful. Have fun developing xatenev#########################'
#use appropriate install dir (--install-dir)
#we need pro version for this sadly.

Write-Host '#########################Steps to take now: go to ~/temp and move .vimrc and PHPStormSettings | Use puttygen.exe to generate a pub/priv key#########################'