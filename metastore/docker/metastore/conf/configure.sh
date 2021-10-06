#!/bin/bash
cat /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml.j2 | envsubst > /opt/apache-hive-metastore-3.0.0-bin/conf/metastore-site.xml