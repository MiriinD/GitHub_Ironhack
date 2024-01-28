USE sakila;

#You need to use SQL built-in functions to gain insights relating to the duration of movies:
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
#Hint: Look for floor and round functions.

SELECT #How the concat works?
    CONCAT(
        FLOOR(AVG(length) / 60),
        ' hours ',
        ROUND(AVG(length) % 60),
        ' minutes'
    ) AS avg_duration
FROM film;


#You need to gain insights related to rental dates:
#2.1 Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT 
    rental_id,
    rental_date,
    DATE_FORMAT(rental_date, '%M') AS rental_month, #What's '%M'
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM rental
LIMIT 20;



#BONUS:Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
#Hint: use a conditional expression.

SELECT 
    rental_id,
    rental_date,
    DATE_FORMAT(rental_date, '%W') AS day_of_week,
    CASE 
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;


SELECT 
    rental_id,
    rental_date,
    CASE 
        WHEN DAYOFWEEK(rental_date) = 1 OR DAYOFWEEK(rental_date) = 7 THEN 'weekend' #1 is sunday and 7 is saturday
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;



SELECT DATE_FORMAT(rental_date, '%M') AS Month,
       DATE_FORMAT(rental_date, '%W') AS Weekday,
       CASE
           WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'weekend'
           ELSE 'workday'
       END AS DAY_TYPE
FROM rental
LIMIT 20;


SELECT DATE_FORMAT(rental_date, '%M') AS Month,
    DATE_FORMAT(rental_date, '%W') AS Weekday
FROM rental
LIMIT 20;

#You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
#If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
#Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.

SELECT 
    title,
    IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

#Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign 
#for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, 
#along with the first 3 characters of their email address, so that you can address them by their first name 
#and use their email address to send personalized recommendations. The results should be ordered 
#by last name in ascending order to make it easier to use the data.

SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    LEFT(email, 3) AS email_prefix #Don't totally get this
FROM customer
ORDER BY last_name ASC;


#You need to analyze the films in the collection to gain some more insights. Using the film table, determine:
#1.1 The total number of films that have been released.
SELECT COUNT(film_id) AS Total_number_of_films
FROM film;

#1.2 The number of films for each rating.

SELECT COUNT(film_id) AS Total_number_of_films, rating
FROM film
GROUP BY rating;



#Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. 
#This will help identify popular movie lengths for each category.


SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for 
#customers who prefer longer movies.

SELECT 
    rating,
    ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating
HAVING avg_duration > 120;


#Bonus: determine which last names are not repeated in the table actor.

SELECT 
    last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;