#!/bin/bash
# backup script

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
if [[ ! -d "${targetDirectory}" ]]; then
  echo "fatal: target directory does not exists"
  exit 1
fi
echo "info: backup directory ${backupDirectory}"

# TODO: remove
echo "info: timestamp format ${timestampFormat}"

targetDirectoryName=$(echo "${targetDirectory}" | sed 's:.*/::')

# make shadow copy of target directory
nice -n 19 cp -r "${targetDirectory}" "/tmp/"
# move shadow copy to tmp dir
nice -n 19 mv "/tmp/${targetDirectoryName}" "/tmp/backup"

# remember current directory
pwd=$(pwd)
cd /tmp/

# compress
nice -n 19 tar -czf "backup.tar.gz" "backup"
nice -n 19 rm -r "backup"
nice -n 19 mv "backup.tar.gz" "${timestampFormat}-backup.tar.gz"
nice -n 19 mv "${timestampFormat}-backup.tar.gz" "${backupDirectory}"

# get back to were we were
cd "${pwd}"
