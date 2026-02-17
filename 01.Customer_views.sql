--Analytical views

--Customer Lifetime Value (CLV)

CREATE OR REPLACE VIEW vw_customer_lifetime_value AS
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(*) AS total_transactions,
    SUM(s.sales_amount) AS lifetime_value
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name;


--Monthly Sales Performance

CREATE OR REPLACE VIEW vw_monthly_sales_performance AS
SELECT 
    TO_CHAR(s.sale_date, 'YYYY-MM') AS sales_month,
    COUNT(*) AS total_transactions,
    SUM(s.sales_amount) AS total_revenue,
    SUM(s.quantity_sold) AS total_units_sold
FROM sales s
GROUP BY TO_CHAR(s.sale_date, 'YYYY-MM')
ORDER BY sales_month;

--Top 10 Customers (by Revenue)

CREATE OR REPLACE VIEW vw_top_10_customers AS
SELECT *
FROM (
    SELECT 
        c.customer_id,
        c.customer_name,
        SUM(s.sales_amount) AS total_spent
    FROM sales s
    JOIN customers c
        ON s.customer_id = c.customer_id
    GROUP BY c.customer_id, c.customer_name
    ORDER BY total_spent DESC
)
WHERE ROWNUM <= 10;

--Sales by State

CREATE OR REPLACE VIEW vw_sales_by_state AS
SELECT 
    c.state,
    COUNT(*) AS total_transactions,
    SUM(s.sales_amount) AS total_revenue
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
GROUP BY c.state
ORDER BY total_revenue DESC;

--Store Performance Dashboard

CREATE OR REPLACE VIEW vw_store_performance AS
SELECT 
    st.store_name,
    COUNT(s.customer_id) AS total_transactions,
    SUM(s.sales_amount) AS total_revenue,
    ROUND(AVG(s.sales_amount), 2) AS avg_transaction_value
FROM sales s
JOIN stores st
    ON s.store_name = st.store_name
GROUP BY st.store_name
ORDER BY total_revenue DESC;

--Product Category Revenue

CREATE OR REPLACE VIEW vw_product_category_revenue AS
SELECT 
    product_category,
    COUNT(*) AS total_sales,
    SUM(sales_amount) AS total_revenue,
    SUM(quantity_sold) AS total_units_sold
FROM sales
GROUP BY product_category
ORDER BY total_revenue DESC;


--Discount Impact Analysis

CREATE OR REPLACE VIEW vw_discount_impact AS
SELECT 
    CASE 
            WHEN discount = 0 THEN 'No Discount'
            WHEN discount > 0 AND discount < 0.10 THEN 'Low Discount'
            WHEN discount >= 0.10 AND discount < 0.25 THEN 'Medium Discount'
            ELSE 'High Discount'
    END AS discount_category,
    COUNT(*) AS total_transactions,
    SUM(sales_amount) AS total_revenue,
    ROUND(AVG(sales_amount), 2) AS avg_sale_value
FROM sales
GROUP BY 
    CASE 
            WHEN discount = 0 THEN 'No Discount'
            WHEN discount > 0 AND discount < 0.10 THEN 'Low Discount'
            WHEN discount >= 0.10 AND discount < 0.25 THEN 'Medium Discount'
            ELSE 'High Discount'
    END;















