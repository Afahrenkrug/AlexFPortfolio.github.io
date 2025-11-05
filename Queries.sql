/*
Data Source: https://www.kaggle.com/datasets/thedevastator/uncovering-factors-that-affect-used-car-prices/data

Modifications include:
-----------------------
-Converting columns to English
-Changing nonRepairedDamage data to binary values
-Converting num to a counting column
-Utilizing imperial versions of the metric units
*/

# Initial Data viewing
SELECT * FROM portfolioproject.full_data;

# Look for vehicles with low kilometers (Less than 10,000)
SELECT brand AS Make, model AS Model, kilometer AS Kilometers
FROM portfolioproject.full_data WHERE kilometer < 10000
ORDER BY kilometer ASC;

# Total number of vehicles with low kilometers (Less than 10,000)
SELECT Count(brand) FROM portfolioproject.full_data WHERE kilometer < 10000;

# Create the damages table
CREATE TABLE damages (
	Make VARCHAR(500),
    DamagedAmount INT,
    Total INT
    );

# Insert damages data into table
INSERT INTO damages (Make, Total, DamagedAmount) SELECT brand as Make, SUM(num) AS TotalAmount, SUM(notRepairedDamage) AS Damaged
FROM portfolioproject.full_data
GROUP BY brand
ORDER BY TotalAmount DESC;

# Display damage rates by brand
SELECT Make, DamagedAmount/Total AS DamageRate
FROM portfolioproject.damages
ORDER BY DamageRate DESC;

# Display transmission types
SELECT gearbox AS Transmission, Count(gearbox)
FROM portfolioproject.full_data
GROUP BY gearbox;

# Display the average number of miles for each brand
SELECT brand AS Make, AVG(kilometer*0.6213712) AS Miles
FROM portfolioproject.full_data
GROUP BY Make
ORDER BY AVG(kilometer*0.6213712) DESC;