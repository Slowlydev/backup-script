#!/bin/bash
# backup setup script

# TODO: ask user about backup target and storage location
# TODO: ask for backup cronjob 
# TODO: convert to arrays of folders to backup

# sets key $1 with value $2 in config file
storeToConfig() {
  sed -i '' "s/\(${1} *= *\).*/\1${2//\//\\/}/" backup.config
}

# check if backup file exsists
if [[ -s "backup.config" ]]; then
  source "backup.config"
else
  echo "fatal: no config file found"
  exit 1
fi

# welcome message
echo ""
echo "Welcome to the backup Setup"
echo ""

# get and save directory for backups 
echo "Please enter the directory where u want to store your compressed backups"
read -p "Backup directory: " backupDirectory
storeToConfig "backupDirectory" $backupDirectory

# get and save direcotroy to backup
echo "Please enter the directory u want to backup"
read -p "Direcotry to backup: " targetDirectory
storeToConfig "targetDirectory" $targetDirectory

