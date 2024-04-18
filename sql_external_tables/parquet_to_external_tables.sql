-- *** RUN A SINGLE SQL COMMAND AT A TIME ***

-- 1. Add your BigQuery PROJECT NAME to each command
-- 2. Copy the gsutil URI for the parquet files from the bucket folders

CREATE OR REPLACE EXTERNAL TABLE `<PROJECT_NAME>.citi_bike_data.citi_bike_2019`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://<uri_to_parquet>']
);

CREATE OR REPLACE EXTERNAL TABLE `<PROJECT_NAME>.citi_bike_data.citi_bike_2020`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://<uri_to_parquet>']
);

CREATE OR REPLACE EXTERNAL TABLE `<PROJECT_NAME>.citi_bike_data.citi_bike_2023`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://<uri_to_parquet>']
);


-- *** To verify row counts ***

SELECT COUNT(*) FROM `<PROJECT_NAME>.citi_bike_data.citi_bike_2019`;
SELECT COUNT(*) FROM `<PROJECT_NAME>.citi_bike_data.citi_bike_2020`;
SELECT COUNT(*) FROM `<PROJECT_NAME>.citi_bike_data.citi_bike_2019`;