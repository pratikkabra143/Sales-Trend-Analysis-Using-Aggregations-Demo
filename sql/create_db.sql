-- ================================================
-- TASK: Sales Trend Analysis Using Aggregations
-- FILE: create_db.sql
-- Purpose: Create database, tables, importing CSV, and clean data
-- Dataset: cleaned_sales_data.csv from Kaggle (https://www.kaggle.com/datasets/martweber/e-commerce-sales-data-raw-cleaned)
-- Database: sales_trend
-- Table: orders
-- ================================================

-- Step 1: Use the database
CREATE DATABASE IF NOT EXISTS sales_trend;
USE sales_trend;

-- Step 2: Create raw staging table
CREATE TABLE IF NOT EXISTS orders_raw (
  TransactionNo VARCHAR(50),
  Date VARCHAR(20),
  ProductNo VARCHAR(50),
  ProductName TEXT,
  Price DECIMAL(10,2),
  Quantity INT,
  CustomerNo VARCHAR(50),
  Country VARCHAR(100),
  ReturnFlag VARCHAR(10)
);

-- Step 3: Load CSV into orders_raw table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_sales_data.csv'
INTO TABLE orders_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(TransactionNo, Date, ProductNo, ProductName, Price, Quantity, CustomerNo, Country, ReturnFlag);

-- Step 4: Create cleaned orders table
CREATE TABLE IF NOT EXISTS orders (
  order_id BIGINT,
  order_date DATE,
  ProductNo VARCHAR(50),
  ProductName TEXT,
  Price DECIMAL(10,2),
  Quantity INT,
  CustomerNo VARCHAR(50),
  Country VARCHAR(100),
  ReturnFlag BOOLEAN
);

-- Step 5: Populate cleaned orders table (exclude invalid TransactionNo or invalid Date)
INSERT INTO orders (order_id, order_date, ProductNo, ProductName, Price, Quantity, CustomerNo, Country, ReturnFlag)
SELECT
  CAST(TransactionNo AS UNSIGNED),
  STR_TO_DATE(Date, '%d/%m/%Y'),
  ProductNo,
  ProductName,
  Price,
  Quantity,
  CustomerNo,
  Country,
  CASE WHEN LOWER(ReturnFlag) IN ('true','1','t','yes') THEN 1 ELSE 0 END
FROM orders_raw
WHERE TransactionNo REGEXP '^[0-9]+$'
  AND STR_TO_DATE(Date, '%d/%m/%Y') IS NOT NULL;

-- Step 6: Verify clean data
SELECT COUNT(*) AS total_orders_cleaned FROM orders;
SELECT * FROM orders LIMIT 10;
