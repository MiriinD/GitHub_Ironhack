CREATE DATABASE IF NOT EXISTS AUTOS_ELEGANTES;

USE AUTOS_ELEGANTES;

CREATE TABLE Cars(
    Vehicle_identification_number_VIN INT PRIMARY KEY,
    Manufacturer_Name VARCHAR(20),
    Model VARCHAR(20),
    Year_of_model INT, 
    Color_cars_inventory VARCHAR(20)
);

CREATE TABLE Customers(
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(20),
    Phone_number INT, 
    email VARCHAR(20),
    address VARCHAR(20), 
    city VARCHAR(20), 
    state_province VARCHAR(20), 
    country VARCHAR(20), 
    postal_code INT
);

CREATE TABLE Salespersons(
    Staff_ID INT PRIMARY KEY ,
    Sales_person_name VARCHAR(20), 
    Store VARCHAR(20)
);

CREATE TABLE Invoices(
    Invoice_Number INT PRIMARY KEY,
    Date_order DATE,
    Amount DECIMAL(10,2),
    Car VARCHAR(20),
    Customer_ID INT,
    Staff_ID INT ,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Salespersons(Staff_ID)
);

