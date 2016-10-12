# QNAPScripts
A repository for developing various Linux scripts for my TS-251 QNAP NAS.

## PlexOrganizer.sh

+ The du command is used to list disk usage
  + This will be handy when monitoring if the size of a directory has changed
  + It is also useful with the -a option to get full paths
+ The awk command is used to format output
  + A handy command might be: 
    + du -a | grep .pdf | awk '{$1=""""; print}'
    + This command lists all of the directories/files and their absolute paths, greps for .pdf, and formats the output to exclude the usage
