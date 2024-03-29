#!/usr/bin/python3

import re
import subprocess
import time

class Wifi(object):

    def __init__(self, intf="wan"):
        self.intfs = [intf]
        self.wpa = '/usr/sbin/wpa_cli'
        self.wpaAddNetwork = '/home/pi/piRouter/wpaNetwork.sh'
        self.macChanger = '/usr/bin/macchanger'
        self.ipCMD = '/usr/sbin/ip'
        self.sendNote = '/home/pi/piRouter/push.sh'
        self.macRandom = '/home/pi/piRouter/mac.sh'
        self.network = []
        self.getKnownNetworks()

    '''
    def changeMac(self, intf):
        # shutdown interface
        cmd = "sudo {} link set down dev {}".format(self.ipCMD, intf)
        self.runCMD(cmd)
        # change the mac address to a random one
        # macchanger -r intf
        cmd = "sudo {} -r {}".format(self.macChanger, intf)
        self.runCMD(cmd)
        # enable interface
        cmd = "sudo {} link set up dev {}".format(self.ipCMD, intf)
        self.runCMD(cmd)
        # reconnect to AP
        cmd = "sudo {} -i {} reassociate".format(self.wpa, intf)
        self.runCMD(cmd)
        # sleep for 10 second before send the notification
        time.sleep(20)
        # send the notificaiton
        self.pushNotification("MAC Address Change")
    '''
    def changeMac(self, intf):
        # run /home/pi/piRouter/mac.sh wan
        cmd = "{} {}".format(self.macRandom, intf)
        self.runCMD(cmd)

    def pushNotification(self, title):
        # get the interface status
        cmd = "{} address list".format(self.ipCMD)
        result = self.runCMD(cmd)
        # send notification
        cmd = '{} "{}" "{}"'.format(self.sendNote, title, result)
        self.runCMD(cmd)

    def addNetwork(self, intf, ssid, psk):
        # add netowkr and get the network id
        # sudo wpa_cli -i wan add_network
        cmd = "sudo {} -i {} add_network".format(self.wpa, intf)
        id = self.runCMD(cmd).strip()
        # add ssid to the new network id
        # sudo wpa_cli -i wan set_network ssid \"ssid\"
        cmd = "sudo {} -i {} set_network {} ssid \\\"{}\\\"".format(self.wpa, intf, id, ssid)
        self.runCMD(cmd)
        # add psk key to the new network id
        # sudo wpa_cli -i wan set_network psk \"psk\"
        if psk:
            cmd = "sudo {} -i {} set_network {} psk \\\"{}\\\"".format(self.wpa, intf, id, psk)
        else:
            cmd = "sudo {} -i {} set_network {} key_mgmt NONE".format(self.wpa, intf, id)
        self.runCMD(cmd)
        # enable the network (by default it's disabled)
        cmd = "sudo {} -i {} enable_network {}".format(self.wpa, intf, id)
        self.runCMD(cmd)

        # refresh the networ list
        self.getKnownNetworks()

    def deleteNetwork(self, intf, id):
        cmd = "sudo {} -i {} remove_network {}".format(self.wpa, intf, id)
        self.runCMD(cmd)
        self.getKnownNetworks()

    def saveNetwork(self, intf):
        cmd = "sudo {} -i {} save".format(self.wpa, intf)
        self.runCMD(cmd)

    def confReload(self, intf):
        cmd = "sudo {} -i {} reconfig".format(self.wpa, intf)
        self.runCMD(cmd)
        self.getKnownNetworks()

    def getScan(self):
        result = ""
        for intf in self.intfs:
            cmd = "sudo {} -i {} scan".format(self.wpa, intf)
            self.runCMD(cmd)
            time.sleep(5)
            cmd = "sudo {} -i {} scan_result".format(self.wpa, intf)
            result += self.runCMD(cmd)
        return result

    def connectNetwork(self, intf, id):
        for net in self.network:
            if net['interface'] == intf and net['id'] == id:
                # disconnect the current connection
                cmd = "sudo {} -i {} select_network {}".format(self.wpa, intf, id)
                self.runCMD(cmd)

    def getStatus(self):
        finalResult = ''
        for intf in self.intfs:
            cmd = "sudo {} -i {} status".format(self.wpa, intf)
            finalResult += self.runCMD(cmd)
        return finalResult


    def addIntf(self, intf):
        if intf not in self.intfs:
            self.intfs.append(intf)

    def getKnownNetworks(self):
        self.network = []
        for intf in self.intfs:
            print("interface: {}".format(intf))
            self.getKnownNetworksByIntf(intf)

    def getKnownNetworksByIntf(self, intf):
        cmd = "sudo {} -i {} list_networks".format(self.wpa, intf)
        result = self.runCMD(cmd).split('\n')
        for line in result:
            #line = re.sub(' +', ' ', line)
            print(line)
            rec = (line.split('\t'))
            if len(rec) > 1:
                # the network entry found
                self.network.append({
                    "id": rec[0],
                    "ssid": rec[1],
                    "interface": intf,
                })
        print(self.network)

    def runCMD(self, cmd):
        print("cmd {}".format(cmd))
        result = subprocess.run(cmd,
                                shell=True,
                                stdout=subprocess.PIPE,
                                stderr=subprocess.PIPE)
        return result.stdout.decode('utf-8')

if __name__ == '__main__':
    wifi = Wifi()
    wifi.addIntf('mon1')
    wifi.getKnownNetworks()


