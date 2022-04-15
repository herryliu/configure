The piRouter setup is based on following:
1. Disable a multiple default network related services including:
- NetworkManager
- dhcpcd
- dnsmasq
- wpa_supplicant

2. The wifi control changed from wpa_supplicant to iwd since iwd does better job on the ssid scanning

3. The piRouter is defined as a systemd service now which will start after all other system wide daemon started

4. Run ./setup.sh to polulate the configuration files ./conf. The seutp script will  copy config to right location or make proper sym-links.

5. All configuration are in ./setting.sh --> mainly to have mac to interface mapping

6. To regen the config, remove all files in ./conf and run the ./setup.sh

7. Create sym-link "piRouter" pointing to main running script (ap.sh.iwd)

8. piRouter will send notificaiton to iPhone if it can get internet connectivity after the bootup
