variable "project" {
  description = "GCP Project ID"
  default     = "project-4bb40182-e231-41c4-ac4"
}

variable "region" {
  description = "GCP Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "My BigQuery dataset name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My storage bucket name"
  default     = "project-4bb40182-e231-41c4-ac4-demo-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket storage class"
  default     = "STANDARD"
}