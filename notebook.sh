#!/bin/bash

PIDFile=./.notebook.pid


start (){
    if [[ -f "$PIDFile" ]]; then
	echo 'notebook already started'
    else
	echo 'starting notebook'
	set -a
	source ./.env
	
	jupyter notebook </dev/null &>/dev/null &
	echo $! > $PIDFile
    fi
}

stop (){
    if [[ -f "$PIDFile" ]]; then
	echo 'stopping notebook'
	kill $(cat $PIDFile)
	rm $PIDFile
    else
	echo 'notebook not started'
    fi
}

restart (){
    stop
    start
}

reset (){
    rm $PIDFile
}

usage (){
  echo './notebook.sh {start|stop|restart|reset}'
}


case "$1" in
    start)
	start
	;;
    stop)
	stop
	;;
    restart)
	restart
	;;
    *)
	usage
	;;
esac
