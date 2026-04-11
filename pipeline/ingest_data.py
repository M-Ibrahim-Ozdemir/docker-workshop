import pandas as pd
from sqlalchemy import create_engine
from tqdm.auto import tqdm

# Veri tiplerini baştan tanımlamak bellek (RAM) dostudur
dtype = {
    "VendorID": "Int64",
    "passenger_count": "Int64",
    "trip_distance": "float64",
    "RatecodeID": "Int64",
    "store_and_fwd_flag": "string",
    "PULocationID": "Int64",
    "DOLocationID": "Int64",
    "payment_type": "Int64",
    "fare_amount": "float64",
    "extra": "float64",
    "mta_tax": "float64",
    "tip_amount": "float64",
    "tolls_amount": "float64",
    "improvement_surcharge": "float64",
    "total_amount": "float64",
    "congestion_surcharge": "float64"
}

parse_dates = ["tpep_pickup_datetime", "tpep_dropoff_datetime"]

def run():
    pg_user, pg_pass = 'root', 'root'
    pg_host, pg_port = 'localhost', 5432
    pg_db = 'ny_taxi'
    target_table = 'yellow_taxi_data'
    
    year, month = 2021, 1
    chunksize = 100000
    
    url = f'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_{year}-{month:02d}.csv.gz'
    engine = create_engine(f'postgresql://{pg_user}:{pg_pass}@{pg_host}:{pg_port}/{pg_db}')

    # Iteratör oluşturuyoruz
    df_iter = pd.read_csv(
        url,
        dtype=dtype,
        parse_dates=parse_dates,
        iterator=True,
        chunksize=chunksize,
    )

    first = True
    for df_chunk in tqdm(df_iter):
        if first:
            # Önce tabloyu oluştur (hiç veri yüklemeden sadece şema)
            df_chunk.head(0).to_sql(name=target_table, con=engine, if_exists='replace', index=False)
            first = False
        
        # Sonra veriyi ekle (append)
        df_chunk.to_sql(name=target_table, con=engine, if_exists='append', index=False)

    print("İşlem tamamlandı! 🚀")

if __name__ == '__main__':
    run()

    """veriyi internetten (GitHub) çektik, parçalara böldüm (chunking) ve Docker üzerinde çalışan Postgres veri tabanına başarıyla akıttım."""
    #uv run python ingest_data.py
    #uv run pgcli -h localhost -p 5432 -u root -d ny_taxi
    #\dt
    #SELECT COUNT(1) FROM yellow_taxi_data;