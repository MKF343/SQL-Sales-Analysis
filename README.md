SQL Sales Analysis Project

Author: Michael Kirtland
Date: August 30, 2025 (23rd when it was made)

Project Overview

This project involves analyzing a sample e-commerce sales dataset to identify key trends in product performance, customer behavior, and sales growth. The analysis is performed using T-SQL in Microsoft SQL Server. The goal is to answer critical business questions and demonstrate proficiency in SQL for data analysis, from data ingestion to insight generation.

Dataset: Sample Sales Data on Kaggle - https://www.kaggle.com/datasets/kyanyoga/sample-sales-data
Tools: Microsoft SQL Server, SSMS, Git/GitHub

## How to Run This Project

To reproduce this analysis, follow these steps:

    Clone the repository to your local machine.

    In SSMS, create a new database (e.g., SalesDB).

    Open the sql_queries/setup.sql file.

    Important: In the BULK INSERT command, update the file path to the location of sales_data_sample.csv on your computer.

    Run the entire setup.sql script. This will create the table and load the data.

    Open and run the queries in sql_queries/analysis_queries.sql to see the analysis.

## SQL Queries

Query 1: Total Sales per Product Line

This query calculates the total sales for each product line to identify the most profitable categories.

SQL Code:

SELECT
    PRODUCTLINE,
    SUM(SALES) AS TotalSales
FROM
    sales_data_sample
GROUP BY
    PRODUCTLINE
ORDER BY
    TotalSales DESC;

Results:
<img width="1473" height="804" alt="Screenshot 2025-08-30 102851" src="https://github.com/user-attachments/assets/39ccf062-310c-43dd-838b-5d59053017d7" />

Insight: The "Classic Cars" product line is the highest revenue generator, significantly outperforming other categories, which suggests it is a core part of the business.

Query 2: Top 5 Most Valuable Customers

This query identifies the top 5 customers based on their total spending to find high-value clients.

SQL Code:

SELECT TOP 5
    CUSTOMERNAME,
    SUM(SALES) AS TotalSpent
FROM
    sales_data_sample
GROUP BY
    CUSTOMERNAME
ORDER BY
    TotalSpent DESC;

Results:
<img width="1463" height="553" alt="Screenshot 2025-08-30 103529" src="https://github.com/user-attachments/assets/2efd2045-8564-4433-827f-d07d1e249f24" />

Insight: A small number of high-value corporate clients, particularly "Euro Shopping Channel" and "Mini Gifts Distributors Ltd.", are responsible for a substantial portion of total sales.

Query 3: Month-over-Month Sales Growth

This query calculates the percentage growth in sales from one month to the next, identifying seasonal trends.

SQL Code:

WITH MonthlySales AS (
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
SELECT
    SalesMonth,
    CurrentMonthSales,
    LAG(CurrentMonthSales, 1, 0) OVER (ORDER BY SalesMonth) AS PreviousMonthSales,
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

Results:
<img width="977" height="690" alt="Screenshot 2025-08-30 103927" src="https://github.com/user-attachments/assets/e74411f5-ffd4-4c22-b93f-82c9bc57a5ab" />

Insight: The data reveals a significant sales ramp-up in the last quarter of the year, with November showing the strongest month-over-month growth, likely driven by holiday shopping. 
