/*
=====================================================================================
Product Report
=====================================================================================
Purpose:
	- This report consolidates	key product metrics and behaviors

Highlights:
	1. Gathers essential fields such as product_name,category,sub category,and cost.
	2. Segments product by revenue to identity High-performers,Mid-Range,or Low-Range.
	3. Aggregates customer-level metrics:
		- total orders
		- total sales 
		- total quantity sold 
		- total customer(unique)
		- lifespan(in months)
	4. Calculates valuable KPIs:
		- recency (month since last sales)
		- average order revenue
		- average monthly revenue
=====================================================================================
*/

/*
---------------------------------------------------------------------------------
1) Base Query: Retrives core columns from fact_Sales and dim_products
---------------------------------------------------------------------------------
*/
CREATE VIEW gold.products_report AS
WITH base_query AS (
	SELECT 
		f.order_number,
		f.order_date,
		f.customer_key,
		f.sales_amount,
		f.quantity,
		p.product_key,
		p.product_name,
		p.category,
		p.subcategory,
		p.cost
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
		ON p.product_key = f.product_key
	WHERE f.order_date IS NOT NULL
),
product_aggegration AS (
/*
---------------------------------------------------------------------------------
2)Product aggregrations : Summarizes key metrics at the product level
---------------------------------------------------------------------------------
*/
	SELECT 
		product_key,
		product_name,
		category,
		subcategory,
		cost,
		DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS life_span,
		MAX(order_date) AS last_sale_date,
		COUNT(DISTINCT order_number) AS total_orders,
		COUNT(DISTINCT customer_key) AS total_customers,
		SUM(sales_amount) AS total_sales,
		SUM(quantity) AS total_quantiy,
		ROUND(AVG(CAST(sales_amount AS FLOAT)/ NULLIF(quantity,0)),1) AS avg_selling_price
	FROM base_query
	GROUP BY 
		product_key,
		product_name,
		category,
		subcategory,
		cost
)
/*
---------------------------------------------------------------------------------
3)Final Query: Combine all product results into one output
---------------------------------------------------------------------------------
*/
SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
	DATEDIFF(MONTH,last_sale_date,GETDATE()) AS recency_in_months,
	CASE
		WHEN total_sales >= 50000 THEN 'High-Performer'
		WHEN total_sales > = 10000 THEN 'Mid-Performer'
		ELSE 'Low-Performer'
	END AS product_segment,
	life_span,
	total_orders,
	total_sales,
	total_quantiy,
	total_customers,
	avg_selling_price,
	CASE 
		WHEN total_sales = 0 THEN 0 
		ELSE total_sales/total_orders 
	END AS avg_order_value,
	CASE 
		WHEN life_span = 0 THEN total_sales
		ELSE total_sales/life_span
	END AS avg_monthly_revenue
FROM product_aggegration
