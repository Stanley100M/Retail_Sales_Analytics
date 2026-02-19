--Procedure – Retrieve Customer Sales History

CREATE OR REPLACE PROCEDURE get_customer_sales_history (
    p_customer_id IN NUMBER,
    p_sales OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_sales FOR
        SELECT *
        FROM sales
        WHERE customer_id = p_customer_id
        ORDER BY sale_date DESC;
END;
/

--Execution

VAR rc REFCURSOR;

EXEC get_customer_sales_history(22485, :rc);

PRINT rc;

--Procedure – Apply Bulk Discount

CREATE OR REPLACE PROCEDURE apply_bulk_discount (
    p_sales_id IN NUMBER
)
AS
BEGIN
    UPDATE sales
    SET discount = CASE
                       WHEN quantity_sold >= 20 THEN quantity_sold * unit_price * 0.20
                       WHEN quantity_sold >= 10 THEN quantity_sold * unit_price * 0.10
                       ELSE 0
                   END,
        sales_amount = (quantity_sold * unit_price) -
                       CASE
                           WHEN quantity_sold >= 20 THEN quantity_sold * unit_price * 0.20
                           WHEN quantity_sold >= 10 THEN quantity_sold * unit_price * 0.10
                           ELSE 0
                       END
    WHERE sales_id = p_sales_id;

    COMMIT;
END;
/

--Execution

EXEC apply_bulk_discount(80973);

--checking the discount applied
SELECT sales_id,
       quantity_sold,
       unit_price,
       discount,
       sales_amount
FROM sales
WHERE sales_id = 80973;

----Procedure – Apply Bulk Discount

CREATE OR REPLACE PROCEDURE apply_bulk_discount (
    p_sales_id IN NUMBER
)
AS
BEGIN
    UPDATE sales
    SET discount = CASE
                       WHEN quantity_sold >= 20 THEN quantity_sold * unit_price * 0.20
                       WHEN quantity_sold >= 10 THEN quantity_sold * unit_price * 0.10
                       ELSE 0
                   END,
        sales_amount = (quantity_sold * unit_price) -
                       CASE
                           WHEN quantity_sold >= 20 THEN quantity_sold * unit_price * 0.20
                           WHEN quantity_sold >= 10 THEN quantity_sold * unit_price * 0.10
                           ELSE 0
                       END
    WHERE sales_id = p_sales_id;

    COMMIT;
END;
/

--Execution

EXEC apply_bulk_discount(80973);

--checking the discount applied
SELECT sales_id,
       quantity_sold,
       unit_price,
       discount,
       sales_amount
FROM sales
WHERE sales_id = 80973;

--Procedure – Generate Monthly Sales Report

CREATE OR REPLACE PROCEDURE generate_monthly_report (
    p_year       IN  NUMBER,
    monthly_report_cursor  OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN monthly_report_cursor FOR
        SELECT 
            TO_CHAR(sale_date, 'Month') AS month_name,
            COUNT(sales_id) AS total_transactions,
            SUM(quantity_sold) AS total_quantity,
            SUM(sales_amount) AS total_revenue
        FROM sales
        WHERE EXTRACT(YEAR FROM sale_date) = p_year
        GROUP BY TO_CHAR(sale_date, 'Month'),
                 TO_CHAR(sale_date, 'MM')
        ORDER BY TO_CHAR(sale_date, 'MM');
END;
/

--testing the procedure

VARIABLE my_cursor REFCURSOR;

EXEC generate_monthly_report(2023, :my_cursor);

PRINT my_cursor;

--Procedure – Update Customer Segmentation

CREATE OR REPLACE PROCEDURE update_customer_segmentation
AS
    -- Cursor to calculate total sales per customer
    CURSOR customer_segment_cursor IS
        SELECT c.customer_id,
               NVL(SUM(s.sales_amount), 0) AS total_sales
        FROM customers c
        LEFT JOIN sales s
            ON c.customer_id = s.customer_id
        GROUP BY c.customer_id;
BEGIN
    -- Loop through each customer in the cursor
    FOR rec IN customer_segment_cursor
    LOOP
        UPDATE customers
        SET customer_type = CASE
            WHEN rec.total_sales > 8500 THEN 'Platinum'
            WHEN rec.total_sales BETWEEN 5000 AND 8500 THEN 'Gold'
            WHEN rec.total_sales BETWEEN 1000 AND 4999 THEN 'Silver'
            ELSE 'Regular'
        END
        WHERE customer_id = rec.customer_id;
    END LOOP;

    COMMIT;
END;
/

--executing the cursor
EXECUTE update_customer_segmentation;


--Testing the procedure

SELECT customer_id, CUSTOMER_TYPE
FROM customers
ORDER BY customer_id;






