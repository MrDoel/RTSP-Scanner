#!/bin/bash 

####################################
# RTSP SCANNER                     #
#      				   #
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
               ||     http://mc-crew.or.id   ||
               --------------------------------${fin}"
}

#Baca Network ID
head
echo -n "Scanning Name ~> "
read COMPANY
echo -n "Input Network ID (1) ~> "
read NID1
echo -n "Input Network ID (2) ~> "
read NID2
echo -n "Prefix ~> "
read PREFIX
echo -n "Input Range Awal ~> "
read BATAS_AWAL
echo -n "Input Range Akhir ~> "
read BATAS_AKHIR

PREFIX=24
let "BATAS_AWAL-=1"

while : ; do
	echo $BATAS_AWAL
	let BATAS_AWAL=BATAS_AWAL+1
	sudo nmap -p554,80 --script http-title --open $NID1.$NID2.$BATAS_AWAL.1/$PREFIX -oX $COMPANY$BATAS_AWAL.xml -T4 -v
	sudo xsltproc $COMPANY$BATAS_AWAL.xml -o $COMPANY$BATAS_AWAL.html
	sudo rm $COMPANY$BATAS_AWAL.xml
	sudo mkdir hasil_scanning
	sudo mv $COMPANY$BATAS_AWAL.html hasil_scanning
	if [ $BATAS_AWAL -eq $BATAS_AKHIR ]
		then
			break
	fi
done



