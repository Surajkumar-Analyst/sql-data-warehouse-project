/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/* Segment products into cost ranges and count how 
   many products fall into each segment.
*/

WITH product_segment AS (
SELECT
	product_key,
	product_name,
	cost,
	CASE
		WHEN cost <100 THEN 'below 100'
		WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
		ELSE 'abpve 1000'
	END cost_range	 
FROM gold.dim_products
)
SELECT 
	cost_range,
	count(product_key) as total_product
FROM product_segment
GROUP BY cost_range
ORDER BY total_product DESC


/*
	Group customer into three segments based on thier spending behavior:
		- VIP : Customers with at least 12 month of history and spending more than $ 5000 
		- Regular : Customer with at least 12 month of history but spending $5000 or less
		- New : Customers with a lifespan less than 12 months.
	And find the total number of customers by each group
*/

WITH life_span AS (
	SELECT 
		c.customer_key,
		SUM(f.sales_amount) AS total_spending,
		MIN(f.order_date) AS first_order,
		MAX(f.order_date) AS last_order,
		DATEDIFF(MONTH,MIN(f.order_date),MAX(f.order_date)) AS life_span
	FROM gold.dim_customers c
	LEFT JOIN gold.fact_sales f
		ON f.customer_key = c.customer_key
	GROUP BY c.customer_key
),
customer_segment AS(
SELECT 
	customer_key,
	CASE
		WHEN life_span >= 12 AND total_spending >= 5000 THEN 'VIP'
		WHEN life_span >= 12 AND total_spending <= 5000 THEN 'Regular'
		ELSE 'NEW'
	END 'customer_segment'
FROM life_span
)
SELECT 
	customer_segment,
	COUNT(customer_segment) AS total_segment_customer,
	CONCAT(ROUND(CAST(COUNT(customer_segment) AS FLOAT)/(SUM(COUNT(customer_segment)) OVER()) *100,2),'%') AS percentage_of_segment_contribution
FROM customer_segment
GROUP BY customer_segment
