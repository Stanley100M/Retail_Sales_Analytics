--Error Logging Table

CREATE TABLE error_log (
    log_id        NUMBER GENERATED ALWAYS AS IDENTITY,
    log_date      DATE,
    error_message VARCHAR2(4000),
    sales_id      NUMBER
);






