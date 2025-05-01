--Lesson-21

--1-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM 
    ProductSales

--2-task
SELECT 
    ProductName,
    SUM(Quantity) AS TotalQuantitySold,
    DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS Rank
FROM 
    ProductSales
GROUP BY 
    ProductName
ORDER BY 
    Rank;

--3-task
WITH RankedSales AS (
    SELECT 
        SaleID, 
        ProductName, 
        SaleDate, 
        SaleAmount, 
        Quantity, 
        CustomerID,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS Rank
    FROM 
        ProductSales
)
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID
FROM 
    RankedSales
WHERE 
    Rank = 1;

--4-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM 
    ProductSales
ORDER BY 
    SaleDate;

--5-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM 
    ProductSales
ORDER BY 
    SaleDate;

--6-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID,
    DENSE_RANK() OVER (PARTITION BY ProductName ORDER BY SaleAmount DESC) AS RankWithinProduct
FROM 
    ProductSales
ORDER BY 
    ProductName, RankWithinProduct;

--7-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID
FROM 
    (
        SELECT 
            SaleID, 
            ProductName, 
            SaleDate, 
            SaleAmount, 
            Quantity, 
            CustomerID,
            LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
        FROM 
            ProductSales
    ) AS RankedSales
WHERE 
    SaleAmount > PreviousSaleAmount;

--8-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID,
    SaleAmount - LAG(SaleAmount) OVER( ORDER BY SaleDate) AS SaleAmountDifference
FROM 
    ProductSales

--9-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID,
    LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS NextSaleAmount,
    CASE 
        WHEN LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NOT NULL 
        THEN ((LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) - SaleAmount) / SaleAmount) * 100
        ELSE NULL 
    END AS PercentageChange
FROM 
    ProductSales
ORDER BY SaleID

--10-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID,
    LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
    CASE 
        WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NOT NULL
        THEN SaleAmount / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate)
        ELSE NULL
    END AS SaleAmountRatio
FROM 
    ProductSales
ORDER BY 
    ProductName, SaleDate;

--11-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID,
    FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS FirstSaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DifferenceFromFirstSale
FROM 
    ProductSales


--12-task
WITH SaleWithPrevious AS (
    SELECT 
        SaleID, 
        ProductName, 
        SaleDate, 
        SaleAmount, 
        Quantity, 
        CustomerID,
        LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount
    FROM 
        ProductSales
)
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID
FROM 
    SaleWithPrevious
WHERE 
    PreviousSaleAmount IS NOT NULL 
    AND SaleAmount > PreviousSaleAmount
ORDER BY 
    ProductName, SaleDate;

--13-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID,
    SUM(SaleAmount) OVER (
        PARTITION BY ProductName 
        ORDER BY SaleDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ClosingBalance
FROM 
    ProductSales

--14-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID,
    AVG(SaleAmount) OVER (
        PARTITION BY ProductName 
        ORDER BY SaleDate 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg_Last3Sales
FROM 
    ProductSales
ORDER BY SaleID

--15-task
SELECT 
    SaleID, 
    ProductName, 
    SaleDate, 
    SaleAmount, 
    Quantity, 
    CustomerID,
    AVG(SaleAmount) OVER () AS OverallAvgSale,
    SaleAmount - AVG(SaleAmount) OVER () AS DifferenceFromOverallAvg
FROM 
    ProductSales
ORDER BY 
    SaleID

--16-task
WITH RankedSalaries AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
)
SELECT 
    SalaryRank,
    EmployeeID,
    Name,
    Department,
    Salary
FROM RankedSalaries
WHERE SalaryRank IN (
    SELECT SalaryRank
    FROM RankedSalaries
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
)
ORDER BY SalaryRank, Salary DESC;


--17-task
WITH RankedSalaries AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM Employees1
)
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SalaryRank
FROM 
    RankedSalaries
WHERE 
    SalaryRank <= 2
ORDER BY 
    Department, Salary DESC;


--18-task
WITH RankedSalaries AS (
    SELECT 
        EmployeeID,
        Name,
        Department,
        Salary,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
    FROM Employees1
)
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary
FROM 
    RankedSalaries
WHERE 
    SalaryRank = 1
ORDER BY 
    Department;


--19-task
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    HireDate,
    SUM(Salary) OVER (
        PARTITION BY Department 
        ORDER BY HireDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotalSalary
FROM Employees1
ORDER BY Department, HireDate;

--20-task
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalDepartmentSalary
FROM 
    Employees1
ORDER BY 
    Department;

--21-task
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AverageDepartmentSalary
FROM 
    Employees1
ORDER BY 
    Department;


--22-task
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgDeptSalary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS SalaryDifference
FROM 
    Employees1
ORDER BY 
    Department;

--23-task
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (
        ORDER BY HireDate 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary
FROM 
    Employees1
ORDER BY 
    HireDate;

--24-task
SELECT 
    EmployeeID,
    Name,
    Department,
    Salary,
    HireDate,
    SUM(Salary) OVER (
        ORDER BY HireDate 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS SumLast3HiredSalaries
FROM 
    Employees1
ORDER BY 
    HireDate;
