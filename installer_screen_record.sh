#!/bin/bash
sudo cp screen_record.sh /bin
sudo chmod 777 /bin/screen_record.sh
sudo echo alias screen_record=\'bash screen_record.sh\' >> ~/.bashrc
source ~/.bashrc
echo "screen record insatlled. you can use 'screen_record' command"