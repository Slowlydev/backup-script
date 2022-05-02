#!/bin/bash
# backup setup script

# TODO: ask user about backup target and storage location
# your sophisticated code here

# replaces $1 with $2 in config file
storeToConfig() {
  sed -i '' "s/${1}/${2}/g" backup.config
}

# write directories to config file
# TODO write function which replaces slash with backslash slash
storeToConfig "replaceTargetDirectory" "\/Your\/Files\/To\/Backup"
storeToConfig "replaceBackupDirectory" "\/Your\/backup\/Directory"
