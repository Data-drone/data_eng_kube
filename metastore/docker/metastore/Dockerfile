FROM openjdk:8u302-jre

RUN apt-get update && apt-get -y upgrade && \
        apt install -y net-tools gettext-base

WORKDIR /opt


### Still missing a lot of env vars
ENV HADOOP_VERSION=3.2.0
ENV METASTORE_VERSION=3.0.0

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin

RUN curl -L https://www.apache.org/dist/hive/hive-standalone-metastore-${METASTORE_VERSION}/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz | tar zxf - && \
    curl -L https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf - && \
    curl https://jdbc.postgresql.org/download/postgresql-42.2.24.jar --output postgresql-42.2.24.jar && \
    cp postgresql-42.2.24.jar ${HIVE_HOME}/lib/ && \
    rm -rf  postgresql-42.2.24.jar

#RUN curl -L https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-web/2.14.1/log4j-web-2.14.1.jar --output ${HIVE_HOME}/lib/log4j-web-2.14.1.jar

COPY conf/metastore-site.xml.j2 ${HIVE_HOME}/conf
COPY conf/configure.sh ${HIVE_HOME}/conf

RUN chmod u+x ${HIVE_HOME}/conf/configure.sh

COPY scripts/entrypoint.sh /entrypoint.sh

COPY conf/metastore-log4j2.properties $HIVE_HOME/conf/metastore-log4j2.properties

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh

RUN rm ${HIVE_HOME}/conf/metastore-site.xml
# remove the logging jar for hadoop to prevent clash
RUN rm ${HADOOP_HOME}/share/hadoop/common/lib/slf4j-log4j12-1.7.25.jar

USER hive

ENV JAVA_OPTS='-Djava.net.preferIPv4Stack=true'
EXPOSE 9083

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]