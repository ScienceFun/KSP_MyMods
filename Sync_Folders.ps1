# $True:  Update GameData folder
# $False: Update Project folder
[bool]$updateGame = $True 
                          
$foldersCFG = @(`
    "Bluedog_DB" `
    ,"Bluedog_DB_Extras" `
    ,"PlayYourWay" `
    ,"PlanetShine" `
    ,"scatterer" `
	,"SETIcontracts" `
    ,"SETIprobeParts" `
    ,"RSSVE" `
	,"UnmannedBeforeManned"`
    ,"TweakScale" `
    )

$foldersALL = @(`
	"KSP_FOV" `
    ,"Chatterer" `
    ,"KSP-1.4-Fixes" `
    ,"WheelSounds" `
    )

$GameData = [System.Environment]::GetEnvironmentVariable("KSPGAMEDATA","Machine")

# Delete all MiniAVC.dll & MiniAVC.xml
Get-ChildItem -Path $GameData -Include MiniAVC.dll -File -Recurse | foreach { $_.Delete()}  
Get-ChildItem -Path $GameData -Include MiniAVC.xml -File -Recurse | foreach { $_.Delete()}  

if($updateGame)
{    
    foreach($folder in $foldersCFG)
    {
        $path = $GameData + "\" + $folder
        
        If (!(Test-Path $path)) 
        {
            New-Item -Path $path -ItemType Directory
        } 

    	robocopy .\$folder $path *.cfg *.version /MIR /FFT /Z /XA:H /W:5
    }

    foreach($folder in $foldersALL)
    {
        $path = $GameData + "\" + $folder

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
        $path = $GameData + "\" + $folder
        
        If (!(Test-Path $folder)) 
        {
            New-Item -Path $folder -ItemType Directory
        } 

    	robocopy $path .\$folder *.cfg *.version /MIR /FFT /Z /XA:H /W:5
    }

    foreach($folder in $foldersALL)
    {
        $path = $GameData + "\" + $folder

        If (!(Test-Path $path)) 
        {
            New-Item -Path $path -ItemType Directory
        } 

	    robocopy $path .\$folder /MIR /FFT /Z /XA:H /W:5
    }
}

# Delete Empty Folders GameData
$dir = dir $GameData -Directory -recurse | where {-NOT $_.GetFiles("*","AllDirectories")} | select -expandproperty FullName
$dir | ForEach-Object { Remove-Item $_ –recurse}

# Delete Empty Folders Project Folder
$dir = dir ".\" -Directory -recurse | where {-NOT $_.GetFiles("*","AllDirectories")} | select -expandproperty FullName
$dir | ForEach-Object { Remove-Item $_ –recurse}