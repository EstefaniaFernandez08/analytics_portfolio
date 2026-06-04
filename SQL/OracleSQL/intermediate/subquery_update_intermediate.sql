/* Instruction: Kruger Foods Inc - In the IPC data for Fiscal Quarter = FY2024 H1  please change

SD WBE SRC VALID: 2024-11-30
SD WBE Flag: Y
SD WBE SRC: WBENC
SD WBENC Certified: 2024-11-30
Diverse flag: YES
Supplier Diversity Attributes: WBE*/

UPDATE SUB_SUP_DIV
SET
    (
        DIVERSITY_FLAG,
        SD_CORP_STRUCTURE,
        SD_DIVERSITY_ATTRIBUTES,
        SD_INDUSTRY,
        SD_IS_WBE,
        SD_SIC,
        SD_WBE_SRC,
        SD_WBE_SRC_VALID,
        SD_WBENC_CERTIFIED 
    )=
    (
        SELECT
            DIVERSITY_FLAG,
            SD_CORP_STRUCTURE,
            'WBE',-- Directly assiigning 'WBE' to SD_DIVERSITY_ATTRIBUTES
            SD_INDUSTRY,
            SD_IS_WBE,
            SD_SIC,
            SD_WBE_SRC,
            TO_DATE('30-NOV-24', 'DD-MM-RR'), --Set SD_WBE_SRC_VALID to a specific date
            TO_DATE('30-NOV-24', 'DD-MM-RR') -- Set SD_WBENC_CERTIFIED to a specific date
        FROM SUB_SUP_DIV
        WHERE BUSINESS_GROUP = 'IPC' AND SUPPLIER_NORMALIZED = 'KRUGER FOODS INC' AND FISCAL_YEAR = 'CY_2023'
    )
WHERE BUSINESS_GROUP = 'IPC' AND SUPPLIER_NORMALIZED = 'KRUGER FOODS INC' AND FISCAL_YEAR = 'FY_2024';
