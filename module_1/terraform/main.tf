terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.16.0"
    }
  }
}

provider "google" {
  project     = "project-4bb40182-e231-41c4-ac4"
  region      = "us-central1"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "project-4bb40182-e231-41c4-ac4-demo-bucket"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}