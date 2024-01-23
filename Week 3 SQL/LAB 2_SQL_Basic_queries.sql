#LAB 2
USE sakila;
#Display all available tables in the Sakila database
SHOW TABLES; 

#Retrieve all the data from the tables actor, film and customer.
SELECT * 
FROM actor, film, customer;

#Retrieve the following columns from their respective tables:
#3.1 Titles of all films from the film table
SELECT title
FROM film;
#3.2 List of languages used in films, with the column aliased as language from the language table
SELECT name AS language_from_the_language_table
FROM language;

#3.3 List of first names of all employees from the staff table
SELECT first_name 
FROM staff; #do they have only 2 people?

TABLE staff; #Seems like

#Retrieve unique release years.
SELECT DISTINCT release_year
FROM film;

#Counting records for database insights:
#5.1 Determine the number of stores that the company has.
SELECT COUNT(store_id)
FROM store;

#5.2 Determine the number of employees that the company has.
SELECT COUNT(staff_id)
FROM staff;

#5.3 Determine how many films are available for rent and how many have been rented. ???
SELECT COUNT(rental_id), COUNT(last_update)
FROM rental;

TABLE rental;

#5.4 Determine the number of distinct last names of the actors in the database.
SELECT DISTINCT last_name AS Unique_ln
FROM actor;

#Retrieve the 10 longest films.
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 10;

#Use filtering techniques in order to:
#7.1 Retrieve all actors with the first name "SCARLETT".

SELECT first_name
FROM actor
WHERE first_name= "SCARLETT"




