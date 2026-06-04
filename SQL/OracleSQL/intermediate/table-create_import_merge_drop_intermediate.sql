-- 1.1. Create the server-side table structure
CREATE TABLE TBC_UPDATE_TABLE

(
    ASSETID VARCHAR2(4000 BYTE),
    FILE_NAME VARCHAR2(4000 BYTE),	
    SUPPLIER_ERP VARCHAR2(4000 BYTE),
    SUPPLIER_NORMALIZED VARCHAR2(4000 BYTE),
    SOURCE_DATA VARCHAR2 (4000 BYTE),
    SOURCE_SYSTEM VARCHAR2 (4000 BYTE),
    TOTAL_SPEND_USD NUMBER(38,2)
);

/* 1.2 Import data into the server-side

        a. Right-click on the created temporary table "DF_TBC_UPDATE_TABLE"  and select "Import Data."
        b. In the Import Data window, browse and select the downloaded CSV file.
        c. In the Import Data window, modify the format to "csv" and encoding to "UTF-8".
        d. Click "Next" on the Import Method tab.
        e. Click "Next" on the Choose Columns tab.
        f. Click "Next" on the Column Definition tab.
        g. Click "Finish".
        h. Wait for the data to load successfully. */
        
-- 2. run the merge statement
-- Begin merge operation into the final spend table
MERGE INTO TBC_SPEND_FINAL FINAL
USING (
    -- Select relevant columns from the update table for the merge
    SELECT 
        ASSETID, FILE_NAME, SUPPLIER_ERP, SUPPLIER_NORMALIZED 
    FROM 
        TBC_UPDATE_TABLE
) SIDE
-- Define the condition for a match between the tables
ON (FINAL.ASSETID = SIDE.ASSETID AND
    FINAL.FILE_NAME = SIDE.FILE_NAME AND
    FINAL.SUPPLIER_ERP = SIDE.SUPPLIER_ERP)
-- Specify the update action on matched records
WHEN MATCHED THEN
    UPDATE SET FINAL.SUPPLIER_NORMALIZED = SIDE.SUPPLIER_NORMALIZED;
    
-- 3. drop the update table
DROP TABLE TBC_UPDATE_TABLE;
