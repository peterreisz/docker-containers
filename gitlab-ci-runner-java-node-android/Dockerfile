FROM sameersbn/gitlab-ci-multi-runner:1.1.4-7
MAINTAINER Peter Reisz <peter@reisz.tk>

ENV GITLAB_CI_MULTI_RUNNER_VERSION=1.11.0 \
    JAVA_HOME="/opt/java" \
    JAVA_VERSION="8u121" \
    JAVA_BUILD="b13" \
    JAVA_VERSION_HASH="e9e7ea248e2c4826b92b3f075a80e441" \
    NODE_HOME="/opt/node" \
    NODE_VERSION="6.10.0" \
    ANDROID_HOME="/opt/android_sdk"

ENV PATH="$PATH:$JAVA_HOME/bin:$NODE_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

RUN buildDeps='xz-utils'; \
    set -x && \
    apt-get update && apt-get upgrade -y && apt-get install -y sshpass $buildDeps --no-install-recommends

RUN wget -O /usr/local/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v${GITLAB_CI_MULTI_RUNNER_VERSION}/binaries/gitlab-ci-multi-runner-linux-amd64
RUN chmod 0755 /usr/local/bin/gitlab-ci-multi-runner

# java
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-$JAVA_BUILD/$JAVA_VERSION_HASH/jdk-$JAVA_VERSION-linux-x64.tar.gz" -O /tmp/java.tar.gz
RUN tar -zxvf /tmp/java.tar.gz -C /opt
RUN mv /opt/jdk* $JAVA_HOME

# node
RUN wget "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" -O /tmp/node.tar.xz
RUN tar xf /tmp/node.tar.xz -C /opt
RUN mv /opt/node-* $NODE_HOME
RUN npm install yarn -g

# android
RUN wget https://dl.google.com/android/repository/tools_r25.2.5-linux.zip -O /tmp/adk-tools.zip
RUN mkdir $ANDROID_HOME
RUN unzip -d $ANDROID_HOME /tmp/adk-tools.zip
RUN mkdir $ANDROID_HOME/licenses
RUN echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > $ANDROID_HOME/licenses/android-sdk-license
RUN echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > $ANDROID_HOME/licenses/android-sdk-preview-license
RUN $ANDROID_HOME/tools/bin/sdkmanager "platform-tools"
RUN $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-25"
RUN $ANDROID_HOME/tools/bin/sdkmanager "sources;android-25"
RUN $ANDROID_HOME/tools/bin/sdkmanager "build-tools;25.0.2"
RUN $ANDROID_HOME/tools/bin/sdkmanager "extras;android;m2repository"

# clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apt-get purge -y --auto-remove $buildDeps
RUN apt-get autoremove -y && apt-get clean
