FROM ubuntu:14.04.4
MAINTAINER Peter Reisz <peter@reisz.tk>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

ENV JRE_HOME="/opt/java" \
    JAVA_VERSION="8u74"

ENV PATH="$PATH:$JRE_HOME/bin"

RUN deps='supervisor mysql-server openssh-server wget'; \
    set -x && \
    apt-get update && apt-get install -y $deps --no-install-recommends && \
    mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    sed -i -e"s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf && \

    # java8
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b02/server-jre-$JAVA_VERSION-linux-x64.tar.gz" -O /tmp/java.tar.gz && \
    tar -zxvf /tmp/java.tar.gz -C /opt && \
    mv /opt/jdk1.8* /opt/java && \

    # tomcat8
    wget http://xenia.sote.hu/ftp/mirrors/www.apache.org/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz -O /tmp/tomcat.tar.gz && \
    tar -zxvf /tmp/tomcat.tar.gz -C /opt && \
    mv /opt/apache-tomcat* /opt/tomcat && \
    useradd tomcat && \

    # clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get autoremove -y && apt-get clean

ADD docker-entrypoint.sh /entrypoint.sh

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22 3306 8080 9200 9300

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
