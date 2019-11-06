#!/bin/bash

PIDFile=./.notebook.pid

if [[ $1 == 'start' ]] ; then
    if [[ -f "$PIDFile" ]]; then
	echo 'notebook already started'
    else
	echo 'starting notebook'
	set -a
	source ./.env

	jupyter notebook </dev/null &>/dev/null &
	echo $! > $PIDFile
    fi
elif [[ $1 == 'stop' ]] ; then
    if [[ -f "$PIDFile" ]]; then
	echo 'stopping notebook'
	kill $(cat $PIDFile)
	rm $PIDFile
    else
	echo 'notebook not started'
    fi
else
    echo 'start the notebook with'
    echo './notebook.sh start'
    echo 'stop the notebook with'
    echo './notebook.sh stop'
fi
