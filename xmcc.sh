#!/bin/bash

VERSION=0.12.2
FILE_RELEASE=monoeciCore-${VERSION}-linux64-cli.Ubuntu16.04.tar.gz
URL_RELEASE=https://github.com/monacocoin-net/monoeci-core/releases/download/${VERSION}/${FILE_RELEASE}

function xmcc_dependency() {
	sudo apt-get update
	sudo apt-get -y install unzip
	sudo apt-get -y install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libboost-all-dev unzip libminiupnpc-dev python-virtualenv
	sudo apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
	sudo apt-get -y install software-properties-common && add-apt-repository ppa:bitcoin/bitcoin
	sudo apt-get update
	sudo apt-get -y install libdb4.8-dev libdb4.8++-dev
	sudo apt-get -y install libzmq3-dev
}

function xmcc_install() {
	xmcc_dependency
	echo "$(tput setaf 1)[INSTALL] XMCC MN $(tput sgr0)"		
	pushd ~/
		wget ${URL_RELEASE}
		tar xzvf ${FILE_RELEASE} ./monoeci
		chmod +x monoecid monoeci-tx monoeci-cli
	popd
	xmcc_run
	xmcc_sentinel
	echo "$(tput setaf 1)[INSTALL] XMCC MN Complete! $(tput sgr0)"
}

function xmcc_sentinel() {
	pushd ~/.monoeciCore
		git clone https://github.com/monacocoin-net/sentinel.git
		pushd sentinel
			virtualenv ./venv
			./venv/bin/pip install -r requirements.txt
		popd
	popd
}

function xmcc_run() {
	echo "$(tput setaf 1)[RUN] XMCC $(tput sgr0)"		
    pushd ~/monoeci/
    	./monoecid
    popd
}

function xmcc_stop() {
	echo "$(tput setaf 1)[STOP] XMCC Wallet$(tput sgr0)"	
	pkill monoecid
}

function xmcc_update() {
	xmcc_stop
	git pull
	xmcc_install
	xmcc_run
}

function xmcc_conf() {
	echo "$HOME/.monoeciCore/monoeci.conf"
}

COMMAND=$1


if [ "${COMMAND}" = "install" ]; then 
	xmcc_install
fi

if [ "${COMMAND}" = "run" ]; then 
	xmcc_run
fi

if [ "${COMMAND}" = "stop" ]; then 
	xmcc_stop
fi

if [ "${COMMAND}" = "update" ]; then 
	xmcc_update
fi
