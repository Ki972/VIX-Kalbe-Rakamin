-- Membuat table dan import data

CREATE TABLE customer_2 (
    "CustomerID" INTEGER,
    "Age" INTEGER,
    "Gender" INTEGER,
    "Marital Status" TEXT,
    "Income" TEXT
);

COPY customer_2 ("CustomerID", "Age", "Gender", "Marital Status", "Income") 
FROM '/Users/kiii_rey/Documents/Kirey/Data science learning/VIX - DS Kalbe/Final Task/Case Study Dataset/Case Study - Customer.csv' 
DELIMITER ';' CSV HEADER;

CREATE TABLE product_2 (
    "ProductID" TEXT,
    "Product Name" TEXT,
    "Price" INTEGER
);

COPY product_2 ("ProductID", "Product Name", "Price") 
FROM '/Users/kiii_rey/Documents/Kirey/Data science learning/VIX - DS Kalbe/Final Task/Case Study Dataset/Case Study - Product.csv' 
DELIMITER ';' CSV HEADER;

CREATE TABLE store_2 (
    "StoreID" INTEGER,
    "StoreName" TEXT,
    "GroupStore" TEXT,
    "Type" TEXT,
    "Latitude" TEXT,
    "Longitude" TEXT
);

COPY store_2 ("StoreID", "StoreName", "GroupStore", "Type", "Latitude", "Longitude") 
FROM '/Users/kiii_rey/Documents/Kirey/Data science learning/VIX - DS Kalbe/Final Task/Case Study Dataset/Case Study - Store.csv' 
DELIMITER ';' CSV HEADER;

drop table transaction_2;

CREATE TABLE transaction_2 (
    "TransactionID" TEXT,
    "CustomerID" INTEGER,
    "Date" TEXT,
    "ProductID" TEXT,
    "Price" INTEGER,
    "Qty" INTEGER,
    "TotalAmount" INTEGER,
    "S" INTEGER
);

COPY transaction_2 ("TransactionID", "CustomerID", "Date", "ProductID", "Price", "Qty", "TotalAmount", "S") 
FROM '/Users/kiii_rey/Documents/Kirey/Data science learning/VIX - DS Kalbe/Final Task/Case Study Dataset/Case Study - Transaction.csv' 
DELIMITER ';' CSV HEADER;

-- rata-rata umur customer jika dilihat dari marital statusnya
select 
    "Marital Status" ,
    round(avg("Age"),2) as average_age
from
    customer_2 c
where "Marital Status" != ''
group by
    "Marital Status";
   
-- Rata-rata Umur Customer Jika Dilihat dari Gender nya
SELECT
    "Gender",
    ROUND(AVG(c."Age"), 2) AS average_age
FROM
    customer_2 c
GROUP BY
    "Gender";
   
-- Nama Store dengan Total Quantity Terbanyak
SELECT s."StoreName", SUM(t."Qty") AS total_qty
FROM "store_2" s
JOIN "transaction_2" t ON s."StoreID" = t."S"
GROUP BY s."StoreName"
ORDER BY total_qty DESC
LIMIT 1;

-- Nama Produk Terlaris dengan Total Amount Terbanyak
SELECT 
	p."Product Name",
	SUM(t."TotalAmount") AS total_sales_amount
from "product_2" p
join "transaction_2" t ON p."ProductID" = t."ProductID"
GROUP by p."Product Name"
ORDER by total_sales_amount DESC
LIMIT 1;
