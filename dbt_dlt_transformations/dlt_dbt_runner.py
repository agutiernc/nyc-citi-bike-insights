import dlt
import os

pipeline = dlt.pipeline(
    pipeline_name='dbt_transform_pipeline',
    destination='bigquery',
    dataset_name='citi_bike_data'
)

print("create or restore virtual environment in which dbt is installed")

venv = dlt.dbt.get_venv(pipeline)

dbt = dlt.dbt.package(
    pipeline,
    os.path.abspath("."), # dbt project name
    venv=venv
)

models = dbt.run_all()

for m in models:
    print(
        f"Model {m.model_name} materialized in {m.time} with status {m.status} and message"
        f" {m.message}"
    )

# on success, print the outcome for each model
for m in models:
    print(
        f"Model {m.model_name} materialized" +
        f"in {m.time}" +
        f"with status {m.status}" +
        f"and message {m.message}"
    )

# now test the models
print("testing the models")

models = dbt.test()

for m in models:
    print(
        f"Test {m.model_name} executed in {m.time} with status {m.status} and message {m.message}"
    )