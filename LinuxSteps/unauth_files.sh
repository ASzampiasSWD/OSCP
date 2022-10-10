#!/bin/bash
# Comments: To remove: sudo apt remove nmap. 
# Or sudo apt remove --purge nmap. Removes config files too, but not dependencies.
# which, where, and whereis can be useful commands too.
# Program is case-insensitive. It will find nmap and nMaP.
# To use: ./unauth_files.sh 1  # Find via apt list --installed
# ./unauth_files.sh 2 # Find program via locate
# ./unauth_files.sh 3 # Find program via Find /
# Dependencies: Need programs.txt file.
while IFS= read -r line; do
  if [ $1 -eq 1 ]
  then
    result=$(sudo apt list --installed 2>/dev/null | grep -i "$line" | wc -l) 
    if [ $result -gt 0 ]
    then
      echo $line "+ - - - - - - - +" $result
    fi
  fi
  if [ $1 -eq 2 ]
  then
    result=$(sudo locate -i 2>/dev/null "$line" | wc -l)
    if [ $result -gt 0 ]
    then
      echo $line "+ - - - - - - - +" $result
    fi
  fi
  if [ $1 -eq 3 ]
  then
    result=$(sudo find / -iname "$line" 2>/dev/null | wc -l)
    if [ $result -gt 0 ]
    then
      echo $line "+ - - - - - - - +" $result
    fi
  fi    
done < "programs.txt"
