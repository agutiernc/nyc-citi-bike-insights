
# Step 7: Data Transformations using dlt and dbt

Follow these steps to perform data transformations and create the final materialized table:

1. Navigate to the `dbt_dlt_transformations` directory in the terminal and code editor.

```shell
cd dbt_dlt_transformations
```

2. Edit the `profiles.yml` file with your GCS information and add your BigQuery Project name to `models/staging/schema.yml`.

3. Change to the `.dlt` directory and edit the `secrets.toml` and `config.toml` files with your GCS information.

   Note: The `profiles.yml` file and the `.dlt` directory (plus its contents) are already listed in the `.gitignore` file to prevent them from being committed to version control.

4. Run the Python script `dlt_dbt_runner.py`:
   
   ```shell
   python dlt_dbt_runner.py
   ```

   The script will process the large amount of data and transform it into a single materialized table combining all three years. The processing may take some time due to the volume of data being transformed.

5. Verify in the BigQuery dataset for the final materialized table.

**Important:** On the first run, the script will execute tests that output staging models, each containing 100 rows, and the materialized table containing 300 rows. If the tests run successfully, you can comment out the test code at the end of the following files:
   - `dlt_dbt_runner.py`
   - The staging `.sql` files in the `models/staging` directory

   After commenting out the tests, rerun the `dlt_dbt_runner.py` script. This time, it will output the materialized table with approximately `76,285,154` rows.

With these steps completed, you have successfully transformed the raw data into a single materialized table using dlt and dbt!

## Why use dbt for data transformations?

[dbt (Data Build Tool)](https://www.getdbt.com) is used to transform the raw data from multiple years into a single, unified materialized table for several reasons:

- **Data Consolidation:** dbt allows us to gather and combine data from different years into a single table, making it easier to perform analysis and queries across the entire dataset.

- **Standardization:** By transforming the data, we can standardize the column names, data types, and structure of the data, ensuring consistency and making it easier to work with.

- **Data Reduction:** dbt enables us to select only the relevant columns needed for our analysis, reducing the amount of data to process and store, which can improve query performance and reduce storage costs.

- **Data Quality:** With dbt, we can define and run tests to ensure data quality and integrity, catching any issues or anomalies early in the pipeline.

- **Ease of Use:** The transformed and materialized table provides a clean, denormalized structure that is optimized for querying and analysis, making it easier to derive insights, create dashboards, or integrate with other tools.
   
- **Partitioning and Clustering:** dbt simplifies the process of partitioning and clustering the final table. Partitioning helps improve query performance and costs by dividing the table into smaller, more manageable parts based on a specific column, such as `start_time_date`. Clustering further optimizes query performance and costs by co-locating related data within each partition based on specified columns, such as `ride_id`.
   
By leveraging dbt for data transformations, we can create a more efficient, reliable, and user-friendly dataset that serves as a foundation for further analysis and visualization.