FROM debian:bookworm
LABEL server_version=1.21.8
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update

RUN apt-get install -y  vim wget  iproute2 curl sudo

RUN mkdir /java && \
    curl -L https://download.java.net/java/GA/jdk23.0.1/c28985cbf10d4e648e4004050f8781aa/11/GPL/openjdk-23.0.1_linux-x64_bin.tar.gz | tar -xz -C /java
    


RUN useradd -s /bin/bash -m mc_server && usermod -aG sudo mc_server && \
    echo export PATH="$PATH:/java/jdk-23.0.1/bin"  >> /home/mc_server/.profile && \
    echo export 'JAVA_HOME=/java/jdk-23.0.1/' >> /home/mc_server/.profile 

RUN  echo "mc_server ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN wget -O /home/mc_server/minecraft_server.jar https://piston-data.mojang.com/v1/objects/6bce4ef400e4efaa63a13d5e6f6b500be969ef81/server.jar





COPY system/home/mc_server/start.sh /home/mc_server/start.sh
RUN chown mc_server /home/mc_server/start.sh && chmod +x /home/mc_server/start.sh

#COPY system/home/mc_server/start_ssh.sh /home/mc_server/start_ssh.sh
#RUN chown mc_server /home/mc_server/start_ssh.sh && chmod u+x /home/mc_server/start_ssh.sh

COPY system/home/mc_server/start_mcs.sh /home/mc_server/start_mcs.sh
RUN chown mc_server /home/mc_server/start_mcs.sh && chmod u+x /home/mc_server/start_mcs.sh

EXPOSE 25565
VOLUME /home/mc_server/server_data
USER mc_server
WORKDIR /home/mc_server/server_data


ENTRYPOINT ["/home/mc_server/start.sh"]
#ENTRYPOINT ["/bin/bash"]
