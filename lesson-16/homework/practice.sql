--Lesson-16

--1-task
with ExpandedCTE as (
select Product,1 as Quantity
from Grouped
where Quantity>0
union all
select e.Product, e.Quantity+1
from Grouped g
join ExpandedCTE e
on e.Product=g.Product
where e.Quantity<g.Quantity)

select Product,1 as Quantity
from ExpandedCTE
order by Product

--2-task
with ComboCTE as (
select r.Region, d.Distributor from 
(select distinct Region from #RegionSales) as r
cross join 
(select distinct Distributor from #RegionSales) as d)
select c.Region,
		c.Distributor,
		isnull(rs.Sales,0) as Sales
from ComboCTE as c
left join #RegionSales as rs 
on rs.Distributor=c.Distributor and rs.Region=c.Region
order by c.Distributor,case c.region
when 'North' then 1
when 'South' then 2
when 'East' then 3
when 'West' then 4
else 5 end 

--3-task
select e.name 
from Employee e
join Employee r 
on e.id= r.managerId
group by e.id,e.name
having count(*)>=5

--4-task
select p.product_name ,
			sum(unit) as unit
from orders o
join products p 
on p.product_id=o.product_id
where month(o.order_date)=2
group by product_name
order by unit desc

--5-task
WITH VendorCounts AS (
  SELECT CustomerID, Vendor, COUNT(*) AS OrderCount
  FROM Orders
  GROUP BY CustomerID, Vendor
 
)

SELECT vc.CustomerID, vc.Vendor
FROM VendorCounts vc
JOIN (
  SELECT CustomerID, MAX(OrderCount) AS MaxCount
  FROM  VendorCounts
  GROUP BY CustomerID
) maxvc
  ON vc.CustomerID = maxvc.CustomerID
 AND vc.OrderCount = maxvc.MaxCount

 order by CustomerID

--6-task
declare @num int=91
declare @i int =2
declare @prime int =1

while @i<=sqrt(@num)
begin 
	if @num%@i=0
	begin
		set @prime=0
		break
	end
	set @i=@i+1
end
select case
when @prime=1 then 
	'the number is prime' 
else 'the number is not prime'
end as result

--7-task
with LocationCountCTE as (
select Device_id,
		locations,
		count(*) as loc_count
from Device
group by Device_id, Locations),
RankLocCTE as (
select *,
	row_number() over ( partition by device_id order by locations) as num_row
from LocationCountCTE),
DeviceSumCTE as (
select device_id,
		count(distinct locations) as num_of_loc,
		sum(loc_count) as num_of_sig
from LocationCountCTE
group by device_id)

select dcte.device_id,
		dcte.num_of_loc,
		rcte.Locations,
		dcte.num_of_sig
		

from DeviceSumCTE as dcte
join RankLocCTE as rcte
on dcte.device_id=rcte.device_id
and num_row=1

--8-task
with avgSalCTE as(
select deptId,
avg(Salary) as avg_sal
from Employee
group by DeptID)

select e.EmpID,
		e.EmpName,
		e.Salary
from avgSalCTE avg
join Employee e
on e.DeptID=avg.deptId
where e.salary>=avg.avg_sal
order by EmpId

--9-task

with matching as (
select t.TicketID,
		count(*) as fixed
		from number n
inner join tickets t
on n.Number=t.Number
group by t.TicketID )

select Sum(
case when fixed=3 then 100
		when fixed>0 then 10
		else 0
end) totalWin
from matching

--10-task
WITH user_platforms AS (
    SELECT 
        Spend_date,
        User_id,
        SUM(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS is_mobile,
        SUM(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS is_desktop,
        SUM(Amount) AS total_amount
    FROM Spending
    GROUP BY Spend_date, User_id
)
SELECT
    Spend_date,
    Platform,
    SUM(total_amount) AS Total_Amount,
    COUNT(*) AS Total_users
FROM (
    SELECT 
        Spend_date,
        CASE 
            WHEN is_mobile = 1 AND is_desktop = 1 THEN 'Both'
            WHEN is_mobile = 1 THEN 'Mobile'
            WHEN is_desktop = 1 THEN 'Desktop'
        END AS Platform,
        total_amount
    FROM user_platforms
) t
GROUP BY Spend_date, Platform
ORDER BY Spend_date, 
    CASE Platform
        WHEN 'Mobile' THEN 1
        WHEN 'Desktop' THEN 2
        WHEN 'Both' THEN 3
    END;
