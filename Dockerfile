FROM ubuntu:18.04

MAINTAINER jecnua "fabrizio.sabatini.it@gmail.com"

# https://github.com/chaostoolkit/chaostoolkit
# https://github.com/chaostoolkit/chaostoolkit-reporting
# https://github.com/pypa/pip/issues/5240
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true && \
  apt-get update && \
  apt-get install -y curl git htop && \
  apt-get install -y python3 python3-pip texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra python3-tk pandoc libffi-dev libcairo2-dev && \
  pip3 install --upgrade pip==9.0.3 && \
  pip3 install chaostoolkit && \
  pip3 install chaostoolkit-reporting && \
  curl https://raw.githubusercontent.com/chaostoolkit/chaostoolkit-tutorials/master/01-chaostoolkit-getting-started/report/assets/chaos-report.json > chaos-report.json

RUN curl -O 'https://storage.googleapis.com/golang/go1.10.1.linux-amd64.tar.gz' && \
  tar -xf go1.10.1.linux-amd64.tar.gz && \
  mv go /usr/local && \
  export PATH=$PATH:/usr/local/go/bin && \
  export GOPATH="$HOME/go" && \
  export GOROOT="$(go env GOROOT)" && \
  export PATH="$GOPATH/bin:$GOROOT/bin:$PATH" && \
  go get github.com/netflix/chaosmonkey/cmd/chaosmonkey

RUN echo 'PATH="$PATH:/usr/local/go/bin"' >> /root/.bashrc && \
  echo 'GOPATH="$HOME/go"' >> /root/.bashrc && \
  echo 'GOROOT="$(go env GOROOT)"' >> /root/.bashrc && \
  echo 'PATH="$GOPATH/bin:$GOROOT/bin:$PATH"' >> /root/.bashrc && \
  echo 'export LC_ALL=C.UTF-8'  >> /root/.bashrc && \
  echo 'export LANG=C.UTF-8'  >> /root/.bashrc

# Metadata params
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF

# Metadata
LABEL org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.name="" \
  org.label-schema.description="" \
  org.label-schema.url="" \
  org.label-schema.vcs-url=$VCS_URL \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.version=$VERSION \
  com.jecnua.docker.dockerfile="/Dockerfile" \
  com.jecnua.license=""
