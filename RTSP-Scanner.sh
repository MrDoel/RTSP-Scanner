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
######Company Section######
echo -en "${lcyn}Scanning Name ~>${fin} "
regex=[A-Za-z]*
regex2=[0-9]*
while read COMPANY
do
        case "$COMPANY" in
        $regex) break;;
        *) echo -e "${rd}Not Valid Input!${fin}";echo -en "${lcyn}Scanning Name ~>${fin} ";;
        esac
done

echo -e "${lgrn}Set Company -> $COMPANY${fin}"

######Network ID (1) Section######
echo && echo -en "${lcyn}Input Network ID (1) ~>${fin} "
while read NID1
do
        case "$NID1" in
        $regex2) break;;
        *) echo -e "${rd}Not Valid Input!${fin}";echo -en "${lcyn}Input Network ID (1) ~>${fin} ";;
        esac
done
echo -e "${lgrn}Set Network ID (1) -> $NID1.xxx.xxx.xxx${fin}"

######Network ID (2) Section######
echo && echo -en "${lcyn}Input Network ID (2) ~>${fin} "
while read NID2
do
        case "$NID2" in
        $regex2) break;;
        *) echo -e "${rd}Not Valid Input!${fin}";echo -en "${lcyn}Input Network ID (2) ~>${fin} ";;
        esac
done
echo -e "${lgrn}Set Network ID (2) -> $NID1.$NID2.xxx.xxx${fin}"

######Range Awal Section######
echo && echo -en "${lcyn}Input Range Awal ~>${fin} "
while read BATAS_AWAL
do
        case "$BATAS_AWAL" in
        $regex2) break;;
        *) echo -e "${rd}Not Valid Input!${fin}";echo -en "${lcyn}Input Range Awal ~>${fin} ";;
        esac
done
echo -e "${lgrn}Set Batas Awal -> $NID1.$NID2.$BATAS_AWAL.1${fin}"


######Range Akhir Section######
echo && echo -en "${lcyn}Input Range Akhir ~> ${fin}"
while read BATAS_AKHIR
do
        case "$BATAS_AKHIR" in
        $regex2) break;;
        *) echo -e "${rd}Not Valid Input!${fin}";echo -en "${lcyn}Input Range Akhir ~>${fin} ";;
        esac
done
echo -e "${lgrn}Set Batas Akhir -> $NID1.$NID2.$BATAS_AKHIR.1${fin}"


######Prefix Section######
echo && echo -en "${lcyn}Prefix ~> "
while read PREFIX
do
        case "$PREFIX" in
        $regex2) break;;
        *) echo -e "${rd}Not Valid Input!${fin}";echo -en "${lcyn}Prefix ~> ";;
        esac
done
echo -e "${lgrn}Set Prefix -> /$PREFIX${fin}"

let "BATAS_AWAL-=1"

function inti {
while : ; do
	let BATAS_AWAL=BATAS_AWAL+1
	
	if [ -x "/opt/Report_RTSP" ]; then
	echo -e "Report will be save to ${grn}/opt/Report_RTSP${fin}"
	else
	sudo mkdir /opt/Report_RTSP
	sudo chown $USER:$USER /opt/Report_RTSP
	fi
	cd /opt/Report_RTSP
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




