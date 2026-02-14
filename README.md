# RETAIL SALES ANALYTICS

## Project Overview

This project involved the design and implementation of an end-to-end Oracle retail analytics database that models real-world retail operations
across four stores selling **food, electronics, furniture, and clothing**. The system integrates **customer, sales, store, and product** data using 
fully normalized relational schemas and ER diagrams, with documented business assumptions to ensure accuracy, consistency, and scalability.


The project emphasizes advanced data analytics and automation through **SQL**. It includes complex SQL views for analyzing 
**customer lifetime value, store performance, sales trends, and product category revenue**, as well as PL/SQL triggers to enforce business
rules such as **automatic sales calculations, data validation, and audit logging**. Stored procedures and packages manage transactional inserts,
discount logic, and monthly sales rollups, while performance is optimized using indexes and analytic functions like RANK, SUM OVER, and LAG 
to support efficient, production-ready reporting.

## Business Scenario

A retail company operates across multiple states and sales channels. Management requires:

* Sales performance insights

* Customer lifetime value analysis

* Store performance tracking

* Product category profitability

* Automated sales calculations

* Performance-optimized queries for reporting

This project transforms raw transactional data into a structured analytics-ready database.

## Dataset Description

The project uses four datasets:

**1️⃣ Customers**

* CustomerID (PK)
* CustomerName
* Gender
* Age
* State
* City
* Location

**2️⃣ Sales**

* SalesID (PK)
* CustomerID (FK)
* Sale_Date
* PurchaseTime
* Sales_RepID (FK)
* StoreID (FK)
* Sales_Amount (auto-calculated)
* Quantity_Sold
* ProductCategory
* Unit_Cost
* Unit_Price
* Customer_Type
* Discount
* Payment_Method
* Sales_Channel

**3️⃣ Store**
* StoreID (PK)
* StoreName
* Sales_Rep
* Sales_RepID

**4️⃣ Products**
* SalesID (FK)
* ProductCategory
* ProductName
* BrandName

## Data Modeling & Assumptions

 **Normalization Decisions**
* Removed duplicate customer names from Sales table
* Used CustomerID as primary reference
* Linked Sales → Customers, Stores, Products via foreign keys
* Designed schema in 3NF

**Assumptions**
* One SaleID represents one product transaction
* Sales_Amount = (Unit_Price × Quantity_Sold) − Discount
* Discount stored as decimal (0–1)
* Customer_Type dynamically updated based on lifetime value

## Entity Relationship Diagram

**Entities:**
* Customers
* Sales
* Store
* Products

**Relationships:**
* One Customer → Many Sales
* One Store → Many Sales
* One Sale → One Product Record

## Technical Implementation

**1. Table Creation & Constraints**

* Primary Keys
* Foreign Keys
* NOT NULL constraints
* CHECK constraints

**2. Indexing Strategy**

Implemented:

* Single-column indexes (CustomerID, Sale_Date, ProductCategory)
* Composite indexes (Sale_Date + StoreID)
* Function-based index (UPPER(City))

Purpose:

* Improve query performance
* Optimize joins
* Speed up reporting views

**3. Analytical Views (CREATE VIEW)**

Created business-focused views:

* Customer Lifetime Value
* Monthly Sales Performance
* Top 10 Customers
* Sales by State
* Store Performance Dashboard
* Product Category Revenue
* Discount Impact Analysis

Advanced SQL Techniques Used

RANK()

DENSE_RANK()

LAG()

LEAD()

ROLLUP

CUBE

Window Functions

Aggregations with PARTITION BY

Correlated Subqueries

🔹 5. Triggers

Implemented automated database logic:

Auto-calculate Sales_Amount

Prevent invalid discount values

Audit logging for new sales

Automatic customer type update

6. Stored Procedures

Created procedures for:

Retrieving customer sales history

Applying bulk discounts

Generating monthly reports

Updating customer segmentation

Includes:

Input parameters

Cursors

Looping

Exception handling

7. PL/SQL Package

Developed reusable package:

SALES_ANALYTICS_PKG

Includes:

Functions for total sales

Customer LTV calculation

Discount management procedures

Benefits:

Modular code

Reusability

Enterprise-style architecture

8. Exception Handling

Implemented:

Custom exceptions

NO_DATA_FOUND handling

OTHERS exception logging

Validation logic in triggers & procedures

📊 Business Questions Answered

Who are the top 10 revenue-generating customers?

Which state generates the highest revenue?

What is the month-over-month sales growth?

Which product category drives the most profit?

How do discounts impact revenue?

Which sales channel performs best?


Retail-Sales-Oracle-Analytics/
│
├── 01_table_creation.sql
├── 02_constraints.sql
├── 03_indexes.sql
├── 04_views.sql
├── 05_analytical_queries.sql
├── 06_triggers.sql
├── 07_stored_procedures.sql
├── 08_packages.sql
├── 09_exception_handling.sql
├── 10_performance_tuning.sql
│
├── ER_Diagram.png
└── README.md












