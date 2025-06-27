CREATE TABLE accounts (
    account_id   NUMBER PRIMARY KEY,
    customer_id  NUMBER,
    balance      NUMBER(10, 2)
);

-- Sample data
INSERT INTO accounts VALUES (201, 1, 5000);
INSERT INTO accounts VALUES (202, 2, 3000);
COMMIT;

--process
CREATE OR REPLACE PROCEDURE TransferFunds (
    from_account_id IN NUMBER,
    to_account_id   IN NUMBER,
    amount          IN NUMBER
) IS
    insufficient_balance EXCEPTION;
BEGIN
  -- Check balance
  DECLARE
    v_balance NUMBER;
  BEGIN
    SELECT balance INTO v_balance FROM accounts WHERE account_id = from_account_id;

    IF v_balance < amount THEN
      RAISE insufficient_balance;
    END IF;

    -- Deduct from source
    UPDATE accounts
    SET balance = balance - amount
    WHERE account_id = from_account_id;

    -- Add to destination
    UPDATE accounts
    SET balance = balance + amount
    WHERE account_id = to_account_id;

    COMMIT;
  END;

EXCEPTION
  WHEN insufficient_balance THEN
    DBMS_OUTPUT.PUT_LINE('Insufficient balance. Transfer failed.');
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid account ID.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

--execute
EXEC TransferFunds(201, 202, 1000);  -- Transfer 1000 from account 201 to 202

-- For display
SELECT * FROM accounts;