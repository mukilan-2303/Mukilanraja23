CREATE TABLE employees (
    emp_id       NUMBER PRIMARY KEY,
    name         VARCHAR2(100),
    department   VARCHAR2(50),
    salary       NUMBER(10, 2)
);

-- Sample data
INSERT INTO employees VALUES (1, 'Alice', 'HR', 5000);
INSERT INTO employees VALUES (2, 'Bob', 'IT', 6000);
INSERT INTO employees VALUES (3, 'Charlie', 'HR', 5500);
COMMIT;

--process
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    dept_name IN VARCHAR2,
    bonus_pct IN NUMBER
) IS
BEGIN
  UPDATE employees
  SET salary = salary + (salary * bonus_pct / 100)
  WHERE department = dept_name;

  COMMIT;
END;
/

--execute
EXEC UpdateEmployeeBonus('HR', 10);  -- Adds 10% bonus to HR department


-- For display
SELECT * FROM employees;