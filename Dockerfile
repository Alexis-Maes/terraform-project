FROM python:3.12-slim

RUN pip install uv

COPY . /app
WORKDIR /app

RUN uv sync --locked

EXPOSE 8080

CMD uv run main.py