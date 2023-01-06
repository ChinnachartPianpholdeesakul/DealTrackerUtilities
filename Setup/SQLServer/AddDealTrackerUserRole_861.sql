/* SQL Server database upgrade script	

   Version: 8.6.1
   Internal Version: 8.6.1.2
   
   Edit History:	
   
   datetime 	IssueID         	Fix          	Reason
   ==========   ==================  ===========  	====================================================
   19/05/2022	DTS_DT853			Surachai C.		[DTS_DT853] DT/MT 8.5.3
   17/10/2022	DTS_DT861			Surachai C.		[DTS_DT861] DT/MT 8.6.1
*/

DECLARE @dttm VARCHAR(55)
SELECT  @dttm=convert(varchar,getdate(),113)
raiserror('Beginning Database grant permission. %s ....',1,1,@dttm) with nowait

USE [DT_Archive8]
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'DealTrackerUserRole')
BEGIN
	CREATE ROLE [DealTrackerUserRole] AUTHORIZATION [dbo]
END

-- GRANT AUTHORIZATION to DealTrackerUserRole role
ALTER AUTHORIZATION ON SCHEMA::[db_datareader] TO [DealTrackerUserRole]
ALTER AUTHORIZATION ON SCHEMA::[db_datawriter] TO [DealTrackerUserRole]

-- To Add “DealTrackerUserRole” is be “db_datareader” and “db_datawriter” role member
EXEC sp_addrolemember N'db_datareader', N'DealTrackerUserRole'
EXEC sp_addrolemember N'db_datawriter', N'DealTrackerUserRole'

-- GRANT EXECUTE permission for all storeprocedure to DealTrackerUserRole role
GRANT EXECUTE ON [dbo].[sp_CheckFullAutoGenTicket] TO [DealTrackerUserRole] AS [dbo]
GRANT EXECUTE ON [dbo].[sp_IncrementRunningValue] TO [DealTrackerUserRole] AS [dbo]
GRANT EXECUTE ON [dbo].[sp_InsertAutoGenTicket] TO [DealTrackerUserRole] AS [dbo]
GRANT EXECUTE ON [dbo].[sp_RemoveJobPurgeAuditTrail] TO [DealTrackerUserRole] AS [dbo]
GRANT EXECUTE ON [dbo].[sp_CreateJobPurgeAuditTrail] TO [DealTrackerUserRole] AS [dbo]
GRANT EXECUTE ON [dbo].[sp_PurgeAuditTrail] TO [DealTrackerUserRole] AS [dbo]
GRANT EXECUTE ON [dbo].[sp_CheckCanUsePurge] TO [DealTrackerUserRole] AS [dbo]
GRANT EXECUTE ON [dbo].[SP_INSERTGENTICKETBYDEALTYPE] TO [DealTrackerUserRole] AS [dbo]
GRANT EXECUTE ON [dbo].[SP_INSERTMANUALGENTICKET] TO [DealTrackerUserRole] AS [dbo]

DECLARE @dttm VARCHAR(55)
SELECT  @dttm=convert(varchar,getdate(),113)
raiserror('Ending Database grant permission. %s ....',1,1,@dttm) with nowait



