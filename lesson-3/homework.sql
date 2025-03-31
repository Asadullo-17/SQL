--LESSON 3

--EASY-LEVEL TASKS

--1-task
--BULK INSERT is a SQL Server command used to efficiently import large volumes of data 
--from a text or CSV file into a database table. It is faster than row-by-row inserts 
--because it minimizes logging and optimizes the data load process

BULK INSERT your_table_name  
FROM 'C:\path\to\your\file.csv'  
WITH (
    FORMAT = 'CSV',  
    FIRSTROW = 2,  
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    TABLOCK
);

----2-task
--SQL Server supports importing data from various file formats. Four common ones are:

--CSV (Comma-Separated Values) – Used with BULK INSERT, OPENROWSET, or SSIS.

--JSON (JavaScript Object Notation) – Imported using OPENJSON or JSON_VALUE.

--XML (Extensible Markup Language) – Imported using OPENXML or XML data type methods.

--Excel (XLSX/XLS) – Imported using OPENROWSET, OPENDATASOURCE, or SSIS.

--3-task
create table Products (
ProductID int primary key,
ProductName varchar(50),
Price decimal(10,2))

--4-task
insert into Products values
(1, 'laptop',100),
(2,'phone',50),
(3,'tab',75)

--5-task
CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,  -- Must have a value
Email VARCHAR(100) NULL     -- Can be NULL (optional)
);

--6-task
create table Products (
ProductID int primary key,
ProductName varchar(50) unique,
Price decimal(10,2))

--7-task
-- Insert a new product into the Products table  
INSERT INTO Products (ProductID, ProductName, Category, Price, Quantity)  
VALUES (6, 'Smartwatch', 'Electronics', 199.99, 20);

--8-task
create table Categories(
CategoryID int primary key,
CategoryName varchar(50) unique)

--9-task
--The IDENTITY column in SQL Server is used to generate auto-incrementing numeric values for a table, typically as a primary key. It eliminates the need for manually inserting unique values.

CREATE TABLE Products (
    ProductID INT IDENTITY(1000,5) PRIMARY KEY,  
    ProductName VARCHAR(50),  
    Price DECIMAL(10,2)
);

--MEDIUM-LEVEL TASKS

--10-task
BULK INSERT Products  
FROM 'D:\MAAB LESSONS\customers.csv'  
WITH (
    FORMAT = 'CSV',  
    FIRSTROW = 2,  -- Skips header row  
    FIELDTERMINATOR = ',',  -- Comma-separated values  
    ROWTERMINATOR = '\n',  -- New line as row terminator  
    TABLOCK  -- Improves performance  
);

--11-task
ALTER TABLE Products
add CategoryID int
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)

--12-task
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,  -- Uniquely identifies each employee
    Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE  -- Ensures unique emails
);

--13-task
ALTER TABLE Products  
ADD CONSTRAINT chk_price CHECK (Price > 0);

--14-task
alter table Products
add Stock int not null
--alter table only allows columns to be added that can contain nulls, or default difinition specified

--15-task
select ProductID,ProductName, isnull(Price,0), isnull(CategoryID, 0) from Products

--16-task
--A FOREIGN KEY ensures referential integrity by enforcing a relationship between two tables. It prevents invalid data by ensuring that a value in one table must exist in another.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

--HARD-LEVEL TASKS

--17-task
create table Customers(
Age int check(Age>0))

--18-task
create table Customers(
Age int check(Age>0),
CategoryID int identity(100,10))

--19-task
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    PRIMARY KEY (OrderID, ProductID)  -- Composite Primary Key
);

--20-task
select OrderID,ProductID, coalesce(Quantity, 0), isnull(Price, 0.00) from OrderDetails

--21-task
create table Employees(
EmpID int primary key,
Email varchar(50) unique)

--22-task
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    OrderDate DATE,
    FOREIGN KEY (ProductID)  
    REFERENCES Products(ProductID)  
    ON DELETE CASCADE  
    ON UPDATE CASCADE
);

