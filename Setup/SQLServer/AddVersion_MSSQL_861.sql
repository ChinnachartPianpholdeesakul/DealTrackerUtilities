/* SQL Server database upgrade script	

   Version: 8.6.1
   Internal Version: 8.6.1.2
   
   Edit History:	
   
   datetime 	IssueID         	Fix          	Reason
   ==========   ==================  ===========  	====================================================
   19/05/2022	DTS_DT853			Surachai C.		[DTS_DT853] DT/MT 8.5.3
   17/10/2022	DTS_DT861			Surachai C.		[DTS_DT861] DT/MT 8.6.1
*/

USE DT_ARCHIVE8
SET NOCOUNT ON

INSERT INTO Version (MajorRevision, MediumRevision, MinorRevision, ReleaseDate, ProductName)
VALUES ( $(major), $(medium), $(minor), $(rel_date), $(name) )
GO

PRINT '	YOUR CURRENT SCHEMA VERSION IS NOW ' + CAST($(major) AS VARCHAR(4))+ '.' + CAST($(medium) AS VARCHAR(4))+ '.' + CAST($(minor) AS VARCHAR(4)) + ' For ' + + CAST($(name) AS VARCHAR(255)) + ' Product.'
PRINT ''