FROM datadrone/deeplearn_tflite:cuda-11.1-base

# Add Spark for spark driver and minio for access datastore

RUN conda install -c conda-forge openjdk=8
RUN conda install -c conda-forge pyspark==3.1.2
RUN pip install minio