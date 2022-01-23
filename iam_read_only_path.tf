resource "google_service_account" "read_only_path" {
  account_id = "bucket-read-only-path"
}

resource "google_project_iam_custom_role" "read_only_path" {
  role_id = "tf_gcp_bucket_sandbox_read_only_path"
  title   = "tf-gcp-bucket-sandbox"
  permissions = [
    "storage.buckets.list",
    "storage.objects.list"
  ]

  description = "read-only-path access to storage buckets"
}

resource "google_service_account_iam_binding" "read_only_path" {
  service_account_id = google_service_account.read_only_path.name
  role               = google_project_iam_custom_role.read_only_path.id

  members = [
    "serviceAccount:${google_service_account.read_only_path.email}"
  ]

  condition {
    expression = "resource.name.startsWith('projects/_/buckets/${google_storage_bucket.default.name}/objects/${google_storage_bucket_object.default.name}')"
    title      = "read-only access to particular path"
  }
}

resource "google_service_account_key" "read_only_path" {
  service_account_id = google_service_account.read_only_path.id
}

resource "google_project_iam_member" "read_only_path" {
  project = google_project_iam_custom_role.read_only_path.project
  role    = google_project_iam_custom_role.read_only_path.name
  member  = "serviceAccount:${google_service_account.read_only_path.email}"
}

resource "local_file" "read_only_path" {
  filename       = "credentials_read_only_path.json"
  content_base64 = google_service_account_key.read_only_path.private_key
}