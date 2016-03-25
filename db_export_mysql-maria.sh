#! /bin/sh
#This script logs into MySQL/MariaDB and exports each database individually.  It then
#takes all of the exports and compresses them for archiving

backupDIR=""$HOME"/backups"
date=$(date '+%Y_%m_%d')

#create list of all databases on localhost
mysql -u DBUSER -pDBPASS --execute='show databases;' | tail -n +2 | sed -e '/mysql/d' -e '/information_schema/d' | cat > "$backupDIR"/databases.txt

#dump all the databases - create user with read only access to all databases for dump
dblist=""$backupDIR"/databases.txt"
while IFS= read -r database
do
  mysqldump -u DBUSER -pDBPASS "$database" > "$backupDIR"/"$database".sql; 
done <"$dblist"

tar -czf "$backupDIR"/databases/"$date".tar.gz "$backupDIR"/*.sql

#clean up the list of files and the database dumps
rm "$backupDIR"/databases.txt
rm "$backupDIR"/*.sql
