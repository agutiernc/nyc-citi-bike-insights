# Step 5: Perform ETL using Data Load Tool (dlt)

1. From the terminal, navigate to the `dlt_data_load` directory:
   ```
   cd dlt_data_load
   ```

2. Open the `secrets.toml` file located in the `.dlt` directory. Follow the instructions within the file to add your Google Cloud Storage (GCS) information.
   <span style="color:yellow">*Note:*</span> These have been added to `.gitignore`

3. Run the Python script `load_bike_data_to_gcs.py` from the `dlt_data_load` directory. This script will fetch `.zip` files that contain `.csv` files, in monthly folders, for the years 2019, 2020, and 2023 from the [Citi Bike website](https://citibikenyc.com/system-data). It will then output a `.parquet` file for each year into your Google Cloud Storage bucket.

   To run the script:
   ```
   python load_bike_data_to_gcs.py
   ```

   <span style="color:yellow">*Note:*</span> The data files are quite large, so depending on your download and upload speeds, the process may take some time. You can monitor the progress in the terminal. Wait for the `Success!` message for all 3 years.

4. After the script finishes executing, verify that the `bike_tripdata` folder has been created in your Google Cloud Storage bucket. It should contain subfolders named `bike_2019`, `bike_2020`, and `bike_2023`, with each containing the `.parquet` file.

<span style="color:red">**Note:**</span> If you cancel the script execution, rerunning the script may display a warning message. You can safely ignore this message, as it is simply informing you about an unfinished job from the previous run.

With these steps completed, you have successfully performed the ETL process using the [Data Load Tool (dlt)](https://dlthub.com) and loaded the Citi Bike data into your Google Cloud Storage bucket.