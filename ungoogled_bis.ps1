
winget install eloston.ungoogled-chromium

New-Item -ItemType Directory -Path "$env:TEMP\WD" | out-null
Set-Location -Path "$env:TEMP\WD"
$versionT = $($(Invoke-WebRequest -Uri "https://dl.google.com/widevine-cdm/versions.txt").Content)
$versionT = $versionT -split "`n"
$version=$versionT[$versionT.Length-2]
$url="https://dl.google.com/widevine-cdm/"+$version+"-win-x64.zip"
$file=$env:TEMP+"\WD\"+$version+"-win-x64.zip"
Invoke-WebRequest -Uri $url -OutFile $file

$build = $(Get-ChildItem -Directory $env:LOCALAPPDATA\Chromium\Application | Where-Object {$_.Name -match "^[0-9]{3}\."} | Select-Object -Last 1).Name
$folder = "$env:LOCALAPPDATA\Chromium\Application\"+$build+"\WidevineCdm\_platform_specific\win_x64"
$folderB = "$env:LOCALAPPDATA\Chromium\Application\"+$build+"\WidevineCdm"
New-Item -ItemType Directory -Path $folder | out-null

Expand-Archive -Path $file -DestinationPath $folder

Remove-Item -Path "$folder\widevinecdm.dll.lib"
Move-Item -Path "$folder\manifest.json" -Destination "$folderB\manifest.json"
Move-Item -Path "$folder\LICENSE.txt" -Destination "$folderB\LICENSE"

Remove-Item -Path $env:TEMP+"\WD" -recurse -force
