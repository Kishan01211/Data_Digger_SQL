1)table: Customer
create table Customers(CustomersID int PRIMARY KEY,Name varchar(30),Email varchar(50),Address varchar(255));
	1)
		Insert Records:

		INSERT into customers values(1,'Raj','raj@gmail.com','Ahemdabad'),
		(2,'Ravi','ravi@gmail.com','Bhavnagar'),
		(3, 'Priya', 'priya@gmail.com', 'Bhavnagar'),
		(4, 'Prem', 'prem@gmail.com', 'Rajkot'),
		(5, 'Alice', 'alice@gmail.com', 'Surat');
		
	2)Retraive all customers details.
		select *from customers;
		
	3)Updates Customers Address.
		UPDATE customers set Address="Gandhinagar" where CustomerID=1;
		
	4)Delete a customer using CustomerID.
		
		
	5)Display all Customer whose name is 'Alice'.
		SELECT * FROM Customers WHERE Name = 'Alice';

2)table: Orders
CREATE TABLE Orders(OrderID int PRIMARY KEY,CustomerID int,OrderDate date,TotalAmount decimal(10,2),FOREIGN KEY(CustomerID)REFERENCES customers(CustomerID));

	1)
		Insert Records:
			INSERT INTO Orders VALUES(1, 1, '2026-09-20', 2500.00),
			(2, 2, '2026-09-18', 1200.00),
			(3, 3, '2026-09-10', 3500.00),
			(4, 4, '2026-09-05', 1800.00),
			(5, 5, '2026-08-30', 900.00);
			
	2)Retrieve all orders made by a specific customers.
		SELECT * FROM Orders WHERE CustomerID = 1;
		
	3)update an order's total amount.
		update orders SET TotalAmount=2700 where OrderID=1;
	
	4)Delete an order using its OrderID.
		DELETE from orders where OrderID=5;
		
	5)Retrieve order placed in the last 30 days.
		SELECT * FROM Orders WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;
		
	6)Retrieve the highest, lowest, and average order amount using aggregate functions.
		select max(TotalAmount) as HighestOrder,MIN(TotalAmount) as LowestOrder,AVG(TotalAmount) as AverageOrder from orders;
	

3)table : Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);


	1)Insert at least 5 sample products into the Products table.
		INSERT INTO Products VALUES(1, 'Wireless Mouse', 800.00, 25),
			(2, 'Keyboard', 1200.00, 15),
			(3, 'Headphones', 1800.00, 10),
			(4, 'USB Cable', 500.00, 30),
			(5, 'Webcam', 2200.00, 0);

	2)Retrieve all products sorted by price in descending order.
		SELECT *from products ORDER BY price DESC;

	3)Update the price of a specific product.
		UPDATE Products SET Price = 1000 WHERE ProductID = 4;

	4)Delete a product if it's out of stock.
		Delete from products where ProductID=5 and Stock=0;
	
	5)Retrieve products whose price is between 2500 and ₹2000.
		select *from Products where price between 500 AND 2000;

	6)Retrieve the most expensive and cheapest product using MAX() and MIN()
		SELECT MAX(Price)as  MostExpensive FROM products;
		SELECT MIN(Price) AS Cheapest FROM Products;

4)OrderDetails
CREATE TABLE OrderDetails(OrderDetailID int PRIMARY  KEY,OrderId int,ProductID int,Quantity int,SubTotal decimal(10,2),
FOREIGN key(OrderID)REFERENCES orders(OrderID),
FOREIGN KEY (ProductID)REFERENCES products(ProductID));

	1)Insert at least 5 sample records into the OrderDetails table.
		INSERT INTO OrderDetails VALUES(1, 1, 1, 3, 2400.00),
			(2, 1, 2, 2, 2400.00),
			(3, 2, 3, 2, 3600.00),
			(4, 3, 1, 5, 4000.00),
			(5, 4, 4, 4, 2000.00);
		
	2)Retrieve all order details for a specific order.
		select *from OrderDetails where OrderID=2;

	3)Calculate the total revenue generated from all orders using SUM().
		select sum(SubTotal)as TotalRevenue from OrderDetails;

	4)Retrieve the top 3 most ordered products.
		SELECT ProductID, SUM(Quantity) AS TotalOrdered FROM OrderDetails GROUP BY ProductID ORDER BY TotalOrdered DESC LIMIT 3;

	5)Count how many times a specific product has been sold using COUNT().
		SELECT COUNT(*) AS TimesSold FROM OrderDetails WHERE ProductID = 1; 

