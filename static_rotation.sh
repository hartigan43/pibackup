# /bin/bsh
#This script is run by cron monthly and compresses all of the static files used in clients websites
date=$(date '+%Y_%m_%d')

tar -czf /home/backups/backups/archives/"$date".tar.gz /home/backups/files/* --verify


