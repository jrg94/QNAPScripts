
# QNAPScripts
A repository for developing various Linux scripts for my TS-251 QNAP NAS.

## PlexOrganizer.sh

### Useful Commands

+ The du command is used to list disk usage
  + This will be handy when monitoring if the size of a directory has changed
  + It is also useful with the -a option to get full paths
+ The awk command is used to format output
  + A handy command might be: 
    + du -a | grep .pdf | awk '{$1=""""; print}'
    + This command lists all of the directories/files and their absolute paths, greps for .pdf, and formats the output to exclude the usage
    
### Design Challenges

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

