--Data Cleaning
--Check data type
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'shopping_trends';

--Change data type for cetain colums
ALTER TABLE shopping_trends
ALTER COLUMN customer_id INT;

ALTER TABLE shopping_trends
ALTER COLUMN age INT; 

ALTER TABLE shopping_trends
ALTER COLUMN purchase_amount_usd DECIMAL;

ALTER TABLE shopping_trends
ALTER COLUMN review_rating DECIMAL;

ALTER TABLE shopping_trends
ALTER COLUMN previous_purchases INT;

--Check for NULL values
SELECT *
FROM shopping_trends
WHERE 
    customer_id IS NULL OR
    age IS NULL OR
    gender IS NULL OR
    item_purchased IS NULL OR
    category IS NULL OR
    purchase_amount_usd IS NULL OR
    location IS NULL OR
    size IS NULL OR
    color IS NULL OR 
    season  IS NULL OR
    review_rating IS NULL OR 
    subscription_status IS NULL OR 
    payment_method IS NULL OR
    shipping_type IS NULL OR 
    discount_applied IS NULL OR 
    promo_code_used IS NULL OR 
    previous_purchases IS NULL OR
    preferred_payment_method IS NULL OR
    frequency_of_purchases IS NULL;

--Check for duplicate rows
SELECT *
FROM shopping_trends
GROUP BY customer_id, age, gender, item_purchased, category, purchase_amount_usd, location, size, color, season, review_rating, subscription_status, payment_method, shipping_type, discount_applied, promo_code_used, previous_purchases, preferred_payment_method, frequency_of_purchases
HAVING COUNT(*) > 1;

--Shopping Trends Analysis (Refer Tableau For Visualization : https://public.tableau.com/views/ShoppingTrendsAnalysis_17314747229240/Dashboard2?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
-- 1) Top 3 Products per Category by Sales
WITH category_sales AS (
    SELECT 
        category,
        item_purchased,
        SUM(purchase_amount_usd) AS total_sales,
        RANK() OVER (PARTITION BY category ORDER BY SUM(purchase_amount_usd) DESC) AS sales_rank
    FROM 
        shopping_trends
    GROUP BY 
        category, item_purchased
)
SELECT 
    category,
    item_purchased,
    total_sales,
    sales_rank
FROM 
    category_sales
WHERE 
    sales_rank <= 3
ORDER BY 
    category, total_sales DESC;

-- 2) Retention and Churn Rate by Subscription Status
SELECT 
    subscription_status,
    COUNT(customer_id) AS Total_Customers,
    COUNT(CASE WHEN frequency_of_purchases IN ('Bi-Weekly', 'Weekly', 'Fortnightly') THEN customer_id END) * 1.0 / COUNT(customer_id) AS Retention_Rate,
    COUNT(CASE WHEN frequency_of_purchases IN ('Monthly', 'Annually', 'Quarterly', 'Every 3 Months') THEN customer_id END) * 1.0 / COUNT(customer_id) AS Churn_Rate
FROM 
    shopping_trends
GROUP BY 
    subscription_status;

-- 3) Average Order Value and Purchase Frequency by Payment Method
SELECT 
    payment_method,
    COUNT(customer_id) AS purchase_frequency,
    AVG(purchase_amount_usd) AS Avg_Order_Value
FROM 
    shopping_trends
GROUP BY 
    payment_method
ORDER BY 
    Avg_Order_Value DESC;

--Market Segmentation Analysis (Refer Tableau For Visualization : https://public.tableau.com/views/MarketSegmentationAnalysis_17314746907080/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
-- 1) Demographic Segmentation Analysis (Analyze by age group and gender to identify purchasing patterns)
SELECT 
    CASE 
        WHEN age < 18 THEN '<18'
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        WHEN age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+'
    END AS age_group,
    gender,
    COUNT(customer_id) AS customer_count,
    AVG(purchase_amount_usd) AS avg_purchase_amount,
    AVG(previous_purchases) AS avg_previous_purchases
FROM 
    shopping_trends
GROUP BY 
    CASE 
        WHEN age < 18 THEN '<18'
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        WHEN age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+'
    END,
    gender
ORDER BY 
    age_group, gender;

-- 2) Geographic Segmentation Analysis (Segment customers by location to understand regional differences in purchasing behavior)
SELECT 
    location,
    COUNT(customer_id) AS total_customers,
    AVG(purchase_amount_usd) AS avg_purchase_amount,
    SUM(purchase_amount_usd) AS total_sales,
    AVG(previous_purchases) AS avg_previous_purchases
FROM 
    shopping_trends
GROUP BY 
    location
ORDER BY 
    avg_purchase_amount DESC;

-- 3) Behavioral Segmentation Analysis (Analyze customer behavior based on frequency of purchases and spending habits)
SELECT 
    frequency_of_purchases,
    COUNT(customer_id) AS customer_count,
    AVG(purchase_amount_usd) AS avg_purchase_amount,
    SUM(purchase_amount_usd) AS total_spending,
    AVG(previous_purchases) AS avg_previous_purchases
FROM 
    shopping_trends
GROUP BY 
    frequency_of_purchases
ORDER BY 
    avg_purchase_amount DESC;

-- 4) Psychographic Segmentation Analysis (Analyze customer preferences based on product characteristics like category, season, and color)
SELECT 
    category,
    season,
    color,
    AVG(purchase_amount_usd) AS avg_purchase_amount,
    COUNT(customer_id) AS purchase_count,
    AVG(review_rating) AS avg_review_rating
FROM 
    shopping_trends
GROUP BY 
    category, season, color
ORDER BY 
    avg_purchase_amount DESC;