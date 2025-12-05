-- Data Cleaning

SELECT * 
FROM layoffs;

-- Plan of action:
-- -------------------
-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Null/Blank values
-- 4. Remove unnecessary rows/columns

-- Create a duplicate table to modify
CREATE TABLE layoffs_staging
LIKE layoffs;

-- Insert the data into the new table
INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

-- 1. Remove duplicates
-- Find the unique rows
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Create a cte for the rows which have duplicates
WITH duplicate_cte AS
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Create a new table to delete only one of the duplicate rows
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- View the duplicates in the new table
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- Insert the data
INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Remove the duplicates from the new table
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- 2. Standardizing data

-- Remove extra white space
UPDATE layoffs_staging2
SET company = TRIM(company);

-- View the repeated columns
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- Update the repeated columns
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Remove the trailing period
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Reformat the dates to a consistent format
UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y');

-- Change to a date type
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 3. Remove null/blank values

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';

-- Find values which have locations listed in other cells
SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '') AND t2.industry IS NOT NULL;

-- Update those cells
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Delete columns where there is no layoff data
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

-- Remove the row_num column that is no longer used
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;