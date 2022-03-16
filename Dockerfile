ARG JDK_VERSION=19-jdk

FROM openjdk:${JDK_VERSION}-alpine

ARG MAVEN_VERSION=3.8.5
ARG MAVEN_MIRROR=https://dlcdn.apache.org

ARG APK_PACKAGES='bash git openssh'
ARG MAVEN_HOME=/usr/share/maven
ARG LANG=C.UTF-8
ARG WORKDIR=/workspace

ENV MAVEN_HOME ${MAVEN_HOME}
ENV WORKDIR ${WORKDIR}

ENV LANG ${LANG}
ENV MUSL_LOCPATH /usr/share/i18n/locales/musl

RUN \
    major=${MAVEN_VERSION%%.*} && \
    baseuri=${MAVEN_MIRROR}/maven/maven-${major} && \
    binary=${baseuri}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    sha512=${baseuri}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz.sha512 && \
    tarball=/tmp/maven.tgz && \
    apk add --no-cache \
        curl \
        gnupg \
        libintl \
        libxml2-dev \
        musl-locales \
        ${APK_PACKAGES} && \
    mkdir -p ${MAVEN_HOME} && \
    echo "curl -fsSL -o ${tarball} ${binary}" && \
    curl -fsSL -o ${tarball} ${binary} && \
    echo "curl -fsSL ${sha512}" && \
    maven_sha512=$(curl -fsSL ${sha512}) && \
    echo "${maven_sha512}  ${tarball}" | sha512sum -c - && \
    tar -xzf ${tarball} -C ${MAVEN_HOME} --strip-components=1 && \
    echo "export MAVEN_URL=${binary}" >> /etc/profile.d/maven-env.sh && \
    echo "export MAVEN_SHA512=${maven_sha512}" >> /etc/profile.d/maven-env.sh && \
    echo "export MAVEN_M2DIR=\$HOME/.m2" >> /etc/profile.d/maven-env.sh && \
    rm -f ${tarball} \
    ;

COPY docker-entrypoint /usr/local/bin/docker-entrypoint
COPY mvn /usr/bin

VOLUME ${WORKDIR}
WORKDIR ${WORKDIR}

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
