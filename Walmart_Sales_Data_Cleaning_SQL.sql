--Walmart Sales Data Cleaning

--Check data type
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'walmart_sales';

--Change data type 
ALTER TABLE dbo.Walmart_Sales
ALTER COLUMN Store INT;

ALTER TABLE dbo.Walmart_Sales
ALTER COLUMN Date DATE;

ALTER TABLE dbo.Walmart_Sales
ALTER COLUMN Weekly_Sales NUMERIC;

ALTER TABLE dbo.Walmart_Sales
ALTER COLUMN Holiday_Flag INT;

ALTER TABLE dbo.Walmart_Sales
ALTER COLUMN Temperature NUMERIC;

ALTER TABLE dbo.Walmart_Sales
ALTER COLUMN Fuel_Price NUMERIC;

ALTER TABLE dbo.Walmart_Sales
ALTER COLUMN CPI NUMERIC;

ALTER TABLE dbo.Walmart_Sales
ALTER COLUMN Unemployment NUMERIC;

--Check for NULL values
SELECT *
FROM walmart_sales
WHERE 
    Store IS NULL OR
    Date IS NULL OR
    Weekly_Sales IS NULL OR
    Holiday_Flag IS NULL OR
    Temperature IS NULL OR
    Fuel_Price IS NULL OR
    CPI IS NULL OR
    Unemployment IS NULL;

--Check for duplicate rows
SELECT Store, Date, Weekly_Sales, Holiday_Flag, Temperature, Fuel_Price, CPI, Unemployment
FROM dbo.walmart_sales
GROUP BY Store, Date, Weekly_Sales, Holiday_Flag, Temperature, Fuel_Price, CPI, Unemployment
HAVING COUNT(*) > 1



  
   