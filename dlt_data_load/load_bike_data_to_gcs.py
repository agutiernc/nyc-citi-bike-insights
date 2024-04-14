import requests
from requests.exceptions import HTTPError
import zipfile
import io, sys, os, time
import dlt
import pyarrow as pa
import pyarrow.csv as pa_csv
from tqdm import tqdm

os.environ["SCHEMA__NAMING"] = "direct"

YEARS = [19, 20, 23]

@dlt.resource(name="citi_bike_data")
def download_citi_data(year):
    url = f"https://s3.amazonaws.com/tripdata/20{year}-citibike-tripdata.zip"
    
    try:
        response = requests.get(url, stream=True)
        response.raise_for_status()

        # for progress bar
        total_size = int(response.headers.get('content-length', 0))
        block_size = 1024 # 1KB chunk size

        with tqdm(total=total_size, unit='iB', unit_scale=True, desc=f"Downloading 20{year} data", colour="blue") as pbar:
            zip_data = io.BytesIO()

            # reading data in chunks
            for data in response.iter_content(block_size):
                zip_data.write(data)
                pbar.update(len(data))

            tqdm.write("Downloaded and extracted zip file")

            # Read CSV files in monthly folders
            with zipfile.ZipFile(zip_data, 'r') as zip_ref:
                total_files = len(zip_ref.namelist())

                with tqdm(total=total_files, desc=f"Processing 20{year} CSV files", colour="green") as file_pbar:
                    for file_name in zip_ref.namelist():
                        if file_name.endswith('.csv') and not file_name.startswith('__MACOSX'):

                            with zip_ref.open(file_name) as f:
                                table = None
                                convert_options = None

                                if year == 23:
                                    convert_options = pa_csv.ConvertOptions(column_types={
                                        "start_station_id": pa.string()
                                    })
                                else:
                                    convert_options = pa_csv.ConvertOptions(column_types={
                                        "start station id": pa.string(),
                                        "end station id": pa.string()
                                    })

                                yield pa_csv.read_csv(f, convert_options=convert_options)

                        file_pbar.update(1)
    except HTTPError as http_err:
        tqdm.write(f"HTTP error occurred: {http_err}")
        sys.exit(1)
    except Exception as err:
        tqdm.write(f"An error occurred: {err}")
        sys.exit(1)


for year in YEARS:
    tqdm.write(f"Once processing is done, converting 20{year} data to parquet and uploading to GCS bucket. Please wait...")

    tables = download_citi_data(year)
        
    pipeline = dlt.pipeline(
        pipeline_name=f"citi_20{year}",
        destination="filesystem",
        dataset_name="bike_tripdata", # bucket folder
        progress=dlt.progress.tqdm(colour="yellow")
    )
        
    pipeline.run(
        tables,
        table_name=f"bike_20{year}",
        loader_file_format="parquet",
        write_disposition="replace"
    )

    tqdm.write(f"Success! Uploaded 20{year} parquet to GCS!")