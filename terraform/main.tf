terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.22.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

resource "google_storage_bucket" "nyc-citi-bike-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "citi_bike_data" {
  dataset_id = var.bq_dataset_name
  location = var.location
}

resource "google_bigquery_dataset" "stage_dataset" {
  dataset_id = var.dbt_stg_dataset
  project    = var.project
  location   = var.region
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "prod_dataset" {
  dataset_id = var.dbt_cloud_dataset
  project    = var.project
  location   = var.region
  delete_contents_on_destroy = true
}