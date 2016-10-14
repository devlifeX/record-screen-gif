#!/bin/bash

# Delay before starting
DELAY=3

DIRECTORY="recored"
TIME=$(date +"%Y-%m-%d_%H%M%S")

cd $HOME
if [ ! -d "$DIRECTORY" ]; then
  mkdir -p "$DIRECTORY"
fi

PATHX=`realpath $DIRECTORY`
FILE_NAME="$PATHX/recored-$TIME.gif"



# Sound notification to let one know when recording is about to start (and ends)
beep() {
  paplay /usr/share/sounds/KDE-Im-Irc-Event.ogg &
}

DEFDUR=10

# Custom recording duration as set by user
USERDUR=$(gdialog --title "Duration?" --inputbox "Please enter the screencast duration in seconds" 200 100 2>&1)

# Duration and output file
if [ $USERDUR -gt 0 ]; then
  Duration=$USERDUR
else
  Duration=$DEFDUR
fi



D="--duration=$Duration $FILE_NAME"


# xrectsel from https://github.com/lolilolicon/xrectsel
ARGUMENTS=$(xrectsel "--x=%x --y=%y --width=%w --height=%h") || exit -1

echo Delaying $DELAY seconds. After that, byzanz will start
for (( i=$DELAY; i>0; --i )) ; do
  echo $i
  sleep 1
done
beep
byzanz-record --verbose --delay=0 ${ARGUMENTS} $D
beep
xdg-open "$DIRECTORY"