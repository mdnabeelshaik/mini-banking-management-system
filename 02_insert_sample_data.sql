
-- Project 2: Mini Banking Management System
-- File: 02_insert_sample_data.sql

-- Insert sample customers
INSERT INTO bank_customers
    (customer_name, mobile_number, customer_status)
VALUES
    ('Rahul Sharma', '9000000001', 'ACTIVE');

INSERT INTO bank_customers
    (customer_name, mobile_number, customer_status)
VALUES
    ('Priya Reddy', '9000000002', 'ACTIVE');

INSERT INTO bank_customers
    (customer_name, mobile_number, customer_status)
VALUES
    ('Arjun Kumar', '9000000003', 'ACTIVE');

COMMIT;

-- Verify inserted customers
SELECT customer_id, customer_name, mobile_number, customer_status
FROM bank_customers
ORDER BY customer_id;




-- Insert sample bank accounts

INSERT INTO bank_accounts
    (account_number, customer_id, account_type, balance)
VALUES
    ('MB1001', 1, 'SAVINGS', 10000);

INSERT INTO bank_accounts
    (account_number, customer_id, account_type, balance)
VALUES
    ('MB1002', 2, 'SAVINGS', 15000);

INSERT INTO bank_accounts
    (account_number, customer_id, account_type, balance)
VALUES
    ('MB1003', 3, 'CURRENT', 20000);

COMMIT;

-- Verify account data
SELECT account_id, account_number, customer_id,
       account_type, balance
FROM bank_accounts
ORDER BY account_id;
