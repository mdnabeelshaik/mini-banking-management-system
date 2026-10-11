\# Mini Banking Management System



\## Project Overview



The Mini Banking Management System is a database project built using Oracle SQL and PL/SQL. It demonstrates basic banking operations, transaction processing, account balance management, and transaction reporting.



The project was developed to practise database programming, stored procedures, functions, exception handling, and transaction control.



\## Technologies Used



\- Oracle Database 21c XE

\- Oracle SQL

\- PL/SQL

\- SQL Developer

\- Git and GitHub



\## Features



\- \*\*Customer Management:\*\* Stores customer information and account relationships.

\- \*\*Account Management:\*\* Maintains account numbers, account types, statuses, and balances.

\- \*\*Deposit:\*\* Adds money to an account and records the transaction.

\- \*\*Withdrawal:\*\* Deducts money after validating the amount and available balance.

\- \*\*Fund Transfer:\*\* Transfers money between two accounts and records outgoing and incoming transactions.

\- \*\*Balance Enquiry:\*\* Uses a PL/SQL function to retrieve an account balance.

\- \*\*Transaction History:\*\* Displays transaction references, types, amounts, statuses, and descriptions.

\- \*\*Reports:\*\* Generates account balance and transaction reports.

\- \*\*Exception Handling:\*\* Rejects invalid transaction amounts and withdrawals exceeding the available balance.



\## Database Tables



| Table | Purpose |

|---|---|

| `BANK\_CUSTOMERS` | Stores customer information |

| `BANK\_ACCOUNTS` | Stores account details and balances |

| `BANK\_TRANSACTIONS` | Stores transaction history |



\## Project Structure



```text

mini-banking-management-system/

├── 01\_create\_tables.sql

├── 02\_insert\_sample\_data.sql

├── 03\_banking\_package\_spec.sql

├── 04\_banking\_package\_body.sql

├── 05\_test\_transactions.sql

├── 06\_reports.sql

└── README.md

```



\## PL/SQL Concepts Practised



\- Packages and package bodies

\- Stored procedures and functions

\- Explicit exception handling

\- Savepoints and rollback

\- Account row locking with `SELECT FOR UPDATE`

\- SQL joins and subqueries

\- Sequences for transaction references

\- Transaction control using `COMMIT`



\## Testing and Results



The following operations were tested:



\- Successful deposit

\- Successful withdrawal

\- Successful transfer between accounts

\- Balance enquiry

\- Transaction history and reports

\- Rejection of a withdrawal exceeding the available balance

\- Rejection of a transfer with a negative amount



The transfer test confirmed that the sender's balance decreased by the transfer amount and the receiver's balance increased by the same amount.



\## How to Run



1\. Open Oracle SQL Developer and connect to your Oracle database.

2\. Execute `01\_create\_tables.sql` in a clean project schema.

3\. Execute `02\_insert\_sample\_data.sql` once.

4\. Execute `03\_banking\_package\_spec.sql`.

5\. Execute `04\_banking\_package\_body.sql`.

6\. Execute individual tests from `05\_test\_transactions.sql`.

7\. Execute `06\_reports.sql` to view account and transaction reports.



\*\*Important:\*\* These scripts are designed for the project schema. If the tables already exist, do not rerun the table-creation script. Sample-data and transaction tests may also create duplicate data or change balances if executed repeatedly. Run each state-changing test only once unless you have reset the test database safely.



\## Learning Objective



This project demonstrates foundational Oracle SQL and PL/SQL skills relevant to database development, transaction processing, and core banking concepts.



\## Disclaimer



This is an educational project using sample data. It is not a production banking application and does not implement all the security, compliance, auditing, and reliability controls required by real banking systems.



