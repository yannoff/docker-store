#!/bin/bash
#
# @author  yannoff <https://github.com/yannoff>
# @package sshbox
# @license MIT
#

DEFAULT_ID=1000
SSH_HOME=/app/ssh
IDENTITY_FILE=${SSH_HOME}/id_rsa

err_undefined() {
    printf "Error: Environment variable %s is not set. Exiting\n" $1
    exit 1
}

err_message() {
    printf "$@"
    exit 1
}

is_first_run() {
    [ `ls -A /home/ | wc -l` -eq 0 ]
}

if is_first_run
then
    [ -z "$USER" ] && err_undefined USER 
    [ -z "$KNOWN_HOST" ] && err_undefined KNOWN_HOST 
    [ -z "$ID" ] && ID=$DEFAULT_ID
    [ -z "$GID" ] && GID=$ID
    [ -z "$GROUP" ] && GROUP=$USER
    USERLAND=/home/$USER

    addgroup -g $GID -S $GROUP
    adduser -u $ID -D -S -s /bin/bash -G $GROUP $USER
    
    echo ". /etc/profile.d/color_prompt" >> /home/$USER/.bashrc
    echo "PS1='\w\$ '" >> /home/$USER/.bashrc
    
    mkdir -p /home/$USER/.ssh || true
    
    [ -f $IDENTITY_FILE ] || err_message "Could not find identity file. Exiting.\n\nPlease provide one by mounting it to [%s] when running the container.\n\n" $IDENTITY_FILE
    cp -v $IDENTITY_FILE $USERLAND/.ssh
    chown -Rv $USER:$GROUP $USERLAND/.ssh || true

    ssh-keyscan -t rsa $KNOWN_HOST | su-exec $USER tee -a $USERLAND/.ssh/known_hosts
else
    USER=`ls -A /home/ | grep -v 'lost+found' | tr -d "\n"`
fi

su-exec $USER "$@" 2>&1
