/* SQL Server database upgrade script	

   Version: 8.6.1
   Internal Version: 8.6.1.2
   
   Edit History:	
   
   datetime 	IssueID         	Fix          	Reason
   ==========   ==================  ===========  	====================================================
   19/05/2022	DTS_DT853			Surachai C.		[DTS_DT853] DT/MT 8.5.3
   17/10/2022	DTS_DT861			Surachai C.		[DTS_DT861] DT/MT 8.6.1
*/

	PRINT 'Beginning Update Stats at ' + CAST(SYSDATETIME() AS VARCHAR(50));

	USE DT_Archive8
	EXEC sp_updatestats; 
	PRINT 'End sp_updatestats';
	
	
GO