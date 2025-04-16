--LESSON_13
--EASY_LEVEL TASKS

--1-task
select concat(EMPLOYEE_ID,'-',FIRST_NAME,'',LAST_NAME)
from Employees

--2-task
update Employees
set PHONE_NUMBER=replace(phone_number,'124','999')
where PHONE_NUMBER like '%124%';

--3-task
select FIRST_NAME, Len(first_name) as LengthOfName from Employees
where FIRST_NAME like 'A%' or
		first_name like 'J%' or
		first_name like 'M%';

--4-task
select MANAGER_ID, sum(SALARY) as TotalSalary from Employees
group by MANAGER_ID

--5-task
select Year1 , GREATEST(Max1,Max2,Max3) MaxValue
from  TestMax

--6-task
select * from cinema
where id%2=1
and description != 'boring'

--7-task
select Id , Vals from SingleOrder order by Id desc

--8-task
select coalesce(ssn,passportid,itin) as FirstNonNull from person

--9-task
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, datediff(year, HIRE_DATE, getdate()) as YearsOfService from Employees
where datediff(year, HIRE_DATE, getdate()) between 10 and 15

--10-task
select FIRST_NAME,LAST_NAME, SALARY from Employees e1
where e1.SALARY> (select avg(Salary) as AvgSalary from Employees as e2
where e1.DEPARTMENT_ID=e2.DEPARTMENT_ID) 

--MEDIUM_LEVEL TASKS

--1-task
SELECT 
    -- Extract uppercase letters
    CONCAT(CASE WHEN SUBSTRING(char, 1, 1) BETWEEN 'A' AND 'Z' THEN char END) AS uppercase_letters,
    
    -- Extract lowercase letters
    CONCAT(CASE WHEN SUBSTRING(char, 1, 1) BETWEEN 'a' AND 'z' THEN char END) AS lowercase_letters,
    
    -- Extract numbers
    CONCAT(CASE WHEN SUBSTRING(char, 1, 1) BETWEEN '0' AND '9' THEN char END) AS numbers,
    
    -- Extract other characters
    CONCAT(CASE WHEN SUBSTRING(char, 1, 1) NOT BETWEEN 'A' AND 'Z' AND 
                                  SUBSTRING(char, 1, 1) NOT BETWEEN 'a' AND 'z' AND 
                                  SUBSTRING(char, 1, 1) NOT BETWEEN '0' AND '9' THEN char END) AS other_characters
FROM 
    (SELECT SUBSTRING('tf56sd#%OqH', n, 1) AS char
     FROM (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL 
           SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL 
           SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12) AS numbers)AS chars;

--2-task
SELECT
  SUBSTRING(FullName, 1, CHARINDEX(' ', FullName) - 1) AS Firstname,
  SUBSTRING(
    FullName,
    CHARINDEX(' ', FullName) + 1,
    CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) - CHARINDEX(' ', FullName) - 1
  ) AS Middlename,
  SUBSTRING(
    FullName,
    CHARINDEX(' ', FullName, CHARINDEX(' ', FullName) + 1) + 1,
    LEN(FullName)
  ) AS Lastname
FROM Students;

--3-task
SELECT * FROM Orders
WHERE DeliveryState = 'Texas'
  AND CustomerID IN (
    SELECT DISTINCT CustomerID
    FROM Orders
    WHERE DeliveryState = 'California'
);

--4-task
select * from Ungroup

WITH Numbers AS (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 -- extend as needed
), Expanded AS (
    SELECT ProductDescription
    FROM Ungroup u
    JOIN Numbers n ON n.n <= u.Quantity
)

SELECT e1.ProductDescription AS Product1, e2.ProductDescription AS Product2
FROM Expanded e1
CROSS JOIN Expanded e2
WHERE e1.ProductDescription <> e2.ProductDescription;

--5-task
SELECT 
  CONCAT(
    (SELECT String FROM DMLTable WHERE SequenceNumber = 1), ' ',
    (SELECT String FROM DMLTable WHERE SequenceNumber = 2), ' ',
    (SELECT String FROM DMLTable WHERE SequenceNumber = 3), ' ',
    (SELECT String FROM DMLTable WHERE SequenceNumber = 4), ' ',
    (SELECT String FROM DMLTable WHERE SequenceNumber = 5), ' ',
    (SELECT String FROM DMLTable WHERE SequenceNumber = 6), ' ',
    (SELECT String FROM DMLTable WHERE SequenceNumber = 7), ' ',
    (SELECT String FROM DMLTable WHERE SequenceNumber = 8), ' ',
    (SELECT String FROM DMLTable WHERE SequenceNumber = 9)
  ) AS FullQuery;

--6-task
select * from Employees
select concat(first_name,' ',Last_name) as FullName,
case
when datediff(year,Hire_date,getdate())<1 then 'New Hire'
when datediff(year,Hire_date,getdate()) between 1 and 5 then 'Junior'
when datediff(year,Hire_date,getdate()) between 5 and 10 then 'Mid-Level'
when datediff(year,Hire_date,getdate()) between 10 and 20 then 'Senior'
when datediff(year,Hire_date,getdate())>20 then 'Veteran'
end as EmployeeStage
from Employees

--7-task
select FIRST_NAME,LAST_NAME, SALARY from Employees e1
where e1.SALARY> (select avg(Salary) as AvgSalary from Employees as e2
where e1.DEPARTMENT_ID=e2.DEPARTMENT_ID) 

--8-task
select * from Employees
where concat(FIRST_NAME,LAST_NAME) like '%a%' and cast(SALARY as int) % 5 = 0;

--9-task
select * from Employees
 select DEpartment_ID,
		count(*) as TotalEmp,
		100*sum(case
		when datediff(year,HIRE_DATE,getdate())>3 then 1
		else 0
		end)/count(*) as EMpPercentage
		
 from Employees
 group by DEPARTMENT_ID

 --10-task
 select * from Personal

 select
 (select SpacemanID from Personal 
 where MissionCount=(select max(MissionCount) from Personal)) as maxExp,
 (select SpacemanID from Personal
 where MissionCount=(select min(MissionCount) from Personal)) as minExp

--HARD-LEVEL TASKS

--1-task
SELECT 
    s1.StudentID,
    s1.Grade,
    s1.Grade + COALESCE(s2.Grade, 0) AS value_plus_prev
FROM Students s1
LEFT JOIN Students s2 
  ON s2.StudentID = (
      SELECT MAX(StudentID) 
      FROM Students 
      WHERE StudentID < s1.StudentID
  )
ORDER BY s1.StudentID;

--2-task

WITH EmployeeHierarchy AS (
    -- Base case: Select the president (assuming the president's employee_id is 1)
    SELECT EmployeeID, ManagerID, 1 AS depth
    FROM Employee
    WHERE ManagerID IS NULL  -- Assuming the president has no manager (top-level)

    UNION ALL

    -- Recursive case: Select employees and calculate their depth
    SELECT e.EmployeeID, e.ManagerID, eh.depth + 1
    FROM Employee e
    JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT EmployeeID, depth
FROM EmployeeHierarchy
ORDER BY depth;

--3-task 

DECLARE @Equation NVARCHAR(200)
DECLARE @sql NVARCHAR(300)
DECLARE @res INT

WHILE EXISTS (SELECT 1 FROM Equations WHERE TotalSum IS NULL)
BEGIN
    SELECT TOP 1 @Equation = Equation FROM Equations WHERE TotalSum IS NULL

    SET @sql = 'SELECT @res_out = ' + @Equation
    EXEC sp_executesql @sql, N'@res_out INT OUTPUT', @res_out = @res OUTPUT

    UPDATE Equations
    SET TotalSum = @res
    WHERE Equation = @Equation
END

SELECT * FROM Equations

--4-task
SELECT s.*
FROM Student s
JOIN (
    SELECT Birthday
    FROM Student
    GROUP BY Birthday
    HAVING COUNT(*) > 1
) dup ON s.Birthday = dup.Birthday
ORDER BY s.Birthday;

--5-task
SELECT
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
    SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY
    CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
    CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;
