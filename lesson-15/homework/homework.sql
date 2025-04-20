
--LESSON-14

--EASY-LEVEL TASKS
--1-task
with NumbersCTE as (
	select 0 as num
	union all
	select num + 1
	from NumbersCTE
	where num<100)

select num from NumbersCTE

--2-task
with DoubledCTE as (
	select 1 as num
	union all
	select num*2
	from DoubledCTE
	where num<1000)

	select num from DoubledCTE

--3-task
select e1.EmployeeID,
	   e1.FirstName,
	   e1.LastName,
	   dt.Total
from Employees1 e1
join
(select EmployeeID,
	   sum(SalesAmount) as Total
from Sales
group by EmployeeID) dt
on e1.EmployeeID=dt.EmployeeID

--4-task


with AvgCTE as (
select avg(Salary) as AvgSalary from Employees1)

select AvgSalary from AvgCTE

--5-task
select ProductID,
		dt.MaxSale
from (select ProductID, max(SalesAmount) as MaxSale from Sales
group by ProductID) dt 

--6-task
WITH SalesCount AS (
    SELECT 
        EmployeeID,
        COUNT(*) AS SaleCount
    FROM Sales
    GROUP BY EmployeeID
)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    sc.SaleCount
FROM SalesCount sc
JOIN Employees1 e ON e.EmployeeID = sc.EmployeeID
WHERE sc.SaleCount > 5;

--7-task
with SalesCTE as (
select ProductID,
		sum(SalesAmount) as Total
from Sales
group by ProductID)

select ProductID, Total from SalesCTE
where Total >500

--8-task
with AvgSalaryCTE as (
select avg(Salary) as AvgSalary
from Employees1 e
)
select e.EmployeeID,
		e.FirstName,
		e.Lastname,
		e.Salary
from Employees1 e
join AvgSalaryCTE acte
on e.Salary> acte.AvgSalary

--9-task
select cast( ((dt.Total)/p.Price) as int) as qty from Products p
join
(select ProductID, sum(SalesAmount) as Total from Sales
group by ProductID) as dt
on dt.ProductID=p.ProductID

--10-task
with EmpCTE as (
select EmployeeID
from Sales 
where SalesAmount=0)

select e.EmployeeID,
		e.Firstname,
		e.LastName
from Employees1 e
join EmpCTE emp
on emp.EmployeeID=e.EmployeeID

--MEDIUM-LEVEL TASKS

--1-task
with factorial as (
select 1 as n, 1 as fact
union all
select n+1, (n+1)*fact
from factorial
where n<5 )

select * from factorial

--2-task
with fibonacci as (
select 0 as step,1 as fib1, 1 as fib2
union all
select step+1  ,fib2,fib1+fib2
from fibonacci
where step<10) 

select * from fibonacci

--3-task
WITH split_cte AS (
    -- Base case: first character
    SELECT 
        id,
        CAST(1 AS INT) AS pos,
        SUBSTRING(String,1,1) AS ch,
        String
    FROM Example

    UNION ALL

    -- Recursive case: move to next character
    SELECT 
        id,
        pos + 1,
        SUBSTRING(String, pos + 1, 1),
        string
    FROM split_cte
    WHERE pos < LEN(string)
)
SELECT id, pos, ch
FROM split_cte
ORDER BY id, pos

--4-task
with rankingCTE as (
select e.EmployeeID,
	   e.FirstName,
	   e.LastName,
	   sum(s.SalesAmount) as total
from Employees1 e
join Sales s 
on s.EmployeeID=e.EmployeeID
group by e.EmployeeID, e.FirstName,e.LastName
),
ranking as (
select EmployeeID,
		FirstName,
		LastName,
		total,
		rank() over( order by total desc) as SaleRank
from rankingCTE)

select EmployeeID, FirstName,LastName,SaleRank
from ranking
order by SaleRank

--5-task
SELECT top 5
    e.EmployeeID,
    ISNULL(s.sales_count, 0) AS qty
FROM Employees1 e
LEFT JOIN (
    SELECT 
        EmployeeID,
        COUNT(*) AS sales_count
    FROM Sales
    GROUP BY EmployeeID
) AS s ON e.EmployeeID = s.EmployeeID
ORDER BY qty DESC;

--6-task
WITH MonthlySales AS (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS Month,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
SalesWithDiff AS (
    SELECT 
        Month,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY Month) AS PrevMonthSales
    FROM MonthlySales
)
SELECT 
    Month,
    TotalSales,
    PrevMonthSales,
    TotalSales - ISNULL(PrevMonthSales, 0) AS SalesDifference
FROM SalesWithDiff
ORDER BY Month;

--7-task
select p.CategoryID,
		sum(sale.Total) as TotalC
from Products p
join
(select ProductID,
	   sum(SalesAmount) as Total
from Sales s
group by ProductID
) as sale
on sale.ProductID=p.ProductID
group by p.CategoryID

--8-task
with LastYearCTE as (
select ProductID,
		sum(s.SalesAmount) as TotalSale
from Sales s 
where s.SaleDate>=dateadd(year,-1,getdate())
group by ProductID),
RankingCTE as (
select p.ProductID,
		p.ProductName,
		ly.TotalSale,
		rank() over (order by ly.TotalSale desc) as SalesRank
from LastYearCTE ly
join Products p
on p.ProductID=ly.ProductID)

select * from RankingCTE
order by SalesRank

--9-task
SELECT 
    e.EmployeeID,
    e.FirstName,
    qtr.Year,
    qtr.Quarter,
    qtr.TotalSales
FROM Employees1 e
JOIN (
    SELECT 
        EmployeeID,
        YEAR(SaleDate) AS Year,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
    HAVING SUM(SalesAmount) > 5000
) AS qtr ON e.EmployeeID = qtr.EmployeeID
ORDER BY e.EmployeeID, qtr.Year, qtr.Quarter;

--10-task
SELECT TOP 3
    e.EmployeeID,
    e.FirstName,
    emp_sales.TotalSales
FROM Employees1 e
JOIN (
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -1, GETDATE())
    GROUP BY EmployeeID
) AS emp_sales ON e.EmployeeID = emp_sales.EmployeeID
ORDER BY emp_sales.TotalSales DESC;
