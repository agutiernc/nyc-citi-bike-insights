{{ config(materialized='view') }}

-- Select the relevant columns from the 2023 data source and perform any necessary transformations

with bike_data as (
   select *,
      row_number() over(partition by ride_id, started_at) as rn
   from {{ source('staging','citi_bike_2023') }}
   where ride_id is not null 
)

select  
   -- identifiers
   {{ dbt.safe_cast("ride_id", api.Column.translate_type("string")) }} as ride_id,
   {{ dbt.safe_cast("start_station_name", api.Column.translate_type("string")) }} as start_station_name,
   {{ dbt.safe_cast("end_station_name", api.Column.translate_type("string")) }} as stop_station_name,

   -- macro
   {{ get_user_category("member_casual")}} as user_category,

   -- timestamps
   cast(started_at as timestamp) as start_time_date,
   cast(ended_at as timestamp) as stop_time_date,

from bike_data
where rn = 1


--  *** for use with dbt core or dbt cloud, other than dlt's dbt runner script ***
-- dbt build --select <model.sql> --vars '{'is_test_run: false}'

-- ~~~~~ IMPORTANT TEST ~~~~
-- 1. Code below verifies and tests new tables in BigQuery 
-- 2. Check row counts are 100 for each materialized table in BigQuery
--      + Final test table will have 300 rows
-- 3. Comment out below when ready to have the fully transformed data in BigQuery

{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}