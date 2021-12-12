#!/bin/bash

APP_PATH=/root/Hamr/hamr-doc/docs/.vuepress/dist
PORT=4010

echo $1 $PORT

function killProsess() {
	NAME=$1
	echo $NAME

	PID=$(lsof -i:$PORT |awk -F'[ ,/n]' '{print $2}')
	echo "old PID: $PID"
	[ $PID ] && kill -9 $PID
}

function start() {
	cd $APP_PATH
	nohup http-server -p $PORT > /dev/null 2>/dev/null &
	sleep 0.5s 
	PID=$(lsof -i:$PORT |awk -F'[ ,/n]' '{print $2}')
	echo "new PID: $PID"
}

function stop() {
	killProsess "hamr-doc"
}

function restart() {
	stop
	start
}

case "$1" in
	start )
		echo "*****  start  *****"
		start
		echo "***** success *****"
		;;
	stop )
		echo "*****  stop   *****"
		stop
		echo "***** success *****"
		;;
	restart )
		echo "***** restart *****"
		restart
		echo "***** success *****"
		;;
	* )
		echo "no command"
		;;
esac
