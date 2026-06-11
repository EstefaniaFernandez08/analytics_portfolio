-- Apply the row count to check on before and after the update

SELECT 
    SOURCE_SYSTEM,
    EXPENSE_TYPE,
    ACCOUNT_CDE,
    ACCOUNT,
    SUM(TOTAL_SPEND_USD) AS TOTAL_SPEND_USD,
    COUNT(SOURCE_SYSTEM) AS ROW_COUNT
FROM DF_TBC_SPEND_FINAL
WHERE SOURCE_SYSTEM = 'Concur'AND EXPENSE_TYPE IN 
    (
   'Meals: Business Meals with Customers',
   'Travel: Taxi/Car Service',
   'Travel: Tolls, Associate business only'
    )
GROUP BY 
    SOURCE_SYSTEM,
    EXPENSE_TYPE,
    ACCOUNT_CDE,
    ACCOUNT
ORDER BY EXPENSE_TYPE DESC;

-- update script

UPDATE DF_TBC_SPEND_FINAL
SET
--update account code
    ACCOUNT_CDE = CASE 
        WHEN EXPENSE_TYPE = 'Meals: Business Meals with Customers' AND ACCOUNT_CDE = '610040' 
            THEN '610041'
        WHEN EXPENSE_TYPE = 'Travel: Taxi/Car Service' AND ACCOUNT_CDE = '610070' 
            THEN '610092'
        WHEN EXPENSE_TYPE = 'Travel: Tolls, Associate business only' AND ACCOUNT_CDE = '610070'
            THEN '610093'
        ELSE ACCOUNT_CDE
    END,
--update account 
    ACCOUNT = CASE 
        WHEN EXPENSE_TYPE = 'Meals: Business Meals with Customers'  AND ACCOUNT = 'Travel Expenses - Meals' 
            THEN 'Entertain: Meals-Business Meals with Cust 50% dedu'
        WHEN EXPENSE_TYPE = 'Travel: Taxi/Car Service' AND ACCOUNT = 'Travel Expenses - Airfare, Rail, Bus' 
            THEN 'Travel Exp-Taxi/Car Service'
        WHEN EXPENSE_TYPE = 'Travel: Tolls, Associate business only' AND ACCOUNT = 'Travel Expenses - Airfare, Rail, Bus' 
            THEN 'Travel Exp-Employee Tolls Business Only'
        ELSE ACCOUNT
    END
-- select only the specified rows
WHERE EXPENSE_TYPE IN 
    (
        'Meals: Business Meals with Customers',
       'Travel: Taxi/Car Service',
       'Travel: Tolls, Associate business only'
    )
AND 
    (
    (ACCOUNT_CDE = '610040' AND ACCOUNT = 'Travel Expenses - Meals')
    OR (ACCOUNT_CDE = '610070' AND ACCOUNT = 'Travel Expenses - Airfare, Rail, Bus')
);

    