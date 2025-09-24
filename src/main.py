import os

from fastapi import FastAPI
from pydantic import BaseModel
from mistral_api import completion

app = FastAPI()

best_company = os.getenv("BEST_COMPANY")

class SimpleQueryRequest(BaseModel):
    query: str



@app.get("/")
def main() -> dict:
    return {"message": "Hello from FastAPI!"}


@app.get("/best_company/")
def get_best_company() -> str:
    return f"The best company is {best_company}"


@app.post("/simple_query/", response_model=str)
def answer_simple_query(request: SimpleQueryRequest) -> str:
    return completion(request.query)
