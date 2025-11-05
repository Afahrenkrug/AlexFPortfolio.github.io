# Create the database
CREATE DATABASE PortfolioProject;

# Go into the database
Use PortfolioProject;

# Create the table for all data to be placed
CREATE TABLE full_Data (
	num INT,
    dateCrawled DATE,
    vehicle_type VARCHAR(800),
    seller VARCHAR(500),
    offerType VARCHAR(500),
    price INT,
    abtest VARCHAR(500),
    vehicleType VARCHAR(500),
    yearOfRegistration VARCHAR(500),
	gearbox VARCHAR(500),
    powerPS INT,
    model VARCHAR(500),
    kilometer INT,
    monthOfRegistration INT,
    fuelType VARCHAR(500),
    brand VARCHAR(500),
    notRepairedDamage VARCHAR(500),
    dateCreated DATE,
    nrOfPictures INT,
    postalCode INT,
    lastSeen DATE
);

# Load the csv data into the table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/autos.csv'
INTO TABLE full_data
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;