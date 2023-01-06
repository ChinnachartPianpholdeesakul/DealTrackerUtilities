/* SQL Server database upgrade script	

   Version: 8.6.1
   Internal Version: 8.6.1.2
   
   Edit History:	
   
   datetime 	IssueID         	Fix          	Reason
   ==========   ==================  ===========  	====================================================
   19/05/2022	DTS_DT853			Surachai C.		[DTS_DT853] DT/MT 8.5.3
   17/10/2022	DTS_DT861			Surachai C.		[DTS_DT861] DT/MT 8.6.1
*/

	PRINT 'Beginning Upgrade Database Schema & View creation script at ' + CAST(SYSDATETIME() AS VARCHAR(50));

	USE DT_Archive8
	SET NOCOUNT ON	
	--SET ANSI_NULLS ON
	--GO
	--SET QUOTED_IDENTIFIER OFF
	--GO
	DECLARE @major smallint
	DECLARE @medium smallint
	DECLARE @minor smallint
	DECLARE @sizecal float

	SELECT @major = MajorRevision,
		@medium = MediumRevision,
		@minor = MinorRevision
		FROM Version
		WHERE ReleaseDate = (SELECT max(ReleaseDate) FROM Version)

	PRINT '	YOUR CURRENT SCHEMA VERSION IS ' + CAST(@major AS VARCHAR(4)) + '.' + CAST(@medium AS VARCHAR(4)) + '.' + CAST(@minor AS VARCHAR(4));

	IF @major = 8 AND @medium = 5 AND @minor = 3
	BEGIN
		BEGIN TRANSACTION;

		BEGIN TRY
			SELECT @sizecal = size * 8 / 1024.00 FROM sys.database_files WHERE [name] LIKE 'DT_Archive8'; 
			PRINT '	MDF Size = ' + CAST(@sizecal AS VARCHAR(20)) + ' MB';
			SELECT @sizecal = size * 8 / 1024.00 FROM sys.database_files WHERE [name] LIKE 'DT_Archive8_log'; 
			PRINT '	LDF Size = ' + CAST(@sizecal AS VARCHAR(20)) + ' MB';
				
			-- Step:1 exec('UPDATE New Deal Tracker Schema e.g add New column to some table, Change size of column, exec UPDATE data in some table etc.	
			-- 1.1 Drop Tickets Index
			PRINT 'Tickets : Start - Drop Index - ' + CAST(SYSDATETIME() as varchar(50));
			exec('DROP INDEX CCY1 ON Tickets');
			exec('DROP INDEX CCY2 ON Tickets');
			exec('DROP INDEX Dealer ON Tickets');
			exec('DROP INDEX DealId ON Tickets');
			exec('DROP INDEX DType ON Tickets');
			exec('DROP INDEX IdIndex ON Tickets');
			exec('DROP INDEX Processed ON Tickets');
			exec('DROP INDEX RRN ON Tickets');
			exec('DROP INDEX SR ON Tickets');
			exec('DROP INDEX TCID ON Tickets');
			exec('DROP INDEX TOD ON Tickets');
			exec('DROP INDEX Logon ON Tickets');
			exec('DROP INDEX DealerName ON Tickets');
			exec('DROP INDEX CoverIDX1 ON Tickets');
			exec('DROP INDEX CoverIDX2 ON Tickets');
			exec('DROP INDEX CoverIDX3 ON Tickets');
			exec('DROP INDEX CoverIDX4 ON Tickets');
			exec('DROP INDEX CoverIDX5 ON Tickets');
			PRINT 'Tickets : End - Drop Index - ' + CAST(SYSDATETIME() as varchar(50));
			
			-- 1.2 Alter column in Tickets Table
			PRINT 'Tickets : Start - Alter Columns - ' + CAST(SYSDATETIME() as varchar(50));
			exec('ALTER TABLE Tickets ALTER COLUMN ReviewReferenceNumber varchar(100)');
			PRINT 'Tickets : End - Alter Columns - ' + CAST(SYSDATETIME() as varchar(50));
			
			-- 1.3 CREATE Tickets Index
			PRINT 'Tickets : Start - Create Index - ' + CAST(SYSDATETIME() as varchar(50));
			exec('CREATE INDEX CCY1 ON Tickets(Currency1)');
			exec('CREATE INDEX CCY2 ON Tickets(Currency2)');
			exec('CREATE INDEX Dealer ON Tickets(DealerId)');
			exec('CREATE INDEX DealId ON Tickets(DealId)');
			exec('CREATE INDEX DType ON Tickets(PureDealType, DealType)');
			exec('CREATE UNIQUE INDEX IdIndex ON Tickets(Id)');
			exec('CREATE INDEX Processed ON Tickets(Processed)');
			exec('CREATE INDEX RRN ON Tickets(ReviewReferenceNumber)');
			exec('CREATE INDEX SR ON Tickets(SourceReference)');
			exec('CREATE INDEX TCID ON Tickets(Bank1DealingCode)');
			exec('CREATE CLUSTERED INDEX TOD ON Tickets(TimeOfDeal)');
			exec('CREATE INDEX Logon ON Tickets(LocalTCID, DealerId, DealerName)');
			exec('CREATE INDEX DealerName ON Tickets(DealerName)');
			exec('CREATE INDEX CoverIDX1 ON Tickets(LocalTCID, DealerId, DealerName, SourceReference, TimeOfDeal)');
			exec('CREATE INDEX CoverIDX2 ON Tickets(TimeOfDeal, LocalTCID, SourceReference, PureDealType, Bank1DealingCode, Currency1, DealVolumeCurrency1, Bank1Name)');
			exec('CREATE INDEX CoverIDX3 ON Tickets(TimeOfDeal, Currency1, LocalTCID, PureDealType, Currency2, DealVolumeCurrency1)');
			exec('CREATE INDEX CoverIDX4 ON Tickets(TimeOfDeal, LocalTCID, SourceReference, Bank1DealingCode, Bank1Name)');
			exec('CREATE INDEX CoverIDX5 ON Tickets(LocalTCID, SourceReference, TimeOfDeal, Id, DealId, Processed, ProcessedBy, SourceOfData)');
			PRINT 'Tickets : End - Create Index - ' + CAST(SYSDATETIME() as varchar(50));
			
			-- 1.4 Drop Conversations Index
			PRINT 'Conversations : Start - Drop Index - ' + CAST(SYSDATETIME() as varchar(50));
			exec('DROP INDEX CCY1 ON Conversations');
			exec('DROP INDEX CCY2 ON Conversations');
			exec('DROP INDEX Dealer ON Conversations');
			exec('DROP INDEX DType ON Conversations');
			exec('DROP INDEX IdIndex ON Conversations');
			exec('DROP INDEX NoDeal ON Conversations');
			exec('DROP INDEX SR ON Conversations');
			exec('DROP INDEX TCID ON Conversations');
			exec('DROP INDEX RRN on Conversations');
			exec('DROP INDEX LocalTCID on Conversations');
			exec('DROP INDEX TOD ON Conversations');
			exec('DROP INDEX Logon ON Conversations');
			exec('DROP INDEX CoverIDX1 ON Conversations');
			exec('DROP INDEX IDXDTFE ON Conversations');
			exec('DROP INDEX IDXArchiveTime ON Conversations');
			PRINT 'Conversations : End - Drop Index - ' + CAST(SYSDATETIME() as varchar(50));
			
			-- 1.5 Alter column in Conversations Table
			PRINT 'Conversations : Start - Alter Columns - ' + CAST(SYSDATETIME() as varchar(50));
			exec('ALTER TABLE Conversations ALTER COLUMN ReviewReferenceNumber varchar(100)');
			PRINT 'Conversations : End - Alter Columns - ' + CAST(SYSDATETIME() as varchar(50));
			
			-- 1.6 CREATE Conversations Index
			PRINT 'Conversations : Start - Create Index - ' + CAST(SYSDATETIME() as varchar(50));
			exec('CREATE INDEX CCY1 ON Conversations(Currency1)');
			exec('CREATE INDEX CCY2 ON Conversations(Currency2)');
			exec('CREATE INDEX Dealer ON Conversations(DealerId)');
			exec('CREATE INDEX DType ON Conversations(PureDealType, DealType)');
			exec('CREATE UNIQUE INDEX IdIndex ON Conversations(Id)');
			exec('CREATE INDEX NoDeal ON Conversations(NoDeal)');
			exec('CREATE INDEX SR ON Conversations(SourceReference)');
			exec('CREATE INDEX TCID ON Conversations(Bank1DealingCode)');
			exec('CREATE INDEX RRN on Conversations(ReviewReferenceNumber)');
			exec('CREATE INDEX LocalTCID on Conversations(LocalTCID)');
			exec('CREATE CLUSTERED INDEX TOD ON Conversations(TimeOfDeal)');
			exec('CREATE INDEX Logon ON Conversations(LocalTCID, DealerId, DealerName)');
			exec('CREATE INDEX CoverIDX1 ON Conversations(SourceReference, Id, TCID, TimeOfDeal, TicketStatus, NoDeal)');
			exec('CREATE INDEX IDXDTFE ON Conversations(DTFEID)');
			exec('CREATE INDEX IDXArchiveTime ON Conversations(ArchiveTime)');
			PRINT 'Conversations : End - Create Index - ' + CAST(SYSDATETIME() as varchar(50));
			
			SELECT @sizecal = size * 8 / 1024.00 FROM sys.database_files WHERE [name] LIKE 'DT_Archive8'; 
			PRINT '	MDF Size = ' + CAST(@sizecal AS VARCHAR(20)) + ' MB';
			SELECT @sizecal = size * 8 / 1024.00 FROM sys.database_files WHERE [name] LIKE 'DT_Archive8_log'; 
			PRINT '	LDF Size = ' + CAST(@sizecal AS VARCHAR(20)) + ' MB';
			
			PRINT '	UPDATE SCRIPT COMPLETE'
			PRINT 'Ending Upgrade Database Schema & View creation script at ' + CAST(SYSDATETIME() AS VARCHAR(50));
			PRINT ''
		
			SET NOEXEC OFF;
				
		END TRY  
		BEGIN CATCH 

			PRINT N'Caught FROM line ' + CAST(ERROR_LINE() AS VARCHAR) + ': ' + ERROR_MESSAGE();

			IF @@TRANCOUNT > 0  
				ROLLBACK TRANSACTION;

		END CATCH;  
	END
	ELSE
	BEGIN
		IF @major = 8 AND @medium = 6 AND @minor = 0
		BEGIN
			PRINT '	Your database is up-to-date'
		END
		ELSE
		BEGIN
			PRINT '	This database does not support this script'
		END
		
		PRINT 'Ending Upgrade Database Schema & View creation script at ' + CAST(SYSDATETIME() AS VARCHAR(50));
		PRINT ''
	
	END
	
IF @@TRANCOUNT > 0  
    COMMIT TRANSACTION;  
GO