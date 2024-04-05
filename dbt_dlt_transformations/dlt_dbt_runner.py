import dlt
import os

# pipeline for the external tables in BigQuery
pipeline = dlt.pipeline(
    pipeline_name='dbt_transform_pipeline',
    destination='bigquery',
    dataset_name='citi_bike_data'
)

print("create or restore virtual environment in which dbt is installed")

venv = dlt.dbt.get_venv(pipeline)

# dbt pipeline for transformations
dbt = dlt.dbt.package(
    pipeline,
    os.path.abspath("."), # local dbt project directory
    venv=venv
)

models = dbt.run_all()

for m in models:
    print(
        f"Model {m.model_name} materialized in {m.time} with status {m.status} and message"
        f" {m.message}"
    )

# on success, print the outcome for each model

print("****** SUCCESS! Materialized and Final tables created in BigQuery *****")

for m in models:
    print(
        f"Model {m.model_name} materialized" +
        f"in {m.time}" +
        f"with status {m.status}" +
        f"and message {m.message}"
    )

# ******* TEST THE STAGING MODELS *******
# IMPORTANT => Leave below to test on first inintial run
# -- each materialized table will be 100 rows and the finalized table will be 300 rows in BigQuery

# Comment out when ready to rerun this script to create finalized table with all the data
# -- Also comment out the tests, at the bottom, of each staging model SQL script

print("**** Testing the Models ****")

models = dbt.test()

for m in models:
    print(
        f"Test {m.model_name} executed in {m.time} with status {m.status} and message {m.message}"
    )