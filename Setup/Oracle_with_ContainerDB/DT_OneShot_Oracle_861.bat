:: Version: 8.6.1																																					
:: Internal Version: 8.6.1.2
:: Support Oracle database
:: 																																			
:: Edit History:																																									
::
:: Date         IssueID             Fix          	Reason
:: ==========   ==================  ===========  	====================================================
:: 19/05/2022	DTS_DT853			Surachai C.		[DTS_DT853] DT/MT 8.5.3
:: 17/10/2022	DTS_DT861			Surachai C.		[DTS_DT861] DT/MT 8.6.1

@echo off

set conn=%1/%2"@"%3 as sysdba
set output=spool.txt

echo -- START CREATE DATABASE SCHEMA -- 
SQLPLUS %conn% @OneShot_Oracle_861.sql >%output%

echo -- Deal Tracker Utilities version 8.6.1.2 is running. -- >>%output%

IF %ERRORLEVEL% == -1 GOTO UNKNOWN
IF %ERRORLEVEL% == 1 GOTO ERRORCONN
IF %ERRORLEVEL% == 861 GOTO UPTODATE
echo -- INSTALLATION IN PROGRESS. PLEASE WAIT... -- 
IF %ERRORLEVEL% == 0 GOTO FULL
IF %ERRORLEVEL% == 831 GOTO UPGRADE831
IF %ERRORLEVEL% == 840 GOTO UPGRADE840
IF %ERRORLEVEL% == 841 GOTO UPGRADE841
IF %ERRORLEVEL% == 850 GOTO UPGRADE850
IF %ERRORLEVEL% == 852 GOTO UPGRADE852
IF %ERRORLEVEL% == 853 GOTO UPGRADE853
echo.
echo -- UNKNOWN CURRENT SCHEMA VERSION %ERRORLEVEL% REQUIRED AT LEAST VERSION 8.3.1 --
echo -- UNKNOWN CURRENT SCHEMA VERSION %ERRORLEVEL% REQUIRED AT LEAST VERSION 8.3.1 -- >>%output%
echo.

 GOTO END

:UNKNOWN
	echo -- UNKNOWN ERROR -- >>%output%
	GOTO END
	
:ERRORCONN
	echo -- ERROR IN CONNECTION, PLEASE CHECK DATABASE CONNECTION STRING -- >>%output%
	GOTO END

:FULL
	echo -- FULL INSTALLATION VERSION 8.6.1 -- >>%output%
	echo EXIT | SQLPLUS %conn% @Full_Oracle_861.sql >>%output%
	GOTO VERSION

:UPTODATE
	echo -- YOUR DATABASE IS UP-TO-DATE -- >>%output%
	:: Do nothing
	GOTO END
	
:UPGRADE831
	echo -- UPGRADE INSTALLATION FROM VERSION 8.3.1 -- >>%output%
	echo EXIT | SQLPLUS %conn% @"..\DT_Utilities_8.4.0\Setup\Oracle_with_ContainerDB\Upgrade_Oracle_840.sql" >>%output%
	
	set majorRevision=8
	set mediumRevision=4
	set minorRevision=0
	set releaseDate="'30-Jun-2021'"
	set productName="'Deal Tracker Analyzer'"
	echo EXIT | SQLPLUS %conn% @..\DT_Utilities_8.4.0\Setup\Oracle_with_ContainerDB\AddVersion_Oracle_840.sql %majorRevision% %mediumRevision% %minorRevision% %releaseDate% %productName% >>%output%
	:: continue to next case

:UPGRADE840
	echo -- UPGRADE INSTALLATION FROM VERSION 8.4.0 -- >>%output%
	echo EXIT | SQLPLUS %conn% @"..\DT_Utilities_8.4.1\Setup\Oracle_with_ContainerDB\Upgrade_Oracle_841.sql" >>%output%
	
	set majorRevision=8
	set mediumRevision=4
	set minorRevision=1
	set releaseDate="'31-Aug-2021'"
	set productName="'Deal Tracker Analyzer'"
	echo EXIT | SQLPLUS %conn% @..\DT_Utilities_8.4.1\Setup\Oracle_with_ContainerDB\AddVersion_Oracle_841.sql %majorRevision% %mediumRevision% %minorRevision% %releaseDate% %productName% >>%output%
	:: continue to next case

:UPGRADE841
	echo -- UPGRADE INSTALLATION FROM VERSION 8.4.1 -- >>%output%
	echo EXIT | SQLPLUS %conn% @"..\DT_Utilities_8.5.0\Setup\Oracle_with_ContainerDB\Upgrade_Oracle_850.sql" >>%output%
	
	set majorRevision=8
	set mediumRevision=5
	set minorRevision=0
	set releaseDate="'15-Dec-2021'"
	set productName="'Deal Tracker Analyzer'"
	echo EXIT | SQLPLUS %conn% @..\DT_Utilities_8.5.0\Setup\Oracle_with_ContainerDB\AddVersion_Oracle_850.sql %majorRevision% %mediumRevision% %minorRevision% %releaseDate% %productName% >>%output%
	:: continue to next case
	
:UPGRADE850
	echo -- UPGRADE INSTALLATION FROM VERSION 8.5.0 -- >>%output%
	echo EXIT | SQLPLUS %conn% @"..\DT_Utilities_8.5.2\Setup\Oracle_with_ContainerDB\Upgrade_Oracle_852.sql" >>%output%
	
	set majorRevision=8
	set mediumRevision=5
	set minorRevision=2
	set releaseDate="'22-Mar-2022'"
	set productName="'Deal Tracker Analyzer'"
	echo EXIT | SQLPLUS %conn% @..\DT_Utilities_8.5.2\Setup\Oracle_with_ContainerDB\AddVersion_Oracle_852.sql %majorRevision% %mediumRevision% %minorRevision% %releaseDate% %productName% >>%output%
	:: continue to next case
	
:UPGRADE852
	echo -- UPGRADE INSTALLATION FROM VERSION 8.5.2 -- >>%output%
	echo EXIT | SQLPLUS %conn% @"..\DT_Utilities_8.5.3\Setup\Oracle_with_ContainerDB\Upgrade_Oracle_853.sql" >>%output%
	
	set majorRevision=8
	set mediumRevision=5
	set minorRevision=3
	set releaseDate="'21-Jul-2022'"
	set productName="'Deal Tracker Analyzer'"
	echo EXIT | SQLPLUS %conn% @..\DT_Utilities_8.5.3\Setup\Oracle_with_ContainerDB\AddVersion_Oracle_853.sql %majorRevision% %mediumRevision% %minorRevision% %releaseDate% %productName% >>%output%
	:: continue to next case
	
:UPGRADE853
	echo -- UPGRADE INSTALLATION FROM VERSION 8.5.3 -- >>%output%
	echo EXIT | SQLPLUS %conn% @Upgrade_Oracle_861.sql >>%output%
	:: continue to next case
	
:VERSION
	set majorRevision=8
	set mediumRevision=6
	set minorRevision=1
	set releaseDate="'17-Jan-2023'"
	set productName="'Deal Tracker Analyzer'"
	echo EXIT | SQLPLUS %conn% @AddVersion_Oracle_861.sql %majorRevision% %mediumRevision% %minorRevision% %releaseDate% %productName% >>%output%
	:: continue to next case
	
:END
	echo -- END OF SCRIPT, PLEASE VERIFY THE RESULT IN SPOOL.TXT -- 
	
PAUSE


				