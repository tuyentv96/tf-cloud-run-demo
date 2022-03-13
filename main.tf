terraform {
  cloud {
    organization = "tuyentv"

    workspaces {
      name = "gh-actions-demo"
    }
  }
}

provider "google" {
  project = var.GCP_PROJECT_ID
  region  = "asia-southeast1"
  zone    = "asia-southeast1-a"
}

# Enables the Cloud Run API
resource "google_project_service" "run_api" {
  service = "run.googleapis.com"

  disable_on_destroy = true
}

resource "google_cloud_run_service" "default" {
  name     = "cloudrun-hello-app"
  location = "asia-southeast1"

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
