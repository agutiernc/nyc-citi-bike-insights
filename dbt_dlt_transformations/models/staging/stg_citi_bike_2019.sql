{{ config(materialized='view') }}

-- Select the relevant columns from the 2019 data source and perform any necessary transformations

with bike_data as (
   select *,
      row_number() over(partition by bikeid, starttime) as rn
   from {{ source('staging','stg_citi_bike_2019') }}
   where bikeid is not null 
)

select
   -- identifiers
   {{ dbt.safe_cast("bikeid", api.Column.translate_type("string")) }} as ride_id,
   {{ dbt.safe_cast("start_station_name", api.Column.translate_type("string")) }} as start_station_name,
   {{ dbt.safe_cast("stop_station_name", api.Column.translate_type("string")) }} as stop_station_name,
   
   --- macro
   {{ get_user_category("usertype")}} as user_category,
   
   -- timestamps
   cast(starttime as timestamp) as start_time_date,
   cast(stoptime as timestamp) as stop_time_date,

   -- trip info
   {{ dbt.safe_cast("tripduration", api.Column.translate_type("integer")) }} as trip_duration_seconds

from bike_data
where rn = 1