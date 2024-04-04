{{ config(materialized='table') }}

-- partition and cluster table
{{ partitioned_by(partition_by='start_time_date', partition_field_type='date') }}
{{ cluster_by('ride_id') }}

-- generate final table
with bike2019_data as (
    select *
    from {{ ref('stg_citi_bike_2019') }}
),
with bike2020_data as (
    select *
    from {{ ref('stg_citi_bike_2020') }}
),
with bike2023_data as (
    select *
    from {{ ref('stg_citi_bike_2023')}}
),
rides_unioned as (
  select
    ride_id,
    start_station_name,
    end_station_name,
    user_category,
    start_time_date,
    stop_time_date,
    case
      when trip_duration_seconds is null 
        then datediff(second, start_time_date, stop_time_date)
      else trip_duration_seconds
    end as trip_duration_seconds
  from bike2019_data
  union all
  select
    ride_id,
    start_station_name,
    end_station_name,
    user_category,
    start_time_date,
    stop_time_date,
    case
      when trip_duration_seconds is null 
        then datediff(second, start_time_date, stop_time_date)
      else trip_duration_seconds
    end as trip_duration_seconds
  from bike2020_data
  union all
  select
    ride_id,
    start_station_name,
    end_station_name,
    user_category,
    start_time_date,
    stop_time_date,
    datediff(second, start_time_date, stop_time_date) as trip_duration_seconds
  from bike2023_data
)

-- remove rows with null/missing values
select
  *
from rides_unioned
where ride_id is not null
  and start_station_name is not null
  and end_station_name is not null
  and user_category is not null
  and start_time_date is not null
  and stop_time_date is not null
  and trip_duration_seconds is not null