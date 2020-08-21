FROM ubuntu:bionic
RUN apt-get update
RUN apt-get --no-install-recommends install curl wget ca-certificates -y
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && \
    apt-get install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata
WORKDIR /app

RUN wget https://github.com/tindy2013/stairspeedtest-reborn/releases/download/v0.7.0/stairspeedtest_reborn_linux64.tar.gz && \
    tar xvf stairspeedtest_reborn_linux64.tar.gz && \
    mv stairspeedtest stairspeedtest_tmp && \
    rm -f stairspeedtest_reborn_linux64.tar.gz && \
    mv stairspeedtest_tmp/* . && \
    rm -rf stairspeedtest_tmp && \
    chmod -R +x * && \
    mv tools/gui/gui.html tools/gui/index.html
VOLUME ["/app/results"]
EXPOSE 65430
ENTRYPOINT [ "./webgui.sh"]
