#!/usr/bin/bash
mamba run -n vscode code-server --auth none --port=$1  .