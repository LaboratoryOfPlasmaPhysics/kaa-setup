#!/usr/bin/bash
mamba run -n vscode code-server --disable-telemetry --auth none --port=$1  .