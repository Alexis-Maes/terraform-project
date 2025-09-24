import os

from google.cloud import secretmanager
from mistralai import Mistral


def get_secret(secret_id: str, project_id: str = "terraform-beginning") -> str:
    client = secretmanager.SecretManagerServiceClient()
    secret_name = f"projects/{project_id}/secrets/{secret_id}/versions/latest"
    response = client.access_secret_version(request={"name": secret_name})
    secret_value = response.payload.data.decode("UTF-8")

    return secret_value


try:
    api_key = get_secret("mistral-api-key")
except:
    api_key = os.getenv("MISTRAL_API_KEY")

client = Mistral(api_key=api_key)

def completion(query: str) -> str:
    print("apikey is None", api_key is None)
    chat_response = client.chat.complete(
        model="mistral-small-latest", messages=[{"role": "user", "content": query}]
    )
    return chat_response.choices[0].message.content
