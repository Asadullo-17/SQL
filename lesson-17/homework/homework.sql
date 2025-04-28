--Lesson-17

--1-task
create table #MonthlySales( ProductID int, TotalQuantity int, TotalRevenue decimal(10,2))

insert into #MonthlySales (ProductID, TotalQuantity,TotalQuantity)
select s.ProductID,
		sum(s.Quantity) as TotalQuantity,
		sum(s.Quantity*p.Price) as TotalRevenue
from Sales s
join Products p
on s.ProductID=p.ProductID
where month(s.SaleDate)=month(getdate())
and year(s.Saledate)=year(getdate())
group by s.ProductID


--2-task
create view vw_ProductSalesSummary as
select p.ProductID,
		p.ProductName,
		p.Category,
		sum(s.Quantity) as TotalQuantitySold
from Products p
join Sales s
on p.ProductID=s.ProductID

group by p.ProductID,p.ProductName,p.Category

--3-task
create function fn_GetTotalRevenueForProduct(@ProductID int)
returns decimal(10,2)
as
begin 
declare @Total decimal(10,2)

select @Total=sum(s.Quantity*p.Price) 
from Sales s
join Products p
on s.ProductID=p.ProductID
where s.ProductID=@ProductID

return isnull(@ProductID,0)
end

select dbo.fn_GetTotalRevenueForProduct(1)

--4-task
create function fn_GetSalesByCategory(@Category varchar(50))
returns table
as
return (
select p.ProductName,
	sum(s.Quantity) as TotalQuantity,
	sum(s.Quantity*p.Price) as TotalRevenue
		

from Products p
join Sales s
on s.ProductID=p.ProductID
where p.Category=@Category
group by p.ProductName)

select * from dbo.fn_GetSalesByCategory('Groceries')

--5-task
CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS varchar(3)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @prime INT = 1;

    IF @Number < 2
        SET @prime = 0;
    ELSE
    BEGIN
        WHILE @i <= SQRT(@Number)
        BEGIN
            IF @Number % @i = 0
            BEGIN
                SET @prime = 0;
                BREAK;
            END
            SET @i = @i + 1;
        END
    END

    if @prime=1
	return 'Yes'
	else
	return 'No'
END

--6-task
create function fn_getnum(@start int, @end nt)
returns @numbers table (Numbers int)
as 
begin 
declare @current int = @start
 while @current<=@end
 begin
	insert into @numbers (Numbers) values(@current)
	set @current=@current +1
	end
	return
end

--7-task
CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS TABLE
AS
RETURN (
    SELECT
        CASE WHEN COUNT(*) >= @N THEN
            (SELECT salary 
             FROM (
                 SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
                 FROM Employee
             ) ranked
             WHERE rnk = @N)
        ELSE NULL
        END AS HighestNSalary
    FROM (
        SELECT DISTINCT salary
        FROM Employee
    ) AS distinct_salaries
);


--8-task
select top 1 id ,
count(*) as cnt from(
select  reqID as id from ReqAccept r
union all
select  accID as id from ReqAccept ) as all_f
group by id
order by cnt desc


--9-task
create view vw_CustomerOrderSummary as (
select c.customer_id ,
		c.name,
		 coalesce(count(o.order_id),0) as total_orders,
		 coalesce(sum(o.amount),0) as total_amount,
		 max(o.order_date) as last_order_date
from customers c
left join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.name)

--10-task
select RowNumber,
	max(Workflow) over ( order by RowNumber rows between unbounded preceding and current row) as Workflow,
	Status

from Gaps
