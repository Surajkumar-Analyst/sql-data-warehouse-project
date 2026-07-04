# 🔍 Exploratory Data Analysis (EDA)

This module contains a complete Exploratory Data Analysis (EDA) performed using SQL Server. The objective is to understand the structure, quality, and characteristics of the data before performing business analytics.

The analysis focuses on exploring tables, validating data quality, examining distributions, and identifying patterns that support downstream reporting and decision-making.

---

# 📖 Overview

Exploratory Data Analysis (EDA) is the first analytical step after building the data warehouse. It helps answer questions such as:

- What data is available?
- What does each table contain?
- Are there missing values?
- What is the date range of the dataset?
- How many customers and products exist?
- Which dimensions can be used for analysis?
- What measures are available?
- What are the top and bottom performing entities?

The findings from this analysis provide a deeper understanding of the dataset and serve as the foundation for business analytics.

---

# 🎯 Objectives

The primary objectives of this analysis are:

- Explore the warehouse structure
- Understand available tables and columns
- Validate data completeness
- Analyze date coverage
- Explore dimensions and measures
- Identify trends and rankings
- Prepare the dataset for business analysis

---

# 📂 Project Structure

```
02_Exploratory_Data_Analysis
│
├── database_exploration.sql
├── date_range_exploration.sql
├── dimensions_exploration.sql
├── magnitude_analysis.sql
├── measures_exploration.sql
├── ranking_analysis.sql
│
└── README.md
```

---

# 🗄️ Database Exploration

The first step was exploring the database structure.

The warehouse contains the following business objects:

| Schema | Object | Type |
|---------|----------|------|
| gold | dim_customers | Table |
| gold | dim_products | Table |
| gold | fact_sales | Table |
| gold | customers_report | View |
| gold | products_report | View |

This exploration provides an overview of the analytical layer available for reporting.

---

# 📅 Date Range Exploration

The dataset spans the following period:

| First Order Date | Last Order Date |
|-----------------|----------------|
| 2010-12-29 | 2014-01-28 |

Understanding the available time period helps determine trend analyses and reporting windows.

---

# 👥 Dimension Exploration

The dimensional analysis focuses on descriptive attributes used to categorize business data.

## Customer Attributes

- Customer Number
- First Name
- Last Name
- Country
- Marital Status
- Gender
- Birthdate
- Create Date

Countries represented in the dataset include:

- Australia
- Canada
- France
- Germany
- United Kingdom
- United States

---

## Product Attributes

The product dimension includes:

- Product Number
- Product Name
- Category
- Subcategory
- Maintenance

Example product categories include:

- Accessories
- Bikes
- Clothing
- Components

Example subcategories include:

- Bike Racks
- Helmets
- Bottles and Cages
- Lights
- Pumps
- Tires and Tubes
- Locks
- Hydration Packs
- Fenders

---

# 📊 Measures Exploration

The numerical measures explored include:

- Sales Amount
- Quantity Sold
- Order Count
- Product Count

These measures are used throughout the analytical reports to calculate business KPIs.

---

# 📈 Magnitude Analysis

Magnitude analysis evaluates the size and distribution of business entities.

Examples include:

- Number of customers
- Number of products
- Sales by category
- Quantity sold by category
- Orders by country

This analysis identifies where the majority of business activity occurs.

---

# 🏆 Ranking Analysis

Ranking analysis identifies the highest and lowest performing entities.

Examples include:

- Top-selling products
- Lowest-selling products
- Best customers
- Top revenue categories
- Highest quantity sold
- Most profitable products

Ranking enables quick identification of business leaders and improvement opportunities.

---

# 💻 SQL Concepts Demonstrated

This module demonstrates practical SQL skills including:

- SELECT Statements
- DISTINCT
- ORDER BY
- GROUP BY
- Aggregate Functions
- HAVING
- CASE Expressions
- TOP
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- Date Functions

---

# 📌 Key Findings

The exploratory analysis revealed:

- The warehouse contains three analytical tables and two reporting views.
- The available data spans from **December 2010** to **January 2014**.
- Customer data includes demographic information such as gender, marital status, country, and birthdate.
- Product data is organized into categories and subcategories suitable for business reporting.
- The dataset provides sufficient dimensional and numerical information for customer, product, and sales analysis.

---

# 🚀 Outcome

This exploratory analysis established a comprehensive understanding of the warehouse data by:

- Validating the analytical dataset
- Understanding business dimensions
- Identifying available measures
- Exploring temporal coverage
- Preparing the foundation for business analytics and reporting

The insights gained from this phase are used directly in the SQL analytics and reporting module.
