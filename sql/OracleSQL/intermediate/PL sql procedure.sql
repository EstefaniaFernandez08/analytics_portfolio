SET DEFINE OFF
SET SERVEROUTPUT ON;

--Variable declaration to count the number of rows updated
DECLARE
    ROWS_UPDATED NUMBER;
BEGIN
    UPDATE SUP_SPEND_FINAL SUB --main database
    --bring the columns to be updated
    SET (SUB.SUPPLIER_TYPE,
        SUB.SUPPLIER_ADDRESS_1,
        SUB.SUPPLIER_ADDRESS_2,
        SUB.SUPPLIER_ADDRESS_3,
        SUB.SUPPLIER_CITY,
        SUB.SUPPLIER_STATE,
        SUB.SUPPLIER_ZIP_POSTAL_CDE,
        SUB.SUPPLIER_COUNTRY) = 
        --Here is the part to establish a one-to-one relationship to update the data (the sub column must be updated with the lookup column)
        (SELECT LKP.SUPPLIER_TYPE,
        LKP.SUPPLIER_ADDRESS_1,
        LKP.SUPPLIER_ADDRESS_2,
        LKP.SUPPLIER_ADDRESS_3,
        LKP.SUPPLIER_CITY,
        LKP.SUPPLIER_STATE,
        LKP.SUPPLIER_ZIP_POSTAL_CDE,
        LKP.SUPPLIER_COUNTRY
        FROM SO_SUBNEW_SUPPLIERMASTER LKP  --Lookup table name
        WHERE SUB.SUPPLIER_NBR = LKP.SUPPLIER_NBR -- Part to create the relationship between tables
        AND SUB.SUPPLIER_ERP = LKP.SUPPLIER_ERP)
    WHERE EXISTS( --validates the existence of the supplier_nbrs and supplier_erps values
        SELECT 1
        FROM SO_SUBNEW_SUPPLIERMASTER LKP
        WHERE SUB.SUPPLIER_NBR = LKP.SUPPLIER_NBR 
        AND SUB.SUPPLIER_ERP = LKP.SUPPLIER_ERP);
    ROWS_UPDATED := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Rows updated with new suppliers: ' || ROWS_UPDATED);
END;