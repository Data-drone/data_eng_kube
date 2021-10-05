FROM continuumio/miniconda3

RUN apt-get update && apt-get install -y libyaml-cpp-dev libyaml-dev

RUN conda install -y -c conda-forge psycopg2
RUN pip install mlflow boto3
RUN pip --no-cache-dir install --force-reinstall -I pyyaml

COPY ./start.sh ./start.sh
RUN chmod +x ./start.sh

EXPOSE 5000
CMD ["./start.sh"]
#ENTRYPOINT ["mlflow", "server"]