[bool]$updateGame = $False # If $True, it will update Game folder, if $False will update Project folder

$foldersCFG = @(`
    "Bluedog_DB" `
    ,"Bluedog_DB_Extras" `
    ,"Chatterer" `
    ,"KSP_FOV" `
    ,"KerbalEngineer" `
    ,"KSP-1.4-Fixes" `
    ,"TweakScale" `
    ,"PlayYourWay" `
    ,"PlanetShine" `
    ,"scatterer" `
	,"SETIcontracts" `
    ,"SETIprobeParts" `
    ,"RSSVE" `
	,"UnmannedBeforeManned"`
    )

$path = [System.Environment]::GetEnvironmentVariable("KSPGAMEDATA","Machine")

# Delete all MiniAVC.dll
Get-ChildItem -Path $path -Include MiniAVC.dll -File -Recurse | foreach { $_.Delete()}  

if($updateGame)
{    
    foreach($folder in $foldersCFG)
    {
        $path = [System.Environment]::GetEnvironmentVariable("KSPGAMEDATA","Machine") + "\" + $folder
        
        If (!(Test-Path $path)) 
        {
            New-Item -Path $path -ItemType Directory
        } 

    	robocopy .\$folder $path /MIR /FFT /Z /XA:H /W:5
    }
}
else
{
    foreach($folder in $foldersCFG)
    {
        $path = [System.Environment]::GetEnvironmentVariable("KSPGAMEDATA","Machine") + "\" + $folder
        
        If (!(Test-Path $folder)) 
        {
            New-Item -Path $folder -ItemType Directory
        } 
    	robocopy $path .\$folder /MIR /FFT /Z /XA:H /W:5
    }
}

$path = [System.Environment]::GetEnvironmentVariable("KSPGAMEDATA","Machine") 
$dir = dir $path -Directory -recurse | where {-NOT $_.GetFiles("*","AllDirectories")} | select -expandproperty FullName
$dir | ForEach-Object { Remove-Item $_ }
