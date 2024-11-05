#!/bin/bash
export JAVA_HOME=/java/jdk-23.0.1/
export PATH="$PATH:/java/jdk-23.0.1/bin"
sudo chown  mc_server -R /home/mc_server/server_data
java -Xmx2048M -Xms1024M -jar /home/mc_server/minecraft_server.jar --initSettings nogui 
sed "s/eula=false/eula=true/" -i.bak eula.txt

java -Xmx2048M -Xms1024M -jar /home/mc_server/minecraft_server.jar nogui 
#/bin/bash