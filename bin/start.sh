#!/bin/bash

# Display IP address

ip -f inet addr show eth0

cd /data/arma3
sudo su -c "LD_LIBRARY_PATH=$^C_LIBRARY_PATH:/usr/lib/jvm/java-7-openjdk-i386/jre/lib/i386/jamvm ./arma3server -netlog" arma
