-----------
Select * from public.yellow_taxi_trips_2021_1
limit 10
--Ana verimiz. İçinde "nereden" ve "nereye" gidildiği sadece sayılarla (ID) yazıyor.

Select * from zones
limit 10

---------
SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    CONCAT(zpu."Borough", ' | ', zpu."Zone") AS "pickup_loc",
    CONCAT(zdo."Borough", ' | ', zdo."Zone") AS "dropoff_loc"
FROM
    yellow_taxi_trips_2021_1 t
JOIN
    zones zpu ON t."PULocationID" = zpu."LocationID"
JOIN
    zones zdo ON t."DOLocationID" = zdo."LocationID"
LIMIT 100;

--t (yellow_taxi_trips_2021_1): Ana verimiz. İçinde "nereden" ve "nereye" gidildiği sadece sayılarla (ID) yazıyor.
--zpu (zones): Bu "Pickup" (Biniş) bölgesi için kullandığımız adres defteri.
--zdo (zones): Bu da "Dropoff" (İniş) bölgesi için kullandığımız adres defteri.


-----------
SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    CONCAT(zpu."Borough", ' | ', zpu."Zone") AS "pickup_loc",
    CONCAT(zdo."Borough", ' | ', zdo."Zone") AS "dropoff_loc"
FROM
    yellow_taxi_trips_2021_1 t
OUTER JOIN
    zones zpu ON t."PULocationID" = zpu."LocationID"
JOIN
    zones zdo ON t."DOLocationID" = zdo."LocationID"
LIMIT 100;

--konumu olupolmayan kayıtlar var mıdır



------
--yoldculuk veritabanında bulunmayan herhanginikimşik olup olamadıgı

SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    "PULocationID",
    "DOLocationID"
FROM
    yellow_taxi_trips_2021_1
WHERE
    "DOLocationID" NOT IN (SELECT "LocationID" from zones)
    OR "PULocationID" NOT IN (SELECT "LocationID" from zones)
LIMIT 100;
--bos kalıt gelmediiğine gore alma bıırakma noktaları full



---------------
DELETE FROM zones WHERE "LocationID" = 142;

SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    CONCAT(zpu."Borough", ' | ', zpu."Zone") AS "pickup_loc",
    CONCAT(zdo."Borough", ' | ', zdo."Zone") AS "dropoff_loc"
FROM
    yellow_taxi_trips_2021_1 t
LEFT JOIN
    zones zpu ON t."PULocationID" = zpu."LocationID"
JOIN
    zones zdo ON t."DOLocationID" = zdo."LocationID"
LIMIT 100;

--normal sartlarda bolgeler de bu kayıt mevcut edğil 142 idli
--yinede gostermek istersek bilinmediği halde left join
--solda bulunan ama sağda bulunmayan kayıt var sa yine de goster


SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    CONCAT(zpu."Borough", ' | ', zpu."Zone") AS "pickup_loc",
    CONCAT(zdo."Borough", ' | ', zdo."Zone") AS "dropoff_loc"
FROM
    yellow_taxi_trips_2021_1 t
RIGHT JOIN
    zones zpu ON t."PULocationID" = zpu."LocationID"
JOIN
    zones zdo ON t."DOLocationID" = zdo."LocationID"
LIMIT 100;




SELECT
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    total_amount,
    CONCAT(zpu."Borough", ' | ', zpu."Zone") AS "pickup_loc",
    CONCAT(zdo."Borough", ' | ', zdo."Zone") AS "dropoff_loc"
FROM
    yellow_taxi_trips_2021_1 t
OUTER JOIN
    zones zpu ON t."PULocationID" = zpu."LocationID"
JOIN
    zones zdo ON t."DOLocationID" = zdo."LocationID"
LIMIT 100;



----------------
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1)
FROM
    yellow_taxi_trips_2021_1
GROUP BY
    CAST(tpep_dropoff_datetime AS DATE)
order by "day" ASC ;

--Her gün icin seyahat sayisi





--en fazla kayıt sayısını nbulamk
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1) as "count"
FROM
    yellow_taxi_trips_2021_1
GROUP BY
    CAST(tpep_dropoff_datetime AS DATE)
order by "count" DESC ;




--surucunun kaszandıgı max toplam para
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    COUNT(1) AS "count",
    MAX(total_amount) AS "total_amount",
    MAX(passenger_count) AS "passenger_count"
FROM
    yellow_taxi_trips_2021_1
GROUP BY
    CAST(tpep_dropoff_datetime AS DATE)
ORDER BY
    "count" DESC
LIMIT 100;




--coklu gruplama
--her bolhge icin her boırakma yeri icin kac yolcu, ve surunucun tpoplams kaandıgı para vb.
SELECT
    CAST(tpep_dropoff_datetime AS DATE) AS "day",
    "DOLocationID",
    COUNT(1) AS "count",
    MAX(total_amount) AS "total_amount",
    MAX(passenger_count) AS "passenger_count"
FROM
    yellow_taxi_trips_2021_1
GROUP BY
    1, 2
ORDER BY
    "day" ASC,
    "DOLocationID" ASC
LIMIT 100;




