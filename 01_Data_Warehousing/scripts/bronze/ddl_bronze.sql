/*
=====================================================
DDL Script: Create Bronze Tables
=====================================================

Script Purpose:
	This script creating tables in the 'bronze' Schema, dropping existing Tables
	if they already exist.
	Run this script to re-define the DDl structure of 'bronze' Schema.
*/

-- use the 'DataWarehouse' database
USE DataWarehouse;

-- create tables of crm source
IF OBJECT_ID('bronze.crm_cust_info','U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(
	cst_id               INT,
	cst_key              NVARCHAR(50),
	cst_firstname        NVARCHAR(50),
	cst_lastname         NVARCHAR(50),
	cst_marital_status   NVARCHAR(20),
	cst_gndr             NVARCHAR(20),
	cst_create_date      DATE
);

IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
	prd_id         INT,
	prd_key        NVARCHAR(50),
	prd_nm         NVARCHAR(50),
	prd_cost       DECIMAL,
	prd_line       NVARCHAR(20),
	prd_start_dt   DATE,
	prd_end_dt     DATE
);

IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num		NVARCHAR(50),
	sls_prd_key		NVARCHAR(50),
	sls_cust_id     INT,
	sls_order_dt    INT,
	sls_ship_dt     INT,
	sls_due_dt      INT,
	sls_sales       INT,
	sls_quantity    INT,
	sls_price       INT

);


-- create tables of erp source
IF OBJECT_ID('bronze.erp_cust_az12','U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12(
	CID		NVARCHAR(50),
	BDATE	DATE,
	GEN		VARCHAR(50)
);

IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
	CID		NVARCHAR(50),
	CNTRY	VARCHAR(50)
);

IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2(
	ID				NVARCHAR(50),
	CAT				VARCHAR(50),
	SUBCAT			VARCHAR(50),
	MAINTENANCE		VARCHAR(30)
);
