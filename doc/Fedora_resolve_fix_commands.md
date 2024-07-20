## Get Resolve to run on Fedora 39

Installing missing packages:

`sudo dnf install fuse libxcrypt-compat`

Removing/moving files:
```
sudo mv /opt/resolve/libs/libglib-2.0.so* ~/
sudo mv /opt/resolve/libs/libgio-2.0.so* ~/
sudo mv /opt/resolve/libs/libgmodule-2.0.so* ~/ 
```
