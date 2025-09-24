resource "google_cloud_run_service" "default" {
    name = "terraform-app"
    location = "europe-west9"

    metadata {
      annotations = {
        "run.googleapis.com/ingress" = "all"
      }
    }

    template {
        spec {
            containers {
                image = "gcr.io/terraform-beginning/terraform-app:v1.1"
                ports {
                    container_port = 8080
                }
            }
        }
    }
    traffic {
        percent = 100
        latest_revision = true
    }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_secret_manager_secret" "mistral_api_key" {
    secret_id = "mistral-api-key"
    replication {
        auto {}
    }
}

resource "google_secret_manager_secret_version" "mistral_api_key_version" {
    secret = google_secret_manager_secret.mistral_api_key.id
    secret_data = var.mistral_api_key
}
