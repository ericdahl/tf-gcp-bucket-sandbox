resource "google_service_account" "read_only" {
  account_id = "bucket-read-only"
}

resource "google_project_iam_custom_role" "read_only" {
  role_id = "tf_gcp_bucket_sandbox_read_only"
  title   = "tf-gcp-bucket-sandbox"
  permissions = [
    "storage.buckets.list",
    "storage.objects.list"
  ]

  description = "read-only access to storage buckets"
}

resource "google_service_account_iam_binding" "read_only" {
  service_account_id = google_service_account.read_only.name
  role               = google_project_iam_custom_role.read_only.id

  members = [
    "serviceAccount:${google_service_account.read_only.email}"
  ]
}

resource "google_service_account_key" "read_only" {
  service_account_id = google_service_account.read_only.id
}

resource "google_project_iam_member" "read_only" {
  project = google_project_iam_custom_role.read_only.project
  role    = google_project_iam_custom_role.read_only.name
  member  = "serviceAccount:${google_service_account.read_only.email}"
}

resource "local_file" "read_only" {
  filename       = "credentials_read_only.json"
  content_base64 = google_service_account_key.read_only.private_key
}