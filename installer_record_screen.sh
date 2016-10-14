#!/bin/bash
sudo cp byzanz_region.sh /bin
sudo chmod 777 /bin/byzanz_region.sh
sudo echo alias screen_record=\'bash byzanz_region.sh\' >> ~/.bashrc
source ~/.bashrc
echo "screen record insatlled. you can use 'screen_record' command"