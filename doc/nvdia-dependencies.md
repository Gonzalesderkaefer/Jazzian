# Dependencies for NVIDIA Driver


Debian dependencies:
```
sudo apt install linux-headers-$(uname -r) gcc make build-essential libnvidia-egl-wayland1 dkms pkg-config libglvnd-dev
```
Fedora dependencies:
```
sudo dnf install kernel-devel libglvnd-devel
```
