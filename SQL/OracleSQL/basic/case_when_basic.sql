--first disable the substitution variable prompt
SET DEFINE OFF; 
--perform the update operation
UPDATE HPO_SPEND_FINAL
SET COST_CENTER_L2 = 
  CASE COST_CENTER_L2_CDE
    WHEN '604' THEN 'Risk Management & Legal'
    WHEN '125' THEN 'CCT Team - Brokerage & PMT'
    ELSE COST_CENTER_L2
  END;

COMMIT;

--enable the substitution variable prompt again
SET DEFINE ON; 