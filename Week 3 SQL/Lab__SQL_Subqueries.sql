USE sakila;
#1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT
		(SELECT title FROM film WHERE film_id = inv.film_id) AS film_title,
		COUNT(*) AS num_copies
		FROM inventory AS inv
		WHERE inv.film_id =
							(SELECT film_id FROM film WHERE title = 'Hunchback Impossible')
		GROUP BY inv.film_id;


#2 List all films whose length is longer than the average length of all the films in the Sakila database.

SELECT 
    title, 
    length
FROM film
WHERE length > (SELECT AVG(length) FROM film);


#3 Use a subquery to display all actors who appear in the film "Alone Trip".


SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));


#BONUS

#4 Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.


#5 Retrieve the name and email of customers from Canada using both subqueries and joins. 
#To use joins, you will need to identify the relevant tables and their primary and foreign keys.



#6 Determine which films were starred by the most prolific actor in the Sakila database. 
#A prolific actor is defined as the actor who has acted in the most number of films. 
#First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.




#7 Find the films rented by the most profitable customer in the Sakila database. 
#You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payments.
#first

#USING JOINT
SELECT customer_id
FROM payment
GROUP BY  customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;


SELECT title
FROM film
INNER JOIN inventory
USING(film_id)
INNER JOIN rental
USING(inventory_id)
INNER JOIN payment
USING (customer_id)
WHERE customer_id = (SELECT customer_id
						FROM  payment
						GROUP BY customer_id
						ORDER BY SUM(amount) DESC
						LIMIT 1)
GROUP BY title;

#Using only subqueries
SELECT title
FROM film
WHERE film_id IN (SELECT film_id	
				FROM inventory
                WHERE inventory_id IN (SELECT inventory_id
									FROM rental
                                    WHERE customer_id = (SELECT customer_id
														FROM  payment
														GROUP BY customer_id
														ORDER BY SUM(amount) DESC
														LIMIT 1)));
#ATTENTION: Similar to the assessment on tomorrow
#8. Retrieve the client_id and the total_amount_spent of those 
#clients who spent more than the average of the total_amount spent by each client. 
#You can use subqueries to accomplish this.

SELECT customer_id, SUM(amount) total_spent_p_c
FROM payment
GROUP BY customer_id
HAVING total_spent_p_c > (SELECT AVG(total_spent)
							FROM	(SELECT SUM(amount) AS total_spent #give this a name
							FROM payment
							GROUP BY customer_id) AS tspc);


