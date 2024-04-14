variable "project" {
  description = "nyc-citi-bike project ID for GCS"
  default = "" # add GCS project ID
}

variable "region" {
  description = "Region for Google Cloud Storage"
  default = "" # add GCS region (e.g. => "us-west1")
}

variable "location" {
  description = "Project Location"
  default = "" # add GCS region (e.g. => "us-west1")
}

variable "credentials" {
  description = "My Credentials"
  default = "" # Add file path to GCS service account json key"
}

variable "gcs_bucket_name" {
  description = "NYC Citi Bike Bucket"
  default = "" # add GCS bucket name
}

variable "bq_dataset_name" {
  description = "NYC Citi Bike BigQuery data set"
  default = "citi_bike_data"
}
