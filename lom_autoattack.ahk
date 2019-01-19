#maxThreadsPerHotkey, 2

$f12::
	isActive:=!isActive
	
	while (isActive=1)
	{
            Send +{Click}
	}
return