-- Support Oracle 19c database
--  
-- Version: 8.6.1
-- Internal Version: 8.6.1.2
-- 
-- Edit History:
--  
-- Date         IssueID             Fix          	Reason
-- ==========   ==================  ===========  	====================================================
-- 19/05/2022	DTS_DT853			Surachai C.		[DTS_DT853] DT/MT 8.5.3
-- 17/10/2022	DTS_DT861			Surachai C.		[DTS_DT861] DT/MT 8.6.1


-- Script for supporting Oracle
SET SERVEROUTPUT ON SIZE 1000000;

INSERT INTO RTR_DT8N.VERSION (MAJORREVISION, MEDIUMREVISION, MINORREVISION, RELEASEDATE, PRODUCTNAME)
VALUES (&1, &2, &3, '&4', '&5' );

SET TIMING OFF
COMMIT;

PROMPT YOUR CURRENT SCHEMA VERSION IS NOW &1 &2 &3;