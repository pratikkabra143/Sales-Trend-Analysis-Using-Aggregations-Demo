-- ================================================
-- TASK: Sales Trend Analysis Using Aggregations
-- FILE: query.sql
-- Purpose: Aggregate monthly revenue and order volume
-- Dataset: cleaned_sales_data.csv from Kaggle (https://www.kaggle.com/datasets/martweber/e-commerce-sales-data-raw-cleaned)
-- Database: sales_trend
-- Table: orders
-- ================================================


-- M1: Monthly revenue & order volume aggregation using YEAR() and MONTH()
USE sales_trend;
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(Price * Quantity) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
WHERE ReturnFlag = FALSE AND MONTH(order_date) BETWEEN 4 AND 6 -- ignore returned orders and limit to Q2
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- M2: Monthly revenue & order volume aggregation using EXTRACT
USE sales_trend;
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(Price * Quantity) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
WHERE ReturnFlag = FALSE AND EXTRACT(MONTH FROM order_date) BETWEEN 4 AND 6 -- ignore returned orders and limit to Q2
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
ORDER BY year, month;
