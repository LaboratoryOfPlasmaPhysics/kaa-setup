import json
import os

if os.path.exists("/opt/conda/share/jupyter/labextensions/@krassowski/jupyterlab-lsp/schemas/@krassowski/jupyterlab-lsp/plugin.json"):
  js=json.load(open("/opt/conda/share/jupyter/labextensions/@krassowski/jupyterlab-lsp/schemas/@krassowski/jupyterlab-lsp/plugin.json","r"))
  js['properties']['language_servers']['default']["pylsp"] = {
        "serverSettings": {
          "pylsp.plugins.pydocstyle.enabled": True,
          "pylsp.plugins.pyflakes.enabled": False,
          "pylsp.plugins.flake8.enabled": True
        }
  }

  with open("/opt/conda/share/jupyter/labextensions/@krassowski/jupyterlab-lsp/schemas/@krassowski/jupyterlab-lsp/plugin.json","w") as f:
      f.write(json.dumps(js))
      f.close

