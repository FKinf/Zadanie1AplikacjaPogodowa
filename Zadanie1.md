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


**Polecenia**

**a) Budowanie obrazu**

docker build -t weather-app:latest .

wynik:
[+] Building 18.5s (18/18) FINISHED                                                                                          docker:default
 => [internal] load build definition from Dockerfile                                                                                   0.0s
 => => transferring dockerfile: 995B                                                                                                   0.0s
 => resolve image config for docker-image://docker.io/docker/dockerfile:1.7                                                            1.8s
 => [auth] docker/dockerfile:pull token for registry-1.docker.io                                                                       0.0s
 => docker-image://docker.io/docker/dockerfile:1.7@sha256:a57df69d0ea827fb7266491f2813635de6f17269be881f696fbfdf2d83dda33e             0.8s
 => => resolve docker.io/docker/dockerfile:1.7@sha256:a57df69d0ea827fb7266491f2813635de6f17269be881f696fbfdf2d83dda33e                 0.0s
 => => sha256:96918c57e42509b97f10c074d80672ecdbd3bb7dcd38c1bd95960cf291207416 11.98MB / 11.98MB                                       0.6s
 => => extracting sha256:96918c57e42509b97f10c074d80672ecdbd3bb7dcd38c1bd95960cf291207416                                              0.2s
 => [internal] load metadata for docker.io/library/python:3.12-slim                                                                    2.1s
 => [auth] library/python:pull token for registry-1.docker.io                                                                          0.0s
 => [internal] load .dockerignore                                                                                                      0.0s
 => => transferring context: 2B                                                                                                        0.0s
 => [builder 1/4] FROM docker.io/library/python:3.12-slim@sha256:ec948fa5f90f4f8907e89f4800cfd2d2e91e391a4bce4a6afa77ba265bc3a2fe      3.8s
 => => resolve docker.io/library/python:3.12-slim@sha256:ec948fa5f90f4f8907e89f4800cfd2d2e91e391a4bce4a6afa77ba265bc3a2fe              0.0s
 => => sha256:b33ff618953dcb6177e78bc33883a49817e571a1d9f0a3aa039e3228e0f21684 250B / 250B                                             0.3s
 => => sha256:759e0c85a86e6d82ceccf351143d3f4a17e4ba196c9684240898abe3b8ec13a9 12.11MB / 12.11MB                                       1.2s
 => => sha256:797809503061a7d1332e7b5c3df030896846f0a6a179f90060e85564dca1cf65 1.29MB / 1.29MB                                         0.9s
 => => sha256:57fb71246055257a374deb7564ceca10f43c2352572b501efc08add5d24ebb61 29.78MB / 29.78MB                                       2.2s
 => => extracting sha256:57fb71246055257a374deb7564ceca10f43c2352572b501efc08add5d24ebb61                                              0.8s
 => => extracting sha256:797809503061a7d1332e7b5c3df030896846f0a6a179f90060e85564dca1cf65                                              0.1s
 => => extracting sha256:759e0c85a86e6d82ceccf351143d3f4a17e4ba196c9684240898abe3b8ec13a9                                              0.4s
 => => extracting sha256:b33ff618953dcb6177e78bc33883a49817e571a1d9f0a3aa039e3228e0f21684                                              0.0s
 => [internal] load build context                                                                                                      0.1s
 => => transferring context: 6.06kB                                                                                                    0.0s
 => [final 2/6] RUN adduser --disabled-password --gecos "" appuser                                                                     0.6s
 => [builder 2/4] WORKDIR /app                                                                                                         0.2s
 => [builder 3/4] COPY app/requirements.txt .                                                                                          0.1s
 => [builder 4/4] RUN pip install --no-cache-dir --prefix=/install -r requirements.txt                                                 7.1s
 => [final 3/6] WORKDIR /app                                                                                                           0.1s
 => [final 4/6] COPY --from=builder /install /usr/local                                                                                0.2s 
 => [final 5/6] COPY app/ .                                                                                                            0.1s 
 => [final 6/6] RUN chown -R appuser:appuser /app                                                                                      0.3s
 => exporting to image                                                                                                                 1.4s
 => => exporting layers                                                                                                                0.8s
 => => exporting manifest sha256:19473cb1fbb6f840f4110d786d2122ed56d27120bb93d5c439ba05b67478d705                                      0.0s
 => => exporting config sha256:97a623bf17f72d000f7bde1d49f5181671636cec2db4b2859333698cc00afc11                                        0.0s
 => => exporting attestation manifest sha256:74aca7db4ca56e01345f2edc87ebee393020454f9a4ce6bcdd0cd34d7a873860                          0.0s
 => => exporting manifest list sha256:bdc85e2c8b8f63a5ff0312a7bb4b474be4cd5bcb2e3e458b6d280287bb98530b                                 0.0s
 => => naming to docker.io/library/weather-app:latest                                                                                  0.0s
 => => unpacking to docker.io/library/weather-app:latest       


**b) Uruchomienie kontenera**

docker run -d --name weather-container -p 8080:8080 -e WEATHER_API_KEY="kluczapi" weather-app:latest

wynik:

1114a810b7152c0f2449149792d9f23f4a700f772e9c21919d84cc03bbcd448f

**c) Odczyt logów z uruchomienia kontenera**

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

**d) Liczba warstw** 

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


**e) Rozmiar obrazu**

docker images weather-app
Wynik:
IMAGE                ID             DISK USAGE   CONTENT SIZE   EXTRA
weather-app:latest   bdc85e2c8b8f        191MB         46.3MB    U



