-- Select files in the main folder
SELECT * FROM sftp_s3_archive
WHERE FILE_NAME LIKE '%TBC%'
ORDER BY CREATED_DATE DESC
;

-- Select supplier reports
SELECT * FROM sftp_s3_archive
WHERE FILE_NAME LIKE '%hpone%'
order;

SELECT * FROM sftp_s3_archive
WHERE FILE_NAME LIKE '%Vendor Power Pivot %' ORDER BY CREATED_DATE DESC;

SELECT * FROM sftp_s3_archive
WHERE FILE_NAME LIKE '%hpone%' 
ORDER BY CREATED_DATE DESC;

SELECT * FROM sftp_s3_archive
WHERE FILE_NAME LIKE '%hpo%' 
  AND CREATED_DATE = TO_DATE('01-DEC-23', 'DD-MMM-YY')
ORDER BY CREATED_DATE DESC;

s





SELECT * FROM sftp_s3_archive
WHERE FILE_NAME LIKE '/hpone/Extract%'
   OR FILE_NAME LIKE '/hpone/Spend%'
   OR FILE_NAME LIKE '/hpone/SB%'
ORDER BY FILE_NAME;


SELECT * FROM sftp_s3_archive
WHERE FILE_NAME LIKE '/hpone/Extract%'
   OR FILE_NAME LIKE '/hpone/Spend%'
   OR FILE_NAME LIKE '/hpone/SB%'
ORDER BY FILE_NAME;