CREATE TABLE savings_accounts (
    account_id   NUMBER PRIMARY KEY,
    customer_id  NUMBER,
    balance      NUMBER(10, 2)
);

-- Sample data
INSERT INTO savings_accounts VALUES (101, 1, 1000);
INSERT INTO savings_accounts VALUES (102, 2, 2000);
INSERT INTO savings_accounts VALUES (103, 3, 3000);
COMMIT;

--process
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
  UPDATE savings_accounts
  SET balance = balance + (balance * 0.01);
  COMMIT;
END;
/
--execute
EXEC ProcessMonthlyInterest;

-- For Display
SELECT * FROM savings_accounts;
