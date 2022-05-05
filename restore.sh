#!/bin/bash
# backup restore script

# backup restore script
if [[ -s "backup.config" ]]; then
  source "backup.config"
else
  echo "fatal: no config file found"
  exit 1
fi

# check if target directory exists
if [[ ! -d "${targetDirectory}" ]]; then
  echo "fatal: target directory does not exists"
  exit 1
fi
echo "info: target directory ${targetDirectory}"

# check if backup directory exists
if [[ ! -d "${backupDirectory}" ]]; then
  echo "fatal: backup directory does not exists"
  exit 1
fi
echo "info: backup directory ${backupDirectory}"

echo "info: timestamp format ${timestampFormat}"

# getting all backups available from backup directory
backups=($(ls ${backupDirectory}))

# ask for backup to restore
PS3="$(date +"%H:%M:%S") prompt: what backup do u want to restore? "
select selectedBackup in "${backups[@]}"; do
  echo "info: you selected: ${selectedBackup}"
  break
done

# ask for confirmation to restore
read -p "prompt: do u want to start the restore process (no point of return from here) y/n: " readConfirmation
if [[ ${readConfirmation} =~ ^[Yy]$ ]]; then
  pwd=$(pwd)
  cd ${backupDirectory}

  if [[ ! -s "${selectedBackup}" ]]; then
    echo "fatal: no config file found"
    exit 1
  fi

  nice -n 19 tar -xf ${selectedBackup}
  cp -r backup $targetDirectory
  rm -r backup

  cd ${pwd}

  echo "info: successfully restored your selected backup"
  exit 0
else
  echo "info: you declined the transfer. enjoy ur current data"
  exit 1
fi
