# terraform-project
# terraform-project


build image:

locally

```bash
docker buildx build --platform linux/arm64,linux/amd64 --tag terraform-app:latest --load .
```

for Google Container Registry

```bash
docker buildx build --platform linux/arm64,linux/amd64 --tag gcr.io/terraform-beginning/terraform-app:v1.2 --push . 
```

pour run:

Locally

```bash
docker run --env-file .env -p 8080:8080 terraform-app:latest
```


to try: curl request 

simple query:

```bash
curl -X POST "http://localhost:8080/simple_query/" \
     -H "Content-Type: application/json" \
     -d '{"query": "\"Hello what'\''s up\""}'
```