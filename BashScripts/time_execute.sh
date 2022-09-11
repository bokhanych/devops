#!/bin/bash
# check execution time of command

#COMMAND="find / -name test -type f"
COMMAND="sleep 3"

# time of execution
time -p $COMMAND

# OR:
START_TIME=$(date +%s)
$COMMAND
END_TIME=$(date +%s)
DIFF=$(( $END_TIME - $START_TIME ))
echo "___"
echo "It took $DIFF seconds"