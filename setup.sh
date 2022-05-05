#!/bin/bash
# backup setup script

# sets key $1 with value $2 in config file
storeToConfig() {
  sed -i '' "s/\(${1} *= *\).*/\1${2//\//\\/}/" backup.config
}

# store to crontab function
storeToCrontab() {
  crontab -l | {
    cat echo "${1}"
  } | crontab -
}

# check if backup file exists
if [[ -s "backup.config" ]]; then
  source "backup.config"
else
  echo "fatal: no config file found"
  exit 1
fi

# welcome message
echo "\n Welcome to the backup setup \n"

# get and save directory for backups
echo "Please enter the directory where u want to store your compressed backups"
read -p "Backup directory: " backupDirectory
# a lovely check for your sanity
if [[ ! -d ${backupDirectory} ]]; then
  echo "error: the backup directory you provided does not exists"
  exit 1
fi
storeToConfig "backupDirectory" $backupDirectory

# get and save directory to backup
echo "Please enter the directory u want to backup"
read -p "Directory to backup: " targetDirectory
# another lovely check for your sanity
if [[ ! -d ${targetDirectory} ]]; then
  echo "error: the target directory you provided does not exists"
  exit 1
fi
storeToConfig "targetDirectory" $targetDirectory

# Ask for cronjob setup
read -p "prompt: would you like to run your backups automatically daily with a cronjob? " cronjobAnswer

# Check for answer
if [[ $cronjobAnswer =~ ^[Yy]$ ]]; then
  echo "info: set scripts directory"
  # store directory of scripts
  scriptsDirectory=$(pwd)
  echo "info: write daily backup to crontab"
  To "0 0 * * * cd ${scriptsDirectory} && ./backup.sh"
fi
