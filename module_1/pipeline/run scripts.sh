# Collection of scripts to run Docker containers for PostgreSQL and data ingestion - not meant to be executed as a single script.

# Run PostgreSQL on the network
docker run -it --rm \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v ny_taxi_postgres_data:/var/lib/postgresql \
  -p 5432:5432 \
  --network=pg-network \
  --name pgdatabase \
  postgres:18

# Run the Containerized Ingestion -network=pg-network
docker run --rm -it --network=pg-network taxi_ingest:nov2025 \
  --pg-user root \
  --pg-pass root \
  --pg-host pgdatabase \
  --pg-port 5432 \
  --pg-db ny_taxi \
  --year 2025 \
  --month 11 \
  --chunksize 100000 \
  --target-table green_taxi_trips \
  --zones-table taxi_zones

# In another terminal, run pgAdmin on the same network
docker run -it --rm \
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
  --target-table=yellow_taxi_trips \
  --year=2021 \
  --month=1 \
  --chunksize=100000

docker start pgadmin