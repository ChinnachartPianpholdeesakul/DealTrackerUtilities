/* SQL Server database upgrade script	

   Version: 8.6.1
   Internal Version: 8.6.1.2
   
   Edit History:	
   
   datetime 	IssueID         	Fix          	Reason
   ==========   ==================  ===========  	====================================================
   19/05/2022	DTS_DT853			Surachai C.		[DTS_DT853] DT/MT 8.5.3
   17/10/2022	DTS_DT861			Surachai C.		[DTS_DT861] DT/MT 8.6.1
*/


USE MASTER
SET NOCOUNT ON
Declare @rc int
SET @rc=-1

Declare @i int
SELECT @i = count(*) FROM SYS.DATABASES WHERE NAME ='DT_ARCHIVE8'

DECLARE @major SMALLINT, @medium SMALLINT, @minor SMALLINT
create table #tmpversion (major smallint, medium smallint, minor smallint)

IF (@i <= 0) /*If no DT_ARCHIVE8 previously, create new database*/
BEGIN

	SELECT @i = count(*) FROM SYS.DATABASES WHERE NAME ='DT_ARCHIVE'

	IF (@i <= 0) /*If no DT_ARCHIVE8 previously, create new database*/
	BEGIN
		SET @rc=0
	END
	ELSE
	BEGIN
		exec ('USE DT_ARCHIVE
		insert into #tmpversion(major,medium,minor) select 
		MajorRevision,
		MediumRevision,
		MinorRevision
		from Version
		where ReleaseDate = (select max(ReleaseDate) from Version)
		 ' )

		Select	
		@major = major,
		@medium = medium,
		@minor = minor
		from #tmpversion
		
		SET @rc=(@major*100) + (@medium *10) + @minor;
	END
END
ELSE
BEGIN	
	exec ('USE DT_ARCHIVE8
	insert into #tmpversion(major,medium,minor) select 
	MajorRevision,
	MediumRevision,
	MinorRevision
	from Version
	where ReleaseDate = (select max(ReleaseDate) from Version)
	 ' )

	Select	
	@major = major,
	@medium = medium,
	@minor = minor
	from #tmpversion
	
	SET @rc=(@major*100) + (@medium *10) + @minor;
END

drop table #tmpversion

EXIT (Select @rc AS CurrentSchema)