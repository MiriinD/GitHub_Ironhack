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

#Retrieve the account id with more than 2 and less than 5 orders, for orders of an amount smaller than 5k
SELECT account_id, COUNT(order_id) as count_of_orders
FROM `order`
WHERE amount < 5000 #It's like filtering, always
GROUP BY account_id #If we group we get each group
HAVING count_of_orders > 2 AND count_of_orders <5 ; #BETWEEN 3 AND 4


# Retrieve the account_id, loan_id, amount, and a new column called 'loan_size' with values:
# big loan if amount is bigger than 50k, medium_loan, if smaller than 50k and bigger than 25k
# small otherwise
SELECT account_id, loan_id, amount,
CASE 
    WHEN amount > 50000 THEN 'big_loan'
    WHEN amount < 50000 AND amount> 25000 THEN 'medium_loan' #btween 25k and 50k
    ELSE 'small'
END AS loan_size
FROM loan;

SELECT account_id, round(amount, -1) #don't get it?
FROM loan;

SELECT account_id, ROUND(amount,-2)
FROM loan;


#INNER JOIN
SELECT a.account_id, district_id, amount
FROM account AS a
INNER JOIN loan as l
ON a.account_id= l.account_id; #using only when column names are matching


SELECT a.account_id, district_id, amount
FROM account AS a
INNER JOIN loan as l
USING(account_id); #In this case the columns are named the same

#Retrieve the number of loans per district
#hint: Use the account and loan tables

SELECT a.district_id, COUNT(l.loan_id) AS loan_count
FROM account AS a 
INNER JOIN loan as l
ON a.account_id= l.account_id
GROUP BY a.district_id
ORDER BY district_id DESC
LIMIT 5;

