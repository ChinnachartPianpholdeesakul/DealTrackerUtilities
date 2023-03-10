-- Support Oracle database Grant role to user script     
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


SET TIMING ON;
WHENEVER OSERROR EXIT FAILURE ROLLBACK;
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK;
SET SERVEROUTPUT ON

-- User Account
DECLARE
  username_val varchar2(50);
BEGIN
   DBMS_OUTPUT.PUT_LINE('Check user account if exist then skip for create new.');
   SELECT username INTO username_val FROM all_users WHERE username=UPPER('&1');
   EXCEPTION
   WHEN NO_DATA_FOUND THEN 
		DBMS_OUTPUT.PUT_LINE('No user found then create user: &1');   
		execute immediate 'CREATE USER &1 IDENTIFIED BY "reut" DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP';
		execute immediate 'GRANT CONNECT TO &1';
END;
/


-- Check Role 
DECLARE
  role_val varchar2(50);
BEGIN
   DBMS_OUTPUT.PUT_LINE('Check role if exist then skip for create new.');
   SELECT ROLE INTO role_val FROM DBA_ROLES where ROLE='C##RTR_DT8N_OBJ_RW_ROLE';
   EXCEPTION
   WHEN NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE('No role found then create role: C##RTR_DT8N_OBJ_RW_ROLE');   
	execute immediate 'CREATE ROLE C##RTR_DT8N_OBJ_RW_ROLE NOT IDENTIFIED';
END;
/


GRANT C##RTR_DT8N_OBJ_RW_ROLE TO &1;


-- Grant table to user account
GRANT CREATE JOB TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TICKETS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.CALLS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.COUNTERPARTIES TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.USERS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.REPORTS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.VERSION TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBUSERAUDIT TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBAUTOCHECKNODEALTCIDS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBLOGINLOG TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBTRADELOG TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBADMINLOG TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBSYSTEMCONFIGURATION TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBSOURCEOFDATA TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBPUREDEALTYPE TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBDEALTYPE TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBCUSTOMDEALINGFIELDS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBCHECKTICKETSTCIDS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBUSERTCIDDEALEREXCEPTIONLIST TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBSEARCH TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBSEARCHFIELD TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBMYLINKSPERSONALIZATION TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.CONVERSATIONS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBRUNNINGNUMBER TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBAUTOTICKETSGENERATIONTCIDS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.VERSIONTHIRDPARTY TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBCLEARINGHOUSE TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBUSERCUSTOMIZEVIEW TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBROLES TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.ALLOCATIONS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBUSERDEFINED TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.CONVERSATIONSCENTRIC TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.RATESOURCES TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT, INSERT, UPDATE, DELETE ON C##RTR_DT8N.TBTRADEREPORT TO C##RTR_DT8N_OBJ_RW_ROLE;

-- Create SYNONYM for table
CREATE OR REPLACE SYNONYM &1.."TICKETS" FOR "C##RTR_DT8N"."TICKETS";
CREATE OR REPLACE SYNONYM &1.."CALLS" FOR "C##RTR_DT8N"."CALLS";
CREATE OR REPLACE SYNONYM &1.."COUNTERPARTIES" FOR "C##RTR_DT8N"."COUNTERPARTIES";
CREATE OR REPLACE SYNONYM &1.."USERS" FOR "C##RTR_DT8N"."USERS";
CREATE OR REPLACE SYNONYM &1.."REPORTS" FOR "C##RTR_DT8N"."REPORTS";
CREATE OR REPLACE SYNONYM &1.."VERSION" FOR "C##RTR_DT8N"."VERSION";
CREATE OR REPLACE SYNONYM &1.."TBUSERAUDIT" FOR "C##RTR_DT8N"."TBUSERAUDIT";
CREATE OR REPLACE SYNONYM &1.."TBAUTOCHECKNODEALTCIDS" FOR "C##RTR_DT8N"."TBAUTOCHECKNODEALTCIDS";
CREATE OR REPLACE SYNONYM &1.."TBLOGINLOG" FOR "C##RTR_DT8N"."TBLOGINLOG";
CREATE OR REPLACE SYNONYM &1.."TBTRADELOG" FOR "C##RTR_DT8N"."TBTRADELOG";
CREATE OR REPLACE SYNONYM &1.."TBADMINLOG" FOR "C##RTR_DT8N"."TBADMINLOG";
CREATE OR REPLACE SYNONYM &1.."TBSYSTEMCONFIGURATION" FOR "C##RTR_DT8N"."TBSYSTEMCONFIGURATION";
CREATE OR REPLACE SYNONYM &1.."TBSOURCEOFDATA" FOR "C##RTR_DT8N"."TBSOURCEOFDATA";
CREATE OR REPLACE SYNONYM &1.."TBPUREDEALTYPE" FOR "C##RTR_DT8N"."TBPUREDEALTYPE";
CREATE OR REPLACE SYNONYM &1.."TBDEALTYPE" FOR "C##RTR_DT8N"."TBDEALTYPE";
CREATE OR REPLACE SYNONYM &1.."TBCUSTOMDEALINGFIELDS" FOR "C##RTR_DT8N"."TBCUSTOMDEALINGFIELDS";
CREATE OR REPLACE SYNONYM &1.."TBCHECKTICKETSTCIDS" FOR "C##RTR_DT8N"."TBCHECKTICKETSTCIDS";
CREATE OR REPLACE SYNONYM &1.."TBUSERTCIDDEALEREXCEPTIONLIST" FOR "C##RTR_DT8N"."TBUSERTCIDDEALEREXCEPTIONLIST";
CREATE OR REPLACE SYNONYM &1.."TBSEARCH" FOR "C##RTR_DT8N"."TBSEARCH";
CREATE OR REPLACE SYNONYM &1.."TBSEARCHFIELD" FOR "C##RTR_DT8N"."TBSEARCHFIELD";
CREATE OR REPLACE SYNONYM &1.."TBMYLINKSPERSONALIZATION" FOR "C##RTR_DT8N"."TBMYLINKSPERSONALIZATION";
CREATE OR REPLACE SYNONYM &1.."CONVERSATIONS" FOR "C##RTR_DT8N"."CONVERSATIONS";
CREATE OR REPLACE SYNONYM &1.."TBRUNNINGNUMBER" FOR "C##RTR_DT8N"."TBRUNNINGNUMBER";
CREATE OR REPLACE SYNONYM &1.."TBAUTOTICKETSGENERATIONTCIDS" FOR "C##RTR_DT8N"."TBAUTOTICKETSGENERATIONTCIDS";
CREATE OR REPLACE SYNONYM &1.."VERSIONTHIRDPARTY" FOR "C##RTR_DT8N"."VERSIONTHIRDPARTY";
CREATE OR REPLACE SYNONYM &1.."TBCLEARINGHOUSE" FOR "C##RTR_DT8N"."TBCLEARINGHOUSE";
CREATE OR REPLACE SYNONYM &1.."TBUSERCUSTOMIZEVIEW" FOR "C##RTR_DT8N"."TBUSERCUSTOMIZEVIEW";
CREATE OR REPLACE SYNONYM &1.."TBROLES" FOR "C##RTR_DT8N"."TBROLES";
CREATE OR REPLACE SYNONYM &1.."ALLOCATIONS" FOR "C##RTR_DT8N"."ALLOCATIONS";
CREATE OR REPLACE SYNONYM &1.."TBUSERDEFINED" FOR "C##RTR_DT8N"."TBUSERDEFINED";
CREATE OR REPLACE SYNONYM &1.."CONVERSATIONSCENTRIC" FOR "C##RTR_DT8N"."CONVERSATIONSCENTRIC";
CREATE OR REPLACE SYNONYM &1.."RATESOURCES" FOR "C##RTR_DT8N"."RATESOURCES";
CREATE OR REPLACE SYNONYM &1.."TBTRADEREPORT" FOR "C##RTR_DT8N"."TBTRADEREPORT";

-- Grant view
GRANT SELECT ON C##RTR_DT8N.VW_TCIDTICKETS TO C##RTR_DT8N_OBJ_RW_ROLE;
GRANT SELECT ON C##RTR_DT8N.VW_POSSIBLEDUPLICATES TO C##RTR_DT8N_OBJ_RW_ROLE;
CREATE OR REPLACE SYNONYM &1.."VW_TCIDTICKETS" FOR "C##RTR_DT8N"."VW_TCIDTICKETS";
CREATE OR REPLACE SYNONYM &1.."VW_POSSIBLEDUPLICATES" FOR "C##RTR_DT8N"."VW_POSSIBLEDUPLICATES";

-- Grant Package
GRANT EXECUTE ON C##RTR_DT8N.DTANALYSER_PCK TO C##RTR_DT8N_OBJ_RW_ROLE;
CREATE OR REPLACE SYNONYM &1.."DTANALYSER_PCK" FOR "C##RTR_DT8N"."DTANALYSER_PCK";

-- Grant Function
GRANT EXECUTE ON C##RTR_DT8N.FN_GETNEXTDAY TO C##RTR_DT8N_OBJ_RW_ROLE;
CREATE OR REPLACE SYNONYM &1.."FN_GETNEXTDAY" FOR "C##RTR_DT8N"."FN_GETNEXTDAY";


SET TIMING OFF;