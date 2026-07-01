/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

/* Analyse the yearly performance of products by comparing their sales
   to both average sales performance of the product and the previous year's sales
*/
WITH yearly_product_sales AS (
	SELECT 
		YEAR(f.order_date) AS order_year,
		p.product_name,
		SUM(f.sales_amount) AS current_sales
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
		ON p.product_key = f.product_key
	WHERE f.order_date IS NOT NULL
	GROUP BY YEAR(f.order_date),p.product_name
),

year_to_year_analysis AS (
	SELECT 
		order_year,
		product_name,
		current_sales,
		AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
		current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
		CASE WHEN 
				current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'above avg'
			 WHEN 
				current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'below avg'
			 ELSE 'avg'
		END avg_change,
		LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS py_sales,
		CASE WHEN 
				current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'increase'
			 WHEN 
				current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'decrease'
			 ELSE 'no_change'
		END py_change
	FROM yearly_product_sales
)
SELECT 
	order_year,
	product_name,
	current_sales,
	avg_change,
	py_change
FROM year_to_year_analysis;
