-- Instuction: Update the existing Fiscal Calendar acording to client expectations

-- 0. Evaluate row count and spend usd before and after running the script
SELECT
    BUSINESS_GROUP,
    FISCAL_YEAR,
    FISCAL_QUARTER,
    COUNT(DIVERSITY_FLAG) AS ROW_COUNT,
    COUNT(DISTINCT SUPPLIER_NORMALIZED) AS DISTINCT_NORMALIZED,
    SUM(SPEND_USD) AS SPEND_USD
FROM
    DF_SUB_SUP_DIV
WHERE 
    BUSINESS_GROUP = 'IPC'
GROUP BY 
    BUSINESS_GROUP,
    FISCAL_YEAR,
    FISCAL_QUARTER;
    
--1. Update the fiscal year for the IPC
UPDATE SUB_SUP_DIV
SET FISCAL_YEAR = CASE 
                      WHEN FISCAL_QUARTER = 'FY23' THEN 'CY_2023'
                      WHEN FISCAL_QUARTER = 'FY2024 H1' THEN 'FY_2024'
                  END,
    FISCAL_QUARTER = CASE 
                         WHEN FISCAL_QUARTER = 'FY23' THEN 'CY2023'
                         ELSE FISCAL_QUARTER
                     END
WHERE BUSINESS_GROUP = 'IPC';

