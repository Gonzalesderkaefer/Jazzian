
# Determining what distro is running 
release="$(cat /etc/os-release)";

waylandDefaultMenu="";
waylandAppMenu="";
xorgDefaultMenu="";
xorgAppMenu="";


case $release in
    *"Debian"* | *"debian"* | *"DEBIAN"*) 
        ;;
    *"Fedora"* | *"fedora"* | *"FEDORA"*) 
        ;;
    *"Arch Linux"* | *"arch linux"* | *"ARCH LINUX"*) 
        ;;
esac
