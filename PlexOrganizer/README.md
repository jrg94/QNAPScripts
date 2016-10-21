# PlexOrganizer.sh

## How to Use PlexOrganizer.sh

+ echo "*/5 * * * * /path/to/plex/filename.sh" >> /etc/config/crontab
+ crontab /etc/config/crontab
+ /etc/init.d/crond.sh restart
+ chmod +x filename.sh

## Useful Commands

+ The du command is used to list disk usage
  + This will be handy when monitoring if the size of a directory has changed
  + It is also useful with the -a option to get full paths
+ The awk command is used to format output
  + A handy command might be: 
    + du -a | grep .pdf | awk '{$1=""""; print}'
    + This command lists all of the directories/files and their absolute paths, greps for .pdf, and formats the output to exclude the usage
    
## Design Challenges

+ When to execute the script?
  + Cronjob? Is this even possible on the BusyBox OS?
    + This will probably require some save file to save state.
    + This has a huge benefit of not worrying if the script dies.
    + Here's a good reference: https://wiki.qnap.com/wiki/Add_items_to_crontab
      + EXAMPLE: echo "1 4 * * * /share/custom/scripts/custom1.sh" >> /etc/config/crontab
      + REMEMBER: chmod +x filename.sh
  + Init script? Run continuously? 
    + This will allow it to hold its own state.
    + How do we keep this script at low resource usage?

## Specifications

+ The script shall run as a cronjob
  + The script shall track its own state between runs
    + If the size of the Plex dump repo is 0, log value and exit
    + If the size of the Plex dump repo was any value and has changed, log value and exit 
    + If the size of the Plex repo was any value and has not changed, execute script (no risk here because 0 case short circuits the logic) 
+ The script shall execute as follows:
  + The script shall begin by assessing the state of the system (see cronjob specifications)
  + The script shall move files from the Plex dump directory into file type sorted folders.
  + The script shall rename sorted files based on Plex naming scheme.
  + The script shall attempt to move files to appropriate directories in Plex.
  + The script shall move uncategorized files to an uncategorized directory (perhaps leave them)
  + The script shall trigger a transfer of all sorted files to the cloud
