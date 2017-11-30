#!/bin/bash
#
# @author  yannoff <https://github.com/yannoff>
# @package sshbox
# @license MIT
#

DEFAULT_ID=1000
LOG_FILE=/var/log/bootstrap.log
SSH_HOME=/app/ssh
IDENTITY_FILE=${SSH_HOME}/id_rsa
KNOWN_HOSTS_FILE=${SSH_HOME}/known_hosts

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

guest_user() {
    ls -A /home/ | grep -v 'lost+found' | tr -d "\n"
}

if is_first_run
then
    [ -z "$USER" ] && err_undefined USER 
    [ -z "$ID" ] && ID=$DEFAULT_ID
    [ -z "$GID" ] && GID=$ID
    [ -z "$GROUP" ] && GROUP=$USER
    USERLAND=/home/$USER

    # Create guest user & group
    addgroup -g $GID -S $GROUP
    adduser -u $ID -D -S -s /bin/bash -G $GROUP $USER
    
    # Create basic bash config file
    echo ". /etc/profile.d/color_prompt" >> /home/$USER/.bashrc
    echo "PS1='\w\$ '" >> /home/$USER/.bashrc
    
    if [ ! -z "$CREATE_SSH_KEY" ]
    then
        ssh-keygen -t rsa -N "" -f $IDENTITY_FILE
        printf "\n\nCreated a new SSH Key. Here is the public generated key:\n\n%s\n\n" "`cat ${IDENTITY_FILE}.pub`"
    else
        [ -f $IDENTITY_FILE ] || err_message "Could not find identity file. Exiting.\n\nPlease provide one by mounting it to [%s] when running the container.\n\n" $IDENTITY_FILE
    fi

    mkdir -p /home/$USER/.ssh || true
    cp -v ${SSH_HOME}/* $USERLAND/.ssh 2>&1 >>$LOG_FILE
    chown -Rv $USER:$GROUP $USERLAND/.ssh 2>&1 >>$LOG_FILE || true

    # If no known_hosts file provided when running container, use KNOWN_HOSTS environment variable
    if [ ! -f $KNOWN_HOSTS_FILE ]
    then
        [ -z "$KNOWN_HOSTS" ] && err_undefined KNOWN_HOSTS 
        ssh-keyscan -t rsa $KNOWN_HOSTS 2>>$LOG_FILE | su-exec $USER tee -a $USERLAND/.ssh/known_hosts
    fi
else
    USER=`guest_user`
fi

su-exec $USER "$@" 2>&1

[ -z "$KEEP_ALIVE" ] || /keep-alive
