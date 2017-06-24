FROM peterreisz/gitlab-ci-runner-java-node:20170624
MAINTAINER Peter Reisz <peter@reisz.tk>

ENV ANDROID_HOME="/opt/android_sdk"

ENV PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

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
