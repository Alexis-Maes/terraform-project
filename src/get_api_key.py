from google.cloud import secretmanager


def get_secret(secret_id: str, project_id: str = "terraform-beginning") -> str:
    client = secretmanager.SecretManagerServiceClient()
    secret_name = f"projects/{project_id}/secrets/{secret_id}/versions/latest"
    response = client.access_secret_version(request={"name": secret_name})
    secret_value = response.payload.data.decode("UTF-8")

    return secret_value

if __name__ == '__main__':
    print(get_secret("mistral-api-key"))
