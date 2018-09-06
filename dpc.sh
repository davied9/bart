#!/bin/bash

echo start build bart for dpc ... | tee buildlog.log

find . -name "*.sh" | xargs dos2unix 2>&1 | tee -a buildlog.log
find . -name "*.mk" | xargs dos2unix 2>&1 | tee -a buildlog.log
find . -name "*.c"  | xargs dos2unix 2>&1 | tee -a buildlog.log
find . -name "*.h"  | xargs dos2unix 2>&1 | tee -a buildlog.log
find . -name "Makefile" | xargs dos2unix 2>&1 | tee -a buildlog.log

./make.sh $* 2>&1 | tee -a buildlog.log

