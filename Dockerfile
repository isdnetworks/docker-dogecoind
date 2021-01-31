FROM isdnetworks/centos:8-ko
LABEL maintainer="is:-D Networks Docker Maintainers <jhcheong@isdnetworks.pe.kr>"

ADD dogecoin-1.14.2-x86_64-linux-gnu.tar.gz /usr/local/
WORKDIR /usr/local/dogecoin-1.14.2
RUN chown -R 0:0 . \
 && cp bin/* /usr/bin \
 && cp include/* /usr/include \
 && cp lib/libdogecoinconsensus.so.0.0.0 /usr/lib64 \
 && ln -s libdogecoinconsensus.so.0.0.0 /usr/lib64/libdogecoinconsensus.so.0 \
 && ln -s libdogecoinconsensus.so.0.0.0 /usr/lib64/libdogecoinconsensus.so \
 && ldconfig \
 && cp share/man/man1/* /usr/share/man/man1 \
 && cd .. \
 && rm -rf dogecoin-1.14.2 \
 && useradd -m -s /bin/bash -u 1000 dogecoin

WORKDIR /home/dogecoin
USER dogecoin
RUN mkdir .dogecoin \
 && chmod 700 .dogecoin

VOLUME ["/home/dogecoin/.dogecoin"]

EXPOSE 22556/tcp 22556/udp 22555/tcp 44556/tcp 44556/udp 44555/tcp

CMD ["dogecoind", "-printtoconsole"]

