#!/bin/bash

echo "[i] Backing up root.hints ..."
cd /var/lib/unbound
sudo cp root.hints $(date +%F).root.hints

if [ -s $(date +%F).root.hints ]
then
     echo "[✓] Backup root.hints success!"
     echo ""
     echo "[i] Updating root.hints ..."
     sudo wget -nv -O named.root https://www.internic.net/domain/named.root
     if [ -s named.root ]
     then
          sudo mv -f named.root root.hints
          echo "[✓] Update root.hints success!"
          echo ""
          echo "[i] Restarting unbound service ..."
          sudo service unbound restart
          sudo service unbound status
          exit 0
     else
          echo "[✗] Update failed!"
          exit 1
     fi
else
     echo "[✗] Backup failed!"
     exit 1
fi
