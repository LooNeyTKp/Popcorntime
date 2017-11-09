#!/bin/bash
# v5.0 final by looneytkp™

set -e
NC='\033[0m'
Y='\033[1;33m'
LC='\033[1;36m'
LR='\033[1;31m'
strtscrpt() {
sleep 0.5
echo -e "
"
strtinst
}
strtinst() {
echo -e "                    ${LC}Popcorn Time for 64bit PC"
echo -e "                                 by looneytkp${Y}"
echo
cd ~
if [ -d popcorntime ]; then
  rm -r popcorntime && mkdir popcorntime
  else
  mkdir popcorntime
fi
cd -
cp Popcorn-Time-64* /home/$USER/popcorntime/Popcorn-Time-64.tar.xz
cd /home/$USER/popcorntime
echo "Installing..."
tar xf Popcorn-Time-64.tar.xz &
pid=$! # Process Id of the running command
printf "["
i=0
while kill -0 $pid 2>/dev/null
do
  i=$(( (i+1) %4 ))
  printf "#"
  sleep .4
done
echo -e "] Done!"
rm Popcorn-Time-64.tar.xz
crt
}
crt() {
			cde;
			sleep 1
}
cde() {
	NAME="Popcorn Time"
	COMMENT="Watch Movies and TV Shows instantly!"

	CURRENT_DIR=$(pwd)
	EXECUTABLE=$CURRENT_DIR/Popcorn-Time
	ICON_PATH=$CURRENT_DIR/src/app/images/icon.png

	DESTINATION_DIR=/home/$(whoami)/.local/share/applications
	DESKTOP_FILE=$DESTINATION_DIR/popcorn-time.desktop

	echo "[Desktop Entry]" > $DESKTOP_FILE
	echo "Version=1.0" >> $DESKTOP_FILE
	echo "Type=Application" >> $DESKTOP_FILE
	echo "Name=$NAME" >> $DESKTOP_FILE
	echo "Icon=$ICON_PATH" >> $DESKTOP_FILE
	echo "Exec=\"$EXECUTABLE\" %U" >> $DESKTOP_FILE
	echo "Comment=$COMMENT" >> $DESKTOP_FILE
	echo "Categories=Multimedia;" >> $DESKTOP_FILE
	echo "Terminal=false" >> $DESKTOP_FILE
}
lch() {
echo
shopt -u nocasematch
printf "${Y}Launch Popcorn Time ?" && read -p "(Y)es/(N)o > " resp;
case $resp in
    y|yes) sleep 1
       echo "Launching..."
       ./Popcorn-Time
       instcomp;;
    n|no) instcomp;;
    *) echo "Invalid input" && lch;;
esac
}
instcomp() {
cd -
sudo gtk-update-icon-cache /usr/share/icons/hicolor
if [ ! -f /usr/bin/popcorntime ]; then
  sudo cp popcorntime /usr/bin/popcorntime
  cd /usr/bin
  sudo chmod 755 popcorntime
  else
      sudo rm /usr/bin/popcorntime
      sudo cp popcorntime /usr/bin/popcorntime
      cd /usr/bin
      sudo chmod 755 popcorntime
fi
echo && sleep 0.5
echo -e "${LC}GTK icon cache updated, you should find Popcorn Time in your applist."
echo -e "Type ${Y}popcorntime --help ${LC}in terminal for more info."
echo "Enjoy :)"
sleep 0.5 && echo
echo "                    Installation complete!"
echo
sleep 1
}
case $1 in
    "") if [ ! -f Popcorn-Time-64* ]; then
          sleep 0.7 && echo
          echo -e "${LR}Popcome time installation file not found!. Read instructions below"
          echo && echo -e "${LC}#### 64bit PC"
          echo "1. Put the downloaded file in the same folder where the popcorn64.sh script is."
          echo "   Or create a specific folder and place both files in it."
          echo
          echo -e "2. Double click and run the "${Y}popcorn64" ${LC}script."
          echo -e "   Or open terminal in that particular folder and type "${Y}bash popcorn64"${LC}."
          echo -e "3. Enjoy..."
          echo;
          else
              strtscrpt
              lch
        fi;;
    "-p"|"--pop") if [ ! -f popcorntime ]; then
                    echo -e "${LR}Cannot find popcorntime file"
                    else
                        if [ ! -f /usr/bin/popcorntime ]; then
                          sudo cp popcorntime /usr/bin/popcorntime
                          cd /usr/bin
                          sudo chmod 755 popcorntime
                          echo -e "${LC}Done!"
                          echo -e "Type ${Y}popcorntime --help ${LC}in terminal for more info."
                          else
                              sudo rm /usr/bin/popcorntime
                              sudo cp popcorntime /usr/bin/popcorntime
                              cd /usr/bin
                              sudo chmod 755 popcorntime
                              echo -e "${LC}Done!"
                              echo -e "Type ${Y}popcorntime --help ${LC}in terminal for more info."
                        fi
                  fi;;
    "--help") echo -e "${LC}Usage: ${Y}popcorn64 [OPTION]..."
              echo -e "${LC}Typing ${Y}'popcorn64'   ${LC}executes the installation of Popcorn Time"
              echo -e "       ${Y}'-p / --pop'  ${LC}copies the popcorntime file to /usr/bin/ only"
              echo -e "       ${Y}'--help'      ${LC}opens the info page"
              echo -e "example: ${Y}popcorntime -p ${LC}or ${Y}popcorntime --pop";;
    *) echo -e "${Y}'$1' ${LC}is not a valid argument."
       echo -e "try ${Y}--help ${LC}for more info";;
esac
