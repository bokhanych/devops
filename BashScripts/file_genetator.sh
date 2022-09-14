#!/bin/bash

# HOW SET LEVEL DEPTH AND CREATE DIRECTORY IN DIRECTORY DEPTH-1???

GENERATION_FOLDER="/tmp"
GENERATION_DEPTH="3"
RND=$[$RANDOM % 9 +1 ]

rm -r dir*

for ((i=1; i <= $RND; i++))
do

# create directory depth 1
mkdir dir$i

        # create directory depth 2
        if [ $i -lt $RND ]
        then
        mkdir dir$i/dir$i$i
        continue
        fi


        # random count of files in directory
        for ((f=1; f < $[$RANDOM % 9 +1 ]; f++))
        do
                touch dir$i/file$i$[$RANDOM % 9 +1 ]
        done
done



# -eq равно (equal)
# -ne не равно (not equal)
# -lt меньше (less)
# -le меньше или равно (less than or equal)
# -gt больше (greater)
# -ge больше или равно (greater)