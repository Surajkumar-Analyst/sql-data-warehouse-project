/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Find the date of the first and last order
-- How many years of sales avaiable
SELECT MIN(order_date) AS First_order_date,
	   MAX(order_date) AS Last_order_date,
	   DATEDIFF(YEAR,MIN(order_date),MAX(order_date)) AS order_range_years
FROM gold.fact_sales;

-- Find the youngest and oldest customer
SELECT MIN(birthdate) AS oldest_customer,
	   DATEDIFF(YEAR,MIN(birthdate),GETDATE()) AS oldest_customer_age,
	   MAX(birthdate) AS youngest_customer,
	   DATEDIFF(YEAR,MAX(birthdate),GETDATE()) AS youngest_customer_age
FROM gold.dim_customers
