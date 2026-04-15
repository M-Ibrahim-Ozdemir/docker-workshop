docker run -it --rm \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v ny_taxi_postgres_data:/var/lib/postgresql \
  -p 5432:5432 \
  --network=pg-network \
  --name pgdatabase \
  postgres:18


docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -v pgadmin_data:/var/lib/pgadmin \
  -p 8085:80 \
  --network=pg-network \
  --name pgadmin \
  dpage/pgadmin4



uv run python ingest_data.py \
  --pg-user=root \
  --pg-pass=root \
  --pg-host=localhost \
  --pg-port=5432 \
  --pg-db=ny_taxi \
  --target-table=yellow_taxi_trips_2021_1 \
  --year=2021 \
  --month=1 \
  --chunksize=100000


  docker run -it --rm \
   --network=pipeline_default \
    taxi_ingest:v001 \
    --pg-user=root \
    --pg-pass=root \
    --pg-host=pgdatabase \
    --pg-port=5432 \
    --pg-db=ny_taxi \
    --target-table=yellow_taxi_trips_2021_1 \
    --chunksize=100000
    #bu verileri ekliyor database içine
    #Kodumuzu her ortamda çalışabilir (portable) hale getirmek.
    #docker run kullandık? Çünkü script'imiz (ingest_data.py) artık bir Docker imajı (taxi_ingest:v001) içinde paketli. Yarın bu imajı bir sunucuya (AWS, Azure vb.) atsak da aynı komutla çalışacak.
      #------
    #Otomatik ayağa kalkan bir Veri Tabanı (Postgres).

    #Onu yöneten bir Arayüz (pgAdmin).

    #Verileri internetten çekip yükleyen Dockerize edilmiş bir Script.

    #Bunların hepsini tek yerden yöneten bir Docker Compose dosyası var.