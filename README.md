# Sales Trend Analysis Using Aggregations Demonstration

---

## Objective: Use SQL queries to analyze monthly revenue and order volume from the e-commerce sales dataset.

### Tools Used: MySQL

## Dataset: [E-Commerce Sales Data Raw & Cleaned - Kaggle](https://www.kaggle.com/datasets/martweber/e-commerce-sales-data-raw-cleaned)  
- File Name: `cleaned_sales_data.csv`  
- Relevant Columns Used:
  - `TransactionNo` → order ID
  - `Date` → order date
  - `Price` → product price
  - `Quantity` → quantity sold
  - `ReturnFlag` → whether the order was returned

---

## 🛠 Deliverables
The following steps were performed for demonstration purposes on the database:

1. **Database & Table Setup**
   - Created database `sales_trend`.
   - Created staging table `orders_raw` to load CSV data.
   - Loaded CSV into `orders_raw`.

2. **Data Cleaning**
   - Created cleaned table `orders` with proper data types:
     - `order_id` → BIGINT
     - `order_date` → DATE
     - `Price` → DECIMAL
     - `Quantity` → INT
     - `ReturnFlag` → BOOLEAN
   - Inserted only valid rows from `orders_raw`:
     - Valid numeric `TransactionNo`
     - Valid `Date`
   - Converted `ReturnFlag` to boolean (`TRUE/FALSE`).

3. **Monthly Aggregation**
   - Aggregated revenue and order volume per month using:
     - `EXTRACT(YEAR FROM order_date)` and `EXTRACT(MONTH FROM order_date)`  
     - `SUM(Price * Quantity)` → monthly revenue  
     - `COUNT(DISTINCT order_id)` → number of orders  
   - Filtered out returned orders (`ReturnFlag = FALSE`) and limited results to specific time periods using:

     **Option M1**
     ```sql
     EXTRACT(MONTH FROM order_date) BETWEEN X AND Y
     OR EXTRACT(YEAR FROM order_date) BETWEEN X AND Y
     -- or
     YEAR(order_date) BETWEEN 2020 AND 2021
     ```
     
     **Option M2**
     ```sql
     MONTH(order_date) BETWEEN X AND Y
     OR YEAR(order_date) BETWEEN X AND Y
     ```
   - Sorted results by year and month.

---

## 📂 Project Structure

```
Sales-Trend-Analysis-Using-Aggregations-Demo/
├── data/
│   └── cleaned_sales_data.csv     # Dataset used
├── results/
│   ├── monthly_sales_results.csv  # Exported CSV results
│   └── results_screenshot.png     # Output screenshot
├── sql/
│   ├── combined.sql               # Single SQL script for creating database, tables, importing CSV, cleaning data and performing sales trend analysis using aggregations
│   ├── create_db.sql              # Alternate SQL script for creating database, tables, importing CSV, cleaning data
│   └── query.sql                  # Alternate SQL script with queries for performing sales trend analysis using aggregations
└── README.md                      # Project explanation
```

---

## 🚀 How to Reproduce
1. Copy `cleaned_sales_data.csv` from `data/` to `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/` (ensure it’s in MySQL’s secure folder on Windows).
1. Import `combined.sql` or both `create_db.sql` and `query.sql` into MySQL. 
2. Run queries from the respective SQL files in order.  
3. Check results and compare them with the provided screenshots and CSV file.

---
