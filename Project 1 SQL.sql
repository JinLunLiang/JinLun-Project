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

--Check for duplicate rows
SELECT Store, Date, Weekly_Sales, Holiday_Flag, Temperature, Fuel_Price, CPI, Unemployment
FROM dbo.walmart_sales
GROUP BY Store, Date, Weekly_Sales, Holiday_Flag, Temperature, Fuel_Price, CPI, Unemployment
HAVING COUNT(*) > 1

SELECT 
    YEAR(Date) AS year,
    DATEPART(WEEK, Date) AS week,
    SUM(Weekly_Sales) AS total_sales
FROM dbo.Walmart_Sales
GROUP BY YEAR(Date), DATEPART(WEEK, Date)
ORDER BY year, week;


SELECT 
    Holiday_Flag,
    AVG(Weekly_Sales) AS avg_weekly_sales,
    COUNT(*) AS num_weeks
FROM 
    walmart_sales
GROUP BY 
    Holiday_Flag
ORDER BY 
    Holiday_Flag;


  
   