/*
==============================================================================
DDL Script: Create silver Tables
==============================================================================

Script Purpose:
	This script creating tables in the 'silver' Schema, dropping existing Tables
	if they already exist.
	Run this script to re-define the DDl structure of 'silver' Schema.
==============================================================================
*/

-- use the 'DataWarehouse' database
USE DataWarehouse;

-- create tables of crm source
IF OBJECT_ID('silver.crm_cust_info','U') IS NOT NULL
	DROP TABLE silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info(
	cst_id               INT,
	cst_key              NVARCHAR(50),
	cst_firstname        NVARCHAR(50),
	cst_lastname         NVARCHAR(50),
	cst_marital_status   NVARCHAR(20),
	cst_gndr             NVARCHAR(20),
	cst_create_date      DATE,
	dwh_create_date		   DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.crm_prd_info','U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info(
	prd_id			       INT,
	cat_id			       NVARCHAR(50),
	prd_key		      	 NVARCHAR(50),
	prd_nm		         NVARCHAR(50),
	prd_cost	         DECIMAL,
	prd_line		       NVARCHAR(20),
	prd_start_dt	  	 DATE,
	prd_end_dt		     DATE,
	dwh_create_date 	 DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.crm_sales_details','U') IS NOT NULL
	DROP TABLE silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details(
	sls_ord_num			    	NVARCHAR(50),
	sls_prd_key			    	NVARCHAR(50),
	sls_cust_id			      INT,
	sls_order_dt		    	DATE,
	sls_ship_dt			    	DATE,
	sls_due_dt			    	DATE,
	sls_sales				      INT,
	sls_quantity		    	INT,
	sls_price				      INT,
	dwh_create_date		    DATETIME2 DEFAULT GETDATE()

);


-- create tables of erp source
IF OBJECT_ID('silver.erp_cust_az12','U') IS NOT NULL
	DROP TABLE silver.erp_cust_az12;
CREATE TABLE silver.erp_cust_az12(
	CID				       	 NVARCHAR(50),
	BDATE				       DATE,
	GEN				      	 VARCHAR(50),
	dwh_create_date		 DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.erp_loc_a101','U') IS NOT NULL
	DROP TABLE silver.erp_loc_a101;
CREATE TABLE silver.erp_loc_a101(
	CID				         NVARCHAR(50),
	CNTRY			      	 VARCHAR(50),
	dwh_create_date		 DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.erp_px_cat_g1v2','U') IS NOT NULL
	DROP TABLE silver.erp_px_cat_g1v2;
CREATE TABLE silver.erp_px_cat_g1v2(
	ID					       NVARCHAR(50),
	CAT					       VARCHAR(50),
	SUBCAT				     VARCHAR(50),
	MAINTENANCE			   VARCHAR(30),
	dwh_create_date		 DATETIME2 DEFAULT GETDATE()
);
