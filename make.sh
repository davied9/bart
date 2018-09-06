#!/bin/bash

export NOLAPACKE=1
export OPENBLAS=1
export GFORTRAN=1
export ADDITIONAL_LIBRARY=/usr/local/lib64:/usr/local/lib

while [ "$1" != "" ]; do
    case $1 in
        -d | --debug )
            export DEBUG=1
            ;;
        -L )
            shift
            if [ "$1" == "" ]; then
                echo -L is specified, library path should be followed, abort.
                exit
            fi
            ADDITIONAL_LIBRARY+=:$1
    esac
    shift
done


make

