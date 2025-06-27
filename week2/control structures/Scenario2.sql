-- Drop tables if they exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE loans';
  EXECUTE IMMEDIATE 'DROP TABLE customers';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

-- Create customers table
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    name        VARCHAR2(100),
    age         NUMBER,
    balance     NUMBER,
    isvip       VARCHAR2(10) DEFAULT 'FALSE'
);

-- Create loans table
CREATE TABLE loans (
    loan_id        NUMBER PRIMARY KEY,
    customer_id    NUMBER REFERENCES customers(customer_id),
    interest_rate  NUMBER(5,2),
    due_date       DATE
);

-- Insert sample data
INSERT INTO customers VALUES (1, 'John Doe', 65, 15000, 'FALSE');
INSERT INTO customers VALUES (2, 'Jane Smith', 45, 8000, 'FALSE');
INSERT INTO customers VALUES (3, 'Robert Black', 70, 11000, 'FALSE');
INSERT INTO customers VALUES (4, 'Emily White', 30, 9500, 'FALSE');

INSERT INTO loans VALUES (101, 1, 10.5, SYSDATE + 20);  -- Due in 20 days
INSERT INTO loans VALUES (102, 2, 12.0, SYSDATE + 40);  -- Due in 40 days
INSERT INTO loans VALUES (103, 3, 9.0, SYSDATE + 10);   -- Due in 10 days
INSERT INTO loans VALUES (104, 4, 11.0, SYSDATE + 25);  -- Due in 25 days

COMMIT;

--execution

BEGIN
  FOR rec IN (
    SELECT customer_id, balance
    FROM customers
  ) LOOP
    IF rec.balance > 10000 THEN
      UPDATE customers
      SET isvip = 'TRUE'
      WHERE customer_id = rec.customer_id;
    END IF;
  END LOOP;

  COMMIT;
END;
/

--enable server

SET SERVEROUTPUT ON;

-- Check VIP flags
SELECT * FROM customers;
