FROM ubuntu:bionic
RUN apt-get update
RUN apt-get --no-install-recommends install git curl wget tar ca-certificates -y
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && \
    apt-get install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata
WORKDIR /app

RUN wget https://github.com/tindy2013/stairspeedtest-reborn/releases/download/v0.6.1-beta/stairspeedtest_reborn_linux64.tar.gz && \
    tar xvf stairspeedtest_reborn_linux64.tar.gz && \
    rm -f stairspeedtest_reborn_linux64.tar.gz && \
    rm -f pref.ini && \
    mv tools/gui/gui.html tools/gui/index.html
COPY pref.ini .
VOLUME ["/app/results"]
EXPOSE 65430
ENTRYPOINT [ "./webgui.sh"]
