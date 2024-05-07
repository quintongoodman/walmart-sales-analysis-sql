# Walmart-Sales-Analysis-sql
# Project Overview

This project explores Walmart sales data using SQL queries to gain insights into top-performing branches, products, sales trends, and customer behavior. The data was obtained from the Kaggle Walmart Sales Forecasting Competition. It aims to identify areas for improvement and optimization of sales strategies.
## About Data

The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting). This dataset contains sales transactions from three different branches of Walmart, respectively located in Mandalay, Yangon, and Naypyitaw. The data contains 17 columns and 1000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| branch                  | Branch at which sales were made         | VARCHAR(5)     |
| city                    | The location of the branch              | VARCHAR(30)    |
| customer_type           | The type of the customer                | VARCHAR(30)    |
| gender                  | Gender of the customer making purchase  | VARCHAR(10)    |
| product_line            | Product line of the product sold        | VARCHAR(100)   |
| unit_price              | The price of each product               | DECIMAL(10, 2) |
| quantity                | The amount of the product sold          | INT            |
| VAT                 | The amount of tax on the purchase       | FLOAT(6, 4)    |
| total                   | The total cost of the purchase          | DECIMAL(10, 2) |
| date                    | The date on which the purchase was made | DATE           |
| time                    | The time at which the purchase was made | TIMESTAMP      |
| payment_method                 | The total amount paid                   | DECIMAL(10, 2) |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(10, 2) |
| rating                  | Rating                                  | FLOAT(2, 1)    |

## Key Questions Addressed:

| Left Column                                                  | Middle Column                                                  | Right Column                                                         |
|--------------------------------------------------------------|----------------------------------------------------------------|-----------------------------------------------------------------------|
| - How many unique cities does the data have?                 | - In which city is each branch located?                       | - Which month has the highest COGS (Cost of Goods Sold)?               |
| - How many unique product lines exist?                       | - What is the most common payment method?                    | - What is the best-selling product line?                               |
| - What is the total revenue by month?                        | - Which product line has the highest revenue?                | - Which city has the highest revenue?                                  |
| - Which branch sold more products than the average?          | - What is the most common product line by gender?            | - What is the average rating for each product line?                    |
| - Number of sales made at each time of day per weekday.      | - Which customer type generates the most revenue?            | - Which city has the highest VAT percentage?                           |
| - How many unique payment methods exist?                    | - What is the most common customer type?                     | - Gender distribution of customers.                                    |
| - Weekday with the best average customer ratings.            | - Weekday with the best average customer ratings per branch. | - Time of day with the most customer ratings.                          |
|                                                              | - Time of day with the most customer ratings per branch.     | - Gender distribution of customers per branch.                         |
|                                                              |                                                              |                                                                       |



## Methodology

This project leverages SQL queries to analyze the Walmart sales data stored in a relational database:

### Data Wrangling and Cleaning:

- The Walmart sales dataset is imported into a relational database management system MySQL.
- The data is organized into appropriate tables with relevant columns.
- The data is inspected for missing or null values.
- 
### Feature Engineering:
New features are generated from existing columns to enhance analysis:

- `time_of_day`Categorizes transactions into morning, afternoon, or evening.
- `day_name` Extracts the day of the week from the transaction date.
- `month_name` Extracts the month from the transaction date.

### SQL Queries:

- SQL queries are written to answer the key questions listed above.
- Queries may involve aggregation functions, joins, filtering, and grouping to extract meaningful insights from the data.
  
Revenue and profit metrics are calculated for different branches and product lines:
> COGS (Cost of Goods Sold): COGS = unit_price * quantity
> VAT (Value Added Tax): VAT = 5% * COGS
> Total Gross Sales: total(gross_sales) = VAT + COGS
> Gross Profit (Gross Income): grossProfit(grossIncome) = total(gross_sales) - COGS

### Analysis and Reporting:

- The results of the SQL queries are analyzed to identify patterns and trends in the data.
- Reports are generated to summarize the findings and present them in a clear and concise manner.
