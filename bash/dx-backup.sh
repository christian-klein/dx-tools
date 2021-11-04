#!/bin/bash

# Assumes websphere profile is nfs mounted to db2 server directory

DX_PROFILE_DIR="/mnt/dx-core-1"
BACKUP_DIR='/mnt/dx-backup'
BACKUP_TS=date +%d%m%y
LOG_DIR="$HOME/dx-backup"
LOG_FILE="DX_BACKUP_`date +%d%m%y`.log"

touch $LOG_DIR/$LOG_FILE

>$LOG_DIR/$LOG_FILE

if [ ! -d "$LOG_DIR" ]
then
    mkdir "$LOG_DIR"
fi

echo "operatation began `date`" >> $working_dir/$logfile

echo "=============================="  >> $working_dir/$logfile ;
echo "Backing up profile directory..."

tar -czf $BACKUP_DIR/profile_$BACKUP_TS.tar.gz $DX_PROFILE_DIR

echo "Delete all backups over 5"
ls -t | grep DX_BACKUP | sed -e '1,5d' | xargs -d '\n' rm
echo "=============================="  >> $working_dir/$logfile ;

for i in `db2 list db directory | grep 'Database name' | awk '{print $4}'`;
do

echo "=============================="  >> $working_dir/$logfile ;
echo "beginning backup for $i"  >> $working_dir/$logfile ;

# echo "=============================="  >> $working_dir/$logfile ;

# echo "checking database state"  >> $working_dir/$logfile ;

# state=$(db2 get db cfg for $i | grep 'HADR database role' | awk '{print $5}');

# echo "Current state is $state"  >> $working_dir/$logfile ;

 

# if [ $state = "STANDBY"  ]

# then

# echo "THIS DATABASE IS THE STANDBY, THIS OPERATION SHOULD BE PERFORMED AT THE PRIMARY"  >> $working_dir/$logfile

# else

# echo "command : db2 backup db $i online use TSM include logs"  >> $working_dir/$logfile ;

# db2 backup db $i online use TSM include logs  >> $working_dir/$logfile ;

# fi

# echo "=============================="  >> $working_dir/$logfile ;

# echo "";

done

# echo "operatation ended `date`" >> $working_dir/$logfile