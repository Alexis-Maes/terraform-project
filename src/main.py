from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def main() -> dict:
    print({"message": "Hello from FastAPI!"})
    return {"message": "Hello from FastAPI!"}




