#!/bin/sh


export HADOOP_HOME=/opt/hadoop-3.2.0
export HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.375.jar:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.2.0.jar
export JAVA_HOME=/usr/local/openjdk-8

## Checking if the file exists prior to rendering the template
## See: https://linuxize.com/post/bash-check-if-file-exists/
FILE=/opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
    bash /opt/apache-hive-metastore-3.0.0-bin/conf/configure.sh
fi

## we set an env var HMS_DB_INITIALISED based on it this has been done or not
## See: https://stackoverflow.com/questions/2981878/checking-for-environment-variables
## See: https://unix.stackexchange.com/questions/258406/correct-way-to-set-permanent-environment-variables-from-script

# Initialise is a shitty flag but with kubernetes then we start a fresh pod each time

CHECKFILE=/opt/apache-hive-metastore-3.0.0-bin/conf/initialised
if [ -f "$CHECKFILE" ] || [ "$INITIALISE"="no" ]; then
    echo "DB initialised skipping init."
else
    /opt/apache-hive-metastore-3.0.0-bin/bin/schematool -initSchema -dbType postgres -ifNotExists
    echo >> /opt/apache-hive-metastore-3.0.0-bin/conf/initialised
fi

/opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore
