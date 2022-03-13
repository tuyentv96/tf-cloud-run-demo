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
}

resource "google_cloud_run_service" "default" {
    name     = var.AppName
    location = var.Location

    metadata {
      annotations = {
        "run.googleapis.com/client-name" = "terraform"
      }
    }

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
     members = ["allUsers"]
   }
 }

 resource "google_cloud_run_service_iam_policy" "noauth" {
   location    = google_cloud_run_service.default.location
   project     = google_cloud_run_service.default.project
   service     = google_cloud_run_service.default.name

   policy_data = data.google_iam_policy.noauth.policy_data
}
