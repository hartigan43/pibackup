# /bin/bsh
#This script is run by cron weekly and compresses all of the static files used in clients websites
date=$(date '+%Y_%m_%d')

#compress current rsync directory and save it
tar -czf /home/backups/backups/archives/files_"$date".tar.gz /home/backups/files/* --verify

#copy the most recent db archive, a week, and a month into the archives
tocopy=$(ls /home/backups/backups/databases | tail -1 )
cp /home/backups/backups/databases/"$tocopy" /home/backups/backups/archives
tocopy=$(find /home/backups/backups/databases -type f -mtime +6)
cp /home/backups/Backups/databases/"$tocopy" /home/backups/Backups/archives
tocopy=$(find /home/backups/backups/databases -type f -mtime +29)
cp /home/backups/Backups/databases/"$tocopy" /home/backups/Backups/archives

#remove files older than 45 days in the archives directory
find /home/backups/Backups/archives/*.tar.gz -mtime +44 -exec rm {} \;
