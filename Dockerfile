FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update

RUN apt install -y  vim wget  iproute2 sudo



RUN apt install -y openjdk-17-jdk-headless

RUN useradd -s /bin/bash -m mc_server && usermod -aG sudo mc_server

RUN  echo "mc_server ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN wget -O /home/mc_server/minecraft_server.jar https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar
EXPOSE 25565




COPY system/home/mc_server/start.sh /home/mc_server/start.sh
RUN chown mc_server /home/mc_server/start.sh && chmod +x /home/mc_server/start.sh

#COPY system/home/mc_server/start_ssh.sh /home/mc_server/start_ssh.sh
#RUN chown mc_server /home/mc_server/start_ssh.sh && chmod u+x /home/mc_server/start_ssh.sh

COPY system/home/mc_server/start_mcs.sh /home/mc_server/start_mcs.sh
RUN chown mc_server /home/mc_server/start_mcs.sh && chmod u+x /home/mc_server/start_mcs.sh


VOLUME /home/mc_server/server_data
USER mc_server
WORKDIR /home/mc_server/server_data


ENTRYPOINT ["/home/mc_server/start.sh"]
#ENTRYPOINT ["/bin/bash"]
