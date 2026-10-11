

CREATE OR REPLACE PACKAGE BODY banking_pkg AS

    -- 1. Balance enquiry
    FUNCTION get_balance(
        p_account_number IN VARCHAR2
    ) RETURN NUMBER
    IS
        v_balance NUMBER(15,2);
    BEGIN
        SELECT balance
        INTO v_balance
        FROM bank_accounts
        WHERE account_number = p_account_number
          AND account_status = 'ACTIVE';

        RETURN v_balance;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                'Account not found or not active.'
            );
    END get_balance;


    -- 2. Deposit money
    PROCEDURE deposit_money(
        p_account_number IN VARCHAR2,
        p_amount IN NUMBER
    )
    IS
        v_account_id NUMBER;
    BEGIN
        SAVEPOINT deposit_start;

        IF p_amount IS NULL OR p_amount <= 0 THEN
            RAISE_APPLICATION_ERROR(
                -20002,
                'Deposit amount must be greater than zero.'
            );
        END IF;

        SELECT account_id
        INTO v_account_id
        FROM bank_accounts
        WHERE account_number = p_account_number
          AND account_status = 'ACTIVE'
        FOR UPDATE;

        UPDATE bank_accounts
        SET balance = balance + p_amount
        WHERE account_id = v_account_id;

        INSERT INTO bank_transactions (
            transaction_reference,
            account_id,
            transaction_type,
            transaction_amount,
            transaction_status,
            description
        )
        VALUES (
            'D-' || TO_CHAR(bank_txn_ref_seq.NEXTVAL),
            v_account_id,
            'DEPOSIT',
            p_amount,
            'SUCCESS',
            'Money deposited'
        );

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK TO deposit_start;
            RAISE;
    END deposit_money;


    -- 3. Withdraw money
    PROCEDURE withdraw_money(
        p_account_number IN VARCHAR2,
        p_amount IN NUMBER
    )
    IS
        v_account_id NUMBER;
        v_balance NUMBER(15,2);
    BEGIN
        SAVEPOINT withdrawal_start;

        IF p_amount IS NULL OR p_amount <= 0 THEN
            RAISE_APPLICATION_ERROR(
                -20003,
                'Withdrawal amount must be greater than zero.'
            );
        END IF;

        SELECT account_id, balance
        INTO v_account_id, v_balance
        FROM bank_accounts
        WHERE account_number = p_account_number
          AND account_status = 'ACTIVE'
        FOR UPDATE;

        IF v_balance < p_amount THEN
            RAISE_APPLICATION_ERROR(
                -20004,
                'Insufficient balance.'
            );
        END IF;

        UPDATE bank_accounts
        SET balance = balance - p_amount
        WHERE account_id = v_account_id;

        INSERT INTO bank_transactions (
            transaction_reference,
            account_id,
            transaction_type,
            transaction_amount,
            transaction_status,
            description
        )
        VALUES (
            'W-' || TO_CHAR(bank_txn_ref_seq.NEXTVAL),
            v_account_id,
            'WITHDRAWAL',
            p_amount,
            'SUCCESS',
            'Money withdrawn'
        );

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK TO withdrawal_start;
            RAISE;
    END withdraw_money;


    -- 4. Transfer money between accounts
    PROCEDURE transfer_money(
        p_from_account IN VARCHAR2,
        p_to_account IN VARCHAR2,
        p_amount IN NUMBER
    )
    IS
        v_from_id NUMBER;
        v_to_id NUMBER;
        v_from_balance NUMBER(15,2);
        v_reference VARCHAR2(30);
    BEGIN
        SAVEPOINT transfer_start;

        IF p_amount IS NULL OR p_amount <= 0 THEN
            RAISE_APPLICATION_ERROR(
                -20005,
                'Transfer amount must be greater than zero.'
            );
        END IF;

        IF p_from_account = p_to_account THEN
            RAISE_APPLICATION_ERROR(
                -20006,
                'Source and destination accounts must differ.'
            );
        END IF;

        SELECT account_id, balance
        INTO v_from_id, v_from_balance
        FROM bank_accounts
        WHERE account_number = p_from_account
          AND account_status = 'ACTIVE'
        FOR UPDATE;

        SELECT account_id
        INTO v_to_id
        FROM bank_accounts
        WHERE account_number = p_to_account
          AND account_status = 'ACTIVE'
        FOR UPDATE;

        IF v_from_balance < p_amount THEN
            RAISE_APPLICATION_ERROR(
                -20007,
                'Insufficient balance for transfer.'
            );
        END IF;

        v_reference :=
            'T-' || TO_CHAR(bank_txn_ref_seq.NEXTVAL);

        UPDATE bank_accounts
        SET balance = balance - p_amount
        WHERE account_id = v_from_id;

        UPDATE bank_accounts
        SET balance = balance + p_amount
        WHERE account_id = v_to_id;

        INSERT INTO bank_transactions (
            transaction_reference,
            account_id,
            transaction_type,
            transaction_amount,
            transaction_status,
            description
        )
        VALUES (
            v_reference,
            v_from_id,
            'TRANSFER',
            p_amount,
            'SUCCESS',
            'Transfer sent to ' || p_to_account
        );

        INSERT INTO bank_transactions (
            transaction_reference,
            account_id,
            transaction_type,
            transaction_amount,
            transaction_status,
            description
        )
        VALUES (
            v_reference || '-IN',
            v_to_id,
            'TRANSFER',
            p_amount,
            'SUCCESS',
            'Transfer received from ' || p_from_account
        );

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK TO transfer_start;
            RAISE;
    END transfer_money;

END banking_pkg;
/
