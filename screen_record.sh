#!/bin/bash

# --console : use ctrl+c to stop recording
if [ "$1" == "--console" ]; then use_trap=1; fi

# Delay before starting
DELAY=3

DIRECTORY="recored"
TIME=$(date +"%Y-%m-%d_%H%M%S")

cd $HOME
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p "$DIRECTORY"
fi

PATHX=`realpath $DIRECTORY`
ABS_FILE_NAME="$PATHX/recored-$TIME"
FILE_NAME="$PATHX/recored-$TIME.gif"



# Sound notification to let one know when recording is about to start (and ends)
beep() {
  paplay /usr/share/sounds/KDE-Im-Irc-Event.ogg &
}


if [ "$use_trap" != 1 ]; then
	# Custom recording duration as set by user
	USERDUR=$(gdialog --title "Duration?" --inputbox "Please enter the screencast duration in seconds" 200 100 2>&1)

	# Duration and output file
	if [[ "$USERDUR" != "" && $USERDUR -gt 0 ]]; then
	  Duration=$USERDUR
	else
	  echo "Operation abort by user"
	  exit
	fi

	D="--duration=$Duration $FILE_NAME"
else
	D="--duration=36000 $FILE_NAME"
fi


# xrectsel from https://github.com/lolilolicon/xrectsel
ARGUMENTS=$(xrectsel "--x=%x --y=%y --width=%w --height=%h") || exit -1

echo Delaying $DELAY seconds. After that, byzanz will start
for (( i=$DELAY; i>0; --i )) ; do
  echo $i
  sleep 1
done

function post_process()
{
	echo "post process"
	beep
	gifsicle -O3 --lossy=50 -o "$ABS_FILE_NAME-opt.gif" "$FILE_NAME" 
	xdg-open "$DIRECTORY"
}

function trap_ctrlc()
{
	post_process
	exit 0
}

beep
byzanz-record --verbose --delay=0 ${ARGUMENTS} $D &
if [ "$use_trap" != 1 ]; then
	wait
else
	trap "trap_ctrlc" 2
	echo "press ctrl+c to stop recording"
	while true; do
		sleep 1
	done
fi
post_process
