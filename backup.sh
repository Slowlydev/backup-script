#!/bin/bash
# backup script

if [[ -s "backup.config" ]]; then
  source "backup.config"
else
  echo "fatal: no config file found"
  exit 1
fi

echo "info: target directory ${targetDirectory}"
echo "info: backup directory ${backupDirectory}"
echo "info: timestamp format ${timestampFormat}"
