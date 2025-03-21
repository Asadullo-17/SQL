--EASY-LEVEL TASKS
--1st task
select top 5 * from Employees
--2nd task
select distinct ProductName from Products
--3rd task
select * from Products
where Price > 100
--4th task
select * from Customers
where CustomerName like 'A%'
--5th task
select * from Products
order by Price asc
--6th task
select * from Employees
where Salary>=5000 and Department='HR'
--7th task
select isnull(Email, 'noemail@example.com') from Employees
--8th task
select * from Products
where Price between 50 and 100
--9th task
select distinct Category, ProductName from Products
--10th task
select * from Products
order by ProductName desc
---------------------------------------------------------------------------------------------------------
--MEDIUM-LEVEL TASKS
--11-th task
select top 10 * from Products
select ProductName, Price from Products
order by Price desc
--12 task
select * from Employees
select top 1 coalesce(FirstName, 'No FirstName') as FirstNonNullName, coalesce(LastName, 'No lastname') as LastNonNullName
from Employees 
where FirstName  is not null
--13 task	
select distinct Category, Price from Products
--14th task
select Age, DepartmentName 
from Employees 
where Age between 30 and 40  
   or (DepartmentName = 'Marketing')
--15th task
select Salary  from Employees
order by Salary desc
offset 10 rows
fetch next 10 rows only
--16th task
select Price,Stock from Products
where Price<=1000 and Stock>50
order by Stock asc
--17th task
select ProductName from Products
where ProductName like '%e%'
--18th task
select Department from Employees
where Department in('HR','IT','Finance')
--19th task
select * from Employees
where Salary>any(select avg(Salary) from Employees)
--20th task
select City, PostalCode from Customers
order by City asc, PostalCode desc
---------------------------------------------------------------------------------
--HARD-LEVEL TASKS
--21st task
select top 10 * from Sales
order by SalesAmount desc
--22nd task
select coalesce(FirstName, '')+ ' '+ coalesce(LastName, '') as FullName
--23rd name
select distinct Category,ProductName,Price  from Products
where Price > 50
--24th task
select * from Products
where Price between(select avg(Price)*0.9 from Products) 
and (select avg(Price)*1.1 from Products)
--25th task
select * from Employees
where Age < 30 and (Department='HR' or Department='IT')
--26th task
select * from Employees
where Email like '%@gmail.com'
--27th task
select * from Employees
where Salary > all ( select Sales from Employees where Department='Sales')
--28th task
select * from Employees
order by Salary desc
offset 0 rows 
fetch next 10 rows only
--29th task
select * from Orders
where Date between dateadd(day,-30, current_date) and current_date
--30th task
select * from Employees
where Salary > any ( select avg(Salary) from Employees)
