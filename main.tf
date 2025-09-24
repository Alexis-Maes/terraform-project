resource "google_cloud_run_service" "default" {
    name = "basic-app"
    location = "europe-west9"

    template {
        spec {
            containers {
                image = "gcr.io/terraform-beginning/basic-app:latest"
            }
        }
    }
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
