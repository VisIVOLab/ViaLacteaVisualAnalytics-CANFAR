FROM ubuntu:focal
 
ARG DEBIAN_FRONTEND=noninteractive
 
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get clean && \
    apt-get update && \
    apt-get install --no-install-recommends -y locales acl sssd libnss-sss libpam-sss \
                    xterm libasound2 libgl1-mesa-glx libopengl0 openssl ca-certificates && \
    rm -rf /var/lib/apt/lists/*
 
ADD https://github.com/VisIVOLab/ViaLacteaVisualAnalytics/releases/download/1.6/ViaLacteaVisualAnalytics-1.6.deb /tmp/visivo-1.6.0.deb
RUN dpkg -i /tmp/visivo-1.6.0.deb && rm -f /tmp/visivo-1.6.0.deb
 
ADD src/nsswitch.conf /etc/
RUN mkdir /skaha
COPY src/startup.sh /skaha/startup.sh
RUN chmod +x /skaha/startup.sh
CMD ["/skaha/startup.sh"]
