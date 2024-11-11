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


-- Top 3 Products per Category by Sales
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

-- Seasonal Purchase Trends by Category and Gender
SELECT 
    category,
    gender,
    SUM(CASE WHEN season = 'Winter' THEN purchase_amount_usd ELSE 0 END) AS Winter_Sales,
    SUM(CASE WHEN season = 'Spring' THEN purchase_amount_usd ELSE 0 END) AS Spring_Sales,
    SUM(CASE WHEN season = 'Summer' THEN purchase_amount_usd ELSE 0 END) AS Summer_Sales,
    SUM(CASE WHEN season = 'Fall' THEN purchase_amount_usd ELSE 0 END) AS Fall_Sales
FROM 
    shopping_trends
GROUP BY 
    category, gender
ORDER BY 
    category, gender;

-- Retention and Churn Rate by Subscription Status
SELECT 
    subscription_status,
    COUNT(customer_id) AS Total_Customers,
    COUNT(CASE WHEN frequency_of_purchases IN ('Weekly', 'Fortnightly') THEN customer_id END) * 1.0 / COUNT(customer_id) AS Retention_Rate,
    COUNT(CASE WHEN frequency_of_purchases = 'Annually' THEN customer_iD END) * 1.0 / COUNT(customer_id) AS Churn_Rate
FROM 
    shopping_trends
GROUP BY 
    subscription_status;