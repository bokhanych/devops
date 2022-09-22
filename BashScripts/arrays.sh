#!/bin/bash 
echo -n "Enter count of rows: "; read ROWS_COUNT;
echo -n "Enter count of lines: "; read LINES_COUNT;
# ROWS_COUNT=($[$RANDOM % 9 +1 ])
# LINES_COUNT=($[$RANDOM % 9 +1 ])
function array {
for (( i=0; i < $ROWS_COUNT; i++ ))
do
arr[i]=$[$RANDOM % 9 +1 ] 
done
echo ${arr[*]}
}

for (( l=1; l <= $LINES_COUNT; l++ ))
do
array
done
