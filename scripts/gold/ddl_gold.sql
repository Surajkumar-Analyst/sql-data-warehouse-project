/*
=====================================================================
DDL Script: Create Gold Views
=====================================================================
Script Purpose:
    This script create views for the Gold layer in the date warehouse.
    The Gold layer represents the final dimensionn and fact tables (Star Schema)

    Each view performs transformation and combine data from the Silver layer to 
    produce a clean,enriched, and business-ready dataset.

Usage:
  - These views can be queried directly for analytics and reporting
=====================================================================
*/


-- =====================================================================
-- Create Dimension View: gold.dim_customers
-- =====================================================================
IF OBJECT_ID('gold.dim_customers') IS NOT NULL 
    DROP VIEW gold.dim_customers;
GO 
  
CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
	cs.cst_id AS customer_id,
	cs.cst_key AS customer_number,
	cs.cst_firstname AS first_name,
	cs.cst_lastname AS last_name,
	lc.CNTRY AS country,
	CASE WHEN cs.cst_gender != 'NA' THEN cs.cst_gender 
		ELSE COALESCE(ca.GEN,'NA')
	END gender,  -- CRM is the Master for gender Index
	cs.cst_marital_status AS marital_status,
	ca.BDATE AS birthday,
	cs.cst_create_date AS create_date
FROM silver.crm_cust_info cs
LEFT JOIN silver.erp_cust_az12 AS ca
	ON ca.CID = cs.cst_key
LEFT JOIN silver.erp_loc_a101 AS lc
	ON lc.CID = cs.cst_key;
GO

-- =====================================================================
-- Create Dimension View: gold.dim_products
-- =====================================================================
IF OBJECT_ID('gold.dim_products') IS NOT NULL 
    DROP VIEW gold.dim_products;
GO 

CREATE VIEW gold.dim_products AS 
	SELECT
		ROW_NUMBER() OVER(ORDER BY pd.prd_start_dt,pd.prd_key) AS product_key,
		pd.prd_id AS product_id,
		pd.prd_key AS product_number,
		pd.prd_nm AS product_name,
		pd.cat_id AS category_id,
		pt.CAT AS category,
		pt.SUBCAT sub_category,
		pt.MAINTENANCE AS maintenance,
		pd.prd_cost AS cost,
		pd.prd_line AS product_line,
		pd.prd_start_dt AS start_date
	FROM silver.crm_prd_info pd
	LEFT JOIN silver.erp_px_cat_g1v2 pt
		ON pt.ID = pd.cat_id
	WHERE prd_end_dt IS NULL;  -- Filter out all historical data
GO
  
-- =====================================================================
-- Create Fact View: gold.fact_sales
-- =====================================================================
IF OBJECT_ID('gold.fact_sales') IS NOT NULL 
    DROP VIEW gold.fact_sales;
GO 

CREATE VIEW gold.fact_sales AS
	SELECT 
		sd.sls_ord_num AS order_number,
		pr.product_key,
		cr.customer_key,
		sd.sls_order_dt AS order_date,
		sd.sls_ship_dt AS ship_date,
		sd.sls_due_dt AS due_date,
		sd.sls_price AS price,
		sd.sls_quantity AS quantity,
		sd.sls_sales AS sales
	FROM silver.crm_sales_details sd
	LEFT JOIN gold.dim_products AS pr
		ON pr.product_number = sd.sls_prd_key
	LEFT JOIN gold.dim_customers AS cr
		ON cr.customer_id = sd.sls_cust_id;
