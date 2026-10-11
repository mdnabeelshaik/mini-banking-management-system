SELECT
    t.transaction_id,
    t.transaction_reference,
    a.account_number,
    t.transaction_type,
    t.transaction_amount,
    t.transaction_status,
    t.description,
    t.created_at
FROM bank_transactions t
JOIN bank_accounts a
    ON t.account_id = a.account_id
ORDER BY t.transaction_id;


SELECT
    transaction_reference,
    transaction_type,
    transaction_amount,
    transaction_status,
    description,
    created_at
FROM bank_transactions
WHERE account_id = (
    SELECT account_id
    FROM bank_accounts
    WHERE account_number = 'MB1001'
)
ORDER BY transaction_id;

SELECT
    c.customer_name,
    a.account_number,
    a.account_type,
    a.balance,
    a.account_status
FROM bank_customers c
JOIN bank_accounts a
    ON c.customer_id = a.customer_id
ORDER BY a.account_number;