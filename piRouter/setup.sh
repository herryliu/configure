#!/bin/sh

# create all configuration file required for the piRouter

# 0. source from global setting
. ./setting.sh

# 0.5 Create udev file
# define all the mac address for wifi interace in the setting.sh

if [ ! -f "${conf_dir}/70-piRouter.rules" ]
then
    # Create the file
    touch ${conf_dir}/70-piRouter.rules
    IFS=','
    for line in ${udevList}
    do
        echo "${line}"
        mac=`echo "${line}" | cut -d ' ' -f 1`
        intName=`echo "${line}" | cut -d ' ' -f 2`
        echo  "SUBSYSTEM==\"net\", ACTION==\"add|change\", ATTR{address}==\"${mac}\", NAME=\"${intName}\"" >> ${conf_dir}/70-piRouter.rules
    done
fi

# setup link from /ect/udev/rules
sudo ln -s -f "${conf_dir}/70-piRouter.rules" /etc/udev/rules.d

# 1. Create piRouter service file

if [ ! -f "${conf_dir}/piRouter.service" ]
then
cat > "${conf_dir}/piRouter.service" <<EOL
[Unit]
Description=Pi Wifi Router
After=multi-user.target

[Service]
Type=forking
User=pi
ExecStart=/bin/sh ${EXECROOT}/piRouter
WorkingDirectory=${EXECROOT}

[Install]
WantedBy=default.target
EOL
fi

# create the soft link from systemd directory
sudo ln -s -f ${EXECROOT}/conf/piRouter.service /etc/systemd/system

# 2. Create  hostapd.conf
if [ ! -f "${conf_dir}/hostapd.conf" ]
then
cat >"${conf_dir}/hostapd.conf" <<EOL
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0
interface=${ap}
country_code=SG
driver=nl80211
ssid=${APSSID}
hw_mode=g
channel=11
wmm_enabled=0
macaddr_acl=0
auth_algs=1
wpa=2PASSPHRASE
wpa_passphrase=herrykali123
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP CCMP
rsn_pairwise=CCMP
EOL

fi

# 3. Create dnsmasq.conf for AP interface
if [ ! -f "${conf_dir}/dnsmasq.conf.${ap}" ]
then
cat >"${conf_dir}/dnsmasq.conf.${ap}" <<EOL
interface=${ap}
no-dhcp-interface=lo,${wan}
except-interface=lo,${wan}
bind-interfaces
server=${ap_net}.1
domain-needed
bogus-priv
dhcp-range=${ap_net}.50,${ap_net}.150,12h
EOL
fi

# 4. Create  dnsmasq.conf for OTG USB interface
if [ ! -f "${conf_dir}/dnsmasq.conf.${otg_int}" ]
then
cat >"${conf_dir}/dnsmasq.conf.${otg_int}" <<EOL
port=0
interface=${otg_int}
no-dhcp-interface=lo,${wan}
except-interface=lo,${wan}
bind-interfaces
domain-needed
bogus-priv
dhcp-range=${otg_net}.50,${otg_net}.150,12h
EOL
fi

# 5. Create  wpa_supplicant.conf

if [ ! -f "${conf_dir}/wpa_supplicant.conf" ]
then
cat >"${conf_dir}/wpa_supplicant.conf" <<EOL
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=SG

network={
        ssid="herry_home_5G"
        psk=6c181db8bbffdfed95ecfff4a1e83f1725ce10022b38b928f89b6c9b06e6ec1c
        priority=1
        id_str="AP1"
}

network={
        ssid="herry_home"
        psk=d2840a83e8af7ec2ff8f865f849c9b8987997f104d4a77e1b5ddb1c8f197a14b
        priority=2
        id_str="AP1"
}

network={
        ssid="hrt-sin"
        psk=96f17da7089e10fec555e15c8e08cbb0ba3c6a1b41b9d395bad0d40f465deb75
        id_str="AP1"
}

network={
        ssid="#WiFi@Changi"
        key_mgmt=NONE
        id_str="AP1"
}

network={
        ssid="LWB Free"
        key_mgmt=NONE
        id_str="AP1"
}

network={
	ssid="Maritime Square"
	key_mgmt=NONE
	id_str="AP1"
}

network={
	ssid="#HKAirport Free WiFi"
	key_mgmt=NONE
	id_str="AP1"
}
EOL
fi
