ARG JDK_VERSION

FROM openjdk:${JDK_VERSION}-alpine

ARG MAVEN_VERSION=3.8.5
ARG USER_HOME=/root
#ARG MAVEN_MIRROR=https://apache.osuosl.org/maven/maven-3
ARG MAVEN_MIRROR=https://dlcdn.apache.org/maven/maven-3

ARG APK_PACKAGES='bash findutils git'
ARG MAVEN_HOME=/usr/share/maven
ARG LANG=C.UTF-8
ARG WORKDIR=/workspace

ENV MAVEN_HOME ${MAVEN_HOME}
ENV MAVEN_CONFIG ${USER_HOME}/.m2
ENV WORKDIR ${WORKDIR}

ENV LANG ${LANG}
ENV MUSL_LOCPATH /usr/share/i18n/locales/musl

RUN \
    binary=${MAVEN_MIRROR}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    sha512=${MAVEN_MIRROR}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz.sha512 && \
    tarball=/tmp/maven.tgz && \
    apk add --no-cache \
        curl \
        gnupg \
        libintl \
        libxml2-dev \
        musl-locales \
        ${APK_PACKAGES} && \
    mkdir -p ${MAVEN_HOME} ${MAVEN_HOME}/ref && \
    echo "curl -fsSL -o ${tarball} ${binary}" && \
    curl -fsSL -o ${tarball} ${binary} && \
    echo "curl -fsSL ${sha512}" && \
    maven_sha512=$(curl -fsSL ${sha512}) && \
    echo "${maven_sha512}  ${tarball}" | sha512sum -c - && \
    tar -xzf ${tarball} -C ${MAVEN_HOME} --strip-components=1 && \
    rm -f ${tarball} && \
    ln -s ${MAVEN_HOME}/bin/mvn /usr/bin/mvn \
    ;

COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml ${MAVEN_HOME}/ref/

VOLUME ${WORKDIR}
WORKDIR ${WORKDIR}

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
CMD ["mvn"]
