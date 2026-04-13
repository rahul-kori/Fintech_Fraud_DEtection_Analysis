-- FRAUD PATTERN ANALYSIS --

-- FRAUD RATE BY TRANSACTION SIZE --
SELECT
amount_category,
COUNT(*) AS total_transactions,
SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
CONCAT(ROUND(SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)* 100.0 / COUNT(*),4),'%') AS fraud_rate_percentage
FROM cleaned_fraud_analysis_table
GROUP BY amount_category
ORDER BY fraud_rate_percentage DESC;

-- FRAUD RATE BY TIME SEGMENT --
SELECT
time_segment,
COUNT(*) AS total_transactions,
SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
CONCAT(ROUND(SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)* 100.0 / COUNT(*),4),'%') AS fraud_rate_percentage
FROM cleaned_fraud_analysis_table
GROUP BY time_segment
ORDER BY fraud_transactions DESC;

-- HIGH VALUE TRANSACTION RISK --
SELECT
high_value_flag,
COUNT(*) AS total_transactions,
SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions
FROM cleaned_fraud_analysis_table
GROUP BY high_value_flag;

-- AVERAGE FRAUD TRANSACTION AMOUNT --
SELECT 
AVG(Amount) AS avg_fraud_amount
FROM cleaned_fraud_analysis_table
WHERE Class = 1;

-- TOP SUSPICIOUS TRANSACTIONS --
SELECT TOP 10
Time,
Amount,
transaction_hours,
amount_category
FROM cleaned_fraud_analysis_table
ORDER BY Amount DESC;

-- FRAUD PERCENTAGE DASHBOARD TABLE --
SELECT
COUNT(*) AS total_transactions,
SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
CONCAT(ROUND(SUM(CASE WHEN Class = 1 THEN 1 ELSE 0 END)*100.0 / COUNT(*),4), '%') AS fraud_rate
FROM cleaned_fraud_analysis_table;