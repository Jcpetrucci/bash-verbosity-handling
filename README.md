bash-verbosity-handling
=======================
#### Purpose: 
Allows your script to accept varying levels of verbosity flags and give appropriate feedback via file descriptors.

#### Example usage:
```
sh-4.2$ ./verbosity-handling.sh 
Verbosity level set to: 2
This would not display 3
This would not display 4
This would not display 5
sh-4.2$ ./verbosity-handling.sh -v
Verbosity level set to: 3
This would display 3
This would not display 4
This would not display 5
This message is seen at verbosity level 3 and above.
sh-4.2$ ./verbosity-handling.sh -vv
Verbosity level set to: 4
This would display 3
This would display 4
This would not display 5
This message is seen at verbosity level 3 and above.
This message is seen at verbosity level 4 and above.
sh-4.2$
```
