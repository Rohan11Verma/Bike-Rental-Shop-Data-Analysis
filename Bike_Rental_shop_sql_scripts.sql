/* ************************* BIKE RENTAL SHOP DATA ANALYSIS **************************/

# Q1: "fetch total number of customers"
SELECT 
    COUNT(*) AS number_of_customers
FROM
    customer;
 
# 2. Emily would like to know how many bikes the shop owns by category.
SELECT 
    category, COUNT(*) AS number_of_bikes
FROM
    bike
GROUP BY category;

# 3. Emily needs a list of customer names with the total number of memberships purchased by each.
SELECT 
    c.name,
    COUNT(membership_type_id) AS no_of_memberships
FROM
    customer c
        LEFT JOIN
    membership m ON c.id = m.customer_id
GROUP BY c.name
ORDER BY no_of_memberships desc;

# Q4. "What is the average time for which each category of the bikes are rented?"
SELECT 
    category, ROUND(AVG(duration), 2) AS average_duration
FROM
    rental r
        JOIN
    bike b ON r.bike_id = b.id
GROUP BY category;

/* 5. Emily is working on a special offer for the winter months. Can you help her 
prepare a list of new rental prices?
For each bike, display its ID, category, old price per hour (call this column old_price_per_hour ), 
discounted price per hour (call it new_price_per_hour ), 
old price per day (call it old_price_per_day ), 
and discounted price per day (call it new_price_per_day ).
Electric bikes should have a 10% discount for hourly rentals and a 20% discount for daily rentals. 
Mountain bikes should have a 20% discount for hourly rentals and a 50% discount for daily rentals.
All other bikes should have a 50% discount for all types of rentals. */
SELECT 
    id,
    category,
    price_per_hour AS old_price_per_hour,
    CASE
        WHEN category = 'electric' THEN price_per_hour * 0.9
        WHEN category = 'mountain bike' THEN price_per_hour * 0.8
        ELSE price_per_hour * 0.5
    END AS new_price_per_hour,
    price_per_day AS old_price_per_day,
    CASE
        WHEN category = 'electric' THEN price_per_day * 0.8
        WHEN category = 'mountain bike' THEN price_per_day * 0.5
        ELSE price_per_day * 0.5
    END AS new_price_per_day
FROM
    bike;

# Q6. "Who has rented the most number of times?"
with cte as
(select customer_id, count(1) as times_rented, dense_rank() over(order by count(1) desc) as rnk
from rental group by customer_id)
select customer_id, name, times_rented, email from cte join customer c on cte.customer_id = c.id where rnk = 1;

# Q7. "Which category of bike has been rented the most times?"
SELECT 
    category, COUNT(category) AS times_rented
FROM
    bike b
        JOIN
    rental r ON b.id = r.bike_id
GROUP BY category
ORDER BY times_rented DESC
LIMIT 1;

# Q8. "Which category of bike has been rented the least times?"
with cte as
(SELECT 
    category, COUNT(category) AS times_rented, rank() over(order by count(category)) as rn
FROM
    bike b
        JOIN
    rental r ON b.id = r.bike_id
GROUP BY category)
select category, times_rented from cte where rn = 1;

# Q9. "Which membership plan is the most popular?"
SELECT 
    name, COUNT(name) AS frequency
FROM
    membership m
        JOIN
    membership_type mt ON m.membership_type_id = mt.id
GROUP BY name
ORDER BY frequency DESC;

/* 10. Emily is looking for counts of the rented bikes and of the available bikes in each category.
Display the number of available bikes (call this column available_bikes_count ) 
and the number of rented bikes (call this column rented_bikes_count ) by bike category.*/
SELECT 
    category,
    COUNT(CASE
        WHEN status = 'available' THEN 1
    END) AS available_bikes_count,
    COUNT(CASE
        WHEN status = 'rented' THEN 1
    END) AS rented_bikes_count
FROM
    bike
GROUP BY category;

#Pivot the above table
SELECT 
    category, status, COUNT(*) as no_of_bikes
FROM
    bike
WHERE
    status IN ('available' , 'rented')
GROUP BY category , status
ORDER BY category;

/* 11. Emily is preparing a sales report. 
She needs to know the total revenue from rentals by month, the total by year, and the all-time across all the years.
Display the total revenue from rentals for each month, the total for each year, and the total across all the years. 
Do not take memberships into account. 
There should be 3 columns: year , month , and revenue . 
Sort the results chronologically. 
Display the year total after all the month totals for the corresponding year.
*/
# Easier approach
SELECT 
    YEAR(start_timestamp) AS year,
    MONTH(start_timestamp) AS month,
    SUM(total_paid) AS revenue
FROM
    rental
GROUP BY year , month 
UNION SELECT 
    YEAR(start_timestamp) AS year,
    NULL AS month,
    SUM(total_paid) AS revenue
FROM
    rental
GROUP BY year , month 
UNION SELECT 
    NULL AS year, NULL AS month, SUM(total_paid)
FROM
    rental
GROUP BY year , month
ORDER BY year
;

# Better Approach
SELECT 
    YEAR(start_timestamp) AS year,
    MONTH(start_timestamp) AS month,
    SUM(total_paid) AS revenue
FROM
    rental
GROUP BY year , month WITH ROLLUP
ORDER BY year;

/* 12. Emily has asked you to get the total revenue from memberships for each combination of year, month, and membership type.
Display the year, the month, the name of the membership type (call this column membership_type_name ), 
and the total revenue (call this column total_revenue ) for every combination of year, month, and membership type. 
Sort the results by year, month, and name of membership type
*/
SELECT 
    YEAR(start_date) AS year,
    MONTH(start_date) AS month,
    mt.name AS membership_type_name,
    SUM(total_paid) AS revenue
FROM
    membership m
        JOIN
    membership_type mt ON m.membership_type_id = mt.id
GROUP BY year , month , membership_type_name
ORDER BY year , month , membership_type_name;

/* 13. Next, Emily would like data about memberships purchased in 2023, with subtotals and grand totals for all the different combinations of membership types and months.
Display the total revenue from memberships purchased in 2023 for each combination of month and membership type. 
There should be 3 columns: membership_type_name , month , and total_revenue .
Sort the results by membership type name alphabetically and then chronologically by month */
SELECT 
    MONTH(start_date) AS month,
    mt.name,
    SUM(total_paid) AS total_revenue
FROM
    membership m
        JOIN
    membership_type mt ON m.membership_type_id = mt.id
WHERE
    YEAR(start_date) LIKE '2023'
GROUP BY month , name
ORDER BY name , month;

/* 14. Customer Segementation :-
Emily wants to segment customers based on the number of rentals and 
see the count of customers in each segment.
Categorize customers based on their rental history as follows:
Customers who have had more than 10 rentals are categorized as 'more than 10' .
Customers who have had 5 to 10 rentals (inclusive) are categorized as 'between 5 and 10' .
Customers who have had fewer than 5 rentals should be categorized as 'fewer than 5' .
Calculate the number of customers in each category. Display two columns: 
rental_count_category (the rental count category) and customer_count (the number of customers in each category)
*/
with cte as
(select customer_id, count(*) as times_rented,
case when count(*) > 10 then 'more than 10'
	when count(*) between 5 and 10 then 'between 5 than 10'
    else 'fewer than 5'
end as category_type
from rental group by customer_id)
select category_type as rental_count_category, count(1) as customer_count 
from cte 
group by category_type 
order by customer_count;