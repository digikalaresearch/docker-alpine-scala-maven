FROM frolvlad/alpine-oraclejdk8:slim

ENV SCALA_VERSION 2.10.6
ENV SCALA_HOME /usr/share/scala

ENV MAVEN_VERSION 3.3.9
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN apk update && \
    apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    apk add --no-cache bash && \
    apk add --no-cache curl && \
    cd "/tmp" && \
    curl "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" --output "scala-${SCALA_VERSION}.tgz" && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    apk del .build-dependencies && \
    rm -rf "/tmp/"*

RUN echo $MAVEN_VERSION
RUN curl http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz --output apache-maven-$MAVEN_VERSION-bin.tar.gz \
    tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz \
    rm apache-maven-$MAVEN_VERSION-bin.tar.gz \
    mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

RUN rm -rf /var/cache/apk/* 
