{
    "configurations": {
        "run": {
            "adapter": "debugpy",
            "default": true,
            "configuration": {
                "request": "launch",
                "type": "python",
                "cwd": "${workspaceRoot}",
                "stopOnEntry": true,
                "program": "${file}",
                "python": "/usr/bin/python2.7"
            },
            "breakpoints": {
                "exception": {
                    "raised": "N",
                    "uncaught": "",
                    "userUnhandled": ""
                }
            }
        }
    }
}
