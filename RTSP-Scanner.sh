#!/bin/bash 

####################################
# RTSP SCANNER                     #
#                                  #
# Coded by Mr.Doel                 #
# Contact me : doel@mc-crew.or.id  #
####################################

#   _____         .__                          _________        ___.                  _________                        
#  /     \ _____  |  | _____    ____    ____   \_   ___ \___.__.\_ |__   ___________  \_   ___ \_______   ______  _  __
# /  \ /  \\__  \ |  | \__  \  /    \  / ___\  /    \  \<   |  | | __ \_/ __ \_  __ \ /    \  \/\_  __ \_/ __ \ \/ \/ /
#/    Y    \/ __ \|  |__/ __ \|   |  \/ /_/  > \     \___\___  | | \_\ \  ___/|  | \/ \     \____|  | \/\  ___/\     / 
#\____|__  (____  /____(____  /___|  /\___  /   \______  / ____| |___  /\___  >__|     \______  /|__|    \___  >\/\_/  
#       

#importkl
lwh='\e[1;37m'
wh='\E[0;37m'
lrd='\e[1;31m'
rd='\E[0;31m'
cyn='\E[0;36m'
lcyn='\e[1;36m'
ylw='\E[0;33m'
lylw='\E[1;33m'
grn='\e[0;32m'
lgrn='\E[1;32m'
fin='\033[0m'

function head {
    clear
    echo -e " ${lrd}
               --------------------------------
               ||       RTSP SCANNER         ||
               ||      	                     ||
               ||                            ||
               ||     Malang Cyber Crew      ||
               ||                            ||
               ||     Coded by : Mr.Doel     ||
               ||     doel@mc-crew.or.id     ||
               ||                            ||
               ||    http://mc-crew.or.id    ||
               --------------------------------${fin}"
}

#Baca Network ID
head
echo -e "${rd}Press ctrl+c to exit${fin}"
echo
echo -en "${lcyn}Scanning Name ~>${fin} "
read COMPANY
echo -e "${lgrn}Set Company -> $COMPANY${fin}"

echo && echo -en "${lcyn}Input Network ID (1) ~>${fin} "
read NID1
echo -e "${lgrn}Set Network ID (1) -> $NID1.xxx.xxx.xxx${fin}"

echo && echo -en "${lcyn}Input Network ID (2) ~>${fin} "
read NID2
echo -e "${lgrn}Set Network ID (2) -> $NID1.$NID2.xxx.xxx${fin}"

echo && echo -en "${lcyn}Input Range Awal ~>${fin} "
read BATAS_AWAL
echo -e "${lgrn}Set Batas Awal -> $NID1.$NID2.$BATAS_AWAL.1/$PREFIX${fin}"

echo && echo -en "${lcyn}Input Range Akhir ~> ${fin}"
read BATAS_AKHIR
echo -e "${lgrn}Set Batas Akhir -> $NID1.$NID2.$BATAS_AKHIR.1/$PREFIX${fin}"

echo && echo -en "${lcyn}Prefix ~> "
read PREFIX
echo -e "${lgrn}Set Prefix -> /$PREFIX${fin}"

let "BATAS_AWAL-=1"

function inti {
while : ; do
	let BATAS_AWAL=BATAS_AWAL+1
	
	if [ -x "/opt/hasil_scanning" ]; then
	echo -e "Report will be save to ${grn}/opt/hasil_scanning${fin}"
	else
	sudo mkdir /opt/hasil_scanning
	sudo chown $USER:$USER /opt/hasil_scanning
	fi
	cd /opt/hasil_scanning
	sudo nmap -p554,80 --script http-title --open $NID1.$NID2.$BATAS_AWAL.1/$PREFIX -oX $COMPANY$BATAS_AWAL.xml -T4 -v
	sudo xsltproc $COMPANY$BATAS_AWAL.xml -o $COMPANY$BATAS_AWAL.html
	sudo rm $COMPANY$BATAS_AWAL.xml
	if [ $BATAS_AWAL -eq $BATAS_AKHIR ]
		then
			break
	fi
done	
}

inti




