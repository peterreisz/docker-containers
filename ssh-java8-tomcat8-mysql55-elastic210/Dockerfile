FROM ubuntu:14.04.4
MAINTAINER Peter Reisz <peter@reisz.tk>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

ENV JRE_HOME="/opt/java" \
    JAVA_VERSION="8u102"

ENV PATH="$PATH:$JRE_HOME/bin"

RUN deps='supervisor mysql-server openssh-server wget'; \
    set -x && \
    apt-get update && apt-get install -y $deps --no-install-recommends && \
    mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    sed -i -e"s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf && \
    sed -i "s|UsePAM yes|UsePAM no|g" /etc/ssh/sshd_config && \

    # java8
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b14/server-jre-$JAVA_VERSION-linux-x64.tar.gz" -O /tmp/java.tar.gz && \
    tar -zxvf /tmp/java.tar.gz -C /opt && \
    mv /opt/jdk1.8* /opt/java && \

    # tomcat8
    wget http://xenia.sote.hu/ftp/mirrors/www.apache.org/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz -O /tmp/tomcat.tar.gz && \
    tar -zxvf /tmp/tomcat.tar.gz -C /opt && \
    mv /opt/apache-tomcat* /opt/tomcat && \
    rm -rf /opt/tomcat/webapps/docs /opt/tomcat/webapps/examples && \
    useradd tomcat && \

    # tomcat shared libs
    wget http://central.maven.org/maven2/commons-logging/commons-logging-api/1.1/commons-logging-api-1.1.jar -O /opt/tomcat/lib/commons-logging-api-1.1.jar && \
    wget http://central.maven.org/maven2/javax/mail/javax.mail-api/1.5.5/javax.mail-api-1.5.5.jar -O /opt/tomcat/lib/javax.mail-api-1.5.5.jar && \
    wget http://central.maven.org/maven2/org/ow2/jotm/jotm-core/2.3.1-M1/jotm-core-2.3.1-M1.jar -O /opt/tomcat/lib/jotm-core-2.3.1-M1.jar && \
    wget http://central.maven.org/maven2/org/ow2/jotm/jotm-datasource/2.3.1-M1/jotm-datasource-2.3.1-M1.jar -O /opt/tomcat/lib/jotm-datasource-2.3.1-M1.jar && \
    wget http://central.maven.org/maven2/org/ow2/jotm/jotm-jms/2.3.1-M1/jotm-jms-2.3.1-M1.jar -O /opt/tomcat/lib/jotm-jms-2.3.1-M1.jar && \
    wget http://central.maven.org/maven2/org/ow2/jotm/jotm-standalone/2.3.1-M1/jotm-standalone-2.3.1-M1.jar -O /opt/tomcat/lib/jotm-standalone-2.3.1-M1.jar && \
    wget http://central.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.5/log4j-core-2.5.jar -O /opt/tomcat/lib/log4j-core-2.5.jar && \
    wget http://central.maven.org/maven2/org/ow2/spec/ee/ow2-connector-1.5-spec/1.0.13/ow2-connector-1.5-spec-1.0.13.jar -O /opt/tomcat/lib/ow2-connector-1.5-spec-1.0.13.jar && \
    wget http://central.maven.org/maven2/org/ow2/spec/ee/ow2-jta-1.1-spec/1.0.13/ow2-jta-1.1-spec-1.0.13.jar -O /opt/tomcat/lib/ow2-jta-1.1-spec-1.0.13.jar && \

    # elastic
    wget --no-check-certificate https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.1.0/elasticsearch-2.1.0.tar.gz -O /tmp/elasticsearch.tar.gz && \
    tar -zxvf /tmp/elasticsearch.tar.gz -C /opt && \
    mv /opt/elasticsearch-* /opt/elasticsearch && \
    useradd elasticsearch && \

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
