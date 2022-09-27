#!/usr/bin/bash
# Упрощенный вариант: сгенерировать в папке n файлов и внести в четный > even, нечетный > odd

GENERATION_FOLDER="/tmp/even_odd"
FILE_COUNT=$[$RANDOM % 9 +1 ]

# clear generation folder:
if [ -d "$GENERATION_FOLDER" ]; then
    rm -rf "$GENERATION_FOLDER" 
    mkdir "$GENERATION_FOLDER";
else
mkdir "$GENERATION_FOLDER";
fi

# even or odd
for ((i=1; i <= FILE_COUNT; i++))
do
touch $GENERATION_FOLDER/file$i
    if [[ $i%2 -eq 0 ]]
    then
    echo "even" >> $GENERATION_FOLDER/file$i
    else
    echo "odd" >> $GENERATION_FOLDER/file$i
    fi
echo -n "file$i " && cat $GENERATION_FOLDER/file$i
done