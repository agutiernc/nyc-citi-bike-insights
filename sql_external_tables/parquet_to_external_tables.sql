-- *** RUN A SINGLE SQL COMMAND AT A TIME ***

-- 1. ADD YOUR BigQuery PROJECT NAME the to each command
-- 2. Copy the gsutil URI for the parquet files in the bucket folders

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