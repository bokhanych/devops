#!/bin/bash
LOGFILE=/var/log/BACKUP_FOLDER.log
BACKUP_FOLDER=/home/BACKUP_FOLDER
BACKUP_COUNT=5
FOLDER=/files
FILE_COUNT=$(ls -l $BACKUP_FOLDER | grep -v ^d | wc -l)

if [ ! -d "$BACKUP_FOLDER" ]; then
  mkdir -p $BACKUP_FOLDER;
fi

tar -czvf $BACKUP_FOLDER/backup.$(date +%Y%m%d).tar.gz $FOLDER



if $FILE_COUNT > $BACKUP_COUNT; then
echo "result: "
ll $BACKUP_FOLDER
fi

#rm -rf $(ls $FOLDER | head -1)
#$ ls -1t | tail -n +11 | xargs rm -f