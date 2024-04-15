# Biking in the Big Apple: Trends and Insights in New York City's Citi Bike Program

## Project Overview 🚀

This project analyzes data from New York City's Citi Bike share program for the years 2019, 2020, and 2023. The primary goal is to investigate ridership trends before the 2020 pandemic, during 2020, and in the year 2023. The project aims to answer the following questions:

1. How did the 2020 pandemic impact ridership, and did it rebound significantly by 2023?
2. Are there any differences or similarities in monthly usage trends for each year, particularly during the 2020 pandemic?
3. What is the comparison between members of the bike program and non-members in terms of total usage across all three years combined?
4. Which bike stations are the most popular, and what are the total trips and average trip times for each of the top 5 stations?

By analyzing the data, we can gain insights into the popularity of certain areas in New York City among Citi Bike users and determine if the most popular stations change over time, even as Citi Bike relocates bike stations. The project also examines whether the average trip time for users changes significantly when starting and completing trips at these popular stations.

Through this analysis, we aim to better understand the impact of the pandemic on bike-sharing in New York City and identify any lasting changes in ridership patterns and user behavior.


## Tech Stack 🖥 

- **Terraform**: Used for Infrastructure as Code (IaC) to create a Google Cloud Storage (GCS) bucket and BigQuery dataset

- **Google Cloud Storage (GCS)**: Used as a data lake to store the raw Citi Bike data in parquet format

- **Google BigQuery**: Used as the data warehouse for storing and analyzing the Citi Bike data

- **PyArrow**: Used in conjunction with the Data Load Tool (dlt) for the initial data pipeline

- **Data Load Tool (dlt)**: Utilized for the ETL process, creating data pipelines, dbt transformations, and setting up GitHub Actions

- **dbt (Data Build Tool)**: Employed for performing data transformations and running tests on the data stored in BigQuery

- **GitHub Actions**: Integrated with dlt to deploy a monthly triggered data pipeline

- **Google Looker Studio**: Used for creating a dashboard to visualize the analyzed Citi Bike data

<ADD TECH FLOW DIAGRAM HERE>

## Data Structure 🧱

### Raw Tables
| 2019 | 2020 | 2023 |
| :-- | :--- | :--- |
| tripduration | tripduration | - |
| startime | startime | started_at|
| stoptime | stoptime | ended_at |
| start station id | start station id | start_station_id |
| start station name | start station name | start_station_name |
| start station latitude | start station latitude | start_lat |
| start station longitude | start station longitude | start_lng |
| end station id | end station id | end_station_id |
| end station name | end station name | end_station_name|
| end station latitude | end station latitude | end_lat |
| end station longitude | end station longitude | end_lng |
| bikeid | bikeid | ride_id |
| usertype | usertype | member_casual |
| birth year | birth year | - |
| gender | gender | - |
| - | - | rideable_type |

#### Number of rows
* **2019 -** 20,551,697
* **2020 -** 19,506,857
* **2023 -** 36,226,600

### Final Materialized Table

| 2019 - 2023 (Combined)|
| :-- |
| ride_id |
| start_time_date |
| stop_time_date |
| trip_duration_seconds |
| start_station_name |
| stop_station_name |
| user_category |

#### Number of rows
* 76,285,697

## Analysis 📊
<p align="center">
    <img src="images/nyc-citi-bike-dashboard.png">
</p>

## Instructions 🧭

<ADD CHALLENGES HERE>