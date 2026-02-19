--RANK() – Top Customers by Total Sales

SELECT 
    c.customer_id,
    c.customer_name,
    SUM(s.sales_amount) AS total_sales,
    RANK() OVER (ORDER BY SUM(s.sales_amount) DESC) AS sales_rank
FROM sales s
JOIN customers c 
    ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name FETCH FIRST 10 ROWS ONLY;

--DENSE_RANK() – Stores Rank by Revenue 

SELECT 
    s.store_name,
    SUM(s.sales_amount) AS total_revenue,
    DENSE_RANK() OVER (ORDER BY SUM(s.sales_amount) DESC) AS dense_rank_store
FROM sales s
GROUP BY s.store_name;

--Combine STORE & PRODUCTS Tables (Top brand per store)

SELECT *
FROM (
    SELECT 
        st.store_name,
        p.brand_name,
        SUM(s.sales_amount) AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY st.store_name
            ORDER BY SUM(s.sales_amount) DESC
        ) AS rank_brand        
    FROM sales s
    JOIN stores st 
        ON s.sales_rep = st.sales_rep
    JOIN products p 
        ON s.sales_id = p.sales_id
    GROUP BY st.store_name, p.brand_name
)
WHERE rank_brand = 1;


--LAG() – Compare Current Sale with Previous Sale (Customer-wise)

SELECT 
    customer_id,
    sale_date,
    sales_amount,
    LAG(sales_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY sale_date
    ) AS previous_sale,
    sales_amount - LAG(sales_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY sale_date
    ) AS difference
FROM sales;

--Comparison Across Customers(comparing each sale to the overall average)

SELECT
    customer_id,
    sale_date,
    sales_amount,
    ROUND(sales_amount - AVG(sales_amount) OVER (),2) AS difference_from_average
FROM sales;

--LEAD() – Next Purchase Amount

SELECT 
    customer_id,
    sale_date,
    sales_amount,
    LEAD(sales_amount) OVER (
        PARTITION BY customer_id
        ORDER BY sale_date
    ) AS next_sale
FROM sales;

--ROLLUP – Sales Summary by State and City

SELECT 
    c.state,
    c.city,
    SUM(s.sales_amount) AS total_sales
FROM sales s
JOIN customers c 
    ON s.customer_id = c.customer_id
GROUP BY ROLLUP (c.state, c.city)
ORDER BY c.state, c.city;

--Aggregation with PARTITION BY – Individual sales against Avg Sales per Store

SELECT 
    store_name,
    sales_id,
    sales_amount,
    ROUND(AVG(sales_amount) OVER  (
        PARTITION BY store_name
    ),2) AS avg_store_sales
FROM sales;

--Correlated Subquery – Customers Who Spend Above Their State Average

SELECT 
    c.customer_id,
    c.customer_name,
    SUM(s.sales_amount) AS total_sales
FROM customers c
JOIN sales s 
    ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customername, c.state
HAVING SUM(s.sales_amount) >
    (
        SELECT AVG(total_state_sales)
        FROM (
            SELECT SUM(s2.sales_amount) AS total_state_sales
            FROM customer c2
            JOIN sales s2 
                ON c2.customer_id = s2.customer_id
            WHERE c2.state = c.state
            GROUP BY c2.customer_id
        )
    );

--Correlated Subquery – Highest Sale per Store

SELECT 
    s1.store_name,
    s1.sales_id,
    s1.sales_amount
FROM sales s1
WHERE s1.sales_amount = (
    SELECT MAX(s2.sales_amount)
    FROM sales s2
    WHERE s2.store_name = s1.store_name
);










































































