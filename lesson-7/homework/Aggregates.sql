--Lesson 7
use AdventureWorks2022
--EASY-LEVEL TASKS
--1-task
select min(Price) as minPrice from Products
--2-task
select max(Salary) as maxSalary from Employees
--3-task
select count(*) as num_of_rows from Customers
--4-task
select count(distinct Category) from Products
--5-task
select sum(Price) as TotalSales from Sales
where ProductName = 'Bike'
--6-task
select avg(Age) as avgAge from Employees
--7-task
select DepartmentName, count(*) from Employees
group by DepartmentName
--8-task
select Category,
		min(Price) as minPrice,
	   max(Price) as maxPrice
from Products
--9-task
select Region, sum(Sales) as sumSales
from Sales
group by Region
--10-task
select * from Employees
group by DepartmentName
having EmployeeNumber>5
--MEDIUM-LEVEL TASKS
--11-task
select sum(distinct Category) as sumProduct,
	   avg(distinct Category) as avgCategory
from Sales
--12-task
select JobTitle, count(JobTitle) as cntJobTitle
from Employees
--13-task
select min(Salary) as minSalary,
	   max(Salary) as maxSalary
from Employees
--14-task
select Department, avg(Salary) as avgSalary
from Employees
group by Department
--15-task
select Department, avg(Salary) as avgSalary, count(*) 
from Employees
group by Department
--16-task
select ProductName, avg(Price) as avgPrice
from Products
group by ProductName
having avg(Price)>100
--17-task
select count(distinct ProductID) as num_of_units
from Products
group by ProductID
having count(ProductID)>100
--18-task
select Date, sum(Sales) as TotalSales
from Sales
group by Date
--19-task
select Region, count(CustomerID) as CountCustomers from Employees
group by Region
--20-task
--HARD-LEVEL TASKS
--21-task
select Category, avg(Sales) as avgSales 
from Sales
group by Category
having avg(Sales)>200
--22-task
select EmployeeID, sum(Sales) as TotalSales 
from Employees
group by EmployeeID
having sum(Sales)>5000
--23-task
select Department, sum(Salary) as TotalSalary,
avg(Salary) as avgSalary from Employees
group by Department
having avg(Salary)>6000
--24-task
select CustomerID, max(orderValue) as max_orderValue,
min(orderValue) as min_orderValue
from Customers
group by CustomerID
having min(orderValue)>=50
--25-task
select Region, sum(Sales) as TotalSales,
		count( distinct ProductID) as ProductsSold
from Orders
group by Region
having count(distinct ProductID)>10
--26-task
select ProductCategory, min(SoldProducts) as minQty,
					max(SoldProducts) as maxQty
from Sales
group by ProductCategory
--27-task
--28-task
--29-task
select ProductCategory, count(OrderID) as OrdersCount
from Orders
group by ProductCategory
having count(OrderID)>50
--30-task
