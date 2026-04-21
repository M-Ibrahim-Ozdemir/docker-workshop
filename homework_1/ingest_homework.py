import pandas as pd
from sqlalchemy import create_engine

# Bağlantı Ayarları
engine = create_engine('postgresql://postgres:postgres@localhost:5433/ny_taxi')

# Verileri Oku
print("Veriler okunuyor...")
# Not: Dosyalar bir üst klasörde kalmış olabilir, yoluna dikkat!
df_green = pd.read_parquet('green_tripdata_2025-11.parquet')
df_zones = pd.read_csv('taxi_zone_lookup.csv')

# Postgres'e Yaz
print("Tablolar oluşturuluyor...")
df_green.to_sql(name='green_taxi_data', con=engine, if_exists='replace', index=False)
df_zones.to_sql(name='zones', con=engine, if_exists='replace', index=False)

print("İşlem Başarılı! SQL sorgularına geçebiliriz.")