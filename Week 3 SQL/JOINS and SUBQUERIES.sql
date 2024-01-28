USE sakila;
#Using sakila database how many cities in Canada have a store

SELECT COUNT(DISTINCT city) AS num_of_cities
FROM city
INNER JOIN country
USING(country_id)
where country = "Canada";

#more than one city
SELECT country, COUNT(city_id) AS num_of_cities
FROM city
INNER JOIN country
USING(country_id)
where country in ("Canada", "Italy")
GROUP BY country;

#Retrieve the number of addresses for country
#Joining 3 tables
SELECT column1, column2
FROM tabla
INNER JOIN tableb
USING(column1)
INNER JOIN country
USING(country_id)
GROUP BY country;

SELECT country, COUNT(address_id)
FROM address
INNER JOIN city
USING(city_id)
INNER JOIN country
USING(country_id)
GROUP BY country;

#Joints are more used with multiple tables, readability, are usually the go to approach.

#SUBQUERIES
SELECT first_name, last_name
FROM actor
WHERE actor_id = 4;


SELECT first_name, last_name
FROM actor
INNER JOIN film_actor
USING(actor_id)
WHERE film_id =4;

SELECT actor_id
FROM film_actor
WHERE film_id = 4;

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
					WHERE film_id = 4);



#Retreive addaptation
SELECT film_id
FROM film
WHERE title = "Adaptation Holes";

SELECT actor_id
FROM film_actor
WHERE film_id = (SELECT film_id
					FROM film
					WHERE title = "Adaptation Holes");

SELECT first_name, last_name
FROM actor
WHERE actor_id in (SELECT actor_id
					FROM film_actor
					WHERE film_id = (SELECT film_id
										FROM film
										WHERE title = "Adaptation Holes"));


#Retreive the first and last names od actores in English language movies
SELECT first_name, last_name
FROM actor
WHERE actor_id in (SELECT actor_id
					FROM film_actor
                    WHERE film_id IN (SELECT film_id
										FROM film
                                        WHERE language_id = (SELECT language_id
																FROM  language
                                                                WHERE name = "English")));


