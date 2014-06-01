#!/bin/sh
mine stop
sleep 5
cp common.unpatch.diff /tmp/
cd /opt/miners/
rm -rf sgminer-x11mod
cd /etc/bamt/
mv sgminer-x11mod.conf sgminer-x11mod.conf.bak
cd /opt/bamt/
cp /tmp/common.unpatch.diff .
sleep 2
patch common.pl < common.unpatch.diff
rm common.unpatch.diff
echo 'Please remove the following lines from bamt.conf manually'
echo '#cgminer_opts: --api-listen --config /etc/bamt/sgminer-x11mod.conf'
echo '# Sgminer X11 Mod "DRK"'
echo 'miner-sgminer-x11mod: 1'
echo 'Done'