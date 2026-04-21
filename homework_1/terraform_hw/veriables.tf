#değişken olusturyoz kendimiz. Bazı şeyelri değiştrimek için
variable "project" {
  description = "Project"
  default     = "project-26ba53b4-6e64-4d2f-9a7"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}


variable "location" {
  description = "Project location"
  default     = "US"
}


variable "bq_dataset_name" {
  description = "My Bigquery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "project-26ba53b4-6e64-4d2f-9a7-terra-bucket"
}


variable "gcs_storage_class" {
  description = "Bucget storage class"
  default     = "STANDARD"
}
