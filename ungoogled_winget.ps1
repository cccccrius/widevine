#widevine Windows install for ungoogled installed trought winget

$CHROMEDIR="$env:localappdata\Chromium\Application"

$CHROMEVERSION=$(gci -directory "$CHROMEDIR" -exclude "Dictionaries" | sort -Property LastWriteTime -Descending | select -First 1).Name

$OUTFILE=$env:temp + "\version.txt"

$WEBFILE="https://dl.google.com/widevine-cdm/versions.txt"

Invoke-WebRequest $WEBFILE -OutFile $OUTFILE

$VERSION = $(get-content $OUTFILE | select -last 1)

$OUTZIP=$env:temp + "\$VERSION-win-x64.zip"

Invoke-WebRequest "https://dl.google.com/widevine-cdm/$VERSION-win-x64.zip" -OutFile $OUTZIP

$WIDEVINEDIR1="$CHROMEDIR\$CHROMEVERSION\WidevineCdm\_platform_specific\win_x64"

$WIDEVINEDIR2="$CHROMEDIR\$CHROMEVERSION\WidevineCdm\"

New-Item -ItemType Directory -Path $WIDEVINEDIR1 -force

Expand-Archive -LiteralPath $OUTZIP -DestinationPath $WIDEVINEDIR2 -force

$DLLS = gci -Path $WIDEVINEDIR2 -filter "*.dll*" -file

foreach ($i in $DLLS) {
     Move-Item $WIDEVINEDIR2\$i -Destination $WIDEVINEDIR1 -force
}

remove-item $OUTZIP -force

remove-item $OUTFILE -force

#chrome://settings/content/protectedContent
