-- Check balance before withdrawal
SELECT account_number, balance
FROM bank_accounts
WHERE account_number = 'MB1001';

-- Withdraw 1000
BEGIN
    banking_pkg.withdraw_money('MB1001', 1000);
END;
/

-- Commit the withdrawal
COMMIT;

-- Check balance after withdrawal
SELECT account_number, balance
FROM bank_accounts
WHERE account_number = 'MB1001';