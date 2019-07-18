FROM ubuntu:bionic
WORKDIR /app
RUN apt-get update
RUN apt-get install -y gnupg curl vim git software-properties-common

# Add repositories
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN add-apt-repository ppa:longsleep/golang-backports

# Install
RUN apt-get update
RUN apt-get install -y vim golang-go nodejs
RUN curl https://sh.rustup.rs -sSf | sh

RUN mkdir -p /go
ENV GOPATH /go
ENV PATH="/go/bin:${PATH}"
ENTRYPOINT ["/bin/bash"]
