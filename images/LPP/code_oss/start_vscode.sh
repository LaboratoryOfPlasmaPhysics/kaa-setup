#!/usr/bin/bash
mamba run -n vscode /usr/bin/code-server --disable-telemetry --auth none --port=$1  .