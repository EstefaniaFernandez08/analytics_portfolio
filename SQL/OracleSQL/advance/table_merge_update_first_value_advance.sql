-- 1.1.  Create the server-side table structure
CREATE TABLE SUB_UPDATE_TABLE
(
        BUSINESS_GROUP VARCHAR2(4000 BYTE),
        SOURCE_DATA VARCHAR2(4000 BYTE),
        INVOICE_DATE DATE,
        SUPPLIER_NBR VARCHAR2(4000 BYTE),
        SUPPLIER_NORMALIZED VARCHAR2(4000 BYTE),
        SUPPLIER_PARENT VARCHAR2(4000 BYTE),
        HOLDING_COMPANY VARCHAR2(4000 BYTE)
);

/* 1.2. Import the data into the server-side table

        a. Right-click on the created temporary table "SUB_UPDATE_TABLE"  and select "Import Data."
        b. In the Import Data window, browse and select the downloaded CSV file.
        c. In the Import Data window, modify the format to "csv" and encoding to "UTF-8".
        d. Click "Next" on the Import Method tab.
        e. Click "Next" on the Choose Columns tab.
        f. Click "Next" on the Column Definition tab.
        g. Click "Finish".
        h. Wait for the data to load successfully. */

-- 2. Insert the holding company data one table at a time
-- 2.1. Merge the holding company data into the sub_spend_final
MERGE INTO SUB_SPEND_FINAL FINAL
USING (
    SELECT DISTINCT
        SIDE.SUPPLIER_NBR,
        SIDE.SUPPLIER_NORMALIZED,
        FIRST_VALUE(SIDE.HOLDING_COMPANY) OVER (PARTITION BY SIDE.SUPPLIER_NBR, SIDE.SUPPLIER_NORMALIZED ORDER BY SUPPLIER_NORMALIZED) AS HOLDING_COMPANY
    FROM SUB_UPDATE_TABLE SIDE
) SIDE
ON (
    FINAL.SUPPLIER_NBR = SIDE.SUPPLIER_NBR AND
    FINAL.SUPPLIER_NORMALIZED = SIDE.SUPPLIER_NORMALIZED AND
    FINAL.BUSINESS_GROUP = 'FAF'
)
WHEN MATCHED THEN
    UPDATE SET FINAL.HOLDING_COMPANY = SIDE.HOLDING_COMPANY
WHERE FINAL.BUSINESS_GROUP = 'FAF' AND FISCAL_YEAR IN ('FY_2022', 'FY_2023');

-- 2.1. Merge the holding company data into the sub_sup_div
MERGE INTO SUB_SUP_DIV FINAL
USING (
    SELECT DISTINCT
        SIDE.SUPPLIER_NBR,
        SIDE.SUPPLIER_NORMALIZED,
        FIRST_VALUE(SIDE.HOLDING_COMPANY) OVER (PARTITION BY SIDE.SUPPLIER_NBR, SIDE.SUPPLIER_NORMALIZED ORDER BY SUPPLIER_NORMALIZED) AS HOLDING_COMPANY
    FROM SUB_UPDATE_TABLE SIDE
) SIDE
ON (
    FINAL.SUPPLIER_NBR = SIDE.SUPPLIER_NBR AND
    FINAL.SUPPLIER_NORMALIZED = SIDE.SUPPLIER_NORMALIZED AND
    FINAL.BUSINESS_GROUP = 'FAF'
)
WHEN MATCHED THEN
    UPDATE SET FINAL.HOLDING_COMPANY = SIDE.HOLDING_COMPANY
WHERE FINAL.BUSINESS_GROUP = 'FAF';

-- 3. Drop the server-side table
DROP TABLE SUB_UPDATE_TABLE;

