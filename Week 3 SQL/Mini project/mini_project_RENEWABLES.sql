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
FOREIGN KEY (country_id) REFERENCES COUNTRIES_ANALIZED(country_id)