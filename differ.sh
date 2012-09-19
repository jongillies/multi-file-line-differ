#!/bin/bash

REVERSE=0

function usage ()
{
    echo "$1"
    echo "Usage $0 [-d] [-r] -f folderwithdatafiles"
    echo "   where -d = turn on debug messages"
    echo "   where -r = reverse rows and columns"
    echo "         Rows will be file names, Columns will be data in file"
    exit 1
}

function print_header ()
{
    echo -en "\t"

    for col in $1
    do
        echo -en "$col\t"
    done
    echo
}


while getopts "f:hdr" options; do
        case $options in
                d ) DEBUG=1
                    echo "DEBUG mode enabled.";;
                f ) DATA_FOLDER=$OPTARG
                    ;;
                r ) REVERSE=1
                    ;;
                h ) usage;;
                \? )usage;;
                * ) usage;;
        esac
done

if [ -z $DATA_FOLDER ]; then
    usage
fi

if [ $REVERSE == 1 ]; then
    ROWS=`cat $DATA_FOLDER/* | sort | uniq`
    COLS=`ls $DATA_FOLDER`
else
    COLS=`cat $DATA_FOLDER/* | sort | uniq`
    ROWS=`ls $DATA_FOLDER`
fi

print_header "$COLS"

for row in $ROWS
do
    echo -en "$row\t"

    for col in $COLS
    do
        if [ $REVERSE == 1 ]; then
            INTERSECT=`$grep ^$row$ $DATA_FOLDER/$col`
        else
            INTERSECT=`$grep ^$col$ $DATA_FOLDER/$row`
        fi

        if [ -z "$INTERSECT" ]; then
            echo -en "\t"
        else
            echo -en "X\t"
        fi
    done
    echo

done
