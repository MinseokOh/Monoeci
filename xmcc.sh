#!/bin/bash


function xmcc_install() {
	pushd ~/
		wget 'https://github.com/monacocoin-net/monacoCoin-Core/releases/download/0.12.1.5.1/monacoCoinCore-0.12.1.5.1-linux64-cli.taz.gz'
		tar xzvf monacoCoinCore-0.12.1.5.1-linux64-cli.taz.gz
		chmod +x monacoCoind monacoCoin-tx monacoCoin-cli
	popd
}

function xmcc_run() {
    pushd ~/
    	./monacoCoind
    popd
}


COMMAND=$1

if [ "${COMMAND}" = "install" ]; then 
	xmcc_install
fi

if [ "${COMMAND}" = "run" ]; then 
	xmcc_run
fi
