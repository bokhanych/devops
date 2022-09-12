#!/bin/bash
GENERATION_FOLDER="/tmp"
GENERATION_DEPTH="2"
rm -r dir*

x="1"
while [ $x -lt $GENERATION_DEPTH ]
do
((x++))
DEPTH=3
#       for ((i=1; i < $[$RANDOM % 9 +1 ]; i++))
        for ((i=1; i < $DEPTH; i++))
        do
        mkdir dir$i
                for ((f=1; f < $[$RANDOM % 9 +1 ]; f++))
                do
                        touch dir$i/file$i$[$RANDOM % 9 +1 ]
                done
        done
done