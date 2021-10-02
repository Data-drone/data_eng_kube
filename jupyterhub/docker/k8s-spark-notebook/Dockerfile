FROM datadrone/deeplearn_minimal:cuda-11.1-base

# Add Spark for spark driver and minio for access datastore

# Add Spark monitor 
USER root

RUN pip install beautifulsoup4 soupsieve && \
      pip install --no-deps sparkmonitor && \
      jupyter nbextension install sparkmonitor --py && \
      jupyter nbextension enable  sparkmonitor --py && \
      jupyter serverextension enable --py --system sparkmonitor && \
      jupyter lab build

USER $NB_USER

RUN conda create --name spark python=3.9 ipykernel scikit-learn
SHELL ["conda", "run", "-n", "spark", "/bin/bash", "-c"]
RUN conda install -c conda-forge openjdk=8
RUN conda install -c conda-forge pyspark==3.1.2
RUN pip install minio boto3 jupyterlab-sparkmonitor 

USER root

ENV RAPIDS_PLUGIN_VERSION=21.08.0
ENV CUDF_VERSION=21.08.2

# make fill rapids folder
RUN mkdir /opt/sparkRapidsPlugin
RUN wget -O /opt/sparkRapidsPlugin/rapids-4-spark_2.12-${RAPIDS_PLUGIN_VERSION}.jar https://repo1.maven.org/maven2/com/nvidia/rapids-4-spark_2.12/${RAPIDS_PLUGIN_VERSION}/rapids-4-spark_2.12-${RAPIDS_PLUGIN_VERSION}.jar
RUN wget -O /opt/sparkRapidsPlugin/cudf-${CUDF_VERSION}-cuda11.jar https://repo1.maven.org/maven2/ai/rapids/cudf/${CUDF_VERSION}/cudf-${CUDF_VERSION}-cuda11.jar
RUN wget -O /opt/sparkRapidsPlugin/getGpusResources.sh https://raw.githubusercontent.com/apache/spark/master/examples/src/main/scripts/getGpusResources.sh

RUN chmod u+x /opt/sparkRapidsPlugin/getGpusResources.sh \
      && chmod u+x /opt/sparkRapidsPlugin/rapids-4-spark_2.12-${RAPIDS_PLUGIN_VERSION}.jar \
      && chmod u+x /opt/sparkRapidsPlugin/cudf-${CUDF_VERSION}-cuda11.jar

# add folder for jars we need to bake in
RUN mkdir /opt/spark-jars

RUN wget -O /opt/spark-jars/hadoop-aws-3.2.0.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar
RUN wget -O /opt/spark-jars/delta-core_2.12-1.0.0.jar https://repo1.maven.org/maven2/io/delta/delta-core_2.12/1.0.0/delta-core_2.12-1.0.0.jar

RUN chmod u+x /opt/spark-jars/hadoop-aws-3.2.0.jar \
      && chmod u+x /opt/spark-jars/delta-core_2.12-1.0.0.jar

USER $NB_USER

EXPOSE 2222
EXPOSE 7777
#ADD .condarc ./
#RUN cat .condarc >> /opt/conda/.condarc