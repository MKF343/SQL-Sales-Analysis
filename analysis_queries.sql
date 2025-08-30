-- SQL Sales Analysis Project (for Microsoft SQL Server)
-- Author: Michael Kirtland
-- Date: 2025-08-23


-- QUERY 1: Total Sales per Product Line
-- This query calculates the sum of all sales for each product line to identify the most profitable categories.

SELECT
    PRODUCTLINE,
    SUM(SALES) AS TotalSales
FROM
    sales_data_sample
GROUP BY
    PRODUCTLINE
ORDER BY
    TotalSales DESC;
GO



-- QUERY 2: Top 5 Most Valuable Customers
-- This query identifies the top 5 customers by their total spending.


SELECT TOP 5
    CUSTOMERNAME,
    SUM(SALES) AS TotalSpent
FROM
    sales_data_sample
GROUP BY
    CUSTOMERNAME
ORDER BY
    TotalSpent DESC;
GO



-- QUERY 3: Month-over-Month Sales Growth
-- This advanced query uses a Common Table Expression (CTE) and a Window Function (LAG)
-- to calculate the percentage growth in sales from one month to the next.


WITH MonthlySales AS (
    -- First, create a temporary table with sales aggregated by month
    SELECT
        FORMAT(CONVERT(DATE, ORDERDATE, 101), 'yyyy-MM') AS SalesMonth,
        SUM(SALES) AS CurrentMonthSales
    FROM
        sales_data_sample
    WHERE
        STATUS = 'Shipped'
    GROUP BY
        FORMAT(CONVERT(DATE, ORDERDATE, 101), 'yyyy-MM')
)
-- Now, compare each month's sales to the previous month's sales
SELECT
    SalesMonth,
    CurrentMonthSales,
    LAG(CurrentMonthSales, 1, 0) OVER (ORDER BY SalesMonth) AS PreviousMonthSales,
    -- Calculate the percentage growth, safely handling potential division by zero
    CAST(
        ROUND(
            (CurrentMonthSales - LAG(CurrentMonthSales, 1, 0) OVER (ORDER BY SalesMonth)) * 100.0 /
            NULLIF(LAG(CurrentMonthSales, 1, 0) OVER (ORDER BY SalesMonth), 0), 2
        ) AS VARCHAR(50)
    ) + '%' AS MoM_Growth
FROM
    MonthlySales
ORDER BY
    SalesMonth;
GO


