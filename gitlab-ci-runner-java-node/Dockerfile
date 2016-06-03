FROM sameersbn/gitlab-ci-multi-runner:1.1.3-2
MAINTAINER Peter Reisz <peter@reisz.tk>

ENV JAVA_HOME="/opt/java8" \
    JAVA8_VERSION="8u92" \
    JAVA7_VERSION="7u80" \
    MAVEN_HOME="/opt/maven" \
    MAVEN_VERSION="3.3.9" \
    ANT_HOME="/opt/ant" \
    ANT_VERSION="1.9.6" \
    GRADLE_HOME="/opt/gradle" \
    GRADLE_VERSION="2.13" \
    NODE_HOME="/opt/node" \
    NODE_VERSION="6.2.1"

ENV PATH="$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin:$ANT_HOME/bin:$GRADLE_HOME/bin:$NODE_HOME/bin"

RUN buildDeps='xz-utils unzip'; \
    set -x && \
    apt-get update && apt-get install -y $buildDeps --no-install-recommends && \

    # java7
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA7_VERSION-b15/jdk-$JAVA7_VERSION-linux-x64.tar.gz" -O /tmp/java7.tar.gz && \
    tar -zxvf /tmp/java7.tar.gz -C /opt && \
    mv /opt/jdk1.7* /opt/java7 && \

    # java8
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA8_VERSION-b14/jdk-$JAVA8_VERSION-linux-x64.tar.gz" -O /tmp/java8.tar.gz && \
    tar -zxvf /tmp/java8.tar.gz -C /opt && \
    mv /opt/jdk1.8* /opt/java8 && \

    # ant
    wget "http://www.eu.apache.org/dist/ant/binaries/apache-ant-$ANT_VERSION-bin.tar.gz" -O /tmp/ant.tar.gz && \
    tar -zxvf /tmp/ant.tar.gz -C /opt && \
    mv /opt/apache-ant-* /opt/ant && \

    # maven
    wget "http://www.eu.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" -O /tmp/maven.tar.gz && \
    tar -zxvf /tmp/maven.tar.gz -C /opt && \
    mv /opt/apache-maven-* /opt/maven && \

    # gradle
    wget "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" -O /tmp/gradle.zip && \
    unzip /tmp/gradle.zip -d /opt && \
    mv /opt/gradle-* /opt/gradle && \

    # node
    wget "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" -O /tmp/node.tar.xz && \
    tar xf /tmp/node.tar.xz -C /opt && \
    mv /opt/node-* /opt/node && \
    npm install grunt gulp bower webpack cordova ionic jspm -g && \

    # clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get autoremove -y && apt-get clean
    
