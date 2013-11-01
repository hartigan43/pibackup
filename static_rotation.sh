# /bin/bsh
#This script is run by cron monthly and compresses all of the static files used in clients websites
date=$(date '+%Y_%m_%d')

#compress current rsync directory and save it
tar -czf /home/backups/backups/archives/files_"$date".tar.gz /home/backups/files/* --verify

#copy the most recent db archive, a week, and a month into the archives
tocopy=$(ls /home/backups/backups/databases | tail -1 )
cp /home/backups/backups/databases/"$tocopy" /home/backups/backups/archives
