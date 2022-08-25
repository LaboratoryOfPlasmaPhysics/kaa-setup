#!/bin/bash
tee -a /etc/jupyter/jupyter_config.py << END

c.ServerProxy.servers = {
  'vs-code': {
    'command': ['/usr/local/bin/start_vscode.sh', '{port}'],
    'timeout': 20,
    'new_browser_tab': True,
    'launcher_entry': {
        'title': 'VS Code',
        'icon_path': '/opt/conda/envs/vscode/lib/python3.10/site-packages/jupyter_vscode_proxy/icons/vscode.svg'
        }
  }
}
END