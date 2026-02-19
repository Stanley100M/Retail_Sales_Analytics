--Trigger -Auto Calculate Sales_Amount

CREATE OR REPLACE TRIGGER trg_calculate_sales_amount
BEFORE INSERT OR UPDATE OF quantity_sold, unit_price, discount
ON sales
FOR EACH ROW
BEGIN
    :NEW.sales_amount := 
        (:NEW.quantity_sold * :NEW.unit_price) 
        - NVL(:NEW.discount, 0);
END;
/

--Trigger – Prevent Invalid Discount Values
CREATE OR REPLACE TRIGGER trg_validate_discount
BEFORE INSERT OR UPDATE OF discount
ON sales
FOR EACH ROW
BEGIN
    IF :NEW.discount < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Discount cannot be negative');
    END IF;

    IF :NEW.discount > (:NEW.quantity_sold * :NEW.unit_price) THEN
        RAISE_APPLICATION_ERROR(-20002, 
            'Discount cannot exceed total sales value');
    END IF;
END;
/


---AFTER INSERT Trigger on SALES(Automatically upgrades/downgrades customers,Runs after every new sale)

CREATE OR REPLACE TRIGGER trg_update_customer_type
AFTER INSERT ON sales
FOR EACH ROW
DECLARE
    v_total_sales NUMBER;
BEGIN
    SELECT SUM(sales_amount)
    INTO v_total_sales
    FROM sales
    WHERE customerid = :NEW.customerid;

    IF v_total_sales > 10000 THEN
        UPDATE customer
        SET customer_type = 'Premium'
        WHERE customerid = :NEW.customerid;

    ELSIF v_total_sales BETWEEN 5000 AND 10000 THEN
        UPDATE customer
        SET customer_type = 'Gold'
        WHERE customerid = :NEW.customerid;

    ELSE
        UPDATE customer
        SET customer_type = 'Regular'
        WHERE customerid = :NEW.customerid;
    END IF;
END;
/

--Trigger with Exception Handling(Discount validation trigger)

CREATE OR REPLACE TRIGGER trg_validate_discount_safe
BEFORE INSERT OR UPDATE ON sales
FOR EACH ROW
DECLARE
    ex_discount_invalid EXCEPTION;
BEGIN
    IF :NEW.discount < 0 OR :NEW.discount > (:NEW.quantity_sold * :NEW.unit_price) THEN
        RAISE ex_discount_invalid;
    END IF;

EXCEPTION
    WHEN ex_discount_invalid THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Trigger Error: Invalid discount for SalesID ' || :NEW.sales_id);
    WHEN OTHERS THEN
        INSERT INTO error_log(log_date, error_message, sales_id)
        VALUES (SYSDATE, SQLERRM, :NEW.salesid);
        RAISE;        
END;
/













