create database if not exists assi99;
use assi99;

create table student(
	stdname varchar(100),
    stdid int primary key,
    marks int
);

create table course (
	courseid int primary key,
    coursename varchar(100),
    instructor varchar(100)
);

insert into student (stdid, stdname, marks)
values
(1, 'imran', 100),
(2, 'asad', 120),
(3, 'hello', 99);

insert into course (courseid, coursename, instructor)
values
(1, 'dbms', 'hi'),
(2,'dccn','kese ho'),
(3,'ds', 'yaar');


#To update the table:
update course
set courseid=10
where courseid=3;

#entry of new row:
insert into course (courseid, coursename, instructor)
values
(1, 'new hai', 'pure');  #error bcz of PK


#Equii Join: 
Select student.stdid, stdname , course.courseid, coursename
from student
inner join course
on student.stdid = course.courseid;


#From lab:
SELECT Employees.Name, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;


#left join:
Select student.stdid, stdname , course.courseid, coursename
from student
left join course
on student.stdid = course.courseid;   #left wali side null nhi karega!


#right join:
Select student.stdid, stdname , course.courseid, coursename
from student
right join course
on student.stdid = course.courseid; #right wali null nhi karega 






#Lab Class Task:

#Tables: Suppliers, Products, Customer, Orders, Emoployees, Projects

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    ProjectID INT
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100)
);

INSERT INTO Suppliers VALUES
(1, 'Global Supplies'),
(2, 'TechSource'),
(3, 'Office Essentials');

INSERT INTO Products VALUES
(101, 'Printer', 1),
(102, 'Laptop', 2),
(103, 'Desk Chair', 3),
(104, 'Monitor', 2),
(105, 'Paper Ream', NULL);

INSERT INTO Customers VALUES
(201, 'Alice Johnson'),
(202, 'Bob Smith'),
(203, 'Charlie Lee');

INSERT INTO Orders VALUES
(301, 201, '2025-04-10', 500.00),
(302, 202, '2025-04-25', 300.00),
(303, 203, '2025-02-20', 150.00);

INSERT INTO Projects VALUES
(401, 'Website Redesign'),
(402, 'Mobile App'),
(403, 'Marketing Campaign');

INSERT INTO Employees VALUES
(501, 'Dana White', 401),
(502, 'Evan Black', NULL),
(503, 'Fiona Grey', 402);



#Queries:

#Use an equi join between Products and Suppliers tables to display product names and supplier names for products with available suppliers
Select Products.ProductID, ProductName, Suppliers.SupplierID, SupplierName
From Products
inner join Suppliers
on Products.SupplierID = Suppliers.SupplierID; #bcz product table is linked with supplier!!!


#Inner join: 
#Use an inner join between Orders and Customers tables to display customer names and 
#order details for all customers who placed orders in the last month. 
#Hint:: Add a date filter on the OrderDate column.

SELECT Customers.CustomerID, Customers.CustomerName, Orders.OrderID, Orders.OrderDate, Orders.TotalAmount
FROM Customers
INNER JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.OrderDate >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);


#Left Join for Unassigned Employees
#Use a left join between Employees and Projects to display employee names and project names, 
#including employees who are not assigned to any project. Hint:: Use ProjectID as the common column for joining.

select Employees.EmployeeName, Projects.ProjectName
from Employees
left join Projects
ON Employees.ProjectID = Projects.ProjectID;  #it means to check if employees project id matches ith project's project id! 

select Employees.EmployeeName, Projects.ProjectName
from Employees
 join Projects
ON Employees.ProjectID = Projects.ProjectID;  #only matches value!!!!



#Homes tasks:

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

-- Create Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    CourseID INT
);


INSERT INTO Courses VALUES
(1, 'Mathematics'),
(2, 'Physics'),
(3, 'Chemistry');

INSERT INTO Enrollments VALUES
(101, 'Alice', 1),
(102, 'Bob', 1),
(103, 'Charlie', 2);



#Task 4: Right Join for Courses without Students
#Use a right join between Courses and Enrollments to display course names 
#and student names, showing all courses even if no student is enrolled. Hint:: Join on CourseID.

select Courses.CourseName, Enrollments.StudentName
from Enrollments
right join Courses
on Courses.CourseID = Enrollments.CourseID;




#Task 5: Full Outer Join for Mismatched Rows


CREATE TABLE OrdersFull (
    OrderID INT PRIMARY KEY,
    OrderDate DATE
);


CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY,
    OrderID INT,
    ShipmentDate DATE
);


INSERT INTO OrdersFull VALUES
(1, '2025-05-01'),
(2, '2025-05-02'),
(3, '2025-05-03');

INSERT INTO Shipments VALUES
(201, 2, '2025-05-04'),
(202, 3, '2025-05-05'),
(203, 4, '2025-05-06'); -- No matching order


#Use a full outer join between Orders and Shipments to display all orders and shipment dates, 
#even if an order has no shipment or a shipment has no associated order. Hint:: Use OrderID as the joining column.


Select OrdersFull.OrderID, OrdersFull.OrderDate, Shipments.ShipmentID, Shipments.ShipmentDate
from OrdersFull
left join Shipments
on OrdersFull.OrderID = Shipments.OrderID
Union
Select OrdersFull.OrderID, OrdersFull.OrderDate, Shipments.ShipmentID, Shipments.ShipmentDate
from OrdersFull
right join Shipments
on OrdersFull.OrderID = Shipments.OrderID;



# Task 6: Equi Join with Aggregation


CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    Revenue DECIMAL(10,2)
);




CREATE TABLE Products1 (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100)
);


INSERT INTO Products1 VALUES
(101, 'Printer'),
(102, 'Laptop'),
(103, 'Monitor');


INSERT INTO Sales VALUES
(1, 101, 2, 200.00),
(2, 102, 1, 1000.00),
(3, 101, 1, 100.00),
(4, 103, 3, 450.00);


#Perform an equi join between Sales and Products tables to calculate the total sales 
#per product. Display product names and their total sales. Hint:: Use ProductID and the SUM function for aggregation.

SELECT Products1.ProductName, SUM(Sales.Revenue) AS TotalRevenue
FROM Products1
JOIN Sales ON Products1.ProductID = Sales.ProductID
GROUP BY Products1.ProductName;


















