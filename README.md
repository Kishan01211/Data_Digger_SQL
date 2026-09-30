# Data Digger – SQL Project

## 📌 Project Overview

**Data Digger** is a beginner-level SQL database project designed to practice database creation, table relationships, CRUD operations, filtering, sorting, updating, deleting, and aggregate functions.

The project contains four related tables:

- `Customers`
- `Orders`
- `Products`
- `OrderDetails`

The project uses **MySQL** and can be executed using **XAMPP/phpMyAdmin**.

---

## 🗂️ Database Structure

### 1. Customers

Stores customer information.

| Column | Data Type | Key |
|---|---|---|
| CustomerID | INT | Primary Key |
| Name | VARCHAR(30) | |
| Email | VARCHAR(50) | |
| Address | VARCHAR(255) | |

### 2. Orders

Stores customer order information.

| Column | Data Type | Key |
|---|---|---|
| OrderID | INT | Primary Key |
| CustomerID | INT | Foreign Key |
| OrderDate | DATE | |
| TotalAmount | DECIMAL(10,2) | |

`CustomerID` references `Customers(CustomerID)`.

### 3. Products

Stores product and stock information.

| Column | Data Type | Key |
|---|---|---|
| ProductID | INT | Primary Key |
| ProductName | VARCHAR(100) | |
| Price | DECIMAL(10,2) | |
| Stock | INT | |

### 4. OrderDetails

Stores individual products included in orders.

| Column | Data Type | Key |
|---|---|---|
| OrderDetailID | INT | Primary Key |
| OrderID | INT | Foreign Key |
| ProductID | INT | Foreign Key |
| Quantity | INT | |
| SubTotal | DECIMAL(10,2) | |

`OrderID` references `Orders(OrderID)` and `ProductID` references `Products(ProductID)`.

---

# 🛠️ SQL Queries

## 1. Customers Table

### Create Table

```sql
CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(30),
    Email VARCHAR(50),
    Address VARCHAR(255)
);
```

### 1.1 Insert Records

```sql
INSERT INTO Customers VALUES
(1,'Raj','raj@gmail.com','Ahemdabad'),
(2,'Ravi','ravi@gmail.com','Bhavnagar'),
(3,'Priya','priya@gmail.com','Bhavnagar'),
(4,'Prem','prem@gmail.com','Rajkot'),
(5,'Alice','alice@gmail.com','Surat');
```

### 1.2 Retrieve All Customer Details

```sql
SELECT * FROM Customers;
```

### 1.3 Update Customer Address

```sql
UPDATE Customers
SET Address = 'Gandhinagar'
WHERE CustomerID = 1;
```

### 1.4 Delete a Customer Using CustomerID

```sql
DELETE FROM Customers
WHERE CustomerID = 5;
```

> Note: Execute this delete only when the customer has no related records in `Orders`, because of the foreign key relationship.

### 1.5 Display Customers Whose Name Is Alice

```sql
SELECT *
FROM Customers
WHERE Name = 'Alice';
```

---

# 2. Orders Table

### Create Table

```sql
CREATE TABLE Orders(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
);
```

### 2.1 Insert Records

```sql
INSERT INTO Orders VALUES
(1, 1, '2026-09-20', 2500.00),
(2, 2, '2026-09-18', 1200.00),
(3, 3, '2026-09-10', 3500.00),
(4, 4, '2026-09-05', 1800.00),
(5, 5, '2026-08-30', 900.00);
```

### 2.2 Retrieve Orders Made by a Specific Customer

```sql
SELECT *
FROM Orders
WHERE CustomerID = 1;
```

### 2.3 Update an Order's Total Amount

```sql
UPDATE Orders
SET TotalAmount = 2700
WHERE OrderID = 1;
```

### 2.4 Delete an Order Using OrderID

```sql
DELETE FROM Orders
WHERE OrderID = 5;
```

### 2.5 Retrieve Orders Placed in the Last 30 Days

```sql
SELECT *
FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;
```

### 2.6 Retrieve Highest, Lowest and Average Order Amount

```sql
SELECT
    MAX(TotalAmount) AS HighestOrder,
    MIN(TotalAmount) AS LowestOrder,
    AVG(TotalAmount) AS AverageOrder
FROM Orders;
```

---

# 3. Products Table

### Create Table

```sql
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);
```

### 3.1 Insert Sample Products

```sql
INSERT INTO Products VALUES
(1, 'Wireless Mouse', 800.00, 25),
(2, 'Keyboard', 1200.00, 15),
(3, 'Headphones', 1800.00, 10),
(4, 'USB Cable', 500.00, 30),
(5, 'Webcam', 2200.00, 0);
```

### 3.2 Retrieve Products Sorted by Price in Descending Order

```sql
SELECT *
FROM Products
ORDER BY Price DESC;
```

### 3.3 Update the Price of a Specific Product

```sql
UPDATE Products
SET Price = 1000
WHERE ProductID = 4;
```

### 3.4 Delete a Product if It Is Out of Stock

```sql
DELETE FROM Products
WHERE ProductID = 5
AND Stock = 0;
```

### 3.5 Retrieve Products Whose Price Is Between ₹500 and ₹2000

```sql
SELECT *
FROM Products
WHERE Price BETWEEN 500 AND 2000;
```

### 3.6 Retrieve the Most Expensive and Cheapest Product

```sql
SELECT MAX(Price) AS MostExpensive
FROM Products;

SELECT MIN(Price) AS Cheapest
FROM Products;
```

---

# 4. OrderDetails Table

### Create Table

```sql
CREATE TABLE OrderDetails(
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY(ProductID) REFERENCES Products(ProductID)
);
```

### 4.1 Insert Sample Records

```sql
INSERT INTO OrderDetails VALUES
(1, 1, 1, 3, 2400.00),
(2, 1, 2, 2, 2400.00),
(3, 2, 3, 2, 3600.00),
(4, 3, 1, 5, 4000.00),
(5, 4, 4, 4, 2000.00);
```

### 4.2 Retrieve All Order Details for a Specific Order

```sql
SELECT *
FROM OrderDetails
WHERE OrderID = 2;
```

### 4.3 Calculate Total Revenue Using SUM()

```sql
SELECT SUM(SubTotal) AS TotalRevenue
FROM OrderDetails;
```

### 4.4 Retrieve the Top 3 Most Ordered Products

```sql
SELECT
    ProductID,
    SUM(Quantity) AS TotalOrdered
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalOrdered DESC
LIMIT 3;
```

### 4.5 Count How Many Times a Specific Product Has Been Sold

```sql
SELECT COUNT(*) AS TimesSold
FROM OrderDetails
WHERE ProductID = 1;
```

---

# 🔗 Table Relationships

```text
Customers
    │
    │ CustomerID
    ▼
Orders
    │
    │ OrderID
    ▼
OrderDetails
    │
    │ ProductID
    ▼
Products
```

### Relationships

- `Customers.CustomerID` → `Orders.CustomerID`
- `Orders.OrderID` → `OrderDetails.OrderID`
- `Products.ProductID` → `OrderDetails.ProductID`

---

# 📚 SQL Concepts Practiced

This project demonstrates:

- Database creation
- Table creation
- Primary Keys
- Foreign Keys
- INSERT
- SELECT
- UPDATE
- DELETE
- WHERE
- ORDER BY
- BETWEEN
- Aggregate functions
  - `MAX()`
  - `MIN()`
  - `AVG()`
  - `SUM()`
  - `COUNT()`
- `GROUP BY`
- `LIMIT`
- Date filtering using `CURDATE()`
- Basic relational database design

---

# ⚠️ Execution Notes

Because foreign keys are used, delete operations should be performed carefully.

For example, a customer cannot be deleted while an order still references that customer.

Similarly, an order or product referenced by `OrderDetails` should not be deleted before its dependent `OrderDetails` records are handled.

---

## 👨‍💻 Project

**Project Name:** Data Digger  
**Database:** MySQL  
**Tools:** XAMPP / phpMyAdmin  
**Project Type:** SQL Database Project
