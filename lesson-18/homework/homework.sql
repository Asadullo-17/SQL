CREATE TABLE Employees ( id INT PRIMARY KEY, name VARCHAR(100), salary DECIMAL(10, 2) );

INSERT INTO Employees (id, name, salary) VALUES (1, 'Alice', 50000), (2, 'Bob', 60000), (3, 'Charlie', 50000);

select * from Employees

--Level-1

--1-task
select * from Employees
where salary= (select min(salary) as MinSalary from Employees)

--2-task
select * from Products
where price> (select avg(price) from Products)

--Level-2

--3-task
select e.id, e.name, d.department_name,d.id as department_id from Employees e
join departments d
on e.DEPARTMENT_ID=d.id
where department_name='Sales'

--4-task
select distinct c.customer_id,c.name from orders o
join Customers c
on o.Customer_id!=c.customer_id

--5-task
select * from Products p
where price=( 
	select max(price) from Products
	where category_id=p.category_id)
order by  category_id

--6-task
select * from Employees e
join departments d
on d.id=e.department_id
where salary>=(
select avg(salary) from employees) 

--Level-4

--7-task
select * from employees e
where salary>=(
	select avg(salary) from employees e1
	where e1.department_id=e.department_id	)

--8-task
select s.student_id,s.name,g.grade,g.course_id from students s
inner join grades g
on s.student_id=g.student_id
where grade=(
	select max(grade) from grades g1
	where g1.course_id=g.course_id) 
order by course_id 

--Level-5

--9-task
select id, product_name, price, category_id,rank
from (select *,
		dense_rank() over(partition by category_id order by price desc) as rank
		from products) ranked

where rank=3 

--10-task
select * from employees e
where salary>(
select avg(salary) from employees) and
salary<(
select max(salary) from employees e1
where e.department_id=e1.department_id)
