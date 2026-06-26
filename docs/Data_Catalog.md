# 📚 Gold Layer Data Catalog

The **Gold Layer** contains business-ready data models designed for reporting, dashboards, and analytics. It follows a **Star Schema**, consisting of **Dimension Tables** and a **Fact Table**.

---

## ⭐ Data Model Overview

```text
                    +----------------------+
                    |  gold.dim_customers  |
                    +----------------------+
                              |
                              |
                              |
+----------------------+       |       +----------------------+
|  gold.dim_products   |-------+-------|    gold.fact_sales   |
+----------------------+               +----------------------+
```

---

# 🧑 Customers Dimension

**Table:** `gold.dim_customers`

### 🎯 Purpose

Stores customer information enriched with demographic and geographic details.

## 📋 Columns

| Column                 | Type         | Description                                       |
| ---------------------- | ------------ | ------------------------------------------------- |
| 🔑 **customer_key**    | INT          | Surrogate key uniquely identifying each customer. |
| 🆔 **customer_id**     | INT          | Business identifier assigned to each customer.    |
| 🔢 **customer_number** | NVARCHAR(50) | Customer reference number.                        |
| 👤 **first_name**      | NVARCHAR(50) | Customer's first name.                            |
| 👤 **last_name**       | NVARCHAR(50) | Customer's last name.                             |
| 🌍 **country**         | NVARCHAR(50) | Customer's country of residence.                  |
| 💍 **marital_status**  | NVARCHAR(50) | Marital status (Married, Single, etc.).           |
| 🚻 **gender**          | NVARCHAR(50) | Gender of the customer.                           |
| 🎂 **birthdate**       | DATE         | Customer's date of birth.                         |
| 📅 **create_date**     | DATE         | Record creation date.                             |

---

# 🚴 Products Dimension

**Table:** `gold.dim_products`

### 🎯 Purpose

Contains product master data and product hierarchy.

## 📋 Columns

| Column                      | Type         | Description                                |
| --------------------------- | ------------ | ------------------------------------------ |
| 🔑 **product_key**          | INT          | Surrogate key for products.                |
| 🆔 **product_id**           | INT          | Business product identifier.               |
| 🔢 **product_number**       | NVARCHAR(50) | Product code used for inventory.           |
| 📦 **product_name**         | NVARCHAR(50) | Product name and description.              |
| 🏷️ **category_id**         | NVARCHAR(50) | Category identifier.                       |
| 📂 **category**             | NVARCHAR(50) | Main product category.                     |
| 📁 **subcategory**          | NVARCHAR(50) | Product subcategory.                       |
| 🔧 **maintenance_required** | NVARCHAR(50) | Indicates whether maintenance is required. |
| 💲 **cost**                 | INT          | Product cost.                              |
| 🚲 **product_line**         | NVARCHAR(50) | Product line (Road, Mountain, etc.).       |
| 📅 **start_date**           | DATE         | Product launch date.                       |

---

# 💰 Sales Fact

**Table:** `gold.fact_sales`

### 🎯 Purpose

Stores transactional sales records used for business reporting and KPI analysis.

## 📋 Columns

| Column               | Type         | Description                     |
| -------------------- | ------------ | ------------------------------- |
| 🧾 **order_number**  | NVARCHAR(50) | Unique sales order number.      |
| 🔑 **product_key**   | INT          | Foreign key to `dim_products`.  |
| 🔑 **customer_key**  | INT          | Foreign key to `dim_customers`. |
| 📅 **order_date**    | DATE         | Date order was placed.          |
| 🚚 **shipping_date** | DATE         | Date order was shipped.         |
| ⏰ **due_date**       | DATE         | Payment due date.               |
| 💰 **sales_amount**  | INT          | Total sales amount.             |
| 📦 **quantity**      | INT          | Quantity sold.                  |
| 💵 **price**         | INT          | Unit selling price.             |

---

# ⭐ Relationships

| From                           | To                                | Relationship |
| ------------------------------ | --------------------------------- | ------------ |
| `gold.fact_sales.customer_key` | `gold.dim_customers.customer_key` | Many-to-One  |
| `gold.fact_sales.product_key`  | `gold.dim_products.product_key`   | Many-to-One  |

---

# 📊 Business Use Cases

This Gold Layer supports analysis such as:

* 📈 Sales Performance Dashboard
* 👥 Customer Segmentation
* 🌎 Country-wise Revenue Analysis
* 🛒 Product Performance
* 💰 Revenue & Profit Analysis
* 📦 Sales Trends
* 🚚 Shipping Performance
* 🎯 Executive KPI Dashboards

---

# 🏛️ Star Schema

```text
                 gold.dim_customers
                        │
                        │
                        │
gold.dim_products ──────┼────── gold.fact_sales
```

---

## 🚀 Layer Summary

| Layer     | Purpose                         |
| --------- | ------------------------------- |
| 🥉 Bronze | Raw data ingestion              |
| 🥈 Silver | Cleaned and transformed data    |
| 🥇 Gold   | Business-ready analytical model |

> The **Gold Layer** serves as the final presentation layer for BI tools such as **Power BI**, **Tableau**, **Excel**, and other reporting platforms.
