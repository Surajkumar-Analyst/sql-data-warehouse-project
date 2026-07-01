/*
=====================================================================================
Customer Report
=====================================================================================
Purpose:
	- This report consolidates	key customers metrics and behaviors

Highlights:
	1. Gathers essential fields such as name,age,and transaction details.
	2. Segments customers into categories(VIP,Regular,NEW) and age groups.
	3. Aggregates customer-level metrics:
		- total orders
		- total sales 
		- total quantity purchased 
		- total products
		- lifespan(in months)
	4. Calculates valuable KPIs:
		- recency (month since last order)
		- average order value
		- average monthly spend
=====================================================================================
*/
/*
---------------------------------------------------------------------------------
1) Base Query: Retrives core columns from tables
---------------------------------------------------------------------------------
*/
CREATE VIEW gold.customers_report AS 
WITH base_query AS (
	SELECT
		f.order_number,
		f.product_key,
		f.order_date,
		f.sales_amount,
		f.quantity,
		c.customer_key,
		c.customer_number,
		CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
		DATEDIFF(YEAR,c.birthdate,GETDATE()) AS age
	FROM gold.dim_customers c
	LEFT JOIN gold.fact_sales f
		ON f.customer_key = c.customer_key
),
customer_aggregations AS (
/*
---------------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------------
*/
	SELECT 
		customer_key,
		customer_number,
		customer_name,
		age,
		COUNT(order_number) AS total_orders,
		SUM(sales_amount) AS total_sales,
		COUNT(DISTINCT product_key) AS total_products,
		MAX(order_date) AS last_order_date,
		DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS life_span
	FROM base_query
	GROUP BY customer_key,
			 customer_number,
			 customer_name,
			 age
)

SELECT
	customer_key,
	customer_number,
	customer_name,
	age,
	CASE
		WHEN age <20 THEN 'Under 20'
		WHEN age BETWEEN 20 AND 29 THEN '20-29'
		WHEN age BETWEEN 30 AND 39 THEN '30-39'
		WHEN age BETWEEN 40 AND 49 THEN '40-49'
		ELSE '50 OR ABOVE'
	END AS age_group,
	CASE
		WHEN life_span >= 12 AND total_sales >= 5000 THEN 'VIP'
		WHEN life_span >= 12 AND total_sales <= 5000 THEN 'Regular'
		ELSE 'NEW'
	END 'customer_segment',
	DATEDIFF(month,last_order_date,GETDATE()) AS recency,
	total_orders,
	total_sales,
	total_products,
	last_order_date,
	life_span,
	-- Compuate average order value (AVO)
	CASE 
		WHEN total_sales = 0 THEN 0 
		ELSE total_sales/total_orders 
	END AS avg_order_value,

	-- Compuate average monthly spend
	CASE WHEN life_span = 0 THEN total_sales
		ElSE total_sales/life_span
	END AS avg_monthly_spend
FROM customer_aggregations
