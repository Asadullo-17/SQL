--LESSON 5 HOMETASKS
--EASY-LEVEL TASKS
use AdventureWorksDW2019
--1-task
select ProductName as Name from Products
--2-task
select * from Customers as Client
--3-task
select ProductName from Products
union
select ProductName from Products_Discontinued
 --4-task
 select * from Products
 intersect
 select * from Products_Discontinued
 --5-task
 select * from Products
 union all
 select * from Orders
 --6-task
 select distinct
 CustomerName, Country
 from Customers
 --7-task
 select Price
 case
 when Price>100 then 'High'
 when Price<=100 then 'Low' 
 end
 from Customers
 --8-task
 select Country, Department from Employees
 group by Country
 --9-task
 select Category, count(ProductID) as num_of_products
 from Products
 group by Category
 --10-task
 select Stock, iif(Stock>100,'Yes','No') as inStock 
 from Products
 --MEDIUM-LEVEL TASKS
 --11-task
 select Orders.OrderID, Cusotmers.CustomerID as ClientName, Orders.OrderDate
 from Orders
 inner join Customers on Orders.CustomerID=Customers.CustomerID
 --12-task
select ProductName from Products
union
select ProductName from OutOfStock
--13-task
select * from Products
except
select * from DiscontinuedProducts
--14-task
Select PlacedOrder
case
when PlacedOrder>5 then 'Eligible'
else 'Not Eligible' end
from Customers
--15-task
select Price, iif(Price>100,'Expensive','Affordable') as Condition
from Products
--16-task
select CustomerID, count(CustomerID) as Count from Orders
group by CustomerID
--17-task
select Salary,Age from Employees
group by Salary, Age
having Salary>6000, Age<25
--18-task
select Region, count(Region) as SalesAmount from Sales
group by Region
--19-task
select Customers.CustomerID,
	   Customers.CustomerName,
	   Orders.OrderID,
	   Orders.OrderDate as PlacedOrderDate
from Customers
left join Orders on Customers.CustomerID=Orders.OrdersID
--20-task
declare @Salary int
		@Department varchar(50)
if @Department= 'HR'
@Salary=@Salary*1.10
print(@Salary)
--HARD-LEVEL TASKS
--21-task
select ProductID,
	   sum(SalesAmount) as TotalSales,
	   sum(ReturnsAmount) as TotalReturns
from( select ProductID, SalesAmount, 0 as ReturnAmount
		  from Sales
		  union all
		  select ProductID, 0 as SalesAmount, ReturnsAmount
		  from Returns)
group by ProductID
--22-task
select ProductName from Products
intersect
select ProductName from Products_Discontiuned
--23-task
select TotalSales
case
when TotalSales>10000 then 'Top Tier'
when TotalSales between 5000 and 10000 then 'Mid Tier'
else 'Low Tier'
from Sales
--24-task
select 
    id, 
    position, 
    salary as old_salary, 
    case 
        when position = 'Manager' then salary * 1.10
        when position = 'Engineer' then salary * 1.05
        else salary * 1.03
    end as new_salary
from Employees
--25-task
select CustomerID from Customers
except
select  CustomerID from Invoice table
--26-task
select CustomerID, ProductID, 
		Region, sum(Sales) as TotalSales
from Orders
group by CustomerID,ProductID,Region
--27-task
select OrderID, ProductID, Quantity,
       case 
           when Quantity >= 100 then 0.20
           when Quantity >= 50 then 0.10 
           when Quantity >= 20 then 0.05 
           else
		   0.00                       
       end as Discount
from Orders
--28-task
select ProductID, ProductName, 'In Stock' as Status  
from Products  

union  

select ProductID, ProductName, 'Discontinued' as Status  
from DiscontinuedProducts
--29-task
select Stock,
iif (Stock=0, 'Out of Stock',iif(Stock>0,'Available','Unavailable') as StockStatus
from Sales
--30-task
select CustomerID from Customers

except

select CustomerID from VIP_Customers
