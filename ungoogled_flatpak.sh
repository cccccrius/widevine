#simple script to install widevine in ungoogled-chromium flatpak - tested Ubuntu 24.10
#crius 2025

cd /tmp

VERSION=$(curl https://dl.google.com/widevine-cdm/versions.txt | tail -n1)

wget @ "https://dl.google.com/widevine-cdm/${VERSION}-linux-x64.zip"

DIRONE="/var/lib/flatpak/app/io.github.ungoogled_software.ungoogled_chromium/current/active/files/chromium/WidevineCdm/_platform_specific/linux_x64"

DIRTWO="/var/lib/flatpak/app/io.github.ungoogled_software.ungoogled_chromium/current/active/files/chromium/WidevineCdm"

sudo mkdir -p $DIRONE

sudo unzip -d $DIRTWO ${VERSION}-linux-x64.zip

sudo mv $DIRTWO/libwidevinecdm.so $DIRONE/libwidevinecdm.so

sudo chmod 644 $DIRONE/libwidevinecdm.so

sudo mv $DIRTWO/LICENSE.txt $DIRTWO/LICENSE

sudo chmod 644 $DIRTWO/LICENSE

sudo chmod 644 $DIRTWO/manifest.json
