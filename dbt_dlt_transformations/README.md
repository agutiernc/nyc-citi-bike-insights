
# Step 7: Data Transformations using dlt and dbt

Follow these steps to perform data transformations and create the final materialized table:

1. Navigate to the `dbt_dlt_transformations` directory in the terminal and code editor.

```shell
cd dbt_dlt_transformations
```

2. Edit the `profiles.yml` file with your GCS information.

3. Change to the `.dlt` directory and edit the `secrets.toml` file with your GCS information.

   <span style="color:yellow">Note:</span> The `profiles.yml` file and the `.dlt` directory (along with its contents) are already listed in the `.gitignore` file to prevent them from being committed to version control.

4. Run the Python script `dlt_dbt_runner.py` using the following command:
   
   ```shell
   python dlt_dbt_runner.py
   ```

   The script will process the large amount of data and transform it into a single materialized table combining all three years.

   <span style="color:yellow">Note:</span> The processing may take some time due to the volume of data being transformed.

5. After the script finishes running, verify in the BigQuery dataset for the final materialized table.

   <span style="color:yellow">Note:</span> On the first run, the script will execute tests that output staging models, each containing 100 rows, and the materialized table containing 300 rows. If the tests run successfully, you can comment out the test code at the end of the following files:
   - `dlt_dbt_runner.py`
   - The staging `.sql` files in the `models/staging` directory

   After commenting out the tests, rerun the `dlt_dbt_runner.py` script. This time, it will output the materialized table with approximately `76,285,154` rows.

With these steps completed, you have successfully transformed the raw data into a single materialized table using dlt and dbt!