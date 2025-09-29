SHOW DATABASES;

USE classicmodels;

SHOW TABLES;

-- Q1. 

-- a.	Fetch the employee number, first name and last name of those employees who are working as Sales Rep reporting to employee with employeenumber 1102 (Refer employee table)

SELECT employeeNumber, firstName, lastName
FROM employees
WHERE jobTitle = 'Sales Rep'
  AND reportsTo = 1102;
  
-- b.	Show the unique productline values containing the word cars at the end from the products table.  

SELECT DISTINCT productLine
FROM products
WHERE productLine LIKE '%cars';

-- --------------------------------------------------------------------------------------------------------------------------------------
-- Q2
SELECT 
    customerNumber, 
    customerName,
    CASE 
        WHEN country IN ('USA', 'Canada') THEN 'North America'
        WHEN country IN ('UK', 'France', 'Germany') THEN 'Europe'
        ELSE 'Other'
    END AS CustomerSegment
FROM customers;

-- --------------------------------------------------------------------------------------------------------------------------------------
-- Q3

-- a.	

SELECT 
    productCode,
    SUM(quantityOrdered) AS totalQuantity
FROM orderdetails
GROUP BY productCode
ORDER BY totalQuantity DESC
LIMIT 10;

-- b.	

SELECT 
    MONTHNAME(paymentDate) AS MonthName,
    COUNT(*) AS TotalPayments
FROM payments
GROUP BY MONTHNAME(paymentDate)
HAVING COUNT(*) > 20
ORDER BY TotalPayments DESC;

-- --------------------------------------------------------------------------------------------------------------------------------------
-- Q4

CREATE DATABASE Customers_Orders;

USE Customers_Orders;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20)
);


CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT chk_total_amount CHECK (total_amount > 0)
);

SHOW TABLES;

DESC Customers;
DESC Orders;

-- ------------------------------------------------------------------------------------------------------------------------------
-- Q5

USE classicmodels;

SELECT 
    c.country,
    COUNT(o.orderNumber) AS totalOrders
FROM customers c
JOIN orders o 
    ON c.customerNumber = o.customerNumber
GROUP BY c.country
ORDER BY totalOrders DESC
LIMIT 5;

-- -----------------------------------------------------------------------------------------------------------------------------
-- Q6

USE classicmodels;

CREATE TABLE project (
  EmployeeID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  FullName   VARCHAR(50) NOT NULL,
  Gender     ENUM('Male','Female') NOT NULL,
  ManagerID  INT NULL
) ENGINE=InnoDB;

INSERT INTO project (EmployeeID, FullName, Gender, ManagerID) VALUES
(1, 'Pranaya', 'Male', 3),
(2, 'Priyanka','Female', 1),
(3, 'Preety',  'Female', NULL),
(4, 'Anurag',  'Male', 1),
(5, 'Sambit',  'Male', 1),
(6, 'Rajesh',  'Male', 3),
(7, 'Hina',    'Female', 3);

SELECT * FROM project ORDER BY EmployeeID;

SELECT
  mgr.FullName AS Manager_Name,
  emp.FullName AS Emp_Name
FROM project AS emp
JOIN project AS mgr
  ON emp.ManagerID = mgr.EmployeeID
ORDER BY mgr.FullName ASC, emp.EmployeeID ASC;

-- -------------------------------------------------------------------------------------------------------------------------------
-- Q7

USE classicmodels;

DROP TABLE IF EXISTS facility;

CREATE TABLE facility (
  Facility_ID INT,
  Name VARCHAR(100),
  State VARCHAR(100),
  Country VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DESCRIBE facility;

ALTER TABLE facility
  MODIFY Facility_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY;
  
ALTER TABLE facility
  ADD COLUMN City VARCHAR(100) NOT NULL AFTER Name;
  
DESCRIBE facility;
SHOW CREATE TABLE facility;

INSERT INTO facility (Name, City, State, Country)
VALUES
  ('Central Facility', 'Hyderabad', 'Telangana', 'India'),
  ('West Wing', 'Bengaluru', 'Karnataka', 'India');
  
SELECT * FROM facility;

-- ----------------------------------------------------------------------------------------------------------------------------
-- Q8

CREATE OR REPLACE VIEW product_category_sales AS
SELECT 
    pl.productLine,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS total_sales,
    COUNT(DISTINCT o.orderNumber) AS number_of_orders
FROM productlines pl
JOIN products p 
    ON pl.productLine = p.productLine
JOIN orderdetails od 
    ON p.productCode = od.productCode
JOIN orders o 
    ON od.orderNumber = o.orderNumber
GROUP BY pl.productLine
ORDER BY 
    CASE pl.productLine
        WHEN 'Classic Cars' THEN 1
        WHEN 'Motorcycles' THEN 2
        WHEN 'Planes' THEN 3
        WHEN 'Ships' THEN 4
        WHEN 'Trains' THEN 5
        WHEN 'Trucks and Buses' THEN 6
        WHEN 'Vintage Cars' THEN 7
        ELSE 8
    END;
    
SELECT * FROM product_category_sales;

-- ------------------------------------------------------------------------------------------------------------------------------------
-- Q9

DELIMITER $$

CREATE PROCEDURE Get_country_payments(
    IN input_year INT,
    IN input_country VARCHAR(50)
)
BEGIN
    SELECT 
        YEAR(p.paymentDate) AS Year,
        c.country AS Country,
        CONCAT(ROUND(SUM(p.amount)/1000, 0), 'K') AS Total_Amount
    FROM payments p
    JOIN customers c 
        ON p.customerNumber = c.customerNumber
    WHERE YEAR(p.paymentDate) = input_year
      AND c.country = input_country
    GROUP BY YEAR(p.paymentDate), c.country;
END$$

DELIMITER ;

CALL Get_country_payments(2003, 'France');

-- -------------------------------------------------------------------------------------------------------------------------------------
-- Q10

USE classicmodels;

SELECT
  c.customerName,
  COUNT(o.orderNumber) AS Order_count,
  DENSE_RANK() OVER (ORDER BY COUNT(o.orderNumber) DESC) AS order_frequency_rnk
FROM customers c
JOIN orders o
  ON c.customerNumber = o.customerNumber
GROUP BY c.customerName
ORDER BY Order_count DESC, c.customerName;

WITH monthly_orders AS (
  SELECT
    YEAR(orderDate) AS Year,
    MONTH(orderDate) AS MonthNum,
    MONTHNAME(orderDate) AS Month,
    COUNT(*) AS TotalOrders
  FROM orders
  GROUP BY YEAR(orderDate), MONTH(orderDate), MONTHNAME(orderDate)
),

with_lag AS (
  SELECT
    Year,
    Month,
    TotalOrders,
    LAG(TotalOrders) OVER (ORDER BY Year, MonthNum) AS PrevOrders
  FROM monthly_orders
  ORDER BY Year, MonthNum
)

SELECT
  Year,
  Month,
  TotalOrders AS `Total Orders`,
  CASE
    WHEN PrevOrders IS NULL THEN 'NULL'
    WHEN PrevOrders = 0 THEN 'NULL'
    ELSE CONCAT(ROUND(((TotalOrders - PrevOrders) / PrevOrders) * 100, 0), '%')
  END AS `% YoY Change`
FROM with_lag
ORDER BY Year, 
         FIELD(Month, 'January','February','March','April','May','June','July','August','September','October','November','December');
         
-- -------------------------------------------------------------------------------------------------------------------------------------
-- Q11

USE classicmodels;

SELECT 
    productLine,
    COUNT(*) AS Total
FROM products
WHERE buyPrice > (
    SELECT AVG(buyPrice) 
    FROM products
)
GROUP BY productLine
ORDER BY CASE productLine
    WHEN 'Classic Cars'     THEN 1
    WHEN 'Vintage Cars'     THEN 2
    WHEN 'Trucks and Buses' THEN 3
    WHEN 'Motorcycles'      THEN 4
    WHEN 'Planes'           THEN 5
    WHEN 'Ships'            THEN 6
    WHEN 'Trains'           THEN 7
END;

-- -----------------------------------------------------------------------------------------------------------------------------------
-- Q12

CREATE TABLE IF NOT EXISTS Emp_EH (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    EmailAddress VARCHAR(100)
);

CALL InsertEmp_EH(1, 'Abhi', 'abhi@example.com');

-- ------------------------------------------------------------------------------------------------------------------------------------
-- Q13

CREATE TABLE Emp_BIT (
    Name VARCHAR(50),
    Occupation VARCHAR(50),
    Working_date DATE,
    Working_hours INT
);

INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);


INSERT INTO Emp_BIT VALUES ('John', 'Developer', '2020-10-05', -8);

SELECT * FROM Emp_BIT;

-- ------------------------------------------------------------------------------------------------------------------------------
  
  
  
  
  
  