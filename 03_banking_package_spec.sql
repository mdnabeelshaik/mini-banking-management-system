
CREATE OR REPLACE PACKAGE banking_pkg AS

    FUNCTION get_balance(
        p_account_number IN VARCHAR2
    ) RETURN NUMBER;

    PROCEDURE deposit_money(
        p_account_number IN VARCHAR2,
        p_amount IN NUMBER
    );

    PROCEDURE withdraw_money(
        p_account_number IN VARCHAR2,
        p_amount IN NUMBER
    );

    PROCEDURE transfer_money(
        p_from_account IN VARCHAR2,
        p_to_account IN VARCHAR2,
        p_amount IN NUMBER
    );

END banking_pkg;
/
