#!/bin/bash
GENERATION_FOLDER="/tmp/even_odd"
FILE_COUNT=2
MAX_GENERATION_DEPTH=2
RANDOM=$[$RANDOM % 9 +1]

# clear generation folder:
if [ -d "$GENERATION_FOLDER" ]; then
    rm -rf "$GENERATION_FOLDER" 
    mkdir "$GENERATION_FOLDER";
else
mkdir "$GENERATION_FOLDER";
fi

function touch_file {
    for ((i=1; i <= $RANDOM; i++)); do
    touch $_/file$i
        if [[ $i%2 -eq 0 ]]; then
        echo "even" >> $_/file$i
        else
        echo "odd" >> $_/file$i
        fi
    done
}

# create directory depth 1
for ((i=1; i <= $[$RANDOM % 9 +1 ]; i++))
    do
    mkdir $GENERATION_FOLDER/dir$i
        # create directory depths
     for ((CURRENT_GENERATION_DEPTH=1; CURRENT_GENERATION_DEPTH < $MAX_GENERATION_DEPTH; CURRENT_GENERATION_DEPTH++ ))
     do
        cd $_
        mkdir $_/dir$[$RANDOM % 9 +1]
     done

done

# find /tmp/even_odd/. -type d -exec sh -c 'for ((i=1; i <= 10; i++)); do touch $_/file$i; if [[ $i%2 -eq 0 ]]; then echo "even" >> $_/file$i;else echo "odd" >> $_/file$i;  fi' _ {} +