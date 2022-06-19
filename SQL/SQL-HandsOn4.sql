-- Part 1
CREATE VIEW initialCustomers AS
SELECT first_name, last_name, email
FROM customer
WHERE customer_id < 100;
#see view
SELECT * FROM initialCustomers;

-- PART 2
CREATE TABLE ProductList(
  ProductId INTEGER PRIMARY KEY auto_increment,
  ProductName NVARCHAR(100) NOT NULL,
  Price NUMERIC NOT NULL,
  DateAdded DATETIME DEFAULT current_timestamp,
  EmployeeSupportId INTEGER NOT NULL
  );
  
INSERT INTO ProductList
VALUES ("USB Drive", 12.99, 0001);

SELECT * FROM ProductList;