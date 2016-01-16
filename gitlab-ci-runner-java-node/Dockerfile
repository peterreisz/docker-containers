FROM sameersbn/gitlab-ci-runner:5.2.1
MAINTAINER Peter Reisz <peter@reisz.tk>

ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle" \
    MAVEN_HOME="/opt/maven" \
    MAVEN_VERSION="3.3.9" \
    ANT_HOME="/opt/ant" \
    ANT_VERSION="1.9.6" \
    GRADLE_HOME="/opt/gradle" \
    GRADLE_VERSION="2.10" \
    NODE_HOME="/opt/node" \
    NODE_VERSION="5.4.1"

ENV MAVEN_DOWNLOAD_URL="http://www.eu.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" \
    ANT_DOWNLOAD_URL="http://www.eu.apache.org/dist/ant/binaries/apache-ant-$ANT_VERSION-bin.tar.gz" \
    GRADLE_DOWNLOAD_URL="https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" \
    NODE_DOWNLOAD_URL="https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
    PATH="$PATH:$MAVEN_HOME/bin:$ANT_HOME/bin:$GRADLE_HOME/bin:$NODE_HOME/bin"

# required to use add-apt-repository
RUN buildDeps='software-properties-common unzip'; \
    set -x && \
    apt-get update && apt-get install -y $buildDeps --no-install-recommends && \

    # use WebUpd8 PPA
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update -y && \

    # automatically accept the Oracle license
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get install -y oracle-java8-set-default && \

    # ant
    wget $ANT_DOWNLOAD_URL -O /tmp/ant.tar.gz && \
    tar -zxvf /tmp/ant.tar.gz -C /opt && \
    mv /opt/apache-ant-* /opt/ant && \

    # maven
    wget $MAVEN_DOWNLOAD_URL -O /tmp/maven.tar.gz && \
    tar -zxvf /tmp/maven.tar.gz -C /opt && \
    mv /opt/apache-maven-* /opt/maven && \

    # gradle
    wget $GRADLE_DOWNLOAD_URL -O /tmp/gradle.zip && \
    unzip /tmp/gradle.zip -d /opt && \
    mv /opt/gradle-* /opt/gradle && \

    # node
    wget $NODE_DOWNLOAD_URL -O /tmp/node.tar.xz && \
    tar xf /tmp/node.tar.xz -C /opt/ && \
    mv /opt/node-* /opt/node && \
    npm install grunt gulp bower webpack cordova ionic jspm -g && \

    # clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get autoremove -y && apt-get clean
