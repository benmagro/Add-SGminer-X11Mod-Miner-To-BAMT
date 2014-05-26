#!/bin/sh
mine stop
sleep 5
cd /opt/miners/
git clone https://github.com/lasybear/sph-sgminer_x11mod.git sgminer-x11mod
cd /opt/miners/sgminer-x11mod
make clean
sleep 5
chmod +x autogen.sh
./autogen.sh
sleep 2
CFLAGS="-O2 -Wall -march=native -I /opt/AMDAPP/include/" LDFLAGS="-L/opt/AMDAPP/lib/x86" ./configure --enable-opencl
sleep 5
make install
sleep 5
clear
cp example.conf /etc/bamt/sgminer-x11mod.conf
cd /etc/bamt/
patch /etc/bamt/bamt.conf <<.
115a116
>   cgminer_opts: --api-listen --config /etc/bamt/sgminer-x11mod.conf
124a126
>   # Sgminer X11 Mod "DRK"
130a133
>   miner-sgminer-x11mod: 1
.
patch /opt/bamt/common.pl <<.
1477a1478,1480
>       } elsif (\${\$conf}{'settings'}{'miner-sgminer-x11mod'}) {
>         \$cmd = "cd /opt/miners/sgminer-x11mod/;/usr/bin/screen -d -m -S sgminer-x11 /opt/miners/sgminer-x11mod/sgminer \$args";
>         \$miner = "sgminer-x11";
.
cd /etc/bamt/
patch /etc/bamt/blake.conf <<.
19a20,23
> "api-listen": true,
> "api-port": "4028",
> "api-allow": "W:127.0.0.1",
> 
.
echo 'X11Mod Miner Installed.'
echo 'Please review your /etc/bamt/bamt.conf to enable.'
echo 'Configure /etc/bamt/sgminer-x11mod.conf with pool'
