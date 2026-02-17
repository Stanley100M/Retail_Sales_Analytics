--Create tables

--stores table

CREATE TABLE stores (
    store_id     VARCHAR2(50),
    store_name   VARCHAR2(100),
    sales_rep_id VARCHAR2(50),
    sales_rep    VARCHAR2(100)
);

--sales table

CREATE TABLE sales (
    customer_name     VARCHAR2(100),
    customer_id       NUMBER,
    product_id        NUMBER,
    sale_date         DATE,
    purchase_time     VARCHAR2(20),
    sales_rep         VARCHAR2(100),
    store_name            VARCHAR2(50),
    sales_amount      NUMBER(10,2),
    quantity_sold     NUMBER,
    product_category  VARCHAR2(50),
    unit_cost         NUMBER(10,2),
    unit_price        NUMBER(10,2),
    customer_type     VARCHAR2(50),
    discount          NUMBER(5,2),
    payment_method    VARCHAR2(50),
    sales_channel     VARCHAR2(50),

    CONSTRAINT pk_sales
        PRIMARY KEY (customer_id, product_id, sale_date),

    CONSTRAINT fk_sales_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
-- Sales amount must be >= 0
ALTER TABLE sales
ADD CONSTRAINT chk_sales_amount
CHECK (sales_amount >= 0);

-- Quantity must be greater than 0
ALTER TABLE sales
ADD CONSTRAINT chk_quantity_sold
CHECK (quantity_sold > 0);

-- Unit cost must be >= 0
ALTER TABLE sales
ADD CONSTRAINT chk_unit_cost
CHECK (unit_cost >= 0);

-- Unit price must be >= 0
ALTER TABLE sales
ADD CONSTRAINT chk_unit_price
CHECK (unit_price >= 0);

-- Discount between 0 and 100
ALTER TABLE sales
ADD CONSTRAINT chk_discount
CHECK (discount BETWEEN 0 AND 100);

-- Customer type restriction
ALTER TABLE sales
ADD CONSTRAINT chk_customer_type
CHECK (customer_type IN ('Returning', 'New'));

-- Payment method restriction
ALTER TABLE sales
ADD CONSTRAINT chk_payment_method
CHECK (payment_method IN ('Cash', 'Bank Transfer', 'Credit Card'));

-- Sales channel restriction
ALTER TABLE sales
ADD CONSTRAINT chk_sales_channel
CHECK (sales_channel IN ('Online', 'Retail'));

CREATE INDEX idx_sales_customer_id
ON sales (customer_id);

CREATE INDEX idx_sales_sale_date
ON sales (sale_date);

CREATE INDEX idx_sales_product_category
ON sales (product_category);


--Products table
CREATE TABLE products (
    sales_id        NUMBER PRIMARY KEY,
    product_category  VARCHAR2(50),
    product_name      VARCHAR2(100),
    brand_name        VARCHAR2(100)
);

ALTER TABLE products
MODIFY (
    product_category NOT NULL,
    product_name     NOT NULL,
    brand_name       NOT NULL
);

--customers table

CREATE TABLE customers (
    
    customer_name   VARCHAR2(100),
    customer_id     NUMBER PRIMARY KEY,
    gender          VARCHAR2(10),
    age             NUMBER,
    state           VARCHAR2(50),
    city            VARCHAR2(50),
    location        VARCHAR2(100)
);
















