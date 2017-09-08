# Install Magic BBR
yum install -y make gcc
wget -O ./tcp_tsunami.c https://raw.githubusercontent.com/aroberts11/MagicBBR/master/tcp_tsunami.c
echo "obj-m:=tcp_tsunami.o" > Makefile
make -C /lib/modules/$(uname -r)/build M=`pwd` modules CC=/usr/bin/gcc
chmod +x ./tcp_tsunami.ko
cp -rf ./tcp_tsunami.ko /lib/modules/$(uname -r)/kernel/net/ipv4
insmod tcp_tsunami.ko
depmod -a
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=tsunami" >> /etc/sysctl.conf
