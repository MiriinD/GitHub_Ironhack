#LAB

USE sakila;
#Step 1: Create a View
#First, create a view that summarizes rental information for each customer. 
#The view should include the customer's ID, name, email address, and total number of rentals 
#(rental_count).

CREATE OR REPLACE VIEW customer_info AS
SELECT customer_id, first_name, last_name, email, address, COUNT(rental_id) AS total_rentals
FROM customer
INNER JOIN address
USING (address_id)
INNER JOIN rental
USING (customer_id)
GROUP BY customer_id;

SELECT * FROM customer_info;



#Step 2: Create a Temporary Table
#Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). 
#The Temporary Table should use the rental summary view created in Step 1 to join with the payment table 
# and calculate the total amount paid by each customer. ---I could have had added the avg here right?

CREATE TEMPORARY TABLE temp_total_amount_paid AS
SELECT customer_info.*, SUM(amount) AS total_paid
FROM payment
INNER JOIN customer_info
USING(customer_id)
GROUP BY customer_id;

SELECT * FROM temp_total_amount_paid;

#Step 3: Create a CTE and the Customer Summary Report ---Is this another way to make subqueries?"""
#Create a CTE that joins the rental summary View with the customer payment summary Temporary Table created in Step 2. 
#The CTE should include the customer's name, email address, rental count, and total amount paid.

WITH cte_report AS( 
SELECT customer_info.*, total_paid 
FROM customer_info
INNER JOIN temp_total_amount_paid
USING(customer_id))

#Next, using the CTE, create the query to generate the final customer summary report, 
#which should include: customer name, email, rental_count, total_paid and average_payment_per_rental, 
#this last column is a derived column from total_paid and rental_count.

#SELECT customer_info.*, total_paid/total_rentals AS avg_rental #FROM cte_report; 
###Why doing customer_info.* doesn't work?

SELECT first_name, last_name, email, total_rentals, total_paid/total_rentals AS avg_rental
FROM cte_report;










