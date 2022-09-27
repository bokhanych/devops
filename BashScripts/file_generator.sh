#!/bin/bash

GENERATION_FOLDER="$1"
MAX_GENERATION_DEPTH="$2"

# clear generation folder:
if [ -d "$GENERATION_FOLDER" ]; then
    rm -rf "$GENERATION_FOLDER" 
    mkdir "$GENERATION_FOLDER";
else
mkdir "$GENERATION_FOLDER";
fi

# create directory depth 1
for ((i=1; i <= $[$RANDOM % 9 +1 ]; i++))
do
mkdir $GENERATION_FOLDER/dir$i

    # create directory depths
    for ((CURRENT_GENERATION_DEPTH=1; CURRENT_GENERATION_DEPTH < $MAX_GENERATION_DEPTH; CURRENT_GENERATION_DEPTH++ ))
    do
    mkdir $_/dir$[$RANDOM % 9 +1 ]
    done
done

# create files
find $GENERATION_FOLDER/. -type d -exec sh -c 'for d; do touch "$d/file"; done' _ {} +