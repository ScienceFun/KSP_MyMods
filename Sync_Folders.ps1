﻿[bool]$updateGame = $False # If true, it will update Game folder, if false will update Project folder

$foldersCFG = @(`
    "Bluedog_DB" `
    ,"Bluedog_DB_Extras" `
    ,"Chatterer" `
    ,"KerbalEngineer" `
    ,"PlayYourWay" `
	,"SETIcontracts" `
    ,"SETIprobeParts" `
    ,"RSSVE" `
	,"UnmannedBeforeManned"`
    )

$foldersALL = @(`
	"KSP_FOV" `
    )

if($updateGame)
{    
    foreach($folder in $foldersCFG)
    {
        $path = [System.Environment]::GetEnvironmentVariable("KSPGAMEDATA","Machine") + "\" + $folder
    	robocopy .\$folder $path /MIR /FFT /Z /XA:H /W:5
    }
    
    foreach($folder in $foldersALL)
    {
        $path = [System.Environment]::GetEnvironmentVariable("KSPGAMEDATA","Machine") + "\" + $folder
    	robocopy .\$folder $path /MIR /FFT /Z /XA:H /W:5
    }
}
else
{
    foreach($folder in $foldersCFG)
    {
        $path = [System.Environment]::GetEnvironmentVariable("KSPGAMEDATA","Machine") + "\" + $folder
    	robocopy $path .\$folder /MIR /FFT /Z /XA:H /W:5
    }
    
    foreach($folder in $foldersALL)
    {
        $path = [System.Environment]::GetEnvironmentVariable("KSPGAMEDATA","Machine") + "\" + $folder
    	robocopy $path .\$folder /MIR /FFT /Z /XA:H /W:5
    }
}