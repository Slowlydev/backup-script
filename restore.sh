#!/bin/bash

# backup restore script
if [[ -s "backup.config" ]]; then
  source "backup.config"
else
  echo "fatal: no config file found"
  exit 1
fi

#Info about your backup directory's
echo "info: target directory ${targetDirectory}"
echo "info: backup directory ${backupDirectory}"
echo "info: timestamp format ${timestampFormat}"
echo ""

#Going into backup directory
echo "Hello User, let's check your 5 last backups"
echo ""
cd ${backupDirectory}
echo ""
echo "Your Backup files: "
echo ""
ls -1 | head -5
sleep 2
echo ""
echo "Do you wanna have the oldest Backup(1) or write 2 to manually choose a file"
read -p "Your Number: " userFileName

firstFile="$(ls -1 | head -1)"
secondFile="$(ls -1 | head -2 | tail -1)"
thirdFile="$(ls -1 | head -3 | tail -1)"
fourthFile="$(ls -1 | head -4 | tail -1)"
fifthFile="$(ls -1 | head -5 | tail -1)"

#Before actually tranfering a file I am checking if the User is sure
function transferCheck {
  echo ""
  echo "Do you really wanna transfer the files"
  read -p "yes/no: " readAnswer
  if [[ $readAnswer == "yes" ]]; then
    echo $readAnswer
    echo "Transfering the directory"
    cd $backupDirectory
  else
    echo "You declined the transfer. Have a good day (:"
    exit 1
  fi
}

#Transfaring the file into the target Directory
function transferFile {
  echo ""
  pwd
  echo backup
  sleep 1
  cp -r backup $targetDirectory
  rm -r backup
}

#Case Statemeant where the user can chose which file should be transfered
case $userFileName in

#First case where you have the option to restore the newest version
"1")
  echo $firstFile
  transferCheck
  nice -n 19 tar -xf $firstFile
  transferFile
  ;;

  #Second case if you want to choose manuall a file
"2")
  cd $backupDirectory
  read -p "Please enter the file name: " selfChosenFile
  if [ -f $selfChosenFileName ]; then
    echo "The file $selfChosenFile exists"
    sleep 1
    transferCheck
    nice -n 19 tar -xf $selfChosenFile
    transferFile
  else
    echo "The file $backupDirectory/$selfChosenFile does not exists"
    exit 1
  fi
  ;;

*)
  echo "Sorry we did not find you number please enter a valid number between 1 and 2"
  ;;

esac
