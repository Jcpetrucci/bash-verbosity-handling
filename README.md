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

You could also use a command substitution inside of the descriptor redirection, to prepend a string to the debug output, such as this:

`(( "$v" <= "$maxverbosity" )) && eval exec "$v> >( xargs -I{} printf '[Debug.%s] %s\n' "\$v" "{}" >&2 )"` 

or

`(( "$v" <= "$maxverbosity" )) && eval exec "$v> >( sed 's/^/[Debug.$v] /' >&2 )"`

The downside to these is that the external commands are slower to run than a builtin, and can result in the output getting out of order.
