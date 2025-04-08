FROM us-central1-docker.pkg.dev/tensorflow-sigs/tensorflow/ml-build:latest

ENV ANDROID_DEV_HOME /android
RUN mkdir -p ${ANDROID_DEV_HOME}

RUN apt-get update && \
    apt-get install -y --no-install-recommends default-jdk

# Install Android SDK.
ENV ANDROID_SDK_FILENAME commandlinetools-linux-6858069_latest.zip
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/${ANDROID_SDK_FILENAME}
ENV ANDROID_API_LEVEL 23
ENV ANDROID_NDK_API_LEVEL 21
ENV ANDROID_SDK_API_LEVEL 26

# Build Tools Version liable to change.
ENV ANDROID_BUILD_TOOLS_VERSION 31.0.0
ENV ANDROID_SDK_HOME ${ANDROID_DEV_HOME}/sdk
RUN mkdir -p ${ANDROID_SDK_HOME}/cmdline-tools
RUN mkdir -p .android
ENV PATH ${PATH}:${ANDROID_SDK_HOME}/cmdline-tools/latest/bin:${ANDROID_SDK_HOME}/platform-tools
RUN cd ${ANDROID_DEV_HOME} && \
    wget -q ${ANDROID_SDK_URL} && \
    unzip ${ANDROID_SDK_FILENAME} -d /tmp && \
    mv /tmp/cmdline-tools ${ANDROID_SDK_HOME}/cmdline-tools/latest && \
    rm ${ANDROID_SDK_FILENAME}

# Install Android NDK.
ENV ANDROID_NDK_FILENAME android-ndk-r25b-linux.zip
ENV ANDROID_NDK_URL https://dl.google.com/android/repository/${ANDROID_NDK_FILENAME}
ENV ANDROID_NDK_HOME ${ANDROID_DEV_HOME}/ndk
ENV PATH ${PATH}:${ANDROID_NDK_HOME}
RUN cd ${ANDROID_DEV_HOME} && \
    wget -q ${ANDROID_NDK_URL} && \
    unzip ${ANDROID_NDK_FILENAME} -d ${ANDROID_DEV_HOME} && \
    rm ${ANDROID_NDK_FILENAME} && \
    bash -c "ln -s ${ANDROID_DEV_HOME}/android-ndk-* ${ANDROID_NDK_HOME}"

RUN yes | sdkmanager --licenses
RUN mkdir -p ~/.android
RUN touch ~/.android/repositories.cfg
RUN touch ~/.android/repositories.cfg
RUN sdkmanager --install "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" "platforms;android-${ANDROID_SDK_API_LEVEL}" \
    "platform-tools"

# Make android ndk executable to all users.
RUN chmod -R go=u ${ANDROID_DEV_HOME}