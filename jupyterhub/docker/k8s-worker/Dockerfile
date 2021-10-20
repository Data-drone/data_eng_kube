# Dependencies Container Image
# Install wget to retrieve Spark runtime components,
# extract to temporary directory, copy to the desired image
FROM ubuntu:20.04 AS deps

RUN apt-get update && apt-get -y install wget
WORKDIR /tmp
RUN wget http://mirrors.gigenet.com/apache/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz \
	&& tar xvzf spark-3.1.2-bin-hadoop3.2.tgz 

# test run updating the kubernetes model
ENV K8_CLIENT=5.4.0

WORKDIR /tmp/k8s
# https://repo1.maven.org/maven2/io/fabric8/kubernetes-model-common/5.4.0/kubernetes-model-common-5.4.0.jar
RUN wget https://repo1.maven.org/maven2/io/fabric8/kubernetes-client/${K8_CLIENT}/kubernetes-client-${K8_CLIENT}.jar && \
    wget https://repo1.maven.org/maven2/io/fabric8/kubernetes-model/${K8_CLIENT}/kubernetes-model-${K8_CLIENT}.jar && \
    wget https://repo1.maven.org/maven2/io/fabric8/kubernetes-model-common/${K8_CLIENT}/kubernetes-model-common-${K8_CLIENT}.jar



# Runtime Container Image. Adapted from the official Spark runtime 
# image from the project repository at https://github.com/apache/spark.
FROM openjdk:8-jdk-slim AS build

# Spark UID
ARG spark_uid=185

# Install Spark Dependencies and Prepare Spark Runtime Environment
RUN set -ex && \
    apt-get update && \
    ln -s /lib /lib64 && \
    apt install -y bash tini libc6 libpam-modules libnss3 wget python3 python3-pip && \
    mkdir -p /opt/spark && \
    mkdir -p /opt/spark/examples && \
    mkdir -p /opt/spark/work-dir && \
    touch /opt/spark/RELEASE && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    ln -sv /usr/bin/tini /sbin/tini && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
    ln -sv /usr/bin/python3 /usr/bin/python && \
    ln -sv /usr/bin/pip3 /usr/bin/pip \
    rm -rf /var/cache/apt/*

# Install Kerberos Client and Auth Components
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt install -yqq krb5-user \
  && rm -rf /var/cache/apt/*


# Copy previously fetched runtime components
COPY --from=deps /tmp/spark-3.1.2-bin-hadoop3.2/bin /opt/spark/bin
COPY --from=deps /tmp/spark-3.1.2-bin-hadoop3.2/jars /opt/spark/jars
COPY --from=deps /tmp/spark-3.1.2-bin-hadoop3.2/python /opt/spark/python
COPY --from=deps /tmp/spark-3.1.2-bin-hadoop3.2/R /opt/spark/R
COPY --from=deps /tmp/spark-3.1.2-bin-hadoop3.2/sbin /opt/spark/sbin
COPY --from=deps /tmp/spark-3.1.2-bin-hadoop3.2/yarn /opt/spark/yarn

# Copy Docker entry script
COPY --from=deps /tmp/spark-3.1.2-bin-hadoop3.2/kubernetes/dockerfiles/spark/entrypoint.sh /opt/

# COpy examples, data, and tests
COPY --from=deps /tmp/spark-3.1.2-bin-hadoop3.2/examples /opt/spark/examples
COPY --from=deps /tmp/spark-3.1.2-bin-hadoop3.2/data /opt/spark/data
COPY --from=deps /tmp/spark-3.1.2-bin-hadoop3.2/kubernetes/tests /opt/spark/tests

# Replace out of date dependencies causing a 403 error on job launch
#RUN rm -rf /opt/spark/jars/kubernetes-client-* \
#    && rm -rf /opt/spark/jars/kubernetes-model-* \
#    && rm -rf /opt/spark/jars/kubernetes-model-common-*
#
#COPY --from=deps /tmp/k8s /opt/spark/jars

#WORKDIR /tmp
#RUN cd /tmp \
#  && wget https://oak-tree.tech/documents/59/kubernetes-client-4.6.4.jar \
#  && wget https://oak-tree.tech/documents/58/kubernetes-model-4.6.4.jar \
#  && wget https://oak-tree.tech/documents/57/kubernetes-model-common-4.6.4.jar \
#  && rm -rf /opt/spark/jars/kubernetes-client-* \
#  && rm -rf /opt/spark/jars/kubernetes-model-* \
#  && rm -rf /opt/spark/jars/kubernetes-model-common-* \
#  && mv /tmp/kubernetes-* /opt/spark/jars/

# add folder for jars we need to bake in
RUN mkdir /opt/spark-jars

RUN wget -O /opt/spark-jars/hadoop-aws-3.2.0.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar
RUN wget -O /opt/spark-jars/delta-core_2.12-1.0.0.jar https://repo1.maven.org/maven2/io/delta/delta-core_2.12/1.0.0/delta-core_2.12-1.0.0.jar
RUN wget -O /opt/spark-jars/aws-java-sdk-bundle-1.11.375.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.375/aws-java-sdk-bundle-1.11.375.jar
RUN wget -O /opt/spark-jars/postgresql-42.2.24.jar https://jdbc.postgresql.org/download/postgresql-42.2.24.jar

RUN chmod u+x /opt/spark-jars/hadoop-aws-3.2.0.jar \
      && chmod u+x /opt/spark-jars/delta-core_2.12-1.0.0.jar \
      && chmod u+x /opt/spark-jars/aws-java-sdk-bundle-1.11.375.jar \
      && chmod u+x /opt/spark-jars/postgresql-42.2.24.jar

# Set Spark runtime options
ENV SPARK_HOME /opt/spark

WORKDIR /opt/spark/work-dir
RUN chmod g+w /opt/spark/work-dir

ENTRYPOINT [ "/opt/entrypoint.sh" ]

# Specify the User that the actual main process will run as
USER ${spark_uid}