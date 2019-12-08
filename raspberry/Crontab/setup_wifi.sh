#!/bin/sh

# script to setup wifi interface to allow one single physical interface can seves as AP and Station

# make a reacord

echo "start at" >> /root/cron-record
date >> /root/cron-record

# 1. Create virtual interface from physical interface to have type of AP (donno why the type is call '__ap' here)
/usr/sbin/iw phy#0 interface add wlan0ap type __ap

# 2. Run hostapd to setup the AP
/usr/sbin/hostapd -B -P /run/hostapd.pid -d /etc/hostapd/hostapd.conf

# 3. Setup static IP address on AP interface
/usr/sbin/ip add add 192.168.10.1/24 dev wlan0ap

# 4. Run dnsmasq services on the AP interface
/usr/bin/systemctl start dnsmasq

# 5. Start the wpa_supplicant on wlan0 interface to attach to outside PA
/usr/sbin/wpa_supplicant -i wlan0 -B -c /etc/wpa_supplicant/wpa_supplicant-wlan0.conf

# 6. Run DCHP client to get IP address
# sleep 30 sec to wait wlan0 up and running
sleep 30
/usr/sbin/dhclient -v wlan0

# 7. Auto ssh to hkzbox to setup remote access
sleep 10
#/usr/bin/autossh -M 0 -T -N hkzbox &
/usr/bin/autossh -M 0 -T -N -f hkzbox

echo "end at" >> /root/cron-record
date >> /root/cron-record
