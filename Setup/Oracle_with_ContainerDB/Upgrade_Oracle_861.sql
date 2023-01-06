-- Support Oracle database upgrade script
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
SET TIMING ON;
SET SQLBLANKLINES ON;
SET SERVEROUTPUT ON SIZE 1000000;
WHENEVER OSERROR EXIT FAILURE ROLLBACK;
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK;

PROMPT Beginning Upgrade Database Schema & View creation script.;
PROMPT;

var rc number;
var IsDBExist NUMBER;
DECLARE
    MAJOR     NUMBER(3);
    MEDIUM    NUMBER(3);
    MINOR     NUMBER(3);
BEGIN
    SELECT COUNT(NAME) 
    INTO :IsDBExist
    FROM V$TABLESPACE
    WHERE NAME = 'DT_ARCHIVE8N';
	
	IF (:IsDBExist > 0) THEN
		EXECUTE IMMEDIATE 'SELECT MajorRevision, MediumRevision, MinorRevision FROM (SELECT *       
		FROM C##RTR_DT8N.Version order by RELEASEDATE desc) WHERE (rownum < 2)'
		INTO MAJOR, MEDIUM,MINOR;
		:rc := (MAJOR*100) + (MEDIUM *10) + MINOR;
	  
	  IF (:rc <> 853) THEN
		RAISE_APPLICATION_ERROR(-20000, 'REQUIRED AT LEAST VERSION 8.5.3');
	  END IF;
	END IF;
END;
/

-- Step:1 exec('UPDATE New Database Schema e.g add New column to some table, Change size of column, exec('UPDATE data in some table etc.
-- 1.1 Alter column in Tickets Table
BEGIN
	DBMS_OUTPUT.PUT_LINE('Tickets Table : Start - Alter Column');
END;
/

ALTER TABLE C##RTR_DT8N.TICKETS MODIFY (REVIEWREFERENCENUMBER VARCHAR2(100));

BEGIN
	DBMS_OUTPUT.PUT_LINE('Tickets Table : End - Alter Column');
END;
/

-- 1.2 Alter column in Conversations Table
BEGIN
	DBMS_OUTPUT.PUT_LINE('Conversations Table : Start - Alter Column');
END;
/

ALTER TABLE C##RTR_DT8N.CONVERSATIONS MODIFY (REVIEWREFERENCENUMBER VARCHAR2(100));

BEGIN
	DBMS_OUTPUT.PUT_LINE('Conversations Table : End - Alter Column');
END;
/

-- Step:2 Update Store Procedure
PROMPT Start - CREATE Strore Procedure process;
@@ Procedure_Oracle_861.SQL;
/
PROMPT End - CREATE Strore Procedure process;
PROMPT;


PROMPT;
PROMPT UPDATE SCRIPT COMPLETE;

PROMPT;
PROMPT Ending Upgrade Database Schema creation script;