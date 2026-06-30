/*
==================================================================================
Stored Procedure: Load Silver Layer(Bronze -> Silver)
==================================================================================
Script Purpose:
    This stored procedure performs the ETL (Extracts, Transform, Load) [process to
    populate the 'silver' schema tables from the 'bronze' schema.
Actions Performed:
    - Truncates Silver tables.
    - Inserts transformed and cleaned data from Bronze into Silver tables.

Parameters:
    None.
    This stored procedure does not accepts or return any values

Usage Example:
    EXEC silver.load_silver
==================================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	BEGIN TRY
		DECLARE @st_time DATETIME, @batch_st_time DATETIME, @ed_time DATETIME, @batch_ed_time DATETIME;

		SET @batch_st_time = GETDATE();
		PRINT '===========================================';
		PRINT 'Loading Silver Layer...'
		PRINT '===========================================';

		PRINT '-------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------------';

		-- Loading silver.crm_cust_info
		SET @st_time = GETDATE(); 
		PRINT '>> Truncating Table: silver.crm_cust_info ';
		TRUNCATE TABLE silver.crm_cust_info;
		PRINT '>> Inserting Data Into: silver.crm_cust_info';
		INSERT INTO silver.crm_cust_info(
			cst_id,
			cst_key,
			cst_firstname,
			cst_lastname,
			cst_gndr,
			cst_marital_status,
			cst_create_date
		  )

		SELECT cst_id
			  ,cst_key
			  ,TRIM(cst_firstname) AS cst_firstname
			  ,TRIM(cst_lastname) AS cst_lastname
			  ,CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
					WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
					ELSE 'NA'
			   END cst_marital_status -- Normalize martial status values  to readable format
			  ,CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
					WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
					ELSE 'NA'
			   END cst_gndr -- Normalize gndr values  to readable format
			  ,cst_create_date
		FROM (
			Select *,
				ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as Flag_rank
			FROM bronze.crm_cust_info
			WHERE cst_id IS NOT NULL
		)t 
		WHERE Flag_rank = 1; -- Select the most recent records per customer
		SET @ed_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@ed_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT '>>---------------------';

		-- Loading silver.crm_prd_info
		SET @st_time = GETDATE();
		PRINT '>> Truncating Table: silver.crm_prd_info ';
		TRUNCATE TABLE silver.crm_prd_info;
		PRINT '>> Inserting Data Into: silver.crm_prd_info';
		INSERT INTO silver.crm_prd_info(
			prd_id,
			cat_id,
			prd_key,
			prd_nm,
			prd_cost,
			prd_line,
			prd_start_dt,
			prd_end_dt
			)
		SELECT 
			prd_id,
			REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id, -- Extract category ID 
			SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,	   -- Extract Product Key
			prd_nm,
			ISNULL(prd_cost,0) AS prd_cost,
			CASE UPPER(TRIM(prd_line)) 
				 WHEN 'M' THEN 'Mountain'
				 WHEN 'R' THEN 'Road'
				 WHEN 'S' THEN 'Other Sales'
				 WHEN 'T' THEN 'Touring'
				 ELSE 'NA'
			END prd_line, -- Map product line code to descriptive values
			CAST(prd_start_dt AS DATE) AS prd_start_dt,
			DATEADD(
				DAY,
				-1,
				LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)
				) AS prd_end_dt -- Calculate end date as one day before the next start date
		FROM bronze.crm_prd_info;
		SET @ed_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@ed_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT '>>---------------------';

		-- Loading silver.crm_sales_details
		SET @st_time = GETDATE();
		PRINT '>> Truncating Table: silver.crm_sales_details ';
		TRUNCATE TABLE silver.crm_sales_details;
		PRINT '>> Inserting Data Into: silver.crm_sales_details';
		INSERT INTO silver.crm_sales_details(
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			sls_order_dt,
			sls_ship_dt,
			sls_due_dt,
			sls_sales,
			sls_quantity,
			sls_price
		)
		SELECT 
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			CASE 
				WHEN sls_order_dt <=0 OR LEN(sls_order_dt) != 8 THEN NULL
				ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
			END sls_order_dt,
			CASE 
				WHEN sls_ship_dt <=0 OR LEN(sls_ship_dt) != 8 THEN NULL
				ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
			END sls_ship_dt,
			CASE 
				WHEN sls_ship_dt <=0 OR LEN(sls_due_dt) != 8 THEN NULL
				ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
			END sls_due_dt,
			CASE 
				WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
					THEN sls_quantity * ABS(sls_price)
				ELSE sls_sales 
			END sls_sales, -- Recalculate sales if original value is missing or incorrect
			sls_quantity,
			CASE 
				WHEN sls_price IS NULL OR sls_sales <= 0
					THEN sls_sales/NULLIF(sls_quantity,0)
				ELSE sls_price
			END sls_price -- Derive price if original value is invalid
		FROM bronze.crm_sales_details;
		SET @ed_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@ed_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT '>>---------------------';

		PRINT '-------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------------------';

		-- Loading silver.erp_cust_az12
		SET @st_time = GETDATE();
		PRINT '>> Truncating Table: silver.erp_cust_az12 ';
		TRUNCATE TABLE silver.erp_cust_az12;
		PRINT '>> Inserting Data Into: silver.erp_cust_az12';
		INSERT INTO silver.erp_cust_az12(
			CID,
			BDATE,
			GEN
		)
		SELECT
			CASE 
				WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID,4,LEN(CID)) 
				ELSE CID -- Remove 'NAS' prefix if present 
			END CID,
			CASE 
				WHEN BDATE > GETDATE() OR BDATE < '1925-01-01' THEN NULL
				ELSE BDATE -- Set the outlier with NULL
			END BDATE,
			CASE 
				WHEN UPPER(TRIM(GEN)) IN ('F','Female') THEN 'Female'
				WHEN UPPER(TRIM(GEN)) IN ('M','Male') THEN 'Male'
				ELSE 'NA' -- Normalize gender values and handle unknown cases
			END GEN
		FROM bronze.erp_cust_az12;
		SET @ed_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@ed_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT '>>---------------------';

		-- Loading silver.erp_loc_a101
		SET @st_time = GETDATE();
		PRINT '>> Truncating Table: silver.erp_loc_a101 ';
		TRUNCATE TABLE silver.erp_loc_a101;
		PRINT '>> Inserting Data Into: silver.erp_loc_a101';
		INSERT INTO silver.erp_loc_a101(
			CID,
			CNTRY
		)
		SELECT
			REPLACE(CID,'-','') AS CID,
			CASE 
				WHEN TRIM(CNTRY) IN ('US','USA') THEN 'United States'
				WHEN TRIM(CNTRY) = 'DE' THEN 'Germany'
				WHEN TRIM(CNTRY) = '' OR CNTRY IS NULL THEN 'NA'
				ELSE TRIM(CNTRY)
			END CNTRY -- Normalize and Handle missing or blank country codes
		FROM bronze.erp_loc_a101;
		SET @ed_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@ed_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT '>>---------------------';

		-- Loading silver.erp_px_cat_g1v2
		SET @st_time = GETDATE();
		PRINT '>> Truncating Table: silver.erp_px_cat_g1v2 ';
		TRUNCATE TABLE silver.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: silver.erp_px_cat_g1v2';
		INSERT INTO silver.erp_px_cat_g1v2(
			ID,
			CAT,
			SUBCAT,
			MAINTENANCE
		)
		SELECT 
			ID,
			TRIM(CAT),
			TRIM(SUBCAT),
			TRIM(MAINTENANCE)
		FROM bronze.erp_px_cat_g1v2;
		SET @ed_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second,@ed_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT '>>---------------------';

		SET @batch_ed_time = GETDATE();
		PRINT '===========================================';
		PRINT 'Silver Layer Loading Complete';
		PRINT ' - Total Load Duration ' + CAST(DATEDIFF(second,@batch_st_time,@batch_ed_time) AS NVARCHAR) + 'seconds'; 
		PRINT '===========================================';

	END TRY
	BEGIN CATCH
	PRINT '===========================================';
	PRINT 'ERROR MESSAGE' + CAST(ERROR_MESSAGE() AS NVARCHAR);
	PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'ERROR STATE' + CAST(ERROR_STATE() AS NVARCHAR)
	PRINT '===========================================';
	END CATCH
END
