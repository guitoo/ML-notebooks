#!/usr/bin/env sh

cd docker
HTTPPAGEFILE=./.notebookhttp
#BROWSER=start
#BROWSER=xdg-open
BROWSER=chromium

if [[ $1 == 'up' ]] ; then
    echo 'creating and startting docker notebook'
    docker-compose up | grep -m1 'http://127.0.0.1:' | awk -F' ' '{print $NF}' > $HTTPPAGEFILE
    $BROWSER $(cat $HTTPPAGEFILE)
elif [[ $1 == 'down' ]] ; then
    echo 'removing docker notebook'
    docker-compose down
    rm $HTTPPAGEFILE
elif [[ $1 == 'start' ]] ; then
    echo 'starting notebook'
    if [[ -f "$HTTPPAGEFILE" ]]; then
	docker-compose start
	$BROWSER $(cat $HTTPPAGEFILE)
    else
	echo './docker-notebook.sh up'
    fi
    
elif [[ $1 == 'stop' ]] ; then
    echo 'stopping notebook'
    docker-compose stop
elif [[ $1 == 'theme' ]] ; then
    if [[ $2 == 'reset' ]] ; then
	docker-compose exec give-me-some-credit jt -r
    elif [[ $2 == 'dark' ]] ; then
	docker-compose exec give-me-some-credit jt -t onedork -fs 95 -altp -tfs 11 -nfs 115 -cellw 88% -T
    elif [[ $2 == 'light' ]] ; then
	docker-compose exec give-me-some-credit jt -t grade3 -fs 95 -altp -tfs 11 -nfs 115 -cellw 88% -T
    fi
    echo 'You need to restart the docker in order to see the effect'
else
    echo 'start the notebook with'
    echo './docker-notebook.sh start'
    echo 'stop the notebook with'
    echo './docker-notebook.sh stop'
fi
