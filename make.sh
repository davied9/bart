#!/bin/bash

export NOLAPACKE=1
export OPENBLAS=1
export GFORTRAN=1
export ADDITIONAL_LIBRARY=/usr/local/lib64:/usr/local/lib

while [ "$1" != "" ]; do
    case $1 in
        -d | --debug )
            export DEBUG=1
            [ -z "$OPT_LEVEL" ] && export NOOPTIMIZATION=1
            shift
            ;;
        -L | --library_path )
            shift
            if [ "$1" == "" ]; then
                echo -L/--library_path is specified, library path should be followed, abort.
                exit
            fi
            ADDITIONAL_LIBRARY+=:$1
            shift
            ;;
        -o | --optimization )
            shift
            unset NOOPTIMIZATION
            if [ "$1" == 0 ]; then # level 0, means no optimization
                export NOOPTIMIZATION=1
                shift
            else
                if [ "$1" -ge 1 ] && [ "$1" -le 3 ]; then # level 1~3, normal specification
                    export OPT_LEVEL=$1
                    shift
                else # otherwise, may be next flag, treat as not specified, default to level 3
                    export OPT_LEVEL=3
                fi
            fi
            ;;
        *)  shift
            ;;
    esac
done


make

