-- Create database

CREATE DATABASE IF NOT EXISTS WalmartSalesProject;

-- Create table

CREATE TABLE IF NOT EXISTS sales(
invoice_id VARCHAR(30) NOT NUll PRIMARY KEY,
branch VARCHAR(5) NOT NULL,
city VARCHAR(30) NOT NUll,
customer_type VARCHAR(30) NOT NUll,
gender VARCHAR(10) NOT NUll,
product_line VARCHAR(100) NOT NUll,
unit_price DECIMAL(10,2) NOT Null,
quantity INT NOT NUll,
vat FLOAT(6,4) NOT NUll,
total DECIMAL(12,4) NOT NUll,
date DATETIME NOT NULL,
time TIME NOT NUll,
payment_method VARCHAR(15) NOT NUll,
cogs DECIMAL(10,2) NOT NULL,
gross_margin_pct FLOAT(11,9),
gross_income DECIMAL(12,4) NOT NUll,
rating FLOAT(3,1)
);


-- --------------------------------------------------------------------------------------
-- -------------------------------------- FEATURE ENGINEERING----------------------------

-- Add the time_of_day column

SELECT
	time,
(CASE 
		WHEN time BETWEEN "00:00:00" AND "12:00:00'" THEN 'Morning'
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
	END
    ) AS time_of_day
FROM sales

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20):

UPDATE sales
SET time_of_day = (
    CASE 
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
)
-- Add day_name column

SELECT
	date,
    DAYNAME(date) AS day_name
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
Set day_name = DAYNAME(date);

-- add month_name column

SELECT
	date,
    MONTHNAME(date)
FROM sales

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
Set month_name = MONTHNAME(date);

-- --------------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------------
-- -------------------------------------- GENERIC ---------------------------------------

-- How many unique cities does the data have?

SELECT
	distinct city
FROM sales;

-- In which city is each branch?

SELECT
	DISTINCT city,
		branch
FROM sales;

-- --------------------------------------------------------------------------------------
-- -------------------------------------- PRODUCT ----------------------------------------

-- How many unique product lines does the data have?

SELECT 
	DISTINCT product_line
FROM sales;
	
-- Most common payment method

SELECT
		payment_method,
    COUNT(payment_method) AS cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt DESC;

-- What is most selling product line?

SELECT
		product_line,
    COUNT(quantity) AS cnt
FROM sales
GROUP BY product_line
ORDER BY cnt DESC;

-- What is the total revenue by month?

SELECT
		month_name AS Month,
   SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest COGs?

SELECT
	month_name AS Month,
	SUM(cogs) AS cogs
FROM sales
Group BY month_name
ORDER BY cogs DESC;

-- What product line had the largest revenue?

SELECT
	product_line,
    SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?

SELECT
	branch,
	city,
    SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue DESC;

--  What product line had the largest VAT?

SELECT
	product_line,
    SUM(VAT) AS sum_tax
FROM sales
GROUP BY product_line
ORDER BY sum_tax DESC;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if it is greater than average sales

SELECT 
	product_line,
	ROUND(AVG(total),2) AS avg_sales,
	(CASE
		WHEN AVG(total) > (SELECT AVG(total) FROM sales) THEN "Good"
        ELSE "Bad"
	END) AS Criteria
FROM sales
GROUP BY product_line
ORDER BY avg_sales;

-- Which branch sold more products than average product sold?

SELECT
	branch,
    SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING sum(quantity) > (SELECT AVG(quantity) FROM sales);
 
-- What is the most common product line by gender?

SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

--  What is the average rating of each product line?

SELECT
	ROUND (AVG(rating),2) AS avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------------------------
-- -------------------------------------- SALES -------------------------------------------

-- Number of sales made at each time of the day per weekday?

SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = 'Monday'
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?

SELECT
	customer_type,
    Round(SUM(total),2)AS total_rev
FROM sales
GROUP BY customer_type
ORDER BY total_rev DESC;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT
	city,
    AVG(vat) AS vat
FROM sales
GROUP BY city
Order BY vat DESC;

-- Which customer type pays the most in VAT?

SELECT
	customer_type,
    AVG(vat) AS vat
FROM sales
GROUP BY customer_type
Order BY vat DESC;

-- --------------------------------------------------------------------------------------
-- -------------------------------------- Customers -------------------------------------

-- How many unique customer types does the date have?

SELECT
	DISTINCT customer_type AS cus_type,
   count(customer_type) AS cus_total
FROM sales
GROUP BY customer_type

-- How many unique payment methods does the data have?

SELECT
	DISTINCT payment_method AS pay_type,
   count(payment_method) AS pay_total
FROM sales
GROUP BY payment_method;

-- Which customer type buys the most?

SELECT
	DISTINCT customer_type,
   count(customer_type) AS cstm_cnt
FROM sales
GROUP BY customer_type;

-- What is the gender of most of the customers?

SELECT
	gender,
    count(*) as gender_cnt
FROM sales
GROUP BY gender
ORDER BY gender DESC;

-- What is the gender distribution by branch?

SELECT
    branch,
    gender,
    COUNT(*) AS gender_cnt
FROM sales
GROUP BY branch, gender
ORDER BY branch ASC, gender DESC;

-- Which time of the day do customers give the most ratings?

SELECT
	time_of_day,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of day do customers give the most ratings per branch?

SELECT
	branch,
    time_of_day,
    AVG(rating) AS avg_rating
FROM sales
GROUP By branch,time_of_day
ORDER BY time_of_day DESC;

-- What day of the week has the best avg ratings?

SELECT
	day_name,
    avg(rating) AS avg_rating
From sales
Group By day_name
Order BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?

SELECT
	branch,
    day_name,
    AVG(rating) AS avg_rating
FROM sales
GROUP By branch, day_name
ORDER BY avg_rating DESC;
