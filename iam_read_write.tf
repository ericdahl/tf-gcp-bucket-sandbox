resource "google_service_account" "read_write" {
  account_id = "bucket-read-write"
}

resource "google_project_iam_custom_role" "read_write" {
  role_id = "tf_gcp_bucket_sandbox_read_write"
  title   = "tf-gcp-bucket-sandbox"
  permissions = [
    "storage.buckets.list",
    "storage.objects.list",
    "storage.objects.create"
  ]

  description = "read-write access to storage buckets"
}

resource "google_service_account_iam_binding" "read_write" {
  service_account_id = google_service_account.read_write.name
  role               = google_project_iam_custom_role.read_write.id

  members = [
    "serviceAccount:${google_service_account.read_write.email}"
  ]
}

resource "google_service_account_key" "read_write" {
  service_account_id = google_service_account.read_write.id
}

resource "google_project_iam_member" "read_write" {
  project = google_project_iam_custom_role.read_write.project
  role    = google_project_iam_custom_role.read_write.name
  member  = "serviceAccount:${google_service_account.read_write.email}"
}

resource "local_file" "read_write" {
  filename       = "credentials_read_write.json"
  content_base64 = google_service_account_key.read_write.private_key
}