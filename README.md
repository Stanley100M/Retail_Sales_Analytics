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


































