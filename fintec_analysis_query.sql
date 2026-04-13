-- CREATE DATABASE --
CREATE DATABASE fintech_fraud;

USE fintech_fraud;

-- VERIFY DATASET --

-- VIEW DATASET STRUCTURE --
SELECT TOP 10 *
FROM transactions;

-- CHECK TOTAL TRANDACTIONS --
SELECT COUNT(*) AS total_transaction
FROM transactions;

-- CHECK FRAUD VS NORMAL TRANSACTIONS --
SELECT
class,
COUNT(*) AS total_transaction
FROM transactions
GROUP BY Class

-- FRAUD RATE --
SELECT
CONCAT(ROUND(SUM(CASE WHEN Class=1 THEN 1 ELSE 0 END)*100.0/COUNT(*),2), '%') AS fraud_transaction
FROM transactions;

-- CHECK TRANSACTION AMOUNT DISTRIBUTION --
SELECT
MAX(Amount) AS max_amount,
MIN(Amount) AS min_amount,
AVG(Amount) AS avg_amount
FROM transactions;

-- CHECK MISSING VALUES --
SELECT *
FROM transactions
WHERE Amount IS NULL;

-- CHECK DUPLICATE VALUE --
SELECT
Time,
Amount,
COUNT(*) AS duplicates_values
FROM transactions
GROUP BY Time,Amount
HAVING COUNT(*) >1;

-- CREATE TRANSACTION AMOUNT --
SELECT
Amount,
CASE
WHEN Amount <50 THEN 'Small'
WHEN Amount BETWEEN 50 AND 200 THEN 'Medium'
WHEN Amount BETWEEN 200 AND 1000 THEN 'Large'
ELSE 'Very Large'
END AS amount_category
FROM transactions;

-- CONVERT TIME INTO HOURS --
SELECT
Time,
(Time/3600) AS transaction_hours
FROM transactions;

-- CREATE TIME SEGMENT --
SELECT
Time,
CASE
WHEN (Time/3600) BETWEEN 0 AND 6 THEN 'Night'
WHEN (Time/3600) BETWEEN 7 AND 12 THEN 'Morning'
WHEN (Time/3600) BETWEEN 13 AND 18 THEN 'Afternoon'
ELSE 'Evening'
END AS time_segment
FROM transactions;

-- HIGH VALUE TRANSACTIONS --
SELECT
Amount,
CASE 
WHEN Amount> 1000 THEN 'High Value'
ELSE 'Normal Value'
END AS high_value_flag
FROM transactions;

-- CREATE CLEAN ANALYSIS TABLE --
SELECT *,

(Time/3600) AS transaction_hours,

CASE
WHEN Amount <50 THEN 'Small'
WHEN Amount BETWEEN 50 AND 200 THEN 'Medium'
WHEN Amount BETWEEN 200 AND 1000 THEN 'Large'
ELSE 'Very Large'
END AS amount_category,

CASE
WHEN (Time/3600) BETWEEN 0 AND 6 THEN 'Night'
WHEN (Time/3600) BETWEEN 7 AND 12 THEN 'Morning'
WHEN (Time/3600) BETWEEN 13 AND 18 THEN 'Afternoon'
ELSE 'Evening'
END AS time_segment,

CASE 
WHEN Amount> 1000 THEN 'High Value'
ELSE 'Normal Value'
END AS high_value_flag

INTO cleaned_fraud_analysis_table
FROM transactions;

--VERIFY CLEANED TABLE --
SELECT TOP 10 *
FROM cleaned_fraud_analysis_table;