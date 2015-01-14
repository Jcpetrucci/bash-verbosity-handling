#!/bin/bash
# A flexible verbosity redirection function
# John C. Petrucci (http://johncpetrucci.com)
# 2013-10-19
# Allows your script to accept varying levels of verbosity flags and give appropriate feedback via file descriptors.
# Example usage: ./this [-v[v[v]]]

verbosity=2 #Start counting at 2 so that any increase to this will result in a minimum of file descriptor 3.  You should leave this alone.
maxverbosity=5 #The highest verbosity we use / allow to be displayed.  Feel free to adjust.

while getopts ":v" opt; do
  case $opt in
    v) (( verbosity=verbosity+1 ))
    ;;
  esac
done
printf "%s %d\n" "Verbosity level set to:" "$verbosity"

for v in $(seq 3 $verbosity) #Start counting from 3 since 1 and 2 are standards (stdout/stderr).
do
  (( "$v" <= "$maxverbosity" )) && echo This would display $v 
  (( "$v" <= "$maxverbosity" )) && eval exec "$v>&2"  #Don't change anything higher than the maximum verbosity allowed.
done

for v in $(seq $(( verbosity+1 )) $maxverbosity ) #From the verbosity level one higher than requested, through the maximum;
do
  (( "$v" > "2" )) && echo This would not display $v 
  (( "$v" > "2" )) && eval exec "$v>/dev/null" #Redirect these to bitbucket, provided that they don't match stdout and stderr.
done

# Some confirmations:
printf "%s\n" "This message is seen at verbosity level 3 and above." >&3
printf "%s\n" "This message is seen at verbosity level 4 and above." >&4
printf "%s\n" "This message is seen at verbosity level 5 and above." >&5
