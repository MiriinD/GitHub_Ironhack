USE bank;
# * means all the columns

SELECT * 
FROM card;

SELECT loan_id, account_id
FROM loan;

SELECT DISTINCT account_id
FROM `order`; # order by, is expecting you to order something. So USE Backticks when the name is ambiguos


SELECT AVG(amount)
FROM `order`;

SELECT MAX(amount), MIN(amount)
FROM loan;

SELECT account_id, amount, status
FROM loan
ORDER BY status DESC, amount DESC; #Desc for descending ASC Acending, if the have the same

SELECT account_id, duration , AVG (amount) AS average_amount #
FROM loan
GROUP BY account_id, duration #If we group we get each group
ORDER BY average_amount DESC;

SELECT account_id, amount
FROM loan
WHERE amount> 50000
ORDER BY amount ASC
LIMIT 5; #Like pandas, just see head

SELECT client_id, district_id
FROM client
WHERE district_id= 1;

#Retrieve the top 5 account_ids with the highest average amount ordered, but only including orders
#with amounts bigger than 3k. 

SELECT account_id, AVG (amount) AS avg_amount
FROM `order`
WHERE amount > 3000 #It's like filtering, always
GROUP BY account_id #If we group we get each group
ORDER BY avg_amount DESC #For filtering the results after the grouping HAVING in the Clause
LIMIT 5;


#Second part of class:


