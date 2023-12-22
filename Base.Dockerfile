FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y \
        sudo wget iputils-ping systemctl curl etcd net-tools nano grep lsb-core \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
