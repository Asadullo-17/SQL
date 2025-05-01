--1-task
SELECT 
    sale_id,
    customer_id,
    customer_name,
    product_category,
    product_name,
    quantity_sold,
    unit_price,
    total_amount,
    order_date,
    region,
    SUM(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotalSales
FROM 
    sales_data
ORDER BY 
    customer_id, order_date;

--2-task
SELECT 
    product_category,
    COUNT(*) AS NumberOfOrders
FROM 
    sales_data
GROUP BY 
    product_category
ORDER BY 
    product_category;

--3-task
SELECT 
    product_category,
    MAX(total_amount) AS MaxTotalAmount
FROM 
    sales_data
GROUP BY 
    product_category
ORDER BY 
    product_category;

--4-task
SELECT 
    product_category,
    MIN(unit_price) AS MinPrice
FROM 
    sales_data
GROUP BY 
    product_category
ORDER BY 
    product_category;

--5-task
SELECT 
    sale_id,
    customer_id,
    customer_name,
    product_category,
    product_name,
    quantity_sold,
    unit_price,
    total_amount,
    order_date,
    region,
    AVG(total_amount) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSales
FROM 
    sales_data
ORDER BY 
    order_date;

--6-task
SELECT 
    region,
    SUM(total_amount) AS TotalSales
FROM 
    sales_data
GROUP BY 
    region
ORDER BY 
    region;
--7-task
SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS TotalPurchaseAmount,
    RANK() OVER (
        ORDER BY SUM(total_amount) DESC
    ) AS CustomerRank
FROM 
    sales_data
GROUP BY 
    customer_id, customer_name
ORDER BY 
    CustomerRank;

--8-task
SELECT 
    sale_id,
    customer_id,
    customer_name,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS PreviousSaleAmount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS SaleAmountDifference
FROM 
    sales_data
ORDER BY 
    customer_id, order_date;

--9-task
WITH RankedProducts AS (
    SELECT 
        product_category,
        product_name,
        unit_price,
        ROW_NUMBER() OVER (
            PARTITION BY product_category 
            ORDER BY unit_price DESC
        ) AS Rank
    FROM 
        sales_data
)
SELECT 
    product_category,
    product_name,
    unit_price
FROM 
    RankedProducts
WHERE 
    Rank <= 3
ORDER BY 
    product_category, Rank;

--10-task
SELECT 
    sale_id,
    customer_id,
    customer_name,
    product_category,
    product_name,
    quantity_sold,
    unit_price,
    total_amount,
    order_date,
    region,
    SUM(total_amount) OVER (
        PARTITION BY region 
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeSales
FROM 
    sales_data
ORDER BY 
    region, order_date;

--11-task
SELECT 
    sale_id,
    customer_id,
    customer_name,
    product_category,
    product_name,
    quantity_sold,
    unit_price,
    total_amount,
    order_date,
    region,
    SUM(total_amount) OVER (
        PARTITION BY product_category 
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeRevenue
FROM 
    sales_data
ORDER BY 
    product_category, order_date;

--12-task
SELECT 
    sale_id,
    SUM(sale_id) OVER (
        ORDER BY sale_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
    ) AS SumPreValues
FROM 
    sales_data
ORDER BY 
    sale_id

--13-task
SELECT 
    Value,
    SUM(Value) OVER (
        ORDER BY Value
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS SumOfPrevious
FROM 
    OneColumn
ORDER BY 
    Value;

--14-task
WITH RowNumsWithInitialOdd AS (
    SELECT 
        Id,
        Vals,
        ROW_NUMBER() OVER (PARTITION BY Id ORDER BY Vals) AS RowNumber
    FROM 
        Row_Nums
)
SELECT 
    Id,
    Vals,
    2 * RowNumber - 1 AS RowNumber  
FROM 
    RowNumsWithInitialOdd
ORDER BY 
    Id, RowNumber;

--15-task
SELECT 
    customer_id,
    customer_name
FROM 
    sales_data
GROUP BY 
    customer_id, customer_name
HAVING 
    COUNT(DISTINCT product_category) > 1;

--16-task
WITH RegionAvg AS (
    SELECT 
        region,
        AVG(total_amount) AS avg_spending
    FROM 
        sales_data
    GROUP BY 
        region
)
SELECT 
    s.customer_id,
    s.customer_name,
    s.region,
    SUM(s.total_amount) AS total_spent
FROM 
    sales_data s
JOIN 
    RegionAvg r ON s.region = r.region
GROUP BY 
    s.customer_id, s.customer_name, s.region, r.avg_spending
HAVING 
    SUM(s.total_amount) > r.avg_spending;

--17-task
SELECT 
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS total_spent,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS rank
FROM 
    sales_data
GROUP BY 
    customer_id, customer_name, region
ORDER BY 
    region, rank;


--18-task
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS cumulative_sales
FROM 
    sales_data
ORDER BY 
    customer_id, order_date;

--19-task
WITH MonthlySales AS (
    SELECT
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        SUM(total_amount) AS monthly_sales
    FROM sales_data
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
    year,
    month,
    monthly_sales,
    LAG(monthly_sales) OVER (ORDER BY year, month) AS previous_month_sales,
    CASE 
        WHEN LAG(monthly_sales) OVER (ORDER BY year, month) IS NULL THEN NULL
        ELSE (monthly_sales - LAG(monthly_sales) OVER (ORDER BY year, month)) / LAG(monthly_sales) OVER (ORDER BY year, month)
    END AS growth_rate
FROM MonthlySales
ORDER BY year, month;

--20-task
WITH CustomerOrders AS (
    SELECT
        customer_id,
        total_amount,
        LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_amount
    FROM sales_data
)
SELECT
    customer_id,
    total_amount AS current_order_amount,
    previous_order_amount
FROM CustomerOrders
WHERE total_amount > previous_order_amount
ORDER BY customer_id, current_order_amount;





