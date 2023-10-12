FROM debian:bookworm
LABEL server_version=1.20.2
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update

RUN apt-get install -y  vim wget  iproute2 sudo openjdk-17-jdk-headless


RUN useradd -s /bin/bash -m mc_server && usermod -aG sudo mc_server

RUN  echo "mc_server ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN wget -O /home/mc_server/minecraft_server.jar https://piston-data.mojang.com/v1/objects/5b868151bd02b41319f54c8d4061b8cae84e665c/server.jar





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
