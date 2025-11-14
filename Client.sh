#!/bin/bash
#PORTAL_PASSWORD=""
PORTAL_USERNAME=""
#PORTAL_USERNAME=""
#PORTAL_USERNAME=""
PORTAL_HOSTNAME=""
PORTAL_PORT=9898
#PORTAL_USERNAME=""
PORTAL_PASSWORD=""
S2S_Ubuntu=5.8.22.2748
S2S_Centos=5.8.22.2748
S2S_Windows=5.8.22.2748
RED='\033[0;31m'      # Red color
GREEN='\033[0;32m'    # Green color
YELLOW='\033[0;33m'   # Yellow color
RESET='\033[0m'        # Reset text color
SEA_GREEN='\033[0;36m'


#Downloading Package for Ubuntur
echo -e "${GREEN}Ubuntu Package(DEB+LIC) Downloading Is In Progress.....${RESET}"
sleep 2.5
VERSION=$S2S_Ubuntu
AMD_CONTROLLER="invisily-client_amd64_ubuntu_server_s2s-$VERSION.deb"
AMD_CONTROLLER_SIGN="invisily-client_amd64_ubuntu_server_s2s-$VERSION.deb.sign"
AMD_CONTROLLER_DL="https://demo-Numeo.com:8084/repository/Numeo-Production-Releases/clients/ubuntu/server_s2s/$VERSION/$AMD_CONTROLLER"
AMD_CONTROLLER_SIGN_DL="https://demo-Numeo.com:8084/repository/Numeo-Production-Releases/clients/ubuntu/server_s2s/$VERSION/$AMD_CONTROLLER_SIGN"
#https://demo-Numeo.com:8084/repository/Numeo-Production-Releases/clients/ubuntu/server_s2s/5.4.0.1233/invisily-client_amd64_ubuntu_server_s2s-5.4.0.1233.deb
sleep 1
wget --user "fareed.ahmad" --password "Numeo123!" -N "$artPass" "$AMD_CONTROLLER_DL" # its not working with variable but plain text.
wget --user "fareed.ahmad" --password "Numeo123!" -N "$artPass" "$AMD_CONTROLLER_SIGN_DL"
echo -e "${YELLOW}Ubuntu S2S Package(DEB+LIC) Download was Successfully${RESET}"

#Download Package for CentOS

#Downloading Package for Ubuntu
echo -e "${GREEN}CentOS Package(DEB+LIC) Downloading Is In Progress.....${RESET}"

sleep 2.5
AMD_CENTOS="invisily-client_amd64_centos_server_s2s-$S2S_Centos.rpm"
AMD_CENTOS_SIGN="invisily-client_amd64_centos_server_s2s-$S2S_Centos.rpm.sign"
AMD_CENTOS_DL="https://demo-Numeo.com:8084/repository/Numeo-Production-Releases/clients/centos/server_s2s/$S2S_Centos/$AMD_CENTOS"
AMD_CENTOS_SIGN_DL="https://demo-Numeo.com:8084/repository/Numeo-Production-Releases/clients/centos/server_s2s/$S2S_Centos/$AMD_CENTOS_SIGN"

#https://demo-Numeo.com:8084/repository/Numeo-Production-Releases/clients/centos/server_s2s/5.4.0.1233/invisily-client_amd64_centos_server_s2s-5.4.0.1233.rpm
sleep 1
	#echo -e  "${RED} $AMD_CENTOS_DL${RESET}"
#echo "$S2S_Centos"
#echo -e  "$AMD_CENTOS_SIGN_DL"
wget --user "fareed.ahmad" --password "Numeo123!" -N "$artPass" "$AMD_CENTOS_DL" # its not working with variable but plain text.
wget --user "fareed.ahmad" --password "Numeo123!" -N "$artPass" "$AMD_CENTOS_SIGN_DL"
echo -e "${YELLOW}CentOS S2S Package(DEB+LIC) Download was Successfully${RESET}"

#Downloading Package for Windows_S2S
sleep 2.5
VERSION=$S2S_Windows
AMD_WINDOWS="invisily-client-windows-s2s-$VERSION.exe"
AMD_WINDOWS_SIGN="invisily-client-windows-s2s-$VERSION.exe.sign"
AMD_WINDOWS_DL="https://demo-Numeo.com:8084/repository/Numeo-Production-Releases/clients/windows/s2s_server/$VERSION/$AMD_WINDOWS"
AMD_WINDOWS_SIGN_DL="https://demo-Numeo.com:8084/repository/Numeo-Production-Releases/clients/windows/s2s_server/$VERSION/$AMD_WINDOWS_SIGN"
#https://demo-Numeo.com:8084/repository/Numeo-Production-Releases/clients/ubuntu/server_s2s/5.4.0.1233/invisily-client_amd64_ubuntu_server_s2s-5.4.0.1233.deb
echo -e "${SEA_GREEN}Windows S2S Package(DEB+LIC) Downloading Are In Progress....${RESET}"
sleep 1

#https://demo-Numeo.com:8084/repository/Numeo-Production-Releases/clients/windows/s2s_server/5.4.0.1233/invisily-client-windows-s2s-5.4.0.1233.exe

wget --user "fareed.ahmad" --password "Numeo123!" -N  "$AMD_WINDOWS_DL" # its not working with variable but plain text.
wget --user "fareed.ahmad" --password "Numeo123!" -N  "$AMD_WINDOWS_SIGN_DL"
echo -e "${YELLOW}Windows S2S Package(DEB+LIC) Download was Successfully${RESET}"


AMD_Ubuntu="invisily-client_amd64_ubuntu_server_s2s-$S2S_Ubuntu.deb"
AMD_Ubuntu_Sign="invisily-client_amd64_ubuntu_server_s2s-$S2S_Ubuntu.deb.sign"

AMD_CentOS="invisily-client_amd64_centos_server_s2s-$S2S_Centos.rpm"
AMD_CentOS_Sign="invisily-client_amd64_centos_server_s2s-$S2S_Centos.rpm.sign"


#Uploading S2S Client
function s2s_server_uploading()
{
 s2s_version=$1
 s2s_package_file=$2
 s2s_sign_file=$3
 s2s_os=$4
 s2s_file_type=$5
 DEB_FILE_BASE=$(base64 $s2s_package_file) #S2S FILE NAME (S2S_PACKAGE)
 SIGN_FILE_BASE=$(base64 $s2s_sign_file) #S2S SIGN FILE NAME (S2S_SIGN_FILE)
 cat > ubuntu.json <<END
{
  "update": {
    "buildOs": "$s2s_os",
    "buildVersion": "$s2s_version",
    "buildComponent": "s2s-client",
    "description": "$s2s_version",
    "is_settings_changed": false
  },
  "attachment": {
    "data": "data:application/octet-stream;base64,$DEB_FILE_BASE", 
    "name": "$s2s_package_file",
    "type": "$s2s_file_type"
  },
  "sigFileData": {
    "data": "data:application/octet-stream;base64,$SIGN_FILE_BASE",
    "name": "$s2s_sign_file",
    "type": "sign"
  }
}
END
  cat > auth.json <<END
{"username":"$PORTAL_USERNAME","password":"$PORTAL_PASSWORD"}
END
  AUTH_TOKEN=$(curl -v https://"$PORTAL_HOSTNAME":"$PORTAL_PORT"/api/authentication -H 'Connection: keep-alive' -H 'sec-ch-ua: "Chromium";v="92", " Not A;Brand";v="99", "Google Chrome";v="92"' -H 'Accept: application/json, text/plain, */*' -H 'sec-ch-ua-mobile: ?0' -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36" -H 'Content-Type: application/json' -H 'Origin: https://"$PORTAL_HOSTNAME":"$PORTAL_PORT"' -H 'Sec-Fetch-Site: same-origin' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Dest: empty' -H 'Referer: https://"$PORTAL_HOSTNAME":"$PORTAL_PORT"/web/login' -H 'Accept-Language: en-US,en;q=0.9' -d @auth.json --compressed --insecure | awk -F ":" '{print $4}' | awk -F "," '{print $1}' | tr -d '"')
 
 #AUTH_TOKEN=$(curl -s -k https://"$PORTAL_HOSTNAME":"$PORTAL_PORT"/api/authentication \
  #-H 'Content-Type: application/json' \
  #-d @auth.json | jq -r '.token')
 echo "$AUTH_TOKEN"
# RESPONSE=$(curl -s -k https://"$PORTAL_HOSTNAME":"$PORTAL_PORT"/api/authentication \
#  -H 'Content-Type: application/json' \
#  -d @auth.json)
#echo "$RESPONSE"

  curl -v -k https://"$PORTAL_HOSTNAME":"$PORTAL_PORT"/api/updates -H "Authorization: Bearer $AUTH_TOKEN" -H "Content-Type: application/json" --data @ubuntu.json
  ##########################################################################################
  curl -v -k "https://${PORTAL_HOSTNAME}:${PORTAL_PORT}/api/templates/user" \
  -H "Authorization: Bearer $AUTH_TOKEN" \
  -H "Content-Type: application/json"

}

echo "$result"
s2s_server_uploading "$VERSION" "$AMD_WINDOWS" "$AMD_WINDOWS_SIGN" "windowsserver" "$S2S_Windows"
s2s_server_uploading "$S2S_Ubuntu" "$AMD_Ubuntu" "$AMD_Ubuntu_Sign" "ubuntuserver18"  "deb"
s2s_server_uploading "$S2S_Centos" "$AMD_CentOS" "$AMD_CentOS_Sign" "centosserver"  "rpm" #Version #File_name(.deb,,exe,.rpm) #sign_file_name #server_type #DEB_or_EXE_or_RPM_extension
