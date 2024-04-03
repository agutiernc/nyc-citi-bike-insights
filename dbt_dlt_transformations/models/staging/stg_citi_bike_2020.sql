{{ config(materialized='view') }}

-- Select the relevant columns from the 2020 data source and perform any necessary transformations

select  
   -- identifiers
   {{ dbt.safe_cast("bikeid", api.Column.translate_type("string")) }} as ride_id,
   {{ dbt.safe_cast("start_station_name", api.Column.translate_type("string")) }} as start_station_name,
   {{ dbt.safe_cast("stop_station_name", api.Column.translate_type("string")) }} as stop_station_name,

   -- macro
   {{ get_user_category("usertype")}} as user_category,
   
   -- timestamps
   cast(starttime as timestamp) as start_time_date,
   cast(stoptime as timestamp) as stop_time_date,

   -- trip info
   {{ dbt.safe_cast("tripduration", api.Column.translate_type("integer")) }} as trip_duration_seconds

from {{ source('citi_bike_data', 'bike_trips_2020') }}