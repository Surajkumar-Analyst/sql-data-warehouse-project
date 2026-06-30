/*
====================================================

Create Database and Schemas

====================================================

Script Purpose:
	This script creates a new database named 'dataWarehouse' after checking if it already exists.
	IF he databse exists, it is dropped and recreated. Additionally, the scriptsets up three schemas within the database: 'bronze','silver',and 'gold'

WARNING:
	Running this script will drop the entire 'DataWarehouse' database if it exsits.
	All data in the database will be permanently deleted. Proceed with caution
	and ensure you have proper backups before running this script.
*/

USE master;
GO 

--Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schema

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

