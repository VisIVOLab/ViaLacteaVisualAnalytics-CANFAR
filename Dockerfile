FROM ubuntu:focal

ARG VISIVO_VERSION=1.6.2
 
ARG DEBIAN_FRONTEND=noninteractive
 
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get clean && \
    apt-get update && \
    apt-get install --no-install-recommends -y locales acl sssd libnss-sss libpam-sss \
                    xterm libasound2 libgl1-mesa-glx libopengl0 openssl ca-certificates \
					libpython3.8-dev python3-pip && \
    rm -rf /var/lib/apt/lists/*
 
RUN pip3 install --no-cache-dir numpy scipy pvextractor jmespath pyvo

ADD https://github.com/VisIVOLab/ViaLacteaVisualAnalytics/releases/download/$VISIVO_VERSION/ViaLacteaVisualAnalytics-$VISIVO_VERSION-amd64.deb /tmp/visivo.deb
RUN dpkg -i /tmp/visivo.deb && rm -f /tmp/visivo.deb
 
ADD src/nsswitch.conf /etc/
RUN mkdir /skaha
COPY src/startup.sh /skaha/startup.sh
RUN chmod +x /skaha/startup.sh
CMD ["/skaha/startup.sh"]
