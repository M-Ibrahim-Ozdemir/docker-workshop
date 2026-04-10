#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd

year = 2021
month = 1

# Ayın başına otomatik 0 eklemek için :02d kullanıyoruz
prefix = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/'
url = f'{prefix}/yellow_tripdata_{year}-{month:02d}.csv.gz'

df = pd.read_csv(url)


# In[ ]:


#karısık veri  tiplerine dair sutunlar  varmıs dıyor uayarı


# In[5]:


df.head()


# In[ ]:


#ne yaptık dockerda jupytter ayagara kaldırdık. NYC taxi bikırsmını çekip buu postgres içine koyacaz


# In[6]:


len(df)


# In[7]:


df


# In[9]:


df['VendorID']


# In[ ]:


#burda mesela 1.0 tamsayı ama NAN var float algılamıs. hataı veri algılamaıs MANDUS


# In[10]:


df['tpep_pickup_datetime']


# In[ ]:


#tarih tyğpe olmaslıo
#aslında su sekilde pakette tur var, pandas turu taghmin etmeye calısıyor ama basaramıyor


# In[ ]:





# In[11]:


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

parse_dates = [
    "tpep_pickup_datetime",
    "tpep_dropoff_datetime"
]

df = pd.read_csv(
    url,
    dtype=dtype,
    parse_dates=parse_dates
)


# In[13]:


df.head()


# In[14]:


df['tpep_pickup_datetime']


# In[ ]:


#grdugmuz gibi datetime değişmiş dogru olmus...


# In[ ]:


##Şimdi sqlalchemy kutuphanesi:  python ve verşitabanları arası ilişki için


# In[ ]:





# In[21]:


get_ipython().system('uv add sqlalchemy')





#terminaldede yazsan aynı seyl olur





get_ipython().system('uv add psycopg2-binary')




pg_user = 'root'
pg_pass = 'root'
pg_host = 'localhost'
pg_port = 5432
pg_db = 'ny_taxi'

from sqlalchemy import create_engine
engine = create_engine(f'postgresql://{pg_user}:{pg_pass}@{pg_host}:{pg_port}/{pg_db}')


# In[ ]:





# In[26]:


print(pd.io.sql.get_schema(df, name='yellow_taxi_data', con=engine))


# In[ ]:


#veritanaımız için olustrucak schema yı sağlıyor


# In[28]:


df.head(n=0).to_sql(name='yellow_taxi_data', con=engine, if_exists='replace')   #amac su: yukardaki tabloyu olutruyo ama içine veri eklemiyor


# terminalde
# > cd ./pipeline/
# > uv run pgcli -h localhost -p 5432 -u root -d ny_taxi
# 
# bunu deik verirabanı olsutrudıl

# In[29]:


len(df)


# In[ ]:


#bu cok buyuk parcalıyıp yuklemelizyiz. Yıneleyici kullnacaz


# In[ ]:





# In[ ]:





# In[41]:


df_iter = pd.read_csv(
    url,
    dtype=dtype,
    parse_dates=parse_dates,
    iterator=True,
    chunksize=100000
)


# In[42]:


#veri tablolaın her birini incelemek, parcaları veritabanına eklemek için
get_ipython().system('uv add tqdm')


# In[43]:


from tqdm.auto import tqdm    #ilerlemeyi gormek icin. 


# In[44]:


for df_chunk in tqdm(df_iter):
    df_chunk.to_sql(name='yellow_taxi_data', con=engine, if_exists='append')  
    #veritabanına ekler


# vs cod terminalden
# 
# ls
# README.md  pipeline  test
# 
# > cd ./pipeline/
# > uv run pgcli -h localhost -p 5432 -u root -d ny_taxi
# 
# select COUNT(1) from yellow_taxi_data      konrtıo edersin gelmişmi vertabanına

# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




