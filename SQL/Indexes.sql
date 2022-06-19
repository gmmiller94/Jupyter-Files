-- create a unique index on a table
CREATE INDEX filmListing -- index_name
ON sakila.film (film_id) -- table_name (column)

-- EXPLAIN QUERY PLAN show you what is happening when a query is run
SELECT film_id FROM sakila.film;

-- The min() function in SQL will return the smallest value of the selected column
SELECT min(amount) FROM sakila.payment;
--  the most spent within the invoices column, replace 'min' with 'max' like below
SELECT max(amount) FROM sakila.payment;

-- The sum() function will return the total sum of a numeric column
SELECT sum(amount) FROM sakila.payment;

-- The avg() function will return the average value of a numeric column
SELECT avg(amount) FROM sakila.payment;

-- The count() function will return the number of rows that match certain criteria
SELECT count(amount) FROM sakila.payment
WHERE amount < 4.00;

-- Using GROUP BY, run the following query to list the number of addresses in each district
SELECT count(address_id), district FROM sakila.address    -- SELECT column_name(s) FROM table_name
GROUP BY district                                         -- WHERE condition
ORDER BY count(address_id) DESC                           -- GROUP BY column_name(s)

-- ex 1
SELECT sakila.customer.customer_id,sakila.customer.first_name, sakila.customer.last_name, COUNT(rental_id) FROM sakila.rental
INNER JOIN sakila.customer USING (customer_id)
GROUP BY sakila.customer.customer_id;

-- ex 2
SELECT customer_id, sum(amount) AS TotalRentalAmount FROM sakila.payment
GROUP BY customer_id;

-- ex 3
-- USE HAVING = WHERE
SELECT customer_id, sum(amount) AS Total, count(rental_id) AS NoOfRentals FROM sakila.payment
GROUP BY customer_id
HAVING count(rental_id) > 40;

