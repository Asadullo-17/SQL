--Lesson 2
--BASIC-LEVEL TASKS
--1-task
create table Employees(
EmpID int,
[Name] varchar(50),
Salary decimal(10,2))
--2-task
--single-row insert
insert into Employees(EmpID,Name, Salary) values (1, 'John', 10000)
--multiple-row insert
insert into Employees values
(5,'Michael',80000,'Economics'),
(6,'Sofia', 40000, 'HR'),
(2,'Mark',20000, 'HR'),
(3,'Alex',50000, 'Marketing'),
(4,'Tim', 40000,'Sales')
--3-task
update Employees
set Salary=12000
where EmpID=1
--4-task
delete from Employees
where EmpID=2
--5-task
--DELETE-deletes informations where EmpID =1 and keeps the rest
delete from Employees
where EmpID=1

--TRUNCATE-deletes all informations in the table, but keeps the structure
truncate table Employees

--DROP- deletes all information in tha table
drop table Employees

--6-task
alter table Employees
add column Name varchar(100)

--7-task
alter table Employees
add Department varchar(50)

--8-task
alter table Employees
alter column Salary float

--9-task
create table Departments ( 
DepartmentID int primary key,
DepartmentName varchar(50))

--10-task
truncate table Employees

--INTERMEDIATE-LEVEL TASKS
--11-task
insert into Departments values
(100, 'Marketing'),
(101, 'HR')

select * from Employees

insert into Departments(DepartmentID, DepartmentName)
select distinct EmpID, Department
from Employees

--12-task
update Employees
set Department='Management'
where Salary>5000

--13-task
truncate table Employees

--14-task
alter table Employees
drop column Department

--15-task
alter table Employees
rename table Employees to StaffMembers
--2nd way
exec sp_rename 'Employees','StaffMembers';

--16-task
drop table Departments

--ADVANCED-LEVEL TASKS

--17-task
create table Products (
ProductID int primary key,
ProductName varchar(50),
Category varchar(50),
Price decimal(10,2),
Quantity int)

--18-task
create table Products (
ProductID int primary key,
ProductName varchar(50),
Category varchar(50),
Price int decimal(10,2) check (Price>0),
Quantity int)

--19-task
alter table Products
add StockQuantity int default 50

--20- task
alter table Products
rename column category to ProductCategory

--2nd way
exec sp_rename 'Products.Category','ProductCategory', 'COLUMN';

--21-task
insert into Products values
(1, 'Laptop', 'Electronics', 999.99, 10),
(2, 'Smartphone', 'Electronics', 699.99, 25),
(3, 'Table', 'Furniture', 149.99, 15),
(4, 'Chair', 'Furniture', 89.99, 30),
(5, 'Headphones', 'Accessories', 59.99, 50);

--22-task
select * into Ptoducts_backup
from Products
 
--23-task
exec sp_rename 'Products','Inventory';

--24-task
alter table Inventory
alter column Price float

--25-task
alter table Products
add ProductCode int identity(1000,5)
