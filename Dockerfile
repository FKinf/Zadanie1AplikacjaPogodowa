# syntax=docker/dockerfile:1.7

FROM python:3.12-slim AS builder
WORKDIR /app

COPY app/requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.12-slim AS final


LABEL org.opencontainers.image.authors="Filip Kwietniak"
LABEL org.opencontainers.image.title="Weather App"
LABEL org.opencontainers.image.description="Aplikacja pogodowa  — Technologie Chmurowe Zadanie 1"
LABEL org.opencontainers.image.version="1.0.0"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080


RUN adduser --disabled-password --gecos "" appuser

WORKDIR /app

COPY --from=builder /install /usr/local

COPY app/ .

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 8080


HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD python3 -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/health')"

CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:8080", "app:app"]
