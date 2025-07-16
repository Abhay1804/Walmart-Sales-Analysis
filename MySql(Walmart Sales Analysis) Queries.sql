 -- WALMART SALES ANALYSIS PROJECT QUERIES -- MySql

create database walmart_db;

use walmart_db;

select count(*) from walmart;

-- Business Problems -- 

-- Q1: Find different payment methods, number of transactions, and quantity sold by payment method
SELECT 
    payment_method,
    COUNT(*) AS no_payments,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;


--  Q2: Identify the highest-rated category in each branch Display the branch, category, and avg rating
SELECT branch, category, avg_rating
FROM (
    SELECT 
        branch,
        category,
        avg_rating,
        RANK() OVER (PARTITION BY branch ORDER BY avg_rating DESC) AS rk
    FROM (
        SELECT 
            branch,
            category,
            AVG(rating) AS avg_rating
        FROM walmart
        GROUP BY branch, category
    ) AS aggregated
) AS ranked
WHERE rk = 1;


-- Q3: Identify the busiest day for each branch based on the number of transactions
SELECT branch, day_name, no_transactions
FROM (
    SELECT 
        branch,
        DAYNAME(STR_TO_DATE(date, '%d/%m/%Y')) AS day_name,
        COUNT(*) AS no_transactions,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rk
    FROM walmart
    GROUP BY branch, day_name
) AS ranked
WHERE rk = 1;


-- Q4: Calculate the total quantity of items sold per payment method
SELECT 
    payment_method,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

-- Q5: Determine the average, minimum, and maximum rating of categories for each city
SELECT 
    city,
    category,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY city, category;

-- Q6: Calculate the total profit for each category
SELECT 
    category,
    SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart
GROUP BY category
ORDER BY total_profit DESC;

-- Q7: Determine the most common payment method for each branch
WITH cte AS (
    SELECT 
        branch,
        payment_method,
        COUNT(*) AS total_trans,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rk
    FROM walmart
    GROUP BY branch, payment_method
)
SELECT branch, payment_method AS preferred_payment_method
FROM cte
WHERE rk = 1;

-- Q8: Categorize sales into Morning, Afternoon, and Evening shifts
SELECT
    branch,
    CASE 
        WHEN HOUR(TIME(time)) < 12 THEN 'Morning'
        WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS num_invoices
FROM walmart
GROUP BY branch, shift
ORDER BY branch, num_invoices DESC;


-- Q9: Identify the 5 branches with the highest revenue decrease ratio from last year to current year (e.g., 2022 to 2023)
WITH revenue_2022 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%Y')) = 2022
    GROUP BY branch
),
revenue_2023 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%Y')) = 2023  -- this was wrongly set to 2022 before
    GROUP BY branch
)
SELECT 
    r2022.branch,
    r2022.revenue AS last_year_revenue,
    r2023.revenue AS current_year_revenue,
    ROUND(((r2022.revenue - r2023.revenue) / r2022.revenue) * 100, 2) AS revenue_decrease_ratio
FROM revenue_2022 AS r2022
JOIN revenue_2023 AS r2023 ON r2022.branch = r2023.branch
WHERE r2022.revenue > r2023.revenue
ORDER BY revenue_decrease_ratio DESC
LIMIT 5;


-- Q10 : What are the monthly sales trends for each branch over the past year? 

SELECT 
    branch,
    DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%Y'), '%Y-%m') AS yr_month,
    SUM(total) AS monthly_sales
FROM walmart
WHERE STR_TO_DATE(date, '%d/%m/%Y') >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY branch, yr_month
ORDER BY branch, yr_month;

-- Q11 : What is the average transaction value for each payment method? 

SELECT 
    payment_method,
    ROUND(SUM(total) / COUNT(*), 2) AS avg_transaction_value
FROM walmart
GROUP BY payment_method
ORDER BY avg_transaction_value DESC;

-- Q12 : Which item had the highest sales volume within each category across branches? 
SELECT branch, category, total_quantity
FROM (
    SELECT 
        branch,
        category,
        SUM(quantity) AS total_quantity,
        RANK() OVER (PARTITION BY branch, category ORDER BY SUM(quantity) DESC) AS rk
    FROM walmart
    GROUP BY branch, category
) AS ranked_items
WHERE rk = 1
ORDER BY branch, category;

-- Q13 : What is the sales volume distribution by hour across branches? 

SELECT 
    branch,
    HOUR(TIME(time)) AS sale_hour,
    SUM(quantity) AS total_sales_volume
FROM walmart
GROUP BY branch, sale_hour
ORDER BY branch, sale_hour;

-- Q14: Which categories generate the highest revenue in each city? 
SELECT city, category, total_revenue
FROM (
    SELECT 
        city,
        category,
        SUM(unit_price * quantity) AS total_revenue,
        RANK() OVER (PARTITION BY city ORDER BY SUM(unit_price * quantity) DESC) AS rk
    FROM walmart
    GROUP BY city, category
) AS ranked
WHERE rk = 1
ORDER BY city;

-- Q15: What are the average product ratings based on customer gender across branches? 

SELECT 
    branch,
    ROUND(AVG(rating), 2) AS avg_rating
FROM walmart
GROUP BY branch
ORDER BY branch;