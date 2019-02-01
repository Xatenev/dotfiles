#MaxThreadsPerHotkey 2

$F12::
	Toggle := !Toggle
	while Toggle
	{
		Send, {F6 Down}
    	Sleep, 50
    	Send, {F6 Up}
	}
return