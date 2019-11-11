#!/usr/bin/env sh

cd docker
HTTPPAGEFILE=./.notebookhttp
#BROWSER=start
#BROWSER=xdg-open
BROWSER=chromium

case "$1" in
    up)
	echo 'creating and startting docker notebook'
	docker-compose up | grep -m1 'http://127.0.0.1:' | awk -F' ' '{print $NF}' > $HTTPPAGEFILE
	$BROWSER $(cat $HTTPPAGEFILE)
	;;
    down)
	echo 'removing docker notebook'
	docker-compose down
	rm $HTTPPAGEFILE
	;;
    start)
	echo 'starting notebook'
	if [[ -f "$HTTPPAGEFILE" ]]; then
	    docker-compose start
	    $BROWSER $(cat $HTTPPAGEFILE)
	else
	    echo './docker-notebook.sh up'
	fi
	;;
    stop)
        echo 'stopping notebook'
	docker-compose stop
	;;
    theme)
	case "$2"in
	    reset)
		docker-compose exec give-me-some-credit jt -r
		;;
	    dark)
		docker-compose exec give-me-some-credit jt -t onedork -fs 95 -altp -tfs 11 -nfs 115 -cellw 88% -T
		;;
	    light)
		docker-compose exec give-me-some-credit jt -t grade3 -fs 95 -altp -tfs 11 -nfs 115 -cellw 88% -T
		;;
	esac
	echo 'You need to restart the docker in order to see the effect'
	;;
    *)
	echo 'start the notebook with'
	echo './docker-notebook.sh start'
	echo 'stop the notebook with'
	echo './docker-notebook.sh stop'
esac
