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

docker history weather-app:latest
wynik:
IMAGE          CREATED        CREATED BY                                      SIZE      COMMENT
bdc85e2c8b8f   2 hours ago    CMD ["gunicorn" "-w" "2" "-b" "0.0.0.0:8080"…   0B        buildkit.dockerfile.v0
<missing>      2 hours ago    HEALTHCHECK &{["CMD-SHELL" "python3 -c \"imp…   0B        buildkit.dockerfile.v0
<missing>      2 hours ago    EXPOSE map[8080/tcp:{}]                         0B        buildkit.dockerfile.v0
<missing>      2 hours ago    USER appuser                                    0B        buildkit.dockerfile.v0
<missing>      2 hours ago    RUN /bin/sh -c chown -R appuser:appuser /app…   24.6kB    buildkit.dockerfile.v0
<missing>      2 hours ago    COPY app/ . # buildkit                          24.6kB    buildkit.dockerfile.v0
<missing>      2 hours ago    COPY /install /usr/local # buildkit             10.9MB    buildkit.dockerfile.v0
<missing>      2 hours ago    WORKDIR /app                                    8.19kB    buildkit.dockerfile.v0
<missing>      2 hours ago    RUN /bin/sh -c adduser --disabled-password -…   73.7kB    buildkit.dockerfile.v0
<missing>      2 hours ago    ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFER…   0B        buildkit.dockerfile.v0
<missing>      2 hours ago    LABEL org.opencontainers.image.version=1.0.0    0B        buildkit.dockerfile.v0
<missing>      2 hours ago    LABEL org.opencontainers.image.description=A…   0B        buildkit.dockerfile.v0
<missing>      2 hours ago    LABEL org.opencontainers.image.title=Weather…   0B        buildkit.dockerfile.v0
<missing>      2 hours ago    LABEL org.opencontainers.image.authors=Filip…   0B        buildkit.dockerfile.v0
<missing>      46 hours ago   CMD ["python3"]                                 0B        buildkit.dockerfile.v0
<missing>      46 hours ago   RUN /bin/sh -c set -eux;  for src in idle3 p…   16.4kB    buildkit.dockerfile.v0
<missing>      46 hours ago   RUN /bin/sh -c set -eux;   savedAptMark="$(a…   41.4MB    buildkit.dockerfile.v0
<missing>      46 hours ago   ENV PYTHON_SHA256=c08bc65a81971c1dd578318282…   0B        buildkit.dockerfile.v0
<missing>      46 hours ago   ENV PYTHON_VERSION=3.12.13                      0B        buildkit.dockerfile.v0
<missing>      46 hours ago   ENV GPG_KEY=7169605F62C751356D054A26A821E680…   0B        buildkit.dockerfile.v0
<missing>      46 hours ago   RUN /bin/sh -c set -eux;  apt-get update;  a…   4.94MB    buildkit.dockerfile.v0
<missing>      46 hours ago   ENV LANG=C.UTF-8                                0B        buildkit.dockerfile.v0
<missing>      46 hours ago   ENV PATH=/usr/local/bin:/usr/local/sbin:/usr…   0B        buildkit.dockerfile.v0
<missing>      5 days ago     # debian.sh --arch 'amd64' out/ 'trixie' '@1…   87.4MB    debuerreotype 0.17

e) Rozmiar obrazu

docker images weather-app
Wynik:
IMAGE                ID             DISK USAGE   CONTENT SIZE   EXTRA
weather-app:latest   bdc85e2c8b8f        191MB         46.3MB    U



