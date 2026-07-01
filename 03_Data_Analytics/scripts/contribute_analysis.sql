/*
===============================================================================
Category Sales Contribution Analysis
===============================================================================
Purpose:
    - To analyze how much each product category contributes to overall sales.
    - To identify the highest revenue-generating categories.
    - To calculate each category's percentage contribution to total sales.

SQL Functions Used:
    - CTE (WITH): Calculates total sales for each product category.
    - SUM(): Aggregates sales amount by category.
    - OVER(): Computes the overall sales across all categories.
    - CAST(): Converts sales values to FLOAT for accurate percentage calculation.
    - ROUND(): Rounds percentage values to two decimal places.
    - CONCAT(): Formats the percentage value with the '%' symbol.
    - ORDER BY: Sorts categories from highest to lowest sales.
===============================================================================
*/

-- Which categories contributes the most to overall sales?
WITH category_sales AS (
SELECT
	p.category,
	SUM(f.sales_amount) total_sales
FROM gold.dim_products p 
LEFT JOIN gold.fact_sales f
	ON f.product_key = p.product_key
GROUP BY p.category
)
SELECT 
	category,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	CONCAT(ROUND((CAST(total_sales AS FLOAT)/SUM(total_sales) OVER()) * 100,2),'%') AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC
