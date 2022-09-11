#!/bin/bash

# date
BACKUP_DATE=`date +%Y-%m-%d_%H:%M:%S`

# log file
LOG_FILE="/var/log/backups.log"

# max count backup copies
MAX_COPIES_COUNTER=5

# backup this directory
DIRECTORY_TO_BACKUP="/files"

# backup storage location
DIRECTORY_FOR_BACKUPS="/home/backups"

# check backup folder is exist
if [ ! -d "$DIRECTORY_FOR_BACKUPS" ]; then
  mkdir -p $DIRECTORY_FOR_BACKUPS;
fi

# backup create
echo "$DIRECTORY_FOR_BACKUPS/backup_$BACKUP_DATE.tar.bz2 DONE" >> $LOG_FILE
tar -cjf $DIRECTORY_FOR_BACKUPS/backup_$BACKUP_DATE.tar.bz2 $DIRECTORY_TO_BACKUP 2>/dev/null
echo "backup_$BACKUP_DATE.tar.bz2 DONE" >> $LOG_FILE

# backup rotation
COPIES_COUNTER=`ls $DIRECTORY_FOR_BACKUPS | grep backup_ | wc -l`
if [ $COPIES_COUNTER -gt $MAX_COPIES_COUNTER ]
then
# how many files to delete
NEED_TO_DELETE_COUNTER=$(($(ls $DIRECTORY_FOR_BACKUPS | wc -l)-$MAX_COPIES_COUNTER))
for (( i==1; i<$NEED_TO_DELETE_COUNTER; i++ ))
do
# sort and delete the older file
echo "$(ls $DIRECTORY_FOR_BACKUPS | sort | head -n 1) REMOVED" >> $LOG_FILE
rm $DIRECTORY_FOR_BACKUPS/$(ls $DIRECTORY_FOR_BACKUPS | sort | head -n 1)
done
fi