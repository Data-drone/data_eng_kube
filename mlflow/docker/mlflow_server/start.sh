#!/bin/bash

# url encode the password
dbpword=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$DB_PASSWORD")

echo "postgresql+psycopg2://$DB_USER:$dbpword@$DB_ADDR:$DB_PORT/$DB_DATABASE"

mlflow server \
    --backend-store-uri "postgresql+psycopg2://$DB_USER:$dbpword@$DB_ADDR:$DB_PORT/$DB_DATABASE" \
    --default-artifact-root s3://mlflow/ \
    --host 0.0.0.0 \
    --workers=2 \
    --static-prefix=/mlflow
