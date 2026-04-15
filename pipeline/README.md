## 📊 Örnek Veri Analizi (SQL)

Proje kapsamında ham verileri anlamlı hale getirmek için tablolar arası birleştirme (Join) işlemleri yapılmıştır. Aşağıdaki sorgu, biniş ve iniş bölgelerinin ID'lerini `zones` tablosuyla eşleştirerek bölge isimlerini okunabilir formatta getirir:

```sql
SELECT 
    tpep_pickup_datetime,
    total_amount,
    CONCAT(zpu."Borough", ' / ', zpu."Zone") AS "pickup_loc",
    CONCAT(zdo."Borough", ' / ', zdo."Zone") AS "dropoff_loc"
FROM 
    yellow_taxi_trips_2021_1 AS t,
    zones zpu,
    zones zdo
WHERE 
    t."PULocationID" = zpu."LocationID" 
    AND t."DOLocationID" = zdo."LocationID"
LIMIT 100;