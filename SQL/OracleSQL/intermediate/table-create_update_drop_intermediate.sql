-- 1. create the table scructure for the update
CREATE TABLE TBC_UPDATE_TABLE 
(
    EXPENSE_TYPE VARCHAR2(4000 BYTE),
    ACCOUNT_CDE VARCHAR2(4000 BYTE),
    ACCOUNT VARCHAR2(4000 BYTE)
);

-- 2. import the csv file into the update table

--3. run the script

-- update ACCOUNT_CDE where it's blank and SOURCE_DATA is 'Concur'
UPDATE TBC_SPEND_FINAL s
SET s.ACCOUNT_CDE = (SELECT u.ACCOUNT_CDE
                        FROM TBC_UPDATE_TABLE u
                        WHERE u.EXPENSE_TYPE = s.EXPENSE_TYPE)
WHERE s.ACCOUNT_CDE IS NULL
AND s.SOURCE_DATA = 'Concur';

 -- update ACCOUNT where it's blank and SOURCE_DATA is 'Concur'
UPDATE TBC_SPEND_FINAL s
SET s.ACCOUNT = (SELECT u.ACCOUNT
                    FROM TBC_UPDATE_TABLE u
                    WHERE u.EXPENSE_TYPE = s.EXPENSE_TYPE)
WHERE s.ACCOUNT IS NULL
AND s.SOURCE_DATA = 'Concur';


-- 4. drop  the update table
DROP TABLE  DF_TBC_UPDATE_TABLE;