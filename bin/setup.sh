#!/bin/bash

# set -o xtrace

CURDIR=$(cd `dirname $0` && pwd)
STEAMCMDDIR=/var/tmp/steamcmd
INSTALLDIR=/data/arma3

STEAM_USERNAME=
STEAM_PASSWORD=

subfile () {
    IN=$1
    OUT=$2
    sed -e "s#@@STEAM_USER@@#$STEAM_USERNAME#g" \
        -e "s#@@STEAM_PASS@@#$STEAM_PASSWORD#g" \
        -e "s#@@INSTALLDIR@@#$INSTALLDIR#g" \
        $IN > $OUT
}

install_packages() {
    apt-get install ia32-libs openjdk-7-jre-headless:i386
}

gather_credentials() {
    echo "Enter steam credentials"
    echo -n "Username: "
    read STEAM_USER
    echo -n "Password: "
    read -s STEAM_PASSWORD
}


install_steamcmd() {
    mkdir -p $STEAMCMDDIR
    cd $STEAMCMDDIR
    subfile $CURDIR/steamcmd.cfg.in $STEAMCMDDIR/steamcmd.cfg
    curl http://media.steampowered.com/installer/steamcmd_linux.tar.gz \
        | tar zxvf -
}


install_game() {
    cd $STEAMCMDDIR
    ./steamcmd.sh +runscript $STEAMCMDDIR/steamcmd.cfg
}


[ -z $STEAM_USERNAME ] && gather_credentials
install_steamcmd
install_game
