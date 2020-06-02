FROM ubuntu:bionic
RUN apt-get update
RUN apt-get --no-install-recommends install git curl wget unzip ca-certificates -y
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && \
    apt-get install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata
WORKDIR /app

RUN wget https://github.com/kotori-bgt/stairspeedtest-reborn/releases/download/beta/stairspeedtest_reborn_linux64.zip && \
    unzip stairspeedtest_reborn_linux64.zip && \
    chmod +x * \
    rm -f stairspeedtest_reborn_linux64.zip && \
    rm -f pref.ini && \
    mv tools/gui/gui.html tools/gui/index.html
COPY pref.ini .
VOLUME ["/app/results"]
EXPOSE 65430
ENTRYPOINT [ "./webgui.sh"]
