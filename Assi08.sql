=CREATE DATABASE IF NOT EXISTS assi89;
USE assi89;

CREATE TABLE Product (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    Date DATE,
    Quantity int,
    Revenue float
);

#how to add new col in existing table:
-- Step 1: Add new column
ALTER TABLE Product
ADD price FLOAT;

UPDATE Product
SET price = 20.00
WHERE id > 0;




ALTER TABLE Product
ALTER COLUMN Date SET DEFAULT (CURRENT_DATE);   #new thing!!

INSERT INTO Product (id, product_name, Quantity, Revenue )
VALUES 
(1, 'hello', 3, 20.00),
(2, 'world', 4, 30.00),
(3, 'yes', 5, 40.00),
(4, 'imran', 6, 50.00);

Select * from Product;

#Total sales by date:
Select Date, SUM(Revenue) as TotalSales 
From Product
Group by Date;

#which product has highest quantity

Select id, MAX(Quantity) as highest
From Product
Group by id
Order by highest desc
limit 1;

#Write a query that returns the product ID, total sales, average quantity sold, minimum price, and maximum price, grouped by ProductID.
Select id, SUM(Revenue), avg(Quantity), Min(Price), Max(Price)
From Product
group by id;



#Task 1: Monthly Sales Summary
#Create a monthly summary of total sales. Write a query that groups sales by month (you may need to use a function to extract the month from the SaleDate) and calculates the total revenue for each month. Submit the SQL query and a brief explanation of how the query works.

Select Month(Date) as Month, SUM(Revenue)
From Product
Group by Month
Order by Month;

#Write a query that provides the average sale price, total quantity sold, and the number of sales transactions for each product. 
Select avg(Price), SUM(Quantity), COUNT(id)
From Product
Group by id
Order by id;


#Identify the top three days with the highest total sales revenue. 
#Write a query that groups sales by date and orders the results by total revenue in descending order, 
#limiting the results to the top three days.

Select Date, SUM(Revenue) as total
From Product
Group by date
Order by total desc
Limit 3;
