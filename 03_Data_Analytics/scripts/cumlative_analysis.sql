/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month
-- and the running total for the sales over time 
WITH sales_report AS 
(
	SELECT 
		DATETRUNC(MONTH,order_date) AS order_date,
		SUM(sales_amount) AS total_sales,
		AVG(sales_amount) AS avg_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH,order_date)
)
SELECT 
	order_date,
	total_sales,
	SUM(total_sales) OVER(PARTITION BY order_date ORDER BY order_date) AS running_total_sales,
	AVG(avg_sales) OVER(PARTITION BY order_date ORDER BY order_date) AS  moving_average_price
FROM sales_report;
