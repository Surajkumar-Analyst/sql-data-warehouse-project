/*
=====================================================
DDL Script: Create Bronze Tables
=====================================================

Script Purpose:
	This script creating tables in the 'bronze' Schema, dropping existing Tables
	if they already exist.
	Run this script to re-define the DDl structure of 'bronze' Schema.
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
		DECLARE @st_time DATETIME,@batch_st_time DATETIME,@et_time DATETIME,@batch_et_time DATETIME;

		SET @batch_st_time = GETDATE();
		PRINT'==============================================';
		PRINT'Loading bronze layer';
		PRINT'==============================================';

		PRINT'----------------------------------------------';
		PRINT'Loading CRM Tables';
		PRINT'----------------------------------------------';

		SET @st_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_cust_info ';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT'Inserting Data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Suraj\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @et_time = GETDATE();
		PRINT'Load Duration: ' + CAST(DATEDIFF(second,@et_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT'>>--------------------'

		SET @st_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_prd_info ';

		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT'Inserting Data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Suraj\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @et_time = GETDATE();
		PRINT'Load Duration: ' + CAST(DATEDIFF(second,@et_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT'>>--------------------'

		SET @st_time = GETDATE();
		PRINT'>> Truncating Table: crm_sales_details ';

		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT'Inserting Data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Suraj\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @et_time = GETDATE();
		PRINT'Load Duration: ' + CAST(DATEDIFF(second,@et_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT'>>--------------------'

		PRINT'----------------------------------------------';
		PRINT'Loading ERP Tables';
		PRINT'----------------------------------------------';

		SET @st_time = GETDATE();
		PRINT'>> Truncating Table: erp_cust_az12 ';

		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT'Inserting Data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Suraj\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @et_time = GETDATE();
		PRINT'Load Duration: ' + CAST(DATEDIFF(second,@et_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT'>>--------------------'

		SET @st_time = GETDATE();
		PRINT'>> Truncating Table:bronze.erp_loc_a101 ';

		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT'Inserting Data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Suraj\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @et_time = GETDATE();
		PRINT'Load Duration: ' + CAST(DATEDIFF(second,@et_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT'>>--------------------'

		SET @st_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_px_cat_g1v2 ';

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT'Inserting Data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Suraj\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @et_time = GETDATE();
		PRINT'Load Duration: ' + CAST(DATEDIFF(second,@et_time,@st_time) AS NVARCHAR) + 'Seconds';
		PRINT'>>--------------------'

		SET @batch_et_time = GETDATE();
		PRINT'==============================================';
		PRINT 'bronze layer loading complete!';
		PRINT'  - Total Load Duration: ' + CAST(DATEDIFF(second,@batch_et_time,@batch_st_time) AS NVARCHAR) + 'Seconds';
		PRINT'==============================================';

	END TRY
	BEGIN CATCH
	PRINT'==============================================';
	PRINT'ERROR MESSAGE' + ERROR_MESSAGE();
	PRINT'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT'ERROR STATE ' + CAST(ERROR_STATE() AS NVARCHAR);
	PRINT'==============================================';
	END CATCH
END
GO 

exec bronze.load_bronze;
