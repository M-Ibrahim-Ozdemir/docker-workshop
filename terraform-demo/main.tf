terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.28.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}


resource "google_storage_bucket" "demo-bucket" {
  name                        = var.gcs_bucket_name
  location                    = var.location
  force_destroy               = true
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

#terrafrom biquery dataset diye aratarak ilgili siyteden adkdıl. 
#cok değişiklik yaprık burda variable onur tarfat olustuduk entehre ettik
resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}
#tekarar terraform apply dedik yes dedik bıquety de buldu. tabı once kaldırdıydık . Google cloude gittim bıgqueyde demo_dataset olostrdu. sonra terraform destroy kadlırdıyoz
#sonra veriables.tf dosyaıs olututyorz
#tekrardan bunun içeriğini guncelledikdetayıca her ıkı doysaıda sonra tekraradan terraform apply diyoruz terminale
#bır sey daha yapcaz terraform destroy , tes dedilk

#google ye unit variable linux arattırdık.  Ama biz yapmadık cunkuanahtar kullnamadık json falan
# gcloud auth application-default print-access-token  terminaden bynu kontrol edelim
#hersey yolunda terraform apply sonra yes de
#tekrar terraform destroy yaptık gitti  hpesi

#kod ile altyapi tanımlama, olustruma istediğimiz kaynakları soyeleyebilme bunları terrafom plam ile onzileme terraform apply ile dağıtma, defrrafrom destroy ile temizleme
#Plan -> Apply -> Destroy