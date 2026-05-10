# Zadanie 1 — Technologie Chmurowe

**Autor:** Filip Kwietniak 
**Repozytorium GitHub:** https://github.com/FKinf/Zadanie1AplikacjaPogodowa
**Obraz DockerHub:** https://hub.docker.com/repository/docker/fkinf/weather-app/general
---


Aplikacja napisana w języku Python z wykorzystaniem frameworka Flask. Informacje o aktualnej pogodzie pobieramy z API OpenWeatherMap
Wszystkie pliki stworzone przezemnie do tego zadania są dostępne na rezpozytorium

Plik Dockerfile wykorzystuje wieloetapowe budowanie obrazu:

- Etap builder — instaluje zależności Pythona do osobnego katalogu `/install`
- Etap final — kopiuje tylko zainstalowane paczki, bez narzędzi budowania

Zastosowane optymalizacje:
- Kopiowanie `requirements.txt` przed kodem źródłowym — optymalizacja cache Docker
- Flaga `--no-cache-dir` — brak cache pip w obrazie
- Niepriwilegowany użytkownik `appuser` — bezpieczeństwo
- `PYTHONDONTWRITEBYTECODE` i `PYTHONUNBUFFERED` — czystszy obraz i natychmiastowe logi
- Healthcheck odpytujący endpoint `/health`
- OCI Labels zgodne ze standardem


Polecenia

a) Budowanie obrazu

docker build -t weather-app:latest .

b) Uruchomienie kontenera

docker run -d --name weather-container -p 8080:8080 -e WEATHER_API_KEY="kluczapi" weather-app:latest

c) Odczyt logów z uruchomienia kontenera

docker logs weather-container
wynik:

[2026-05-10 16:18:28 +0000] [1] [INFO] Starting gunicorn 23.0.0
[2026-05-10 16:18:28 +0000] [1] [INFO] Listening at: http://0.0.0.0:8080 (1)
[2026-05-10 16:18:28 +0000] [1] [INFO] Using worker: sync
[2026-05-10 16:18:28 +0000] [7] [INFO] Booting worker with pid: 7
[2026-05-10 16:18:28 +0000] [8] [INFO] Booting worker with pid: 8
2026-05-10 16:18:28,546 - INFO - === Aplikacja uruchomiona ===
2026-05-10 16:18:28,546 - INFO - Data uruchomienia : 2026-05-10 16:18:28
2026-05-10 16:18:28,546 - INFO - Autor             : Filip Kwietniak
2026-05-10 16:18:28,546 - INFO - Nasłuchuje na porcie TCP: 8080
2026-05-10 16:18:28,588 - INFO - === Aplikacja uruchomiona ===
2026-05-10 16:18:28,588 - INFO - Data uruchomienia : 2026-05-10 16:18:28
2026-05-10 16:18:28,588 - INFO - Autor             : Filip Kwietniak
2026-05-10 16:18:28,588 - INFO - Nasłuchuje na porcie TCP: 8080

d) Liczba warstw 

docker inspect weather-app:latest | grep -c "sha256"
wynik:
12

e) Rozmiar obrazu

docker images weather-app
Wynik:
IMAGE                ID             DISK USAGE   CONTENT SIZE   EXTRA
weather-app:latest   bdc85e2c8b8f        191MB         46.3MB    U



