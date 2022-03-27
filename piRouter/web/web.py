#!/usr/bin/python3

import subprocess
from functools import partial

from pywebio.input import *
from pywebio.output import *
from pywebio import start_server, config
from pywebio.session import go_app

from wifi import Wifi

class PiRouter(object):
    def __init__(self, port=28080):
        self.port = port
        self.appList = {"index": self.index, "wifi": self.wifi}
        config(title="piRouter Management Interface")
        self.buttonCMD = {
            'Wifi': ['iw dev', 'iwctl station wan show'],
            'Interface': ['ip address list'],
            'Route': ['ip route list'],
            'Firewall': ['sudo iptables -L -n -v', 'sudo iptables -t nat -L -n -v'],
            'Service': ['systemctl status --type service --no-pager'],
            'Process': ['ps aux'],
            'Journal': ['journalctl -b --no-pager | head -1000'],
        }

    # ----------------- Main Index App -----------------------------------
    def start(self):
        start_server(self.appList, port=self.port, debug=True, cdn=False)

    def runCMD(self, cmd):
        result = subprocess.run(cmd,
                                shell=True,
                                stdout=subprocess.PIPE,
                                stderr=subprocess.PIPE)
        return result.stdout.decode('utf-8')


    def buttonAction(self, choice, id):
        with use_scope('result', clear=True):
            for cmd in self.buttonCMD[choice]:
                put_code(self.runCMD(cmd))

    def shutdownActoin(self, choice, id):
        close_popup()
        with use_scope('result', clear=True):
            if choice == "No":
                put_text(self.runCMD('echo "Shutdown is cancelled!!"'))
            else:
                put_text(self.runCMD('echo "Shutdown!!"'))
                cmd = 'sudo /usr/sbin/poweroff -f'
                self.runCMD(cmd)

    def shutDown(self):
        with use_scope('result', clear=True):
            popup('Are you sure that you want to shutdown the piRouter!!',
                [put_buttons(["No", "Yes"], onclick=partial(self.shutdownActoin, id=1))])


    def index(self):
        #actionList = [showWifi, showInterface, showRoute, showFirewall, shutDown]
        #put_buttons(buttonList, actionList)
        buttonList = self.buttonCMD.keys()
        put_row([
            put_buttons(buttonList, onclick=partial(self.buttonAction, id=1)),
            put_button('Wifi App', onclick=lambda : go_app('wifi', new_window=False)),
            None,
            put_button('Shutdown', self.shutDown, color="danger"),
        ])

    #---------------------- Wifi App ----------------------------
    def wifi(self):
        wi = Wifi()

        put_button('Back To Main', onclick=lambda : go_app('index', new_window=False))

        # Add a new network to configuration file
        def addNetworkAction():
            def checkPSK(psk):
                if len(psk) < 8 and len(psk) > 0:
                    return "psk password is at less 8 charactor long"

            with use_scope("result", clear=True):
                data = input_group("Add New SSID/Password", [
                    input("Interface", name="intf", value="wan"),
                    input("SSID", name="ssid"),
                    input("psk", name="psk", validate=checkPSK),
                ])
                print(type(data['intf']), type(data['ssid']), type(data['psk']))
                print(data['intf'], data['ssid'], data['psk'])
                wi.addNetwork(str(data['intf']), str(data['ssid']), str(data['psk']))
                knownNetworkAction()

        def knownNetworkAction():
            with use_scope("result", clear=True):
                tableHeader = ['interface','id', 'ssid', 'action']

                def clickRow(choice, row):
                    #put_text("click on {} row {}".format(choice, row))
                    if choice == "Connect":
                        intf, id = row.split(',')
                        wi.connectNetwork(intf, id)
                    if choice == "Delete":
                        intf, id = row.split(',')
                        wi.deleteNetwork(intf, id)
                        knownNetworkAction()

                tableList = []
                for rec in wi.network:
                    entry = [rec['interface'],
                            rec['id'],
                            rec['ssid'],
                            put_buttons(['Connect', 'Delete'],
                            onclick=partial(clickRow, row=rec['interface'] + ',' +rec['id'])),
                            ]
                    tableList.append(entry)

                put_table(tableList, header=tableHeader)

        def statusAction():
            with use_scope("result", clear=True):
                put_text(wi.getStatus())

        def scanAction():
            with use_scope("result", clear=True):
                put_text(wi.getScan())

        def saveNetworkAction():
            wi.saveNetwork("wan")

        def reloadConfigAction():
            with use_scope("result", clear=True):
                wi.confReload('wan')
                knownNetworkAction()


        put_row([
            put_button('Known Network', onclick=knownNetworkAction),
            put_button('Status', onclick=statusAction),
            put_button('Scan', onclick=scanAction),
            put_button('Add Network', onclick=addNetworkAction),
            put_button('Save Network', onclick=saveNetworkAction),
            put_button('Reload Config', onclick=reloadConfigAction),
            
        ])
        statusAction()


if __name__ == "__main__":
    pi = PiRouter()
    pi.start()
