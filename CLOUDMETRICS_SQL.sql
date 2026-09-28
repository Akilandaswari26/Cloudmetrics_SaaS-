create database cloudmetrics

use cloudmetrics

select * from customers_clean

SELECT * FROM subscription_clean

select * from support_ticket_clean

select * from usage_clean

-- USING JOIN+GROUP BY :

-- CUSTOMERS ACTIVE, CHURNED AND PAUSED :

SELECT
    s.Status,
    COUNT(DISTINCT s.CustomerID) AS CustomerCount
FROM Customers_clean c
JOIN subscription_clean s
    ON c.CustomerID = s.CustomerID
GROUP BY s.Status
ORDER BY CustomerCount DESC;

--USING GROUP BY :

-- WHICH PLAN GENERATES THE HIGHEST MRR? :

SELECT
    PlanName,
    SUM(MRR) AS TotalMRR,
    COUNT(DISTINCT CustomerID) AS CustomerCount
FROM subscription_clean
GROUP BY PlanName
ORDER BY TotalMRR DESC;


-- HAVING :
-- INDUSTRIES HAS MORE THAN 15 CHRNED CUSTOMERS:

SELECT
    c.Industry,
    COUNT(DISTINCT c.CustomerID) AS ChurnedCustomers
FROM customers_clean c
JOIN subscription_clean s
    ON c.CustomerID = s.CustomerID
WHERE s.Status = 'Churned'
GROUP BY c.Industry
HAVING COUNT(DISTINCT c.CustomerID) > 15
ORDER BY ChurnedCustomers DESC;

-- CASE:
-- CUSTOMERS BASED ON THEIR MRR

SELECT
    CustomerID,
    MRR,
    CASE
        WHEN MRR >= 1000 THEN 'High Value'
        WHEN MRR >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS CustomerValue
FROM subscription_clean;


-- SUBQUERY:
-- WHICH CUSTOMER HAVE MRR ABOVE THE AVERAGE MRR:

SELECT
    CustomerID,
    MRR
FROM subscription_clean
WHERE MRR > (
    SELECT AVG(MRR)
    FROM subscription_clean
)
ORDER BY MRR DESC;

--CTE:
-- BELOW-AVERAGE LOGIN ACTIVITY:

WITH CustomerUsage AS (
    SELECT
        CustomerID,
        AVG(Logins) AS AvgLogins
    FROM usage_clean
    GROUP BY CustomerID
)

SELECT
    CustomerID,
    AvgLogins
FROM CustomerUsage
WHERE AvgLogins < (
    SELECT AVG(AvgLogins)
    FROM CustomerUsage
)
ORDER BY AvgLogins;

-- WINDOW FUNCTION:

-- CUSTOMER BASED ON MRR EACH PLAN RANKING:

SELECT
    CustomerID,
    PlanName,
    MRR,
    RANK() OVER (
        PARTITION BY PlanName
        ORDER BY MRR DESC
    ) AS MRRRank
FROM subscription_clean;

-- ORPHAN RECORDS:
-- CUSTOMERID DOES NOT EXIST IN THE  CUSTOMERS TABLE

SELECT
    u.CustomerID,
    COUNT(*) AS OrphanRecords
FROM usage_clean u
LEFT JOIN customers_clean c
    ON u.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL
GROUP BY u.CustomerID;

SELECT
    u.CustomerID,
    CASE
        WHEN c.CustomerID IS NULL THEN 'Orphan Record'
        ELSE 'Valid Record'
    END AS RecordStatus,
    COUNT(*) AS RecordCount
FROM usage_clean u
LEFT JOIN customers_clean c
    ON u.CustomerID = c.CustomerID
GROUP BY
    u.CustomerID,
    CASE
        WHEN c.CustomerID IS NULL THEN 'Orphan Record'
        ELSE 'Valid Record'
    END;