#!/bin/bash
# backup setup script

# TODO: ask user about backup target and storage location
# your sophisticated code here

# check if backup config already exists
if [[ -s "backup.config" ]]; then
  rm "backup.config"
fi

# write directories to config file
echo 'targetDirectory="/Your/Files/To/Backup"' >>"backup.config"
echo 'backupDirectory="/Your/Backup/Directory"' >>"backup.config"
