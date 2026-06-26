# 📝 Naming Conventions

This document defines the naming standards used throughout the Data Warehouse project. Following consistent naming conventions improves readability, maintainability, and collaboration across all layers of the warehouse.

---

# 📑 Table of Contents

* [General Principles](#-general-principles)
* [Table Naming Conventions](#-table-naming-conventions)

  * Bronze Layer
  * Silver Layer
  * Gold Layer
* [Category Prefixes](#-category-prefixes)
* [Column Naming Conventions](#-column-naming-conventions)

  * Surrogate Keys
  * Technical Columns
* [Stored Procedure Naming](#-stored-procedure-naming)
* [Examples](#-examples)

---

# 📌 General Principles

The following standards apply to all database objects.

| Rule                  | Description                                                          |
| --------------------- | -------------------------------------------------------------------- |
| 🔤 **Naming Style**   | Use **snake_case** with lowercase letters and underscores (`_`).     |
| 🌍 **Language**       | Use **English** for all database objects.                            |
| 🚫 **Reserved Words** | Avoid SQL reserved keywords such as `SELECT`, `TABLE`, `ORDER`, etc. |
| 📖 **Readability**    | Use meaningful and descriptive names.                                |
| 🔄 **Consistency**    | Apply the same naming pattern across all schemas and layers.         |

---

# 🗂️ Table Naming Conventions

## 🥉 Bronze Layer

### Purpose

Stores raw data exactly as received from the source systems.

### Naming Pattern

```text
<source_system>_<entity>
```

| Component       | Description                                |
| --------------- | ------------------------------------------ |
| `source_system` | Source application (e.g., `crm`, `erp`)    |
| `entity`        | Original table name from the source system |

### Examples

```text
crm_customer_info
crm_sales_details
erp_products
erp_locations
```

> ✅ Bronze tables should **retain their original source table names** without modification.

---

## 🥈 Silver Layer

### Purpose

Stores cleaned, standardized, and transformed data.

### Naming Pattern

```text
<source_system>_<entity>
```

Although data is transformed, the original business entity name is preserved.

### Examples

```text
crm_customer_info
crm_sales_details
erp_products
erp_locations
```

> ✅ Silver tables keep the same naming convention as Bronze while containing cleansed and validated data.

---

## 🥇 Gold Layer

### Purpose

Stores business-ready analytical models using Star Schema principles.

### Naming Pattern

```text
<category>_<entity>
```

| Component  | Description                          |
| ---------- | ------------------------------------ |
| `category` | Table type (`dim`, `fact`, `report`) |
| `entity`   | Business entity                      |

### Examples

```text
dim_customers
dim_products
fact_sales
report_monthly_sales
```

---

# 📚 Category Prefixes

| Prefix    | Meaning         | Example                |
| --------- | --------------- | ---------------------- |
| `dim_`    | Dimension Table | `dim_customers`        |
| `fact_`   | Fact Table      | `fact_sales`           |
| `report_` | Reporting Table | `report_sales_monthly` |

---

# 🏷️ Column Naming Conventions

Columns should use meaningful business names.

---

## 🔑 Surrogate Keys

Every dimension table should have a surrogate key ending with **`_key`**.

### Naming Pattern

```text
<table_name>_key
```

### Examples

```text
customer_key
product_key
employee_key
store_key
```

Example:

| Table         | Primary Key  |
| ------------- | ------------ |
| dim_customers | customer_key |
| dim_products  | product_key  |
| dim_stores    | store_key    |

---

## ⚙️ Technical Columns

Technical (system-generated) columns must begin with the prefix **`dwh_`**.

### Naming Pattern

```text
dwh_<column_name>
```

### Examples

```text
dwh_load_date
dwh_insert_date
dwh_update_date
dwh_source_system
dwh_batch_id
```

These columns are used for:

* ETL tracking
* Audit history
* Data lineage
* Incremental loading
* Error tracking

---

# ⚡ Stored Procedure Naming

Stored procedures responsible for loading data should follow a consistent naming convention.

### Naming Pattern

```text
load_<layer>
```

### Examples

```text
load_bronze
load_silver
load_gold
```

For larger projects, procedures may also include the entity name.

```text
load_bronze_crm_customers
load_silver_erp_products
load_gold_fact_sales
```

---

# 💡 Naming Examples

## Schemas

```text
bronze
silver
gold
```

---

## Tables

```text
bronze.crm_customer_info
bronze.erp_products

silver.crm_customer_info
silver.erp_products

gold.dim_customers
gold.dim_products
gold.fact_sales
```

---

## Columns

```text
customer_key
product_key
sales_amount
order_date
shipping_date
dwh_load_date
dwh_source_system
```

---

# ✅ Best Practices

* ✔ Use lowercase letters only.
* ✔ Separate words with underscores (`_`).
* ✔ Keep names descriptive and concise.
* ✔ Use business-friendly terminology.
* ✔ Use surrogate keys in all dimension tables.
* ✔ Prefix metadata columns with `dwh_`.
* ✔ Keep naming consistent across Bronze, Silver, and Gold layers.
* ✔ Avoid spaces and special characters.
* ✔ Do not abbreviate unless the abbreviation is widely understood.

---

# 🎯 Summary

| Object           | Naming Pattern  | Example                |
| ---------------- | --------------- | ---------------------- |
| Bronze Table     | `source_entity` | `crm_customer_info`    |
| Silver Table     | `source_entity` | `erp_products`         |
| Gold Dimension   | `dim_entity`    | `dim_customers`        |
| Gold Fact        | `fact_entity`   | `fact_sales`           |
| Gold Report      | `report_entity` | `report_sales_monthly` |
| Surrogate Key    | `entity_key`    | `customer_key`         |
| Technical Column | `dwh_column`    | `dwh_load_date`        |
| Stored Procedure | `load_layer`    | `load_gold`            |

---

> 💡 **Following these naming conventions ensures consistency, improves collaboration, and makes the Data Warehouse easier to maintain and scale over time.**
