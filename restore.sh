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
echo "Do you wanna have the newest Backup(1) or write 2 to manually choose a file"
read -p "Your Number: " userFileName


firstFile="$(ls -1 | head -1)"
secondFile="$(ls -1 | head -2 | tail -1)"
thirdFile="$(ls -1 | head -3 | tail -1)"
fourthFile="$(ls -1 | head -4 | tail -1)"
fifthFile="$(ls -1 | head -5 | tail -1)"
#transferDirectory="$(ls | grep -E '(^|\s)backup($|\s)')"

function transferCheck {
  echo ""
  echo "Do you really wanna transfer the files"
  read -p "yes/no: " $readAnswer
  if [[ $readAnswer -eq "yes" ]]; then
    echo "Transfering the directory"
    cd $backupDirectory
  else 
    exit 1
  fi
}

function transferFile {
  echo ""
  pwd
  echo backup
  sleep 1
  cp -r backup $targetDirectory
  rm -r backup
}

#Case Statemeant that gonna choose the file to restore
case $userFileName in 

"1")
  echo $firstFile 
  transferCheck
  nice -n 19 tar -xf $firstFile
  transferFile
  ;;

"2")
  read -p "Please enter the file name: " $selfChosenFile
  if [[ -s $selfChosenFileName ]]; then
    echo "The file $selfChosenFile exists"
    sleep 1
    transferCheck
    nice -n 19 tar -xf $selfChosenFile
    transferFile
  else 
    echo "The file does not exists"
    exit 1
  fi ;;
*)
  echo "Sorry we did not find you number please enter a valid number between 1 and 2" ;;

esac
