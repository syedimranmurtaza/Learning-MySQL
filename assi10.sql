
CREATE DATABASE company_db;
USE company_db;


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);


CREATE TABLE Salaries (
    SalaryID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);


INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Marketing');


INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID)
VALUES
(101, 'Alice', 1),
(102, 'Bob', 2),
(103, 'Charlie', 2),
(104, 'Diana', 3);


INSERT INTO Salaries (EmployeeID, DepartmentID, Salary)
VALUES
(101, 1, 50000),
(102, 2, 70000),
(103, 2, 80000),
(104, 3, 60000);

-- Final Query to display Employee info and average salary by department

SELECT
	E.EmployeeID,
    E.EmployeeName,
    E.DepartmentName,
    (Select Avg(Salary)
    from Salaries
    Group by 
From Employee E
Join Department D 
on E.EmployeeID = D.EmployeeID





SELECT 
    E.EmployeeID, 
    E.EmployeeName, 
    D.DepartmentName, 
    (SELECT AVG(Salary) 
     FROM Salaries 
     WHERE DepartmentID = E.DepartmentID) AS AvgSalary
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- Employees(EmployeeID, EmployeeName, DepartmentID)
-- Departments(DepartmentID, DepartmentName)
-- Write a query to list all employees along with their department names.
Select E.EmployeeID, E.EmployeeName, E.DepartmentID
from Employee E
Join Department D
on E.DepartmentID = D.DepartmentID



-- Students(StudentID, StudentName, ClassID)
-- Classes(ClassID, ClassName)
-- Get the names of all students who are in the class named 'Computer Science'
SELECT S.StudentID, S.StudentName, C.ClassName
FROM Students S
JOIN Classes C ON S.ClassID = C.ClassID
WHERE C.ClassName = 'Computer Science';



--  Q3. JOIN Three Tables
-- Tables:
-- Orders(OrderID, CustomerID)
-- Customers(CustomerID, CustomerNme)
-- Products(ProductID, ProductName)
-- OrderDetails(OrderID, ProductID, Quantity)
-- ❓Question:
-- List all orders with:
-- Customer name
-- Product name
-- Quantity ordered

Select O.OrderID, C.CustomerName, P.ProductName, D.Quantity
From OrderDetails D
Join Orders O on D.OrderID = O.OrderID
Join Customers C on O.CustomerID = C.CustomerID
Join Products P on D.ProductID = P.ProductID






-- Q4. LEFT JOIN
-- Tables:
-- Employees(EmployeeID, EmployeeName, ManagerID)
-- Managers(ManagerID, ManagerName)
-- ❓ Question:
-- Show all employees and their manager names.
-- Also show employees who do not have a manager (use LEFT JOIN).


select E.EmployeeName, M.ManagerName
from Employees E
left join Managers M
on E.ManagerID = M.ManagerID


--  Q5. Aggregation with JOIN
-- Tables:
-- Salaries(EmployeeID, Salary)
-- Departments(DepartmentID, DepartmentName)
-- Employees(EmployeeID, DepartmentID)
-- ❓ Question:
-- Show each department's name along with the average salary of its employees.

select D.DepartmentName, avg(Salary)
from Departments D
join Employees E on E.DepartmentID = D.DepartmentID 
join Salaries S on S.EmployeeID = E.EmployeeID


 -- Q6. Filtered JOIN
-- Tables:
-- Books(BookID, Title, AuthorID)
-- Authors(AuthorID, AuthorName)
-- ❓ Question:
-- Get the titles of all books written by 'Ali Khan'.

select B.Title
from Books B
join Authors A on B.AuthorID = A.AuthorID
where AuthorName = 'Ali Khan'


-- 🔹 Q7. JOIN with DISTINCT
-- Tables:
-- Enrollments(StudentID, CourseID)
-- Courses(CourseID, CourseName)
-- ❓ Question:
-- List all unique course names in which students are enrolled.

select C.CourseName Distinct
from Courses C
join Enrollments E on E.CourseID = C.CourseID;





-- Sub Queries::::::::
--  Q1. Highest Salary
-- Table:
-- Employees(EmployeeID, EmployeeName, Salary)
-- ❓ Question:
-- Find the name(s) of employee(s) who have the highest salary.

select EmployeeName
from Employees
where Salary > (Select max(Salary) from Employees)



-- Students(StudentID, StudentName)
-- Enrollments(StudentID, CourseID)
-- ❓ Question:
-- Get the names of all students who are not enrolled in any course.

select StudentName 
from Students
where StudentID not in (Select StudentID from Enrollments);


-- 🔹 Q3. Products Above Average Price
-- Products(ProductID, ProductName, Price)
-- List all product names whose price is greater than the average product price.

select ProductNames 
from Products 
where Price > (Select avg(Price) from Products);


-- 🔹 Q4. Employees in 'Marketing' Department (Use Subquery)
-- Tables:
-- Employees(EmployeeID, EmployeeName, DepartmentID)
-- Departments(DepartmentID, DepartmentName)
-- Get the names of employees who work in the 'Marketing' department (using a subquery instead of JOIN).

select EmployeeName
from Employees
where DepartmentID = (Select DepartmentID from Department where DepartmentName = 'Marketing');


--  Correlated Subquery: Department-wise Salary Avg
-- Employees(EmployeeID, EmployeeName, Salary, DepartmentID)
-- ❓ Question:
-- List each employee's name along with the average salary of their own department.


Select EmployeeName, (Select avg(Salary) from Employees)
from Employees;







-- LETS START WITH LAB QUETSIONS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- Find employees whose DepartmentID matches the department of "Sales
select employeesName
from Employees
where DepartmentID = (Select DepertmentID from Department where DepartmentName = 'Sales');


-- Find employees and their department names along with the average salary in that department. 
select E.EmployeeID, E.EmployeeName, D.DepartmentName, (Select AVG(Salary) from department where E.DepartmentID = D.DepartmentID)
from Employees E
Join Departments D on E.DepartmentID = D.DepartmentID



-- Find departments with an average salary greater than 50,000. 
SELECT D.DepartmentID, D.DepartmentName
FROM Departments D
JOIN Employees E ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentID, D.DepartmentName
HAVING AVG(E.Salary) > 50000;


-- Find employees whose salary is greater than the average salary in their department.
select E.EmployeeName, Salary, DepartmentID
from Employee E
where E.Salary > (Select AVG(Salary)
					from Employees
                    where Department = E.DepartmentID);
                    
                    
SELECT EmployeeID, EmployeeName
FROM Employees
WHERE DepartmentID IN (
    SELECT DepartmentID 
    FROM Departments 
    WHERE DepartmentName IN ('HR', 'Sales')
);



-- : Find departments that have at least one employee.
SELECT DepartmentName
FROM Departments D
WHERE EXISTS (
    SELECT 1
    FROM Employees E
    WHERE E.DepartmentID = D.DepartmentID
);





create table Students(
	StudentID int primary key,
    StudentName varchar(100),
    CourseID int,
    Marks float,
    foreign key(CourseID) references Courses(CourseID)
    );
    
create table Courses(
	CourseID int primary key,
    CourseName varchar(100)
    );

insert into Students (StudentID, CourseID, StudentName, Marks)
values
(1, 1, 'Imran', 12),
(2, 1, 'Asad', 100),
(3, 2, 'Mairaj', 133),
(4,3, 'Saqlain', 232);

insert into Courses (CourseID, CourseName)
values
(1, 'SST'),
(2, 'PST'),
(3,'Hello');



-- Queries::::
-- Write a query to retrieve all records from a table where a certain column value matches a value returned by another query. 
-- The subquery should return a single value that is used to filter the main query’s results. 




