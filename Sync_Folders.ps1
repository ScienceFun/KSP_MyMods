[bool]$updateGame = $False # If $True, it will update Game folder, if $False will update Project folder

$foldersCFG = @(`
    "Bluedog_DB" `
    ,"Bluedog_DB_Extras" `
    ,"Chatterer" `
    ,"KerbalEngineer" `
    ,"TweakScale" `
    ,"PlayYourWay" `
    ,"PlanetShine" `
	,"SETIcontracts" `
    ,"SETIprobeParts" `
    ,"RSSVE" `
	,"UnmannedBeforeManned"`
    )

$foldersALL = @(`
	"KSP_FOV" `
    )

$path = [System.Environment]::GetEnvironmentVariable("KSPGAMEDATA","Machine")

# Delete all MiniAVC.dll
Get-ChildItem -Path $path -Include MiniAVC.dll -File -Recurse | foreach { $_.Delete()}  

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