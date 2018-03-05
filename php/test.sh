#!/bin/bash
#
# @package php
# @author  Yannoff <https://github.com/yannoff>
# @license MIT
#

versions=( "5" "5-fpm" "7" "7-fpm" "latest" )

dbg(){ 
    printf "$@" 
}

./update.sh "${versions[@]}"

for v in ${versions[*]}
do
    dbg "Trying to build docker image for version \033[01;32m%s\033[00m...\n\n" "$v"
    echo "---------------------------------------------------------------------------------"
    docker build -t yannoff/php:$v $v/
    echo "---------------------------------------------------------------------------------"
    docker run --rm yannoff/php:$v --version
    echo "---------------------------------------------------------------------------------"
done
