CREATE DATABASE IF NOT EXISTS RE_COMPANY_ANALYSIS;

USE RE_COMPANY_ANALYSIS;

CREATE TABLE IF NOT EXISTS COUNTRIES_ANALIZED
(	country_id	INT PRIMARY KEY,
	country_name VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS RENEWABLE_ELECTRICITY_INDICATORS
(   year INT,
    population_access_to_electricity FLOAT PRIMARY KEY,
    access_to_clean_fuels_for_cooking FLOAT,
    re_share_in_total_ec_in_percentage FLOAT,
    electricity_from_renewables_twh FLOAT,
    lowcarbon_electricity FLOAT,
    primary_energy_consumption_per_capita_kwhperson FLOAT,
    gdp_growth FLOAT,
    gdp_per_capita FLOAT, 
    country_id INT
);

ALTER TABLE RENEWABLE_ELECTRICITY_INDICATORS
ADD CONSTRAINT Fk_country_id
FOREIGN KEY (country_id) REFERENCES COUNTRIES_ANALIZED(country_id);


#Queries:



#1 The top 5 countries with greater energy consumption per person in kWh

SELECT c.country_name, MAX(r.primary_energy_consumption_per_capita_kwhperson) AS avg_energy_consumption
FROM COUNTRIES_ANALIZED AS  c
JOIN RENEWABLE_ELECTRICITY_INDICATORS AS r
ON c.country_id = r.country_id
#WHERE  r.year= 2020
GROUP BY c.country_name
ORDER BY avg_energy_consumption DESC 
;

#2 The top 5 countries with less energy consumption per person in kWh

SELECT c.country_name, AVG(r.primary_energy_consumption_per_capita_kwhperson) AS avg_energy_consumption
FROM COUNTRIES_ANALIZED AS  c
JOIN RENEWABLE_ELECTRICITY_INDICATORS AS r
ON c.country_id = r.country_id
GROUP BY c.country_name
ORDER BY avg_energy_consumption ASC
LIMIT 10;


#The top 10 countries with less access to clean fuels for cooking

SELECT c.country_name, AVG(r.access_to_clean_fuels_for_cooking) AS avg_access_to_clean_fuels
FROM COUNTRIES_ANALIZED AS  c
JOIN RENEWABLE_ELECTRICITY_INDICATORS AS r
ON c.country_id = r.country_id
WHERE  r.year= 2020
GROUP BY c.country_name
ORDER BY avg_access_to_clean_fuels ASC
LIMIT 10;

# countries with least access of electricity in 2020
SELECT c.country_name, AVG(r.population_access_to_electricity) AS access_electricity
FROM COUNTRIES_ANALIZED AS  c
JOIN RENEWABLE_ELECTRICITY_INDICATORS AS r
ON c.country_id = r.country_id
WHERE  r.year= 2020
GROUP BY c.country_name
ORDER BY access_electricity ASC
LIMIT 10;

#10 countries with no low carbon electricity
SELECT c.country_name, AVG(r.lowcarbon_electricity) AS avg_lowcarbon_electricity
FROM COUNTRIES_ANALIZED AS  c
JOIN RENEWABLE_ELECTRICITY_INDICATORS AS r
ON c.country_id = r.country_id
WHERE  r.year= 2020
GROUP BY c.country_name
ORDER BY avg_lowcarbon_electricity ASC
LIMIT 10;

SELECT c.country_name, MAX(r.primary_energy_consumption_per_capita_kwhperson) AS sum_energy_consumption
FROM countries_analized AS  c
JOIN renewable_electricity_indicators AS r
ON c.country_id = r.country_id
GROUP BY c.country_name
ORDER BY sum_energy_consumption DESC
LIMIT 7;


#Countries with largest share of renewables 
SELECT c.country_name, MAX(r.re_share_in_total_ec_in_percentage) AS re_share
FROM countries_analized AS  c
JOIN renewable_electricity_indicators AS r
ON c.country_id = r.country_id
GROUP BY c.country_name
ORDER BY re_share DESC
LIMIT 10;

#Countries with lowest share of renewables 
SELECT c.country_name, MAX(r.re_share_in_total_ec_in_percentage) AS re_share
FROM countries_analized AS  c
JOIN renewable_electricity_indicators AS r
ON c.country_id = r.country_id
WHERE  r.year= 2020
GROUP BY c.country_name
ORDER BY re_share ASC
LIMIT 10;


#Countries with the lowest GDP per capita
SELECT c.country_name, MAX(r.gdp_per_capita) AS gdp_capita
FROM countries_analized AS  c
JOIN renewable_electricity_indicators AS r
ON c.country_id = r.country_id
WHERE  r.year= 2020
GROUP BY c.country_name
ORDER BY gdp_capita ASC
LIMIT 10;

#Countries with the highest GDP per capita

SELECT c.country_name, MAX(r.gdp_per_capita) AS max_gdp_per_capita
FROM countries_analized AS c
JOIN renewable_electricity_indicators AS r 
ON c.country_id = r.country_id
WHERE r.year = 2020
GROUP BY c.country_name
ORDER BY max_gdp_per_capita DESC
LIMIT 10;