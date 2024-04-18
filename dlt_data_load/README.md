# Step 5: Perform ETL using Data Load Tool (dlt)

1. From the terminal, navigate to the `dlt_data_load` directory:
   ```
   cd dlt_data_load
   ```

2. Edit the `secrets.toml` file located in the `.dlt` directory. Follow the instructions within the file to add your Google Cloud Storage (GCS) information. These have already been added to `.gitignore`

3. Run the Python script `load_bike_data_to_gcs.py`:

   ```
   python load_bike_data_to_gcs.py
   ```

   This script will fetch `.zip` files that contain `.csv` files, in monthly folders, for the years 2019, 2020, and 2023 from the [Citi Bike website](https://citibikenyc.com/system-data). It will then output a `.parquet` file for each year into your Google Cloud Storage bucket.

   The data files are quite large, so depending on your download and upload speeds, the process may take some time. You can monitor the progress in the terminal. Wait for the `Success!` message for all 3 years.

4. Verify that the `bike_tripdata` folder has been created in your Google Cloud Storage bucket. It should contain subfolders named `bike_2019`, `bike_2020`, and `bike_2023`, with each containing the `.parquet` file.

**Note:** If you cancel the script execution, rerunning the script may display a warning message. You can safely ignore this message, as it is simply informing you about an unfinished job from the previous run.

With these steps completed, you have successfully performed the ETL process using the [Data Load Tool (dlt)](https://dlthub.com) and loaded the Citi Bike data into your Google Cloud Storage bucket.


## Why use dlt for data pipelines?

[dlt (Data Load Tool)](https://dlthub.com) is  used for creating and managing data pipelines in this project for several compelling reasons:

- **Simplicity and Performance:** dlt simplifies the process of fetching data and reading `.csv` files by leveraging PyArrow under the hood. It abstracts away the complexities, making it easier to build and maintain data pipelines. Moreover, dlt's ability to efficiently handle large datasets, like the Citi Bike data, was another key factor.

- **Schema Handling:** With dlt and PyArrow, we can efficiently handle mixed data types within columns and adjust the schema accordingly. This flexibility ensures data integrity and consistency throughout the pipeline.

- **Integration with dbt:** dlt provides a seamless integration with dbt through its *dbt runner*. This allows us to leverage dbt for data transformations, in Step 7, without the need for a separate dbt Cloud account or installing dbt Core locally. dlt takes care of the necessary configurations, making the setup process more streamlined.

- **GCS Configuration:** dlt simplifies the configuration of Google Cloud Storage (GCS) settings, making it easier to connect and interact with GCS.

- **Deployment with GitHub Actions:** dlt provides support for deploying pipelines using GitHub Actions. With just a few simple commands, we can trigger GitHub Actions to automatically build, test, and deploy our data pipeline. This streamlines the deployment process and enables continuous integration and delivery (CI/CD) practices.

- **Underdog Appeal:** dlt may not be as well-known as some other tools in the market, but it proves to be a powerful and reliable choice for building data pipelines. It's like a lean, mean, data-processing machine! Its focused approach and well-designed features make it stand out as a nimble and efficient solution.