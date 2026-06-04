-- 1.1. Create/Delete the server-side table structure
CREATE TABLE SUB_UPDATE_TABLE
(
    SUPPLIER_NBR VARCHAR2(4000 BYTE), 
    SUPPLIER_TYPE VARCHAR2(4000 BYTE), 
    SUPPLIER_ADDRESS_1 VARCHAR2(4000 BYTE), 
    SUPPLIER_ADDRESS_2 VARCHAR2(4000 BYTE), 
    SUPPLIER_ADDRESS_3 VARCHAR2(4000 BYTE), 
    SUPPLIER_CITY VARCHAR2(4000 BYTE), 
    SUPPLIER_STATE VARCHAR2(4000 BYTE), 
    SUPPLIER_ZIP_POSTAL_CDE VARCHAR2(4000 BYTE), 
    SUPPLIER_COUNTRY VARCHAR2(4000 BYTE)
);

/* 1.2 Import data into the server-side

        a. Right-click on the created temporary table "SUB_UPDATE_TABLE"  and select "Import Data."
        b. In the Import Data window, browse and select the downloaded CSV file.
        c. In the Import Data window, modify the format to "csv" and encoding to "UTF-8".
        d. Click "Next" on the Import Method tab.
        e. Click "Next" on the Choose Columns tab.
        f. Click "Next" on the Column Definition tab.
        g. Click "Finish".
        h. Wait for the data to load successfully. */
        
-- 2. run the merge/update statement
MERGE INTO SUB_SPEND_FINAL FINAL -- Begin the merge operation into the final spend table
USING (SELECT * FROM SUB_UPDATE_TABLE)SIDE
-- Define the condition for a match between the tables
ON (FINAL.SUPPLIER_NBR=SIDE.SUPPLIER_NBR)
-- Specify the update action
WHEN MATCHED THEN
UPDATE SET
    FINAL.SUPPLIER_ADDRESS_1 = SIDE.SUPPLIER_ADDRESS_1,
    FINAL.SUPPLIER_ADDRESS_2 = SIDE.SUPPLIER_ADDRESS_2,
    FINAL.SUPPLIER_ADDRESS_3 = SIDE.SUPPLIER_ADDRESS_3,
    FINAL.SUPPLIER_CITY = SIDE.SUPPLIER_CITY,
    FINAL.SUPPLIER_COUNTRY = SIDE.SUPPLIER_COUNTRY,
    FINAL.SUPPLIER_STATE = SIDE.SUPPLIER_STATE,
    FINAL.SUPPLIER_TYPE = SIDE.SUPPLIER_TYPE,
    FINAL.SUPPLIER_ZIP_POSTAL_CDE = SIDE.SUPPLIER_ZIP_POSTAL_CDE
-- Define the exclusions for the update
WHERE  SUPPLIER_ADDRESS_1 IS NULL AND SOURCE_DATA = 'Invoice'
;

-- 3. Drop the update table
DROP TABLE SUB_UPDATE_TABLE;