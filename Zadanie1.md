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

docker inspect weather-app:latest | grep -10 "Layers"
wynik:
Obraz zawiera 9 warstw.

  "Type": "layers",
            "Layers": [
                "sha256:79dd1f4c855cd061f687a994426634cf5f84c8ecdbc66c7a7d118e828dd93c99",
                "sha256:1361e0a963c66ac67506e2b5cacf01a39cc0816185f96afe77031eb5d4ba2d56",
                "sha256:fae8529c7ef7ef831623bd668a9a847f681ab78e77abb2fb84bd7d3c47a70cc0",
                "sha256:23ed4b6439ad2c4b1602f19014cc7a90b49a943eabe7f8ab9bb1aa7c0482949c",
                "sha256:5b23af176c49917b76c32b3923cb2ca14c237c4935a12f8f0985e0bbf9f61dac",
                "sha256:cf87387bf97c47d54939efb63b3ead2a34016b8a94b464ce156f78505b7012bf",
                "sha256:aad74a1e3ac01b89b8d89f3b94f0c43f834e58494b44317a89084efba25c7e64",
                "sha256:a41cca00660b08912086bcf34a626b4aeb8e5819f2535df3e8ce287893662fef",
                "sha256:dac5ee4f6e0c755456e5cda3bb2da4d3d10f0e1252149526f35c722ddc609fcd"
            ]


e) Rozmiar obrazu

docker images weather-app
Wynik:
IMAGE                ID             DISK USAGE   CONTENT SIZE   EXTRA
weather-app:latest   bdc85e2c8b8f        191MB         46.3MB    U



