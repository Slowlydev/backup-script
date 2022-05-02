#!/bin/bash
# backup restore script

if [[ -s "backup.config" ]]; then
  source "backup.config"
else
  echo "fatal: no config file found"
  exit 1
fi

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
echo "Please type a number between 1 and 5 or write 6 to manually choose a file"
read -p "Your Number: " userFileName


firstFile="$(ls -1 | head -1)"
secondFile="$(ls -1 | head -2 | tail -1)"
thirdFile="$(ls -1 | head -3 | tail -1)"
fourthFile="$(ls -1 | head -4 | tail -1)"
fifthFile="$(ls -1 | head -5 | tail -1)"


#Case Statemeant that gonna choose the file to restore
case $userFileName in 

"1")
  echo $firstFile ;;

"2")
  echo $secondFile ;;

"3")
  echo $thirdFile ;;

"4") 
  echo $fourthFile ;;

"5") 
  echo $fifthFile ;;

"6")
  read -p "Please enter the file name: " $selfChosenFile
  if [[ -s $selfChosenFileName ]]; then
    echo "The file $selfChosenFile exists"
  else 
    echo "The file does not exists"
    exit 1
  fi ;;
*)
  echo "Sorry we did not find you number please enter a valid number between 1 and 6" ;;

esac
