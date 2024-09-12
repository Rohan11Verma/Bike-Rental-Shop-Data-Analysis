# Bike-Rental-Shop-Data-Analysis
Bike rental shop - SQL Case study 
# Introduction:
Emily is the shop owner, and she would like to gather data to help her grow the business. She wants to get the answers to her business questions such as How many bikes does the shop own by category? What was the rental revenue for each month? etc.

# Understanding the database:
 The shop's database consists of 5 tables:
 customer
 bike
 rental
 membership_type
 membership

# Project Process:
1. Data Collection & Preparation:
Dataset: The dataset includes information on customers, bike rentals, bike categories, membership details, and rental transactions.
Environment: I used Jupyter Notebook for data processing and analysis, along with Pandas for data manipulation.
2. Exploratory Data Analysis (EDA):
Pandas was used to load, clean, and explore the multi-dimensional dataset.
Explored various data points such as customer demographics, bike rental frequency, membership types, and bike categories.
Conducted in-depth analysis using statistical summaries, data visualization, and trends to gain initial insights.
3. Data Export & Integration:
After performing EDA, the cleaned and processed dataset was dynamically imported into MySQL Workbench using SQLAlchemy.
4. SQL-Based Analysis:
Wrote complex SQL queries to answer specific business questions posed by the shop owner.
The use of SQL enabled efficient querying of the dataset for insights that were otherwise difficult to extract through EDA alone.
5. Business Insights:
By combining SQL and Pandas, I was able to uncover actionable insights, such as:
Identifying the most popular bike categories.
Monthly rental revenue breakdown.
Customer segmentation based on membership and rental frequency.
Technologies Used:
Pandas for data analysis and manipulation.
Jupyter Notebook for the analysis environment.
SQLAlchemy for dynamic data export to MySQL.
MySQL Workbench for SQL-based querying and deeper insights.
Conclusion:
This project demonstrates how combining Python for EDA and SQL for database-driven analysis can help a business owner make data-driven decisions, uncover hidden trends, and optimize operations.

 Answered the following questions and generated insights to support the business using SQL queries.
 
1: "fetch total number of customers"

2. Emily would like to know how many bikes the shop owns by category.

3. Emily needs a list of customer names with the total number of memberships purchased by each.

4. "What is the average time for which each category of the bikes are rented?"

5. Emily is working on a special offer for the winter months. Can you help her prepare a list of new rental prices?For each bike, display its ID, category, old price per hour (call this column old_price_per_hour ), discounted price per hour (call it new_price_per_hour ), old price per day (call it old_price_per_day ), and discounted price per day (call it new_price_per_day ).Electric bikes should have a 10% discount for hourly rentals and a 20% discount for daily rentals. Mountain bikes should have a 20% discount for hourly rentals and a 50% discount for daily rentals.All other bikes should have a 50% discount for all types of rentals.

6. "Who has rented the most number of times?"

7. "Which category of bike has been rented the most times?"

8. "Which category of bike has been rented the least times?"

9. "Which membership plan is the most popular?"

10. Emily is looking for counts of the rented bikes and of the available bikes in each category.Display the number of available bikes (call this column available_bikes_count ) and the number of rented bikes (call this column rented_bikes_count ) by bike category.

11. Emily is preparing a sales report. She needs to know the total revenue from rentals by month, the total by year, and the all-time across all the years.Display the total revenue from rentals for each month, the total for each year, and the total across all the years. Do not take memberships into account. There should be 3 columns: year , month , and revenue . Sort the results chronologically. Display the year total after all the month totals for the corresponding year.

12. Emily has asked you to get the total revenue from memberships for each combination of year, month, and membership type.Display the year, the month, the name of the membership type (call this column membership_type_name ), and the total revenue (call this column total_revenue ) for every combination of year, month, and membership type. Sort the results by year, month, and name of membership type.

13. Next, Emily would like data about memberships purchased in 2023, with subtotals and grand totals for all the different combinations of membership types and months.Display the total revenue from memberships purchased in 2023 for each combination of month and membership type. There should be 3 columns: membership_type_name , month , and total_revenue .Sort the results by membership type name alphabetically and then chronologically by month.

14. Customer Segementation :-Emily wants to segment customers based on the number of rentals and see the count of customers in each segment.
Categorize customers based on their rental history as follows:
Customers who have had more than 10 rentals are categorized as 'more than 10' .
Customers who have had 5 to 10 rentals (inclusive) are categorized as 'between 5 and 10' .
Customers who have had fewer than 5 rentals should be categorized as 'fewer than 5' .
Calculate the number of customers in each category. Display two columns: 
rental_count_category (the rental count category) and customer_count (the number of customers in each category)
