/* Changes to Update 

1. In DIVERSITY_ATTRIBUTES, find ANY cases where the following 6 characters exist - "SC-SDB" convert the only the 6 characters of "SD-SDB" -> "SDB" 
2. Update DIVERSE_FLAG -> "NO"
*/

-- Disable substitution prompt
SET DEFINE OFF;
    
-- Update the attribute name by removing 'SC-' from specific entries
UPDATE SUB_SUP_DIV 
SET SD_DIVERSITY_ATTRIBUTES = REPLACE(SD_DIVERSITY_ATTRIBUTES, 'SC-', '')
WHERE SD_DIVERSITY_ATTRIBUTES IN (
    'MBE SMALL SC-SDB HUB',
    'SMALL SC-SDB',
    'SMALL SC-SDB HUB',
    'WBE SMALL SC-SDB');

-- Update diversity flag based on new attribute values
UPDATE SUB_SUP_DIV
SET DIVERSITY_FLAG = 'NO'
WHERE SD_DIVERSITY_ATTRIBUTES IN ('SMALL SDB', 'SMALL SDB HUB');

COMMIT;
