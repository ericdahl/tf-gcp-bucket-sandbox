provider "google" {
  project = "tf-gcp-bucket-sandbox"
  region = "us-west-1"
}


resource "google_storage_bucket" "default" {

  force_destroy = true

  name = "tf-gcp-bucket-sandbox"
  location = "US-WEST1"
}

resource "google_storage_bucket_object" "default" {

  bucket = google_storage_bucket.default.name
  name   = "hello.txt"

  content = <<EOF
hello world
EOF
}
