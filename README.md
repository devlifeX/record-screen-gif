# Record screen gif
This isn't standalone program, this is solution for record selected region with gif output

![alt tag](https://raw.githubusercontent.com/devlifex/record-screen-gif/master/recored-2016-10-14_200028-opt.gif)

You need record screen with gif output also need optimize gif file?

Do the following steps

Dependencies
========
Run following command to ensure dependencies are ok.
notice: if you are on debian base like(Ubuntu, Mint etc) run below command
```bash
sudo apt-get install byzanz dh-autoreconf
```
Install xrectsel
========

```bash
cd /tmp
git clone https://github.com/lolilolicon/xrectsel.git
cd xrectsel
chmod 777 bootstrap
./bootstrap
./configure --prefix /usr
make
sudo make install
```
Install giflossy
========

```bash
cd /tmp
git clone https://github.com/pornel/giflossy.git
cd giflossy
chmod 777 bootstrap.sh
./bootstrap.sh
./configure --prefix /usr
make
sudo make install
```
Go to ``record-screen-gif`` directory and run
```bash
./installer_screen_record.sh
```
You can use 
```bash
screen_record
```
for recording

