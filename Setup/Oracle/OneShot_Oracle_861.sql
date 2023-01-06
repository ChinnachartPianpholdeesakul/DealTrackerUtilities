-- Support Oracle database
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

var rc number;
var IsDBExist NUMBER;
whenever sqlerror exit :rc
exec :rc:=-1;

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
		FROM RTR_DT8N.Version order by RELEASEDATE desc) WHERE (rownum < 2)'
		INTO MAJOR, MEDIUM,MINOR;
		:rc := (MAJOR*100) + (MEDIUM *10) + MINOR;
	ELSE
	
		SELECT COUNT(NAME) 
		INTO :IsDBExist
		FROM V$TABLESPACE
		WHERE NAME = 'DT_ARCHIVE8';
		
		IF (:IsDBExist > 0) THEN
		  EXECUTE IMMEDIATE 'SELECT MajorRevision, MediumRevision, MinorRevision FROM (SELECT *       
		  FROM RTR_DT8.Version order by RELEASEDATE desc) WHERE (rownum < 2)'
		  INTO MAJOR, MEDIUM,MINOR;
		  :rc := (MAJOR*100) + (MEDIUM *10) + MINOR;
		ELSE 
		-- No DT_ARCHIVE8 exist in this machine -- 
			:rc := 0;
		END IF;
	END IF;
	END;
	/
exit :rc