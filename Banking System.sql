CREATE DATABASE BankingSystem;
USE BankingSystem;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    phone VARCHAR(15),
    email VARCHAR(100),
    city VARCHAR(50),
    date_of_birth DATE
);
desc Customers;
INSERT INTO Customers VALUES
(1, 'Rahul', '9876500001', 'rahul@gmail.com', 'Hyderabad', '1999-05-12'),
(2, 'Priya', '9876500002', 'priya@gmail.com', 'Warangal', '1997-08-20'),
(3, 'Arjun', '9876500003', 'arjun@gmail.com', 'Hyderabad', '2000-02-15'),
(4, 'Sneha', '9876500004', 'sneha@gmail.com', 'Karimnagar', '1996-11-10'),
(5, 'Kiran', '9876500005', 'kiran@gmail.com', 'Hyderabad', '2001-07-25');

SELECT * FROM Customers;

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
desc Accounts;

INSERT INTO Accounts VALUES
(101, 1, 'Savings', 60000),
(102, 2, 'Current', 90000),
(103, 3, 'Savings', 40000),
(104, 4, 'Current', 120000),
(105, 5, 'Savings', 75000),
(106, 1, 'Current', 30000);

select * from Accounts;


CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    amount DECIMAL(12,2),
    transaction_type VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
desc Transactions;
INSERT INTO Transactions VALUES
(1001, 101, 5000, 'Credit'),
(1002, 102, 2000, 'Debit'),
(1003, 103, 8000, 'Credit'),
(1004, 104, 3000, 'Debit'),
(1005, 105, 10000, 'Credit'),
(1006, 106, 1500, 'Credit');

select * from Transactions;

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    designation VARCHAR(50),
    salary DECIMAL(10,2),
    branch_id INT
);
desc Employees;
INSERT INTO Employees VALUES
(201, 'Ramesh', 'Manager', 55000, 1),
(202, 'Suresh', 'Cashier', 30000, 2),
(203, 'Anita', 'Accountant', 45000, 1),
(204, 'Divya', 'Clerk', 35000, 3),
(205, 'Vikram', 'Manager', 60000, 2);

select * from Employees;

CREATE TABLE Branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(50),
    location VARCHAR(50)
);
desc Branches;
INSERT INTO Branches VALUES
(1, 'Main Branch', 'Hyderabad'),
(2, 'City Branch', 'Warangal'),
(3, 'Central Branch', 'Karimnagar');

select * from Branches;

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(30),
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
desc Loans;
INSERT INTO Loans VALUES
(301, 1, 'Home Loan', 500000, 8.50),
(302, 2, 'Personal Loan', 100000, 11.00),
(303, 3, 'Car Loan', 300000, 9.25),
(304, 4, 'Education Loan', 200000, 7.50),
(305, 5, 'Personal Loan', 80000, 12.00);

select * from Loans;


# 1. Display all records from the Customers table
SELECT * FROM Customers;

# 2. Display customer name, phone number, and email
SELECT name, phone, email
FROM Customers;

# 3. Display customers from Hyderabad
SELECT *
FROM Customers
WHERE city = 'Hyderabad';

# 4. Display all Savings accounts
SELECT *
FROM Accounts
WHERE account_type = 'Savings';

# 5. Display accounts with a balance greater than ₹50,000
SELECT *
FROM Accounts
WHERE balance > 50000;

# 6. Display all credit transactions
SELECT *
FROM Transactions
WHERE transaction_type = 'Credit';

# 7. Display employees with salary greater than ₹40,000
SELECT *
FROM Employees
WHERE salary > 40000;

# 8. Display customers born after January 1, 1998
SELECT *
FROM Customers
WHERE date_of_birth > '1998-01-01';

# 9. Display accounts in descending order of balance
SELECT *
FROM Accounts
ORDER BY balance DESC;

# 10. Find the total number of customers
SELECT COUNT(*) AS total_customers
FROM Customers;

# 11. Find the total balance of all accounts
SELECT SUM(balance) AS total_balance
FROM Accounts;

# 12. Find the average account balance
SELECT AVG(balance) AS average_balance
FROM Accounts;

# 13. Find the highest and lowest account balance
SELECT
    MAX(balance) AS highest_balance,
    MIN(balance) AS lowest_balance
FROM Accounts;

# 14. Count the accounts for each account type
SELECT account_type, COUNT(*) AS total_accounts
FROM Accounts
GROUP BY account_type;

# 15. Display account types whose total balance exceeds ₹80,000
SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type
HAVING SUM(balance) > 80000;

# 16. Display customer name, account ID, account type, and balance
SELECT
    c.name,
    a.account_id,
    a.account_type,
    a.balance
FROM Customers c
INNER JOIN Accounts a
    ON c.customer_id = a.customer_id;
    
# 17. Display customer name, transaction ID, amount, and transaction type
SELECT
    c.name,
    t.transaction_id,
    t.amount,
    t.transaction_type
FROM Customers c
INNER JOIN Accounts a
    ON c.customer_id = a.customer_id
INNER JOIN Transactions t
    ON a.account_id = t.account_id;
    
# 18. Display customer name, loan type, loan amount, and interest rate
SELECT
    c.name,
    l.loan_type,
    l.loan_amount,
    l.interest_rate
FROM Customers c
INNER JOIN Loans l
    ON c.customer_id = l.customer_id;
    
# 19. Display employee name, designation, branch name, and location
SELECT
    e.employee_name,
    e.designation,
    b.branch_name,
    b.location
FROM Employees e
INNER JOIN Branches b
    ON e.branch_id = b.branch_id;

# 20. Display customers whose account balance is greater than the average balance
SELECT DISTINCT c.name
FROM Customers c
INNER JOIN Accounts a
    ON c.customer_id = a.customer_id
WHERE a.balance > (
    SELECT AVG(balance)
    FROM Accounts
);