#!/bin/sh
#
# Entry point script
#
# @author  yannoff <https://github.com/yannoff>
# @package gulp
# @license MIT
#

GULPFILE=gulpfile.js
DEPSDIR=node_modules/

err(){
    printf "$@"
    echo
    exit 1
}

# If no gulpfile present, exit with an error message
[ -f "$GULPFILE" ] || err "No gulpfile found (%s). Exiting." ./$GULPFILE

# If no gulpfile present, create an empty one
[ -d "$DEPSDIR" ] || mkdir $DEPSDIR

# By default (no command provided), launch "watch" task
args=$@
[ "$#" -eq "0" ] && args="watch"

# Test if a local gulp is present, if not install it
gulp >/dev/null  2>/dev/null
if [ "$?" -eq "0" ]
then
    npm install gulp
fi

gulp "$args" || true
