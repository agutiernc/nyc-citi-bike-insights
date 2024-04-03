import requests
from requests.exceptions import HTTPError
import zipfile
import io, sys, os, time
import dlt
import pyarrow as pa
import pyarrow.csv as pa_csv

os.environ["SCHEMA__NAMING"] = "direct"

YEARS = [19, 20, 23]

def download_citi_data(year):
    url = f"https://s3.amazonaws.com/tripdata/20{year}-citibike-tripdata.zip"
    tables = []
    try:
        response = requests.get(url, stream=True)
        response.raise_for_status()

        zip_data = io.BytesIO(response.content)

        print("downloaded and extracted zip file")

        # Read CSV files in monthly folders
        with zipfile.ZipFile(zip_data, 'r') as zip_ref:
            for file_name in zip_ref.namelist():
                if file_name.endswith('.csv') and not file_name.startswith('__MACOSX'):
                    print(f"Reading {file_name}")

                    with zip_ref.open(file_name) as f:
                        # Specifying data types for mixed columns
                        convert_options = pa.csv.ConvertOptions(column_types={
                            'start_station_id': pa.string(),
                            'end_station_id': pa.string()
                        })

                        table = pa_csv.read_csv(f, convert_options=convert_options)
                        tables.append(table)
    except HTTPError as http_err:
        print(f"HTTP error occurred: {http_err}")
        sys.exit(1)
    except Exception as err:
        print(f"An error occurred: {err}")
        sys.exit(1)

    return tables


for year in YEARS:
    pipeline = dlt.pipeline(
        pipeline_name=f"citi-20{year}",
        destination="filesystem",
        dataset_name=f"citi_data_20{year}"
    )

    tables = download_citi_data(year)
    combined_table = pa.concat_tables(tables)

    print("Combined tables done. Attempting to convert to parquet and upload to GCS bucket")

    pipeline.run(
        combined_table,
        table_name=f"citi_bike_20{year}-tester",
        loader_file_format="parquet",
        write_disposition='replace',
        progress="tqdm"
    )

    print("Success! Uploaded parquet to gcs!")
    print("Pausing for 10 seconds")

    time.sleep(10)