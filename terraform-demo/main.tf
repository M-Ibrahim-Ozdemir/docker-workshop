terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.28.0"
    }
  }
}

provider "google" {
  project = "project-26ba53b4-6e64-4d2f-9a7"
  region  = "us-central1"
}


resource "google_storage_bucket" "demo-bucket" {
  name          = "project-26ba53b4-6e64-4d2f-9a7-terra-bucket"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}


#bu kdolara tearraform cloud bucget vb yazarakdokımnakradan bulduk ıd falan ısım depiştiridk.İölerinde ne anlama geldiğine baabilirz