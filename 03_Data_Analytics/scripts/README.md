# 📊 SQL Business Analytics

This module represents the final phase of the project, where the data warehouse is transformed into meaningful business insights using SQL.

After designing the data warehouse and preparing clean, reliable data through the Bronze, Silver, and Gold layers, this phase focuses on solving real business problems. The analyses answer key business questions, uncover trends, measure performance, and generate reusable reports that support data-driven decision making.

---

# 📖 Project Overview

The goal of this module is to convert business requirements into SQL solutions.

Using analytical SQL queries, this project explores sales performance, customer behavior, product performance, and revenue trends. The final output consists of two reusable SQL reports that provide a complete overview of customers and products.

The entire analysis is performed directly in SQL Server without using external BI tools, demonstrating how SQL alone can be used to generate business insights.

---

# 🧠 Analytics Mind Map

![Analytics Mind Map](docs/mind-map.png)

The mind map illustrates the complete analytical workflow followed throughout this module, starting from business questions and ending with executive-ready reports.

---

# 🎯 Business Objectives

The analysis is designed to answer questions such as:

* How is the business performing over time?
* Which products generate the highest revenue?
* Which customers contribute the most to sales?
* What percentage of total sales comes from each category?
* How can customers and products be segmented?
* Which KPIs should be monitored regularly?

---

# 📂 Project Structure

```text
03_Data_Analytics
│
├── dataset
│   └── DataWarehouseAnalytics.bak
│
├── docs
│   └── mind-map.png
│
├── scripts
│   ├── change_over_time_analysis.sql
│   ├── contribute_analysis.sql
│   ├── cumulative_analysis.sql
│   ├── customers_report.sql
│   ├── data_segmentation_analysis.sql
│   ├── performance_analysis.sql
│   ├── product_report.sql
│   └── placeholder.txt
│
├── LICENSE
└── README.md
```

---

# 📈 Analytical Modules

Each SQL script focuses on solving a specific business problem.

## 📅 Change Over Time Analysis

Tracks business performance across different time periods to identify growth patterns and seasonality.

**Key Metrics**

* Monthly Sales
* Monthly Revenue
* Monthly Orders
* Monthly Quantity Sold

**Business Value**

* Monitor growth
* Identify seasonal trends
* Compare business performance over time

---

## 📊 Cumulative Analysis

Calculates running totals to measure long-term business performance.

**Examples**

* Running Sales
* Running Revenue
* Cumulative Quantity Sold

**Business Value**

Provides a clear picture of how the business grows over time instead of looking at isolated monthly results.

---

## 🏆 Performance Analysis

Evaluates how customers, products, and categories perform.

**Examples**

* Best-selling products
* Highest revenue products
* Top customers
* Best-performing categories

**Business Value**

Highlights top performers while identifying areas that need improvement.

---

## 🎯 Contribution Analysis

Measures how much each product, category, or customer contributes to the overall business.

**Examples**

* Percentage of revenue by category
* Product contribution
* Customer contribution

**Business Value**

Shows where the business generates the majority of its revenue.

---

## 👥 Customer Segmentation

Groups customers according to purchasing behavior and business value.

**Customer Segments**

* ⭐ VIP Customers
* 👤 Regular Customers
* 🆕 New Customers

**Business Value**

Supports customer retention, loyalty programs, and targeted marketing campaigns.

---

# 📑 Customer Report

The **Customer Report** consolidates customer information and purchasing behavior into a single business-ready view.

### Customer Information

* Customer Number
* Customer Name
* Age
* Age Group

### Customer Segmentation

* VIP
* Regular
* New

### Business KPIs

* Total Orders
* Total Sales
* Total Products Purchased
* Customer Lifespan
* Last Order Date
* Recency (Months Since Last Order)
* Average Order Value
* Average Monthly Spend

This report provides a **360° view of each customer**, making it easier to evaluate customer value and purchasing behavior.

---

# 📦 Product Report

The **Product Report** summarizes the business performance of every product.

### Product Information

* Product Name
* Category
* Subcategory
* Cost

### Product Segmentation

Products are automatically classified based on revenue generated:

* 🟢 High Performer
* 🟡 Mid Performer
* 🔴 Low Performer

### Business KPIs

* Total Orders
* Total Sales
* Total Quantity Sold
* Total Customers
* Product Lifespan
* Last Sale Date
* Recency (Months Since Last Sale)
* Average Selling Price
* Average Order Revenue
* Average Monthly Revenue

This report provides a complete overview of product performance and helps identify the products driving business success.

---

# 🔄 Analytics Workflow

```text
Business Questions
        │
        ▼
Explore Business Data
        │
        ▼
Write SQL Queries
        │
        ▼
Perform Analytical Calculations
        │
        ▼
Generate KPIs
        │
        ▼
Create Customer Report
        │
        ▼
Create Product Report
        │
        ▼
Business Insights
```

---

# 💻 SQL Concepts Demonstrated

This module demonstrates practical use of SQL for business analytics, including:

* Common Table Expressions (CTEs)
* Aggregate Functions
* Window Functions
* CASE Expressions
* GROUP BY & HAVING
* Joins
* Date Functions
* Ranking Functions
* Views
* Customer Segmentation
* Product Segmentation
* KPI Calculations
* Running Totals
* Contribution Analysis

---

# 📌 Key Insights Generated

The analyses performed in this module help answer important business questions such as:

* Which products generate the highest revenue?
* Which customers are the most valuable?
* How has revenue changed over time?
* Which categories contribute the most to total sales?
* Which products require business attention?
* How should customers be segmented for better decision making?

---

# 🚀 Business Impact

The final analytical layer transforms raw transactional data into actionable business insights.

By combining multiple analytical techniques with reusable SQL reports, the project delivers a comprehensive view of business performance that can support:

* Executive Reporting
* Sales Performance Monitoring
* Customer Analysis
* Product Analysis
* Business Strategy
* Dashboard Development

The Customer Report and Product Report are designed as reusable analytical views that can be directly connected to visualization tools such as **Power BI** or **Tableau**.

---

# 🎓 Learning Outcomes

Through this module, I strengthened my understanding of:

* Business Analytics using SQL
* KPI Development
* Customer Behavior Analysis
* Product Performance Analysis
* Time Series Analysis
* Business Reporting
* SQL View Development
* Translating Business Questions into Data-Driven Solutions

This module completes the end-to-end analytics workflow by transforming a structured SQL Data Warehouse into meaningful business intelligence.
