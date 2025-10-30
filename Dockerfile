FROM ubuntu:24.04

# see https://signal.org/download/linux/
# https://community.frame.work/t/need-help-running-signal-desktop-in-distrobox/63726

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get -y install  \
    gpg \
    wget \
    libasound2t64

RUN mkdir -p /opt/signal
WORKDIR /opt/signal
RUN wget -qO- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg;

RUN cat signal-desktop-keyring.gpg | tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

RUN wget -qO signal-desktop.sources https://updates.signal.org/static/desktop/apt/signal-desktop.sources;
RUN cat signal-desktop.sources | tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null

RUN apt-get update && apt-get -y install signal-desktop

