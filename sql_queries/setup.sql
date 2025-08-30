-- This script sets up the sales_data_sample table and loads it with data.

-- Drop the table if it already exists to make the script re-runnable
IF OBJECT_ID('dbo.sales_data_sample', 'U') IS NOT NULL
    DROP TABLE dbo.sales_data_sample;
GO

-- Creates the table with appropriate data types
CREATE TABLE sales_data_sample (
    ORDERNUMBER INT,
    QUANTITYORDERED INT,
    PRICEEACH DECIMAL(10, 2),
    ORDERLINENUMBER INT,
    SALES DECIMAL(10, 2),
    ORDERDATE VARCHAR(50),
    STATUS VARCHAR(50),
    QTR_ID INT,
    MONTH_ID INT,
    YEAR_ID INT,
    PRODUCTLINE VARCHAR(50),
    MSRP INT,
    PRODUCTCODE VARCHAR(50),
    CUSTOMERNAME VARCHAR(255),
    PHONE VARCHAR(50),
    ADDRESSLINE1 VARCHAR(255),
    ADDRESSLINE2 VARCHAR(255),
    CITY VARCHAR(50),
    STATE VARCHAR(50),
    POSTALCODE VARCHAR(50),
    COUNTRY VARCHAR(50),
    TERRITORY VARCHAR(50),
    CONTACTLASTNAME VARCHAR(50),
    CONTACTFIRSTNAME VARCHAR(50),
    DEALSIZE VARCHAR(50)
);
GO

-- Load the data from the CSV file into the table
-- IMPORTANT: You MUST update the file path to match the location of the CSV on YOUR computer.
BULK INSERT sales_data_sample
FROM 'C:\SQLData\sales_data_sample.csv' -- <-- CHANGE THIS PATH
WITH (
    FIRSTROW = 2, -- Skips the header row
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO
