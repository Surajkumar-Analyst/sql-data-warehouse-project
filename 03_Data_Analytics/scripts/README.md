# 📊 SQL Data Analytics

This module represents the final stage of the project, where the data warehouse is transformed into meaningful business insights through SQL analytics.

Using the cleaned and modeled data from the Gold layer, this phase focuses on answering real business questions, identifying trends, measuring performance, and creating reusable analytical reports that support data-driven decision making.

Unlike the previous modules, this stage is not about preparing data—it's about extracting value from it.

---

# 📖 Project Overview

The objective of this module is to analyze business data using SQL and convert raw numbers into actionable insights.

The analysis covers multiple business perspectives, including:

* Sales trends over time
* Customer purchasing behavior
* Product performance
* Revenue contribution
* Customer segmentation
* Executive reporting

Every analysis is written using SQL and follows a problem-solving approach, where each script answers a specific business question.

---

# 🧠 Analytics Mind Map

![Analytics Mind Map](docs/mind-map.png)

The mind map illustrates the overall analytical workflow and shows how different analyses are connected to answer business questions and generate reports.

---

# 🎯 Business Objectives

The primary objectives of this module are:

* Understand business performance over time
* Identify top-performing products
* Analyze customer purchasing behavior
* Measure contribution of products and categories
* Segment customers based on business rules
* Build reusable SQL reports
* Generate business-ready KPIs

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
│   └── product_report.sql
│
├── LICENSE
└── README.md
```

---

# 📈 Analytics Performed

## 1️⃣ Change Over Time Analysis

This analysis explores how business performance changes across different time periods.

It helps answer questions such as:

* Is revenue increasing or decreasing?
* Which months generate the highest sales?
* How many orders are placed each month?
* Are there seasonal sales patterns?

Typical KPIs:

* Monthly Sales
* Monthly Orders
* Monthly Quantity Sold
* Monthly Revenue Trend

---

## 2️⃣ Cumulative Analysis

Instead of looking at individual months, cumulative analysis tracks overall business growth.

This helps visualize long-term performance and monitor business progress over time.

Examples include:

* Running Total Sales
* Cumulative Revenue
* Running Quantity Sold

---

## 3️⃣ Performance Analysis

Performance analysis compares products, customers, and categories to identify the best and worst performers.

Business questions answered include:

* Which products generate the highest revenue?
* Which customers spend the most?
* Which categories perform best?
* Which products require improvement?

This analysis helps prioritize business decisions and identify opportunities for growth.

---

## 4️⃣ Contribution Analysis

Contribution analysis measures how much each entity contributes to the overall business.

Instead of only knowing total revenue, we determine where that revenue comes from.

Examples:

* Sales contribution by category
* Revenue contribution by product
* Customer contribution to total sales

This analysis highlights the most valuable business segments.

---

## 5️⃣ Customer Segmentation Analysis

Customers are grouped based on purchasing behavior and lifetime value.

Segmentation rules classify customers into meaningful groups such as:

* ⭐ VIP Customers
* 👤 Regular Customers
* 🆕 New Customers

Customer segmentation supports marketing campaigns, customer retention strategies, and personalized business decisions.

---

# 📑 Business Reports

The final output of this module consists of two reusable SQL reports.

## 👤 Customer Report

The customer report consolidates customer information and purchasing behavior into a single analytical view.

Key metrics include:

* Customer Information
* Age
* Age Group
* Customer Segment
* Total Orders
* Total Sales
* Products Purchased
* Customer Lifespan
* Last Purchase Date
* Recency
* Average Order Value
* Average Monthly Spend

This report provides a 360° view of every customer.

---

## 📦 Product Report

The product report summarizes the performance of every product in the business.

Included metrics:

* Product Information
* Product Category
* Product Subcategory
* Total Orders
* Total Quantity Sold
* Total Revenue
* Customer Reach
* Product Ranking
* Performance Indicators

The report helps evaluate product success and identify high-performing products.

---

# 🔄 Analytics Workflow

```text
Business Requirements
          │
          ▼
Identify Business Questions
          │
          ▼
Write SQL Queries
          │
          ▼
Perform Analysis
          │
          ▼
Generate KPIs
          │
          ▼
Create Customer & Product Reports
          │
          ▼
Business Insights
```

---

# 💻 SQL Concepts Demonstrated

This module showcases practical analytical SQL skills, including:

* Common Table Expressions (CTEs)
* Window Functions
* Aggregate Functions
* GROUP BY & HAVING
* CASE Expressions
* Ranking Functions
* Date Functions
* Joins
* Views
* Business KPI Calculations
* Customer Segmentation
* Running Totals
* Percentage Contribution Analysis

---

# 📊 Business Value

The analyses performed in this module help answer critical business questions such as:

* What products drive the most revenue?
* Who are the most valuable customers?
* How has the business grown over time?
* Which customer segments contribute the most?
* Which categories should receive more business focus?

These insights enable data-driven decision making and provide a strong foundation for dashboards and executive reporting.

---

# 🚀 Future Improvements

Potential enhancements for this project include:

* Interactive Power BI dashboards
* SQL stored procedures for automated reporting
* Scheduled report generation
* Additional customer lifetime value (CLV) analysis
* Predictive sales forecasting
* RFM (Recency, Frequency, Monetary) customer segmentation

---

# 🎓 Learning Outcomes

Through this project, I strengthened my understanding of:

* Business Analytics with SQL
* KPI Development
* Customer Behavior Analysis
* Product Performance Evaluation
* Time Series Analysis
* Analytical Query Design
* Report Development
* Translating Business Questions into SQL Solutions

This module completes the end-to-end analytics workflow by transforming a well-designed data warehouse into actionable business insights.
