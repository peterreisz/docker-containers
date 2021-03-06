FROM ubuntu:14.04.4
MAINTAINER Peter Reisz <peter@reisz.tk>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

ENV JRE_HOME="/opt/java"

ENV PATH="$PATH:$JRE_HOME/bin"

RUN deps='supervisor mysql-server openssh-server wget'; \
    set -x && \
    apt-get update && apt-get install -y $deps --no-install-recommends && \
    mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    sed -i -e"s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf && \
    sed -i "s|UsePAM yes|UsePAM no|g" /etc/ssh/sshd_config && \

    # java8
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u112-b15/server-jre-8u112-linux-x64.tar.gz" -O /tmp/java.tar.gz && \
    tar -zxvf /tmp/java.tar.gz -C /opt && \
    mv /opt/jdk* /opt/java && \

    # clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get autoremove -y && apt-get clean

ADD docker-entrypoint.sh /entrypoint.sh

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 3306 8080

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
