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
raiserror('Beginning Database Creation / Update Stored procedures & Trigger script %s ....',1,1,@dttm) with nowait

USE DT_Archive8

-- Drop Unnecessary Store Procedures -Start
if exists (select * from sysobjects where id = object_id(N'[dbo].[GetRecentConv_sp]') 
and OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[GetRecentConv_sp]
GO

if exists (select * from sysobjects where id = object_id(N'[dbo].[sp_DTAglobalqueue]') 
and OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DTAglobalqueue]
GO

if exists (select * from sysobjects where id = object_id(N'[dbo].[sp_DTAglobalqueue2]') 
and OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DTAglobalqueue2]
GO

if exists (select * from sysobjects where id = object_id(N'[dbo].[sp_DTArecent]') 
and OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DTArecent]
GO

if exists (select * from sysobjects where id = object_id(N'[dbo].[sp_DTAsearch]') 
and OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DTAsearch]
GO

--Unused - Start
IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_ConvPosDeals]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_ConvPosDeals]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_ConvPosNoDeals]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_ConvPosNoDeals]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_NoDeals]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_NoDeals]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CheckedTickets]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CheckedTickets]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_AllConvUncheckedTickets]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_AllConvUncheckedTickets]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_PossibleDuplicates]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_PossibleDuplicates]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_ConvDetail]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_ConvDetail]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TopRecent]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TopRecent]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TradeRecent]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TradeRecent]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TradeQuickSearch]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TradeQuickSearch]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DTDatabaseVersion]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DTDatabaseVersion]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetCpty]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetCpty]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetCptyByLocalTCID]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetCptyByLocalTCID]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertCpty]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertCpty]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteCpty]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteCpty]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteCptyByLocalTCID]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteCptyByLocalTCID]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertLoginLog]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertLoginLog]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertAdminLog]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertAdminLog]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertTradelogForDetail]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertTradelogForDetail]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetAutoCheckNoDealTCIDs]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetAutoCheckNoDealTCIDs]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteAutoCheckNoDealTCIDs]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteAutoCheckNoDealTCIDs]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertAutoCheckNoDealTCIDs]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertAutoCheckNoDealTCIDs]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetAutoTicketsGenTCIDs]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetAutoTicketsGenTCIDs]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteAutoTicketsGenTCIDs]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteAutoTicketsGenTCIDs]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertAutoTicketsGenTCIDs]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertAutoTicketsGenTCIDs]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetCheckTicketsTCIDs]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetCheckTicketsTCIDs]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteCheckTicketsTCIDs]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteCheckTicketsTCIDs]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertCheckTicketsTCIDs]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertCheckTicketsTCIDs]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetCustomDealingFields]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetCustomDealingFields]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteCustomDealingFields]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteCustomDealingFields]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertCustomDealingFields]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertCustomDealingFields]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetRole]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetRole]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteRoleByNumber]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteRoleByNumber]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertRole]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertRole]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetUserCustomizeView]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetUserCustomizeView]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertUserCustomizeView]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertUserCustomizeView]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetUserPermission]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetUserPermission]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetUserById]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetUserById]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteUserById]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteUserById]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteSearchFieldsByUserId]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteSearchFieldsByUserId]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteSearchByUserId]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteSearchByUserId]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertNewUser]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertNewUser]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetRoleDetailOfUserList]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetRoleDetailOfUserList]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_ApplyUserListToRole]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_ApplyUserListToRole]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetTotSearchBySearchId]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetTotSearchBySearchId]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetSearchId]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetSearchId]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteSaveSearch]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteSaveSearch]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteSearchFieldById]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteSearchFieldById]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertSearch]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertSearch]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertSearchWithoutSysRole]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertSearchWithoutSysRole]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertSearchField]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertSearchField]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_SetSearchDefault]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_SetSearchDefault]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetMySearchesDataForAdmin]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetMySearchesDataForAdmin]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetMySearchesDataForUser]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetMySearchesDataForUser]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetMySearchesData]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetMySearchesData]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CopySearchCriteria]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CopySearchCriteria]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetTradeSearchCriteria]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetTradeSearchCriteria]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DefaultTradeSearchCriteria]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DefaultTradeSearchCriteria]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetSearchBySearchId]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetSearchBySearchId]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetPersonalization]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetPersonalization]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetPersonalization2]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetPersonalization2]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetPersonalization3]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetPersonalization3]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetPersonalization4]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetPersonalization4]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeletePersonalization]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeletePersonalization]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertPersonalization]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertPersonalization]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteSourceOfDataByCode]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteSourceOfDataByCode]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertSourceOfData]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertSourceOfData]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetSourceOfData]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetSourceOfData]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetSourceOfDataByCode]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetSourceOfDataByCode]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteSystemConfiguration]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteSystemConfiguration]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertSystemConfiguration]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertSystemConfiguration]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetSystemConfiguration]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetSystemConfiguration]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_SetAlertLicenseExpAllUser]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_SetAlertLicenseExpAllUser]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetDefaultUserRole]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetDefaultUserRole]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateForUserLayoutById]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateForUserLayoutById]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateForUserMaintenaneById]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateForUserMaintenaneById]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateRoleById]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateRoleById]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UncheckedTickets]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UncheckedTickets]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_WorkStatus]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_WorkStatus]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_WorkStatusStartEndConvOfDay]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_WorkStatusStartEndConvOfDay]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdatePersonalization]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdatePersonalization]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TradeSearchConvs]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TradeSearchConvs]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TradeSearch]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TradeSearch]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TradeSearchTickets]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TradeSearchTickets]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetClearingHouse]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetClearingHouse]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TradeReportResult]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TradeReportResult]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateSourceOfDataByCode]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateSourceOfDataByCode]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_ValidateConvSqlStatement]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_ValidateConvSqlStatement]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateCpty]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateCpty]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteClearingHouse]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteClearingHouse]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteClearingHouseByNumber]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteClearingHouseByNumber]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateClearingHouseFullName]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateClearingHouseFullName]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertClearingHouse]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertClearingHouse]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetLoginLog]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetLoginLog]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetAdminLog]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetAdminLog]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetTradeLog]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetTradeLog]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_ConvLookup]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_ConvLookup]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_ConvLookupDetailByConvId]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_ConvLookupDetailByConvId]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CptyTotalTradeLast12Months]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CptyTotalTradeLast12Months]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CptyTotalTradeSelectPeriod]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CptyTotalTradeSelectPeriod]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GroupedConvPosNoDeals]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GroupedConvPosNoDeals]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GroupedConvPosDeals]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GroupedConvPosDeals]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GroupedNoDeals]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GroupedNoDeals]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_IncrementConvPrinted]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_IncrementConvPrinted]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetConvPrintedNumber]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetConvPrintedNumber]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateNoDealStatus]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateNoDealStatus]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateReviewedAt]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateReviewedAt]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetConversationsByConvId]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetConversationsByConvId]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateCustomDealingField]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateCustomDealingField]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateMidOfficeComment]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateMidOfficeComment]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateConvDetailChecked1]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateConvDetailChecked1]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateConvDetailChecked2]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateConvDetailChecked2]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TicketDetail]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TicketDetail]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetPuredealtypeNot128Outr]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetPuredealtypeNot128Outr]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetFieldFromTicketUnionConv]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetFieldFromTicketUnionConv]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetContraTicketId]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetContraTicketId]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_IncrementTicketPrinted]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_IncrementTicketPrinted]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetTicketPrintedNumber]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetTicketPrintedNumber]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetTicketById]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetTicketById]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteTicketById]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteTicketById]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateTicketDetailById]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateTicketDetailById]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateTicketDetailChecked1]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateTicketDetailChecked1]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateTicketDetailChecked2]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateTicketDetailChecked2]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CptyIncomingCallByCpty]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CptyIncomingCallByCpty]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CptyIncomingCallByCptyInfo]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CptyIncomingCallByCptyInfo]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CptyConvInOut]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CptyConvInOut]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CptyAnalysisBySource]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CptyAnalysisBySource]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CptyAnalysisBySourceInfo]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CptyAnalysisBySourceInfo]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CcyAnalysisBySource]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CcyAnalysisBySource]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CcyAnalysisBySourceInfo]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CcyAnalysisBySourceInfo]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderAnalysisBySource]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderAnalysisBySource]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderAnalysisBySourceInfo]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderAnalysisBySourceInfo]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateLocalTCIDFilter]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateLocalTCIDFilter]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteUserTCIDDealerExcepts]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteUserTCIDDealerExcepts]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetTcidDealerExceptList]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetTcidDealerExceptList]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetTcidDealerExceptListUser]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetTcidDealerExceptListUser]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_DeleteTcidDealerExceptList]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_DeleteTcidDealerExceptList]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertTcidDealerExceptList]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertTcidDealerExceptList]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateForUserPreferenceById]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateForUserPreferenceById]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CcyTotTradeLast12Months]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CcyTotTradeLast12Months]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CcyTotTradeSelectPeriod]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CcyTotTradeSelectPeriod]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CcyTotTradeVolLast12Months]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CcyTotTradeVolLast12Months]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CcyTotTradeVolSelectPeriod]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CcyTotTradeVolSelectPeriod]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CcyRejectQuote]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CcyRejectQuote]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CcyRejectQuoteInfo]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CcyRejectQuoteInfo]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderProfile]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderProfile]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderProfileAnsCall]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderProfileAnsCall]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderProfileByCcy]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderProfileByCcy]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderProfileByCpty]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderProfileByCpty]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderProfileByCptyTotTrade]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderProfileByCptyTotTrade]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderProfileOutgoingConv]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderProfileOutgoingConv]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderProfileSumCall]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderProfileSumCall]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderProfileSumConv]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderProfileSumConv]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderProfileSumTrade]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderProfileSumTrade]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_OutConvByTraderPerCpty]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_OutConvByTraderPerCpty]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_OutConvInfo]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_OutConvInfo]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscTradeBySource]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscTradeBySource]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscTradeBySourceInfo]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscTradeBySourceInfo]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetCurrentApplyToRole]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetCurrentApplyToRole]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_GetHomePageEnableCount]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_GetHomePageEnableCount]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertTradelogForNormal]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertTradelogForNormal]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscUnAnsCall]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscUnAnsCall]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscRecentCall]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscRecentCall]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscLatestConv]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscLatestConv]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscMissingTicket]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscMissingTicket]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateAllFields]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateAllFields]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscCptyLookupAnsCall]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscCptyLookupAnsCall]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscCptyLookupOutgoingConv]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscCptyLookupOutgoingConv]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscCptyLookupSumCall]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscCptyLookupSumCall]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscCptyLookupSumConv]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscCptyLookupSumConv]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscCptyLookupSumTrade]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscCptyLookupSumTrade]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscCptyLookupTotCall]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscCptyLookupTotCall]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscCptyLookupTradeByCcy]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscCptyLookupTradeByCcy]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscCptyLookupTradeBySource]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscCptyLookupTradeBySource]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscCptyLookupUnAnsCall]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscCptyLookupUnAnsCall]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateSearch]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateSearch]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateSearchWithoutSysRole]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateSearchWithoutSysRole]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderTotTradeSelectPeriod]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderTotTradeSelectPeriod]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderTotTradeLast12Months]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderTotTradeLast12Months]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_TraderProfileBySource]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_TraderProfileBySource]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_MiscCptyLookupTradeByTrader]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_MiscCptyLookupTradeByTrader]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_UpdateUserCustomizeView]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_UpdateUserCustomizeView]
GO

-- Drop Unnesscerry Storeprocedure -End

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CheckFullAutoGenTicket]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CheckFullAutoGenTicket]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_IncrementRunningValue]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_IncrementRunningValue]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_InsertAutoGenTicket]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_InsertAutoGenTicket]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_RemoveJobPurgeAuditTrail]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_RemoveJobPurgeAuditTrail]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CreateJobPurgeAuditTrail]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CreateJobPurgeAuditTrail]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_PurgeAuditTrail]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_PurgeAuditTrail]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[sp_CheckCanUsePurge]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[sp_CheckCanUsePurge]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[SP_INSERTGENTICKETBYDEALTYPE]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[SP_INSERTGENTICKETBYDEALTYPE]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[SP_INSERTMANUALGENTICKET]') 
AND OBJECTPROPERTY(id,N'IsProcedure')=1)
DROP PROCEDURE [dbo].[SP_INSERTMANUALGENTICKET]
GO

-- ###Trigger###---
IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[ConvInsertedTrigger]') 
AND OBJECTPROPERTY(id,N'IsTrigger')=1)
DROP TRIGGER [dbo].[ConvInsertedTrigger]
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[AutoCheckTicketsForTCIDs]') 
AND OBJECTPROPERTY(id,N'IsTrigger')=1)
DROP TRIGGER [dbo].[AutoCheckTicketsForTCIDs]
GO

SET QUOTED_IDENTIFIER OFF
SET ANSI_NULLS ON
GO



/*Store procedure for check Full ATG*/
/*Parameter:
- return is valid for full ATG ex:				ex: 1
- Value of field PureDealType ex:				ex: 2
- Value of field DealVolumeCurrency1			ex: 1000000
- Value of field Currency1						ex: 'USD'
- Value of field Currency2						ex: 'USD'
- Value of field DealType						ex: 1
- Value of field ExchangeRatePeriod1			ex: 0.99
- Value of field ExchangeRatePeriod2			ex: 0.99
- Value of field DepositRate					ex: 0.99
- Value of field SwapRate						ex: 0.99
- Value of field ValueDatePeriod1Currency1		ex: 01/01/1900
- Value of field ValueDatePeriod1Currency2		ex: 01/01/1900
- Value of field ValueDatePeriod2Currency1		ex: 01/01/1900
- Value of field ValueDatePeriod2Currency2		ex: 01/01/1900
- Value of field FraFixingDate					ex: 01/01/1900
- Value of field FraSettlementDate				ex: 01/01/1900
- Value of field FraMaturityDate				ex: 01/01/1900
*/
CREATE   PROCEDURE [dbo].[sp_CheckFullAutoGenTicket] 
	@nIsFullAutoGenTicket tinyint OUTPUT,
	@nDealType smallint,
	@fVolume float,
	@strCurrency1 char(3),
	@strCurrency2 char(3),
	@nDirection tinyint,
	@fExchangeRateP1 float,
	@fExchangeRateP2 float, 
	@fDepositRate float,
	@fSwapRate float,
	@dtValueDateP1C1 datetime,
	@dtValueDateP1C2 datetime,
	@dtValueDateP2C1 datetime,
	@dtValueDateP2C2 datetime, 
	@dtFraFixingDate datetime,
	@dtFraSettlementDate datetime,
	@dtFramaturityDate datetime,
	@strInterestDayBasis VARCHAR(10) = NULL,
	@nResetFrequency smallint = NULL,
	@strIndex1 VARCHAR(20) = NULL,
	@strOptionType VARCHAR(20) = NULL,
	@fTotalNetPremiumAmount float = NULL,
	@strPremiumCurrency VARCHAR(3) = NULL,
	@nExpiryStyle smallint = NULL,
	@dtStartDate datetime = NULL, 
	@dtEndDate datetime = NULL, 
	@dtDeliveryDate datetime = NULL, 
	@dtExpiryDate datetime = NULL,
	@volatility1 float,
	@volatility2 float,
	@premiumAmount1 float,
	@premiumAmount2 float

AS
BEGIN
	SET NOCOUNT ON

	SET @nIsFullAutoGenTicket = 0
	IF((@nDealType IN (2,4,128) AND @fVolume <> 0 AND @strCurrency1 <> '' AND @strCurrency2 <> '' AND 
							@nDirection > 0 AND @fExchangeRateP1 <> 0 AND @dtValueDateP1C1 is not null AND @dtValueDateP1C2 is not null) 
		OR (@nDealType = 8 AND @fVolume <> 0 AND @strCurrency1 <> '' AND @strCurrency2 <> '' AND @nDirection > 0 AND 
							@fExchangeRateP1 <> 0 AND @fExchangeRateP2 <> 0 AND @fSwapRate <> 0 AND 
							@dtValueDateP1C1 is not null AND @dtValueDateP1C2 is not null AND @dtValueDateP2C1 is not null AND @dtValueDateP2C2 is not null) 
		OR (@nDealType = 13 AND @fVolume <> 0 AND @strCurrency1 <> '' AND @nDirection > 0 AND @fDepositRate <> 0 AND 
							@dtValueDateP1C1 is not null AND @dtValueDateP2C1 is not null)
		OR (@nDealType = 16 AND @fVolume <> 0 AND @strCurrency1 <> '' AND @nDirection > 0 AND @fDepositRate <> 0 AND 
							@dtValueDateP1C1 is not null AND @dtValueDateP2C1 is not null)
		OR (@nDealType = 32 AND @fVolume <> 0 AND @strCurrency1 <> '' AND @nDirection > 0 AND @fDepositRate <> 0 AND @dtFraFixingDate is not null AND 
							@dtFraSettlementDate is not null AND @dtFraMaturityDate is not null)
		OR ((@nDealType = 9 OR @nDealType = 10) AND @fVolume <> 0 AND @strCurrency1 <> '' AND 
							@dtStartDate is not null AND @dtEndDate is not null and
							@strInterestDayBasis <> '' AND @nResetFrequency <> 0 AND @strIndex1 <> '')
		OR (@nDealType = 7 AND @nDirection > 0 AND @fVolume <> 0 AND @strCurrency1 <> '' AND @strCurrency2 <> '' and
							@fExchangeRateP1 <> 0 AND @dtDeliveryDate is not null AND @dtExpiryDate is not null and
							@strOptionType <> '' AND (@volatility1 > 0 OR @volatility2 >0) AND (@premiumAmount1 <> 0 OR @premiumAmount2 <> 0) AND 
							@strPremiumCurrency <> '' AND @nExpiryStyle <> 0))
	BEGIN  
		SET @nIsFullAutoGenTicket = 1
	END 
END
-- End sp_CheckFullAutoGenTicket
GO



/*Store procedure for get running value */
/*Parameter:
- Return Current Running Value							ex:	111111
- Key Name FOR Retrieve Running Value					ex:	1 
- Auto Increment Running Value WHEN Procedure Called	ex: 1
*/
CREATE   PROCEDURE [dbo].[sp_IncrementRunningValue] 
	@nValue Numeric(10,0) OUTPUT,
	@strKeyName VARCHAR(50)
AS
	SET NOCOUNT ON

	DECLARE @nMaxValue Numeric(10,0)

	BEGIN TRANSACTION 

		SELECT @nValue = RunningValue,@nMaxValue = MaxValue FROM tbRunningNumber (UPDLOCK) WHERE KeyName = @strKeyName;

		IF(@nValue + 1) > @nMaxValue
		BEGIN
			UPDATE tbRunningNumber SET RunningValue = MinValue WHERE KeyName = @strKeyName
		END
		ELSE
		BEGIN
			UPDATE tbRunningNumber SET RunningValue = RunningValue + 1 WHERE KeyName = @strKeyName
		END

	COMMIT TRANSACTION 
-- End sp_IncrementRunningValue
GO



/*Store procedure for INSERT Ticket with ATG Trigger*/
/*Parameter:
- Conversations.ID											ex:	11111
- Type of auto gen Ticket									ex:	1(Full), 2(Partial)
- Is SET Tickets.Processed to 1 OR 0						ex: 1
- Is SET Tickets.Processed2 to 1 OR 0						ex: 1
*/
CREATE   PROCEDURE [dbo].[sp_InsertAutoGenTicket] 
	@nConv_ID Numeric(18,0),
	@nCreationType tinyint,
	@nSetChecked1 tinyint,
	@nSetChecked2 tinyint 
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @dProcessDate DATETIME
	DECLARE @dUTCProcessDate DATETIME

	SELECT @dProcessDate = GetDate();
	SELECT @dUTCProcessDate = GetUTCDate();

	DECLARE @nNewId Numeric(10,0)
	EXEC sp_IncrementRunningValue @nNewId OUTPUT, 'AutoTicketDealID'

	INSERT INTO Tickets 
		(
			[DealId]
			,[Processed]
			,[ProcessedBy]
			,[ProcessedAt]
			,[Processed2]
			,[Processed2By]
			,[Processed2At]
			,[LocalTCID]
			,[SourceReference]
			,[TimeOfDeal]
			,[DealerId]
			,[PureDealType]
			,[DealType]
			,[Bank1DealingCode]
			,[BrokerDealingCode]
			,[Currency1]
			,[Currency2]
			,[DealVolumeCurrency1]
			,[ExchangeRatePeriod1]
			,[ExchangeRatePeriod2]
			,[MethodOfDeal]
			,[Period1]
			,[Period2]
			,[ConfirmationTime]
			,[ConfirmedById]
			,[Bank1Name]
			,[DepositRate]
			,[SwapRate]
			,[SourceOfData]
			,[RateDirection]
			,[ValueDatePeriod1Currency1]
			,[ValueDatePeriod1Currency2]
			,[ValueDatePeriod2Currency1]
			,[ValueDatePeriod2Currency2]
			,[DealerName]
			,[ReviewReferenceNumber]
			,[BrokerName]
			,[FRAFixingDate]
			,[FRASettlementDate]
			,[FRAMaturityDate]
			,[IMMIndicator]
			,[OutrightPointsPremiumRate]
			,[SpotBasisRate]
			,[ConversationText]
			,[ConfirmedByName]
			,[IDifContra]
			,[IDPrevious]
			,[AutoGeneratedTicket]
			,[TransactionID] 
			,[StartDate]
			,[EndDate]
			,[DeliveryDate]
			,[DeliveryDate2]
			,[ExpiryDate]
			,[ExpiryDate2]
			,[PaymentDate]
			,[PremiumDate]
			,[InterestDayBasis]
			,[InterestDayBasis2]
			,[Index1]
			,[Index2]
			,[ResetFrequency]
			,[ResetBusinessDayConvention]
			,[PaymentBusinessDayConvention]
			,[ResetCalendar]
			,[PaymentFrequency]
			,[SecondaryFrequency]
			,[StubIndicator] 
			,[StubRate]
			,[IndexSpread]
			,[OptionType]
			,[OptionType2]
			,[Cutoff]
			,[Cutoff2]
			,[ExpiryStyle]
			,[Direction2]
			,[TradingStrategy]
			,[Settlement]
			,[PremiumAmount]
			,[PremiumAmount2]
			,[Volatility]
			,[Volatility2]
			,[PremiumQuote]
			,[PremiumQuote2]
			,[PremiumCurrency]
			,[TotalNetPremiumAmount]
			,[PremiumQuoteConvention]
			,[DepositRateReference]
			,[DepositRateReference2]
			,[SwapPointsReference]
			,[SwapPointsReference2]
			,[SwiftBicC1P1]
			,[SwiftBicC1P2]
			,[SwiftBicC2P1]
			,[SwiftBicC2P2]
			,[PaymentInstructionP1C1]
			,[PaymentInstructionP1C2]
			,[PaymentInstructionP2C1]
			,[PaymentInstructionP2C2]
			,[FixedRate]
			,[CalVolumeP2C1]
			,[InterestVolume]
			,[ElapsedDays]
			,[YearLength]
			,[PriceConvention]
			,[ClearingHouse]
			,[ClearingAccount]
			,[OurClearingMember]
			,[TheirClearingMember]
			,[OnBehalfOfName]
			,[OnBehalfOfCode]
			,[PremiumDate2]
			,[MidPrice]
			,[BestBid]
			,[BestAsk]
			,[OurLEI]
			,[TheirLEI]
			,[BrokerageAmount]
			,[ReportingParty]
			,[Namespace]
			,[LinkID]
			,[TransactionID2]
			,[TradeRepository]
			,[BrokerageCurrency]
			,[CPUserID]
			,[CPUserName]
			,[UTI1]
			,[UTI2]
			,[Printed]
			,[OurEmailAddress]
			,[TheirEmailAddress]
			,[TradingInterface]
			,[BenchmarkFixingType1]
			,[BenchmarkFixingDate1]
			,[BenchmarkFixingRate1]
			,[BenchmarkFixingType2]
			,[BenchmarkFixingDate2]
			,[BenchmarkFixingRate2]
			,[Ourjurisdiction]
			,[Theirjurisdiction]
			,[Executionvenuetype]
			,[Ourclearingbroker]
			,[Ourclearingbrokerlei]
			,[Theirclearingbroker]
			,[Theirclearingbrokerlei]
			,[Executionid]
			,[Orderid]
			,[CallInitTime]
			,[AcceptTime]
			,[ConfirmedTime]
			,[ExtractedTime]
			,[FirstEndTime]
			,[SecondEndTime]
			,[QuoteTime]
			,[QuoteRejectTime]
			,[AggressorIndicator]
		 )
		SELECT [TCID]+'#MA'+ cast(@nNewId as VARCHAR)						--[DealId]
			,CASE WHEN @nSetChecked1 <> 0 THEN 1 ELSE 0 END					--,[Processed]
			,CASE WHEN @nSetChecked1 <> 0 THEN 'System' ELSE null END		--,[ProcessedBy]
			,CASE WHEN @nSetChecked1 <> 0 THEN @dProcessDate ELSE null END	--,[ProcessedAt]
			,CASE WHEN @nSetChecked2 <> 0 THEN 1 ELSE 0 END					--,[Processed2]
			,CASE WHEN @nSetChecked2 <> 0 THEN 'System' ELSE null END		--,[Processed2By]
			,CASE WHEN @nSetChecked2 <> 0 THEN @dProcessDate ELSE null END	--,[Processed2At]
			,[LocalTCID]
			,[SourceReference]		
			,[TimeOfDeal]		
			,[DealerId]			
			,CASE WHEN @nCreationType = 2 THEN 32000 ELSE [PureDealType] END 		
			,[DealType]			
			,[Bank1DealingCode]		
			,[BrokerDealingCode]		
			,[Currency1]						
			,CASE WHEN [PureDealType] IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN [Currency2] ELSE null END 	--,[Currency2]	
			,[DealVolumeCurrency1]				
			,[ExchangeRatePeriod1]				
			,[ExchangeRatePeriod2]				
			,1									--,[MethodOfDeal]
			,[Period1]							
			,[Period2]							
			,@dUTCProcessDate					--,[ConfirmationTime]
			,'System'							--,[ConfirmedById]
			,[Bank1Name]					
			,[DepositRate]					
			,[SwapRate]						
			,5									--,[SourceOfData]
			,[RateDirection]	
			,[ValueDatePeriod1Currency1]	
			,[ValueDatePeriod1Currency2]	
			,[ValueDatePeriod2Currency1]	
			,[ValueDatePeriod2Currency2]	
			,[DealerName]				
			,[ReviewReferenceNumber]		
			,[BrokerName]				
			,[FRAFixingDate]			
			,[FRASettlementDate]					
			,[FRAMaturityDate]						
			,[IMMIndicator]						
			,[OutrightPointsPremiumRate]				
			,[SpotBasisRate]						
			,[ConversationText]
			,'System'							--,[ConfirmedByName]
			,[TCID]+'#0'						--,[IDifContra]
			,[TCID]+'#0'						--,[IDPrevious]
			,@nCreationType						--,[AutoGenerate]
			,[TransactionID] 
			,[StartDate]
			,[EndDate]
			,[DeliveryDate]
			,[DeliveryDate2]
			,[ExpiryDate]
			,[ExpiryDate2]
			,[PaymentDate]
			,[PremiumDate]
			,[InterestDayBasis]
			,[InterestDayBasis2]
			,[Index1]
			,[Index2]
			,[ResetFrequency]
			,[ResetBusinessDayConvention]
			,[PaymentBusinessDayConvention]
			,[ResetCalendar]
			,[PaymentFrequency]
			,[SecondaryFrequency]
			,[StubIndicator] 
			,[StubRate]
			,[IndexSpread]
			,[OptionType]
			,[OptionType2]
			,[Cutoff]
			,[Cutoff2]
			,[ExpiryStyle]
			,[Direction2]
			,[TradingStrategy]
			,[Settlement]
			,[PremiumAmount]
			,[PremiumAmount2]
			,[Volatility]
			,[Volatility2]
			,[PremiumQuote]
			,[PremiumQuote2]
			,[PremiumCurrency]
			,[TotalNetPremiumAmount]
			,[PremiumQuoteConvention]
			,[DepositRateReference]
			,[DepositRateReference2]
			,[SwapPointsReference]
			,[SwapPointsReference2]
			,[SwiftBicC1P1]
			,[SwiftBicC1P2]
			,[SwiftBicC2P1]
			,[SwiftBicC2P2]
			,[PaymentInstructionP1C1]
			,[PaymentInstructionP1C2]
			,[PaymentInstructionP2C1]
			,[PaymentInstructionP2C2]
			,[FixedRate]
			,[CalVolumeP2C1]
			,[InterestVolume]
			,[ElapsedDays]
			,[YearLength]
			,[PriceConvention]
			,[ClearingHouse]
			,[ClearingAccount]
			,[OurClearingMember]
			,[TheirClearingMember]
			,[OnBehalfOfName]
			,[OnBehalfOfCode]
			,[PremiumDate2]
			,[MidPrice]
			,[BestBid]
			,[BestAsk]
			,[OurLEI]
			,[TheirLEI]
			,[BrokerageAmount]
			,[ReportingParty]
			,[Namespace]
			,[LinkID]
			,[TransactionID2]
			,[TradeRepository]
			,[BrokerageCurrency]
			,[CPUserID]
			,[CPUserName]
			,[UTI1]
			,[UTI2]
			,0									--,[Printed]
			,[OurEmailAddress]
			,[TheirEmailAddress]
			,[TradingInterface]
			,[BenchmarkFixingType1]
			,[BenchmarkFixingDate1]
			,[BenchmarkFixingRate1]
			,[BenchmarkFixingType2]
			,[BenchmarkFixingDate2]
			,[BenchmarkFixingRate2]
			,[Ourjurisdiction]
			,[Theirjurisdiction]
			,[Executionvenuetype]
			,[Ourclearingbroker]
			,[Ourclearingbrokerlei]
			,[Theirclearingbroker]
			,[Theirclearingbrokerlei]
			,[Executionid]
			,[Orderid]
			,[CallInitTime]
			,[AcceptTime]
			,[ConfirmedTime]
			,[ExtractedTime]
			,[FirstEndTime]
			,[SecondEndTime]
			,[QuoteTime]
			,[QuoteRejectTime] 
			,[AggressorIndicator] 
		FROM conversations WHERE id = @nConv_ID 

		UPDATE conversations SET TicketStatus = 1, NoDeal = 0 WHERE id = @nConv_ID
END
-- End sp_InsertAutoGenTicket
GO


CREATE   PROCEDURE [dbo].[sp_RemoveJobPurgeAuditTrail]
AS

SET NOCOUNT ON

BEGIN TRANSACTION 
	  DECLARE @JobID BINARY(16)  
	  DECLARE @ReturnCode INT    
	  SELECT @ReturnCode = 0 

	  -- Delete the job with the same name (IF it exists)
	  SELECT @JobID = job_id     
	  FROM   msdb.dbo.sysjobs_view    
	  WHERE (name = N'JOB_PURGEAUDITTRAIL')       
	  
	  IF(@JobID IS NOT NULL)    
	  BEGIN  
		-- Delete the [local] job 
		EXECUTE msdb.dbo.sp_delete_job @job_name = N'JOB_PURGEAUDITTRAIL' 
	  END 

COMMIT TRANSACTION    
      
GOTO   EndSave              
QuitWithRollback:
  IF(@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave:

-- End Creation Store Procedure sp_RemoveJobPurgeAuditTrail
GO



CREATE   PROCEDURE [dbo].[sp_CreateJobPurgeAuditTrail]
	@numDay int,
	@startDateTime VARCHAR(20),
	@DayOfWeek VARCHAR(30)
AS

	SET NOCOUNT ON

	BEGIN TRANSACTION 
		DECLARE @JobID BINARY(16)  
		DECLARE @ReturnCode INT    
		SELECT @ReturnCode = 0 

		EXEC sp_RemoveJobPurgeAuditTrail;

	BEGIN 
		DECLARE @command_sp VARCHAR(100);
		DECLARE @db_name VARCHAR(50);
		DECLARE @next_date_run DATETIME;
		DECLARE @active_start_date_run VARCHAR(10);
		DECLARE @active_start_time_run VARCHAR(10);
		DECLARE @DayOfWeekInt INT;
		DECLARE @dateDb DATETIME,@dateGmt DATETIME;
		SELECT @command_sp = N'EXEC SP_PURGEAUDITTRAIL ' + CAST(@numDay as VARCHAR);
		SELECT @db_name = db_name();
		SELECT @next_date_run = CAST(DATEADD(MINUTE, datediff(MINUTE ,GETUTCDATE(),getdate()), @startDateTime) as DATETIME)

		SELECT @active_start_date_run = CONVERT(CHAR(10),@next_date_run,112);	--YYYYMMDD
		SELECT @active_start_time_run = CAST(DATEPART(hh, @next_date_run) as VARCHAR)+ --hhmmss
		  (CASE LEN(CAST(DATEPART(mi, @next_date_run) as VARCHAR)) 
			WHEN 1 THEN  '0'+CAST(DATEPART(mi, @next_date_run) as VARCHAR)
			ELSE CAST(DATEPART(mi, @next_date_run) as VARCHAR)  END ) +'00';	


		SELECT  @dateGmt = CAST(CONVERT(CHAR(10),@startDateTime,112) as DATETIME)
			   , @dateDb = CAST(CONVERT(CHAR(10),@next_date_run,112) as DATETIME)

		-- Shift
		IF @dateDb > @dateGmt 
		BEGIN 
		  SELECT @DayOfWeekInt = (CASE WHEN CHARINDEX('SUN',@DayOfWeek)> 0 THEN 2 ELSE 0 END)|
			(CASE WHEN CHARINDEX('MON',@DayOfWeek) > 0 THEN 4 ELSE 0 END)|
			(CASE WHEN CHARINDEX('TUE',@DayOfWeek) > 0 THEN 8 ELSE 0 END)|
			(CASE WHEN CHARINDEX('WED',@DayOfWeek) > 0 THEN 16 ELSE 0 END)|
			(CASE WHEN CHARINDEX('THU',@DayOfWeek) > 0 THEN 32 ELSE 0 END)|
			(CASE WHEN CHARINDEX('FRI',@DayOfWeek) > 0 THEN 64 ELSE 0 END)|
			(CASE WHEN CHARINDEX('SAT',@DayOfWeek) > 0 THEN 1 ELSE 0 END);
		END;
		ELSE IF @dateDb < @dateGmt 
		BEGIN 
		  SELECT @DayOfWeekInt = (CASE WHEN CHARINDEX('SUN',@DayOfWeek)> 0 THEN 64 ELSE 0 END)|
			(CASE WHEN CHARINDEX('MON',@DayOfWeek) > 0 THEN 1 ELSE 0 END)|
			(CASE WHEN CHARINDEX('TUE',@DayOfWeek) > 0 THEN 2 ELSE 0 END)|
			(CASE WHEN CHARINDEX('WED',@DayOfWeek) > 0 THEN 4 ELSE 0 END)|
			(CASE WHEN CHARINDEX('THU',@DayOfWeek) > 0 THEN 8 ELSE 0 END)|
			(CASE WHEN CHARINDEX('FRI',@DayOfWeek) > 0 THEN 16 ELSE 0 END)|
			(CASE WHEN CHARINDEX('SAT',@DayOfWeek) > 0 THEN 32 ELSE 0 END);
		END;
		ELSE
		BEGIN
		  SELECT @DayOfWeekInt = (CASE WHEN CHARINDEX('SUN',@DayOfWeek)> 0 THEN 1 ELSE 0 END)|
			(CASE WHEN CHARINDEX('MON',@DayOfWeek) > 0 THEN 2 ELSE 0 END)|
			(CASE WHEN CHARINDEX('TUE',@DayOfWeek) > 0 THEN 4 ELSE 0 END)|
			(CASE WHEN CHARINDEX('WED',@DayOfWeek) > 0 THEN 8 ELSE 0 END)|
			(CASE WHEN CHARINDEX('THU',@DayOfWeek) > 0 THEN 16 ELSE 0 END)|
			(CASE WHEN CHARINDEX('FRI',@DayOfWeek) > 0 THEN 32 ELSE 0 END)|
			(CASE WHEN CHARINDEX('SAT',@DayOfWeek) > 0 THEN 64 ELSE 0 END);
		END;

		-- Add the job
		EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT , 
		@job_name = N'JOB_PURGEAUDITTRAIL', 	
		@description = N'Purging of the Database AuditTrail Log Table.', 
		@category_name = N'Database Maintenance', 
		@enabled = 1, 
		@notify_level_email = 0, 
		@notify_level_page = 0, 
		@notify_level_netsEND = 0, 
		@notify_level_eventlog = 2, 
		@delete_level= 0
		IF(@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

		-- Add the job steps
		EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, 
		@step_id = 1, 
		@step_name = N'Schedule AuditTrail Log Table Purge', 
		@commAND = @command_sp , 
		@database_name = @db_name, 
		@server = N'',	
		@subsystem = N'TSQL', 
		@cmdexec_success_code = 0, 
		@flags = 0, 
		@retry_attempts = 0, 
		@retry_interval = 1, 
		@output_file_name = N'', 
		@on_success_step_id = 0, 
		@on_success_action = 1, 
		@on_fail_step_id = 0, 
		@on_fail_action = 2
		IF(@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

		EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 

		IF(@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

		-- Add the job schedules
		EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, 
				@name = N'JobSchedule', 
				@enabled = 1, 
				@freq_type = 8, --8=weekly
				@active_start_date = @active_start_date_run, 
				@active_start_time = @active_start_time_run, 
				@freq_interval = @DayOfWeekInt, -- DayOfWeek
				@freq_subday_type = 1, 
				@freq_subday_interval = 0, 
				@freq_relative_interval = 0, 
				@freq_recurrence_factOR = 1
		IF(@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

		-- Add the Target Servers
		EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)' 
		IF(@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

	END
	COMMIT TRANSACTION 
			 
	GOTO   EndSave              
	QuitWithRollback:
	  IF(@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
	EndSave:

-- End Creation Store Procedure sp_CreateJobPurgeAuditTrail
GO 



CREATE   PROCEDURE [dbo].[sp_PurgeAuditTrail]
	@numDay int
AS

	SET NOCOUNT ON

	DECLARE  @loginLogLastDate DATETIME;
	DECLARE  @adminLogLastDate DATETIME;
	DECLARE  @tradeLogLastDate DATETIME;

	-- Convert to MM/DD/YYYY
	SELECT @loginLogLastDate =CAST(CONVERT(CHAR(10),MAX(datetime),112) as DATETIME) FROM tbloginlog;
	SELECT @adminLogLastDate =CAST(CONVERT(CHAR(10),MAX(datetime),112) as DATETIME) FROM tbadminlog;
	SELECT @tradeLogLastDate =CAST(CONVERT(CHAR(10),MAX(accessdatetime),112) as DATETIME) FROM tbtradelog;

	BEGIN TRANSACTION
		DELETE FROM tbloginlog WHERE CAST(CONVERT(CHAR(10),datetime,112) as DATETIME) <=DATEADD(day,-@numDay , @loginLogLastDate);
		IF(@@ERROR <> 0 ) GOTO QuitWithRollback 
		DELETE FROM tbadminlog WHERE CAST(CONVERT(CHAR(10),datetime,112) as DATETIME) <=DATEADD(day,-@numDay , @adminLogLastDate);
		IF(@@ERROR <> 0 ) GOTO QuitWithRollback 
		DELETE FROM tbtradelog WHERE CAST(CONVERT(CHAR(10),accessdatetime,112) as DATETIME) <=DATEADD(day,-@numDay , @tradeLogLastDate);
		IF(@@ERROR <> 0 ) GOTO QuitWithRollback 
	COMMIT TRANSACTION

	QuitWithRollback:
	  IF(@@TRANCOUNT > 0) ROLLBACK TRANSACTION 

 -- End Creation Store Procedure sp_CreateJobPurgeAuditTrail
GO



/*Store procedure for Check User Permission ON msdb for job schedule*/
/* Parameter: none
   Return Value:
	   0: user has permission
	  -1: user hasn't permission ON msdb.dbo.sysjobs_view
	  -2: user hasn't permission ON msdb.dbo.sp_delete_job
	  -3: user hasn't permission ON msdb.dbo.sp_add_job 
	  -4: user hasn't permission ON msdb.dbo.sp_add_jobstep
	  -5: user hasn't permission ON msdb.dbo.sp_update_job
	  -6: user hasn't permission ON msdb.dbo.sp_add_jobschedule
	  -7: user hasn't permission ON msdb.dbo.sp_add_jobserver

Support Investigate Command:

DECLARE  @Res INT , @ErrDesc VARCHAR(55)
EXEC sp_CheckCanUsePurge @Res OUTPUT ,@ErrDesc  OUTPUT
SELECT @Res, @ErrDesc
*/

CREATE   PROCEDURE [dbo].[sp_CheckCanUsePurge] 
	@Res INT OUTPUT, 
	@ErrDesc VARCHAR(55) OUTPUT
AS
	BEGIN
	SET NOCOUNT ON

	DECLARE @SqlVerString VARCHAR(4);
	DECLARE @SqlVer INT

	/* Get Sql Server Version */
	SELECT @SqlVerString = RTRIM(LTRIM(RIGHT((LEFT(@@VERSION,26)),5)))
	SELECT @SqlVer = CAST(@SqlVerString as int) 

	IF @SqlVer = 2000
	BEGIN
		IF PERMISSIONS(OBJECT_ID('msdb.dbo.sysjobs_view'))&0x1=0x1 
		BEGIN
			SELECT @Res = 0
			SELECT @ErrDesc ='user has permission ON msdb'
		END
		ELSE
		BEGIN
			SELECT @Res = -1
			SELECT @ErrDesc = 'user has not permission ON msdb.dbo.sysjobs_view'
		END
	END
	ELSE
	BEGIN
		IF((SELECT count(*) FROM sys.fn_my_permissions('msdb.dbo.sysjobs_view', 'OBJECT') WHERE Permission_name = 'SELECT') <= 0)
		BEGIN
			SELECT @Res = -1
			SELECT @ErrDesc = 'user has not permission ON msdb.dbo.sysjobs_view'
		END
		ELSE IF((SELECT count(*) FROM sys.fn_my_permissions('msdb.dbo.sp_delete_job', 'OBJECT') WHERE Permission_name = 'EXECUTE') <= 0)
		BEGIN
			SELECT @Res = -2
			SELECT @ErrDesc = 'user hasn not permission ON msdb.dbo.sp_delete_job'
		END
		ELSE IF((SELECT count(*) FROM sys.fn_my_permissions('msdb.dbo.sp_add_job', 'OBJECT') WHERE Permission_name = 'EXECUTE') <= 0)
		BEGIN
			SELECT @Res = -3
			SELECT @ErrDesc = 'user has not permission ON msdb.dbo.sp_add_job'
		END
		ELSE IF((SELECT count(*) FROM sys.fn_my_permissions('msdb.dbo.sp_add_jobstep', 'OBJECT') WHERE Permission_name = 'EXECUTE') <= 0)
		BEGIN
			SELECT @Res = -4
			SELECT @ErrDesc = 'user has not permission ON msdb.dbo.sp_add_jobstep'
		END
		ELSE IF((SELECT count(*) FROM sys.fn_my_permissions('msdb.dbo.sp_update_job', 'OBJECT') WHERE Permission_name = 'EXECUTE') <= 0)
		BEGIN
			SELECT @Res = -5
			SELECT @ErrDesc = 'user has not permission ON msdb.dbo.sp_update_job'
		END
		ELSE IF((SELECT count(*) FROM sys.fn_my_permissions('msdb.dbo.sp_add_jobschedule', 'OBJECT') WHERE Permission_name = 'EXECUTE') <= 0)
		BEGIN
			SELECT @Res = -6
			SELECT @ErrDesc = 'user has not permission ON msdb.dbo.sp_add_jobschedule'
		END
		ELSE IF((SELECT count(*) FROM sys.fn_my_permissions('msdb.dbo.sp_add_jobserver', 'OBJECT') WHERE Permission_name = 'EXECUTE') <= 0)
		BEGIN
			SELECT @Res = -7
			SELECT @ErrDesc = 'user has not permission ON msdb.dbo.sp_add_jobserver'
		END
		ELSE
		BEGIN
			SELECT @Res = 0
			SELECT @ErrDesc ='user has permission ON msdb'
		END
	END

END
-- End Creation Store Procedure sp_CheckCanUsePurge
GO



/*Store procedure for create ticket by dealtype*/
/*Parameter:
- same as SP_INSERTMANUALGENTICKET
- additional parameter
- sNewDealID
- dProcessDate
- nPureDealType
*/
CREATE   PROCEDURE [dbo].[SP_INSERTGENTICKETBYDEALTYPE] 
	@nConv_ID Numeric(18,0),
	@nCreationType tinyint,
	@nSetChecked1 tinyint,
	@nSetChecked2 tinyint,
	@sUserName VARCHAR(30),
	@sCustomDeal1 VARCHAR(200),
	@sCustomDeal2 VARCHAR(200),
	@sCustomDeal3 VARCHAR(200),
	@sCustomDeal4 VARCHAR(200) = null,
	@sCustomDeal5 VARCHAR(200) = null,
	@sCustomDeal6 VARCHAR(200) = null,
	@nSetMidOfficeOption tinyint,
	@sMidOfficeComment VARCHAR(200),
	@strConfirmDate VARCHAR(200),
	@sPaymentInstructionP1C1 NVARCHAR(200) = null,
	@sPaymentInstructionP1C2 NVARCHAR(200) = null,
	@sPaymentInstructionP2C1 NVARCHAR(200) = null,
	@sPaymentInstructionP2C2 NVARCHAR(200) = null,
	@sClearingHouse VARCHAR(200) = null,
	@sOurClearingMember VARCHAR(200) = null,
	@sTheirClearingMember VARCHAR(200) = null,
	@sSwiftBicC1P1 VARCHAR(200) = null,
	@sSwiftBicC1P2 VARCHAR(200) = null,
	@sSwiftBicC2P1 VARCHAR(200) = null,
	@sSwiftBicC2P2 VARCHAR(200) = null,
	@sUserDefinedTitle1 VARCHAR(200) = null,
	@sUserDefinedData1 NVARCHAR(200) = null,
	@sUserDefinedTitle2 VARCHAR(200) = null,
	@sUserDefinedData2 NVARCHAR(200) = null,
	@sUserDefinedTitle3 VARCHAR(200) = null,
	@sUserDefinedData3 NVARCHAR(200) = null,
	@sCommentText VARCHAR(200) = null,
	@sNewDealID VARCHAR(15),
	@dProcessDate DATETIME,
	@nPureDealType SmallInt
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO Tickets 
			(
				[DealId]
				,[Processed]
				,[ProcessedBy]
				,[ProcessedAt]
				,[Processed2]
				,[Processed2By]
				,[Processed2At]
				,[LocalTCID]
				,[SourceReference]
				,[TimeOfDeal]
				,[DealerId]
				,[PureDealType]
				,[DealType]
				,[Bank1DealingCode]
				,[BrokerDealingCode]
				,[Currency1]
				,[Currency2]
				,[DealVolumeCurrency1]
				,[ExchangeRatePeriod1]
				,[ExchangeRatePeriod2]
				,[MethodOfDeal]
				,[Period1]
				,[Period2]
				,[ConfirmationTime]
				,[ConfirmedById]
				,[Bank1Name]
				,[DepositRate]
				,[SwapRate]
				,[SourceOfData]
				,[RateDirection]
				,[ValueDatePeriod1Currency1]
				,[ValueDatePeriod1Currency2]
				,[ValueDatePeriod2Currency1]
				,[ValueDatePeriod2Currency2]
				,[DealerName]
				,[ReviewReferenceNumber]
				,[BrokerName]
				,[FRAFixingDate]
				,[FRASettlementDate]
				,[FRAMaturityDate]
				,[IMMIndicator]
				,[OutrightPointsPremiumRate]
				,[SpotBasisRate]
				,[ConversationText]
				,[ConfirmedByName]
				,[IDifContra]
				,[IDPrevious]
				,[CustomDealingField1]
				,[CustomDealingField2]
				,[CustomDealingField3]
				,[MidOfficeComment]
				,[AutoGeneratedTicket]
				,[TransactionID] 
				,[StartDate]
				,[EndDate]
				,[DeliveryDate]
				,[DeliveryDate2]
				,[ExpiryDate]
				,[ExpiryDate2]
				,[PaymentDate]
				,[PremiumDate]
				,[InterestDayBasis]
				,[InterestDayBasis2]
				,[Index1]
				,[Index2]
				,[ResetFrequency]
				,[ResetBusinessDayConvention]
				,[PaymentBusinessDayConvention]
				,[ResetCalendar]
				,[PaymentFrequency]
				,[SecondaryFrequency]
				,[StubIndicator] 
				,[StubRate]
				,[IndexSpread]
				,[OptionType]
				,[OptionType2]
				,[Cutoff]
				,[Cutoff2]
				,[ExpiryStyle]
				,[Direction2]
				,[TradingStrategy]
				,[Settlement]
				,[PremiumAmount]
				,[PremiumAmount2]
				,[Volatility]
				,[Volatility2]
				,[PremiumQuote]
				,[PremiumQuote2]
				,[PremiumCurrency]
				,[TotalNetPremiumAmount]
				,[PremiumQuoteConvention]
				,[DepositRateReference]
				,[DepositRateReference2]
				,[SwapPointsReference]
				,[SwapPointsReference2]
				,[SwiftBicC1P1]
				,[SwiftBicC1P2]
				,[SwiftBicC2P1]
				,[SwiftBicC2P2]
				,[PaymentInstructionP1C1]
				,[PaymentInstructionP1C2]
				,[PaymentInstructionP2C1]
				,[PaymentInstructionP2C2]
				,[FixedRate]
				,[CalVolumeP2C1]
				,[CustomDealingField4]
				,[CustomDealingField5]
				,[CustomDealingField6]
				,[InterestVolume]
				,[ElapsedDays]
				,[YearLength]
				,[PriceConvention]
				,[ClearingHouse]
				,[ClearingAccount]
				,[OurClearingMember]
				,[TheirClearingMember]
				,[OnBehalfOfName]
				,[OnBehalfOfCode]
				,[PremiumDate2]
				,[UserDefinedTitle1]
				,[UserDefinedData1]
				,[UserDefinedTitle2]
				,[UserDefinedData2]
				,[UserDefinedTitle3]
				,[UserDefinedData3]
				,[CommentText]
				,[MidPrice]
				,[BestBid]
				,[BestAsk]
				,[OurLEI]
				,[TheirLEI]
				,[BrokerageAmount]
				,[ReportingParty]
				,[Namespace]
				,[LinkID]
				,[TransactionID2]
				,[TradeRepository]
				,[BrokerageCurrency]
				,[CPUserID]
				,[CPUserName]
				,[UTI1]
				,[UTI2]
				,[Printed]
				,[OurEmailAddress]
				,[TheirEmailAddress]
				,[TradingInterface]
				,[BenchmarkFixingType1]
				,[BenchmarkFixingDate1]
				,[BenchmarkFixingRate1]
				,[BenchmarkFixingType2]
				,[BenchmarkFixingDate2]
				,[BenchmarkFixingRate2]
				,[Ourjurisdiction]
				,[Theirjurisdiction]
				,[Executionvenuetype]
				,[Ourclearingbroker]
				,[Ourclearingbrokerlei]
				,[Theirclearingbroker]
				,[Theirclearingbrokerlei]
				,[Executionid]
				,[Orderid]
				,[CallInitTime]
				,[AcceptTime]
				,[ConfirmedTime]
				,[ExtractedTime]
				,[FirstEndTime]
				,[SecondEndTime]
				,[QuoteTime]
				,[QuoteRejectTime]
				,[AggressorIndicator]
			  )
		SELECT @sNewDealID														--[DealId]
			,CASE WHEN @nSetChecked1 <> 0 THEN 1 ELSE 0 END						--,[Processed]
			,CASE WHEN @nSetChecked1 <> 0 THEN @sUserName ELSE null END			--,[ProcessedBy]
			,CASE WHEN @nSetChecked1 <> 0 THEN @dProcessDate ELSE null END		--,[ProcessedAt]
			,CASE WHEN @nSetChecked2 <> 0 THEN 1 ELSE 0 END						--,[Processed2]
			,CASE WHEN @nSetChecked2 <> 0 THEN @sUserName ELSE null END			--,[Processed2By]
			,CASE WHEN @nSetChecked2 <> 0 THEN @dProcessDate ELSE null END		--,[Processed2At]
			,[LocalTCID]
			,[SourceReference]		
			,[TimeOfDeal]		
			,[DealerId]			
			,@nPureDealType 													--,[PureDealType]
			,[DealType]			
			,[Bank1DealingCode]		
			,[BrokerDealingCode]		
			,[Currency1]						
			,CASE WHEN @nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN [Currency2] ELSE null END 							--,[Currency2]	
			,[DealVolumeCurrency1]				
			,CASE WHEN @nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN [ExchangeRatePeriod1] ELSE null END 					--,[ExchangeRatePeriod1]		
			,CASE WHEN @nPureDealType IN (8, 7, 32000) THEN [ExchangeRatePeriod2] ELSE null END 									--,[ExchangeRatePeriod2]		
			,1							  																							--,[MethodOfDeal]
			,[Period1]							
			,CASE WHEN @nPureDealType IN (8, 13, 16, 18, 32, 9, 10, 7, 32000) THEN [Period2] ELSE null END 							--,[Period2]							
			,@dProcessDate																											--,[ConfirmationTime]
			,SUBSTRING(@sUserName, 1, 6)																							--,[ConfirmedById]
			,[Bank1Name]					
			,CASE WHEN @nPureDealType IN (13, 16, 18, 32, 32000) THEN [DepositRate] ELSE null END 									--,[DepositRate]		
			,CASE WHEN @nPureDealType IN (8, 32000) THEN [SwapRate] ELSE null END 													--,[SwapRate]						
			,5							  																							--,[SourceOfData]
			,CASE WHEN @nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN [RateDirection] ELSE null END 						--,[RateDirection]	
			,CASE WHEN @nPureDealType IN (2, 21, 64, 4, 128, 8, 13, 16, 18, 32000) THEN [ValueDatePeriod1Currency1] ELSE null END 	--,[ValueDatePeriod1Currency1]
			,CASE WHEN @nPureDealType IN (2, 21, 64, 4, 128, 8, 32000) THEN [ValueDatePeriod1Currency2] ELSE null END 				--,[ValueDatePeriod1Currency2]
			,CASE WHEN @nPureDealType IN (8, 13, 16, 18, 32000) THEN [ValueDatePeriod2Currency1] ELSE null END 						--,[ValueDatePeriod2Currency1]	
			,CASE WHEN @nPureDealType IN (8, 32000) THEN [ValueDatePeriod2Currency2] ELSE null END 									--,[ValueDatePeriod2Currency2]	
			,[DealerName]				
			,[ReviewReferenceNumber]		
			,[BrokerName]				
			,CASE WHEN @nPureDealType IN (4, 128, 8, 32, 7, 32000) THEN [FRAFixingDate] ELSE null END 								--,[FRAFixingDate]			
			,CASE WHEN @nPureDealType IN (8, 32, 7, 32000) THEN [FRASettlementDate] ELSE null END 									--,[FRASettlementDate]					
			,CASE WHEN @nPureDealType IN (32, 32000) THEN [FRAMaturityDate] ELSE null END 											--,[FRAMaturityDate]						
			,CASE WHEN @nPureDealType IN (32, 9, 10, 32000) THEN [IMMIndicator] ELSE null END 										--,[IMMIndicator]	
			,CASE WHEN @nPureDealType IN (4, 128, 32000) THEN [OutrightPointsPremiumRate] ELSE null END 							--,[OutrightPointsPremiumRate]		
			,CASE WHEN @nPureDealType IN (4, 128, 7, 32000) THEN [SpotBasisRate] ELSE null END 										--,[SpotBasisRate]						
			,[CONVERSATIONTEXT]					
			,@sUserName							                                        									--,[ConfirmedByName]
			,[TCID]+'#0'							                                    									--,[IDifContra]
			,[TCID]+'#0'							                                    									--,[IDPrevious]
			,@sCustomDeal1						                                        									--,[CustomDealingField1]
			,@SCUSTOMDEAL2						                                        									--,[CustomDealingField2]
			,@sCustomDeal3						                                        									--,[CustomDealingField3]
			,CASE WHEN @NSETMIDOFFICEOPTION <> 0 THEN @SMIDOFFICECOMMENT ELSE null END										--,[MidOfficeComment]
			,0					                                                        									--,[AutoGenerate] 0 = Manual
			,[TransactionID] 					
			,CASE WHEN @nPureDealType IN (9, 10, 32000) THEN [StartDate] ELSE null END 										--,[StartDate]
			,CASE WHEN @nPureDealType IN (9, 10, 32000) THEN [EndDate] ELSE null END 										--,[EndDate]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [DeliveryDate] ELSE null END 										--,[DeliveryDate]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [DeliveryDate2] ELSE null END 										--,[DeliveryDate2]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [ExpiryDate] ELSE null END 										--,[ExpiryDate]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [ExpiryDate2] ELSE null END										--,[ExpiryDate2]
			,CASE WHEN @nPureDealType IN (9, 32000) THEN [PaymentDate] ELSE null END 										--,[PaymentDate]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [PremiumDate] ELSE null END 										--,[PremiumDate]
			,CASE WHEN @nPureDealType IN (9, 10, 32000) THEN [InterestDayBasis] ELSE null END 								--,[InterestDayBasis]
			,CASE WHEN @nPureDealType IN (9, 10, 32000) THEN [InterestDayBasis2] ELSE null END 								--,[InterestDayBasis2]
			,CASE WHEN @nPureDealType IN (32, 9, 10, 32000) THEN [Index1] ELSE null END 									--,[Index1]
			,CASE WHEN @nPureDealType IN (10, 32000) THEN [Index2] ELSE null END 											--,[Index2]
			,CASE WHEN @nPureDealType IN (32, 9, 10, 32000) THEN [ResetFrequency] ELSE null END 							--,[ResetFrequency]
			,CASE WHEN @nPureDealType IN (9, 10, 32000) THEN [ResetBusinessDayConvention] ELSE null END 					--,[ResetBusinessDayConvention]
			,CASE WHEN @nPureDealType IN (10, 32000) THEN [PaymentBusinessDayConvention] ELSE null END 						--,[PaymentBusinessDayConvention]
			,CASE WHEN @nPureDealType IN (9, 10, 32000) THEN [ResetCalendar] ELSE null END 									--,[ResetCalendar]
			,CASE WHEN @nPureDealType IN (10, 32000) THEN [PaymentFrequency] ELSE null END 									--,[PaymentFrequency]
			,CASE WHEN @nPureDealType IN (10, 32000) THEN [SecondaryFrequency] ELSE null END 								--,[SecondaryFrequency]
			,CASE WHEN @nPureDealType IN (10, 32000) THEN [StubIndicator] ELSE null END 									--,[StubIndicator] 
			,CASE WHEN @nPureDealType IN (10, 32000) THEN [StubRate] ELSE null END 											--,[StubRate]
			,CASE WHEN @nPureDealType IN (10, 32000) THEN [IndexSpread] ELSE null END 										--,[IndexSpread]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [OptionType] ELSE null END 										--,[OptionType]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [OptionType2] ELSE null END 										--,[OptionType2]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [Cutoff] ELSE null END 											--,[Cutoff]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [Cutoff2] ELSE null END 											--,[Cutoff2]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [ExpiryStyle] ELSE null END 										--,[ExpiryStyle]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [Direction2] ELSE null END 										--,[Direction2]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [TradingStrategy] ELSE null END 									--,[TradingStrategy]
			,CASE WHEN @nPureDealType IN (4, 128, 8, 7, 32000) THEN [Settlement] ELSE null END 								--,[Settlement]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [PremiumAmount] ELSE null END 										--,[PremiumAmount]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [PremiumAmount2] ELSE null END 									--,[PremiumAmount2]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [Volatility] ELSE null END 										--,[Volatility]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [Volatility2] ELSE null END 										--,[Volatility2]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [PremiumQuote] ELSE null END 										--,[PremiumQuote]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [PremiumQuote2] ELSE null END 										--,[PremiumQuote2]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [PremiumCurrency] ELSE null END 									--,[PremiumCurrency]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [TotalNetPremiumAmount] ELSE null END 								--,[TotalNetPremiumAmount]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [PremiumQuoteConvention] ELSE null END 							--,[PremiumQuoteConvention]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [DepositRateReference] ELSE null END 								--,[DepositRateReference]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [DepositRateReference2] ELSE null END 								--,[DepositRateReference2]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [SwapPointsReference] ELSE null END 								--,[SwapPointsReference]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [SwapPointsReference2] ELSE null END 								--,[SwapPointsReference2]
			,@sSwiftBicC1P1
			,CASE WHEN @nPureDealType IN (8, 13, 16, 18, 32, 9, 10, 7, 32000) THEN @sSwiftBicC1P2 ELSE null END 			--@sSwiftBicC1P2
			,CASE WHEN @nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN @sSwiftBicC2P1 ELSE null END 				--@sSwiftBicC2P1
			,CASE WHEN @nPureDealType IN (8, 7, 32000) THEN @sSwiftBicC2P2 ELSE null END 									--@sSwiftBicC2P2
			,@sPaymentInstructionP1C1
			,CASE WHEN @nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN @sPaymentInstructionP1C2 ELSE null END 		--@sPaymentInstructionP1C2
			,CASE WHEN @nPureDealType IN (8, 13, 16, 18, 32, 9, 10, 7, 32000) THEN @sPaymentInstructionP2C1 ELSE null END 	--@sPaymentInstructionP2C1
			,CASE WHEN @nPureDealType IN (8, 7, 32000) THEN @sPaymentInstructionP2C2 ELSE null END 							--@sPaymentInstructionP2C2
			,CASE WHEN @nPureDealType IN (9, 10, 32000) THEN [FixedRate] ELSE null END 										--,[FixedRate]
			,CASE WHEN @nPureDealType IN (8, 13, 16, 18, 7, 32000) THEN [CalVolumeP2C1] ELSE null END 						--,[CalVolumeP2C1]
			,@SCUSTOMDEAL4						                                              								--,[CustomDealingField4]
			,@SCUSTOMDEAL5						                                              								--,[CustomDealingField5]
			,@sCustomDeal6						                                              								--,[CustomDealingField6]
			,CASE WHEN @nPureDealType IN (13, 16, 18, 32000) THEN [InterestVolume] ELSE null END 							--,[InterestVolume]
			,CASE WHEN @nPureDealType IN (8, 13, 16, 18, 32, 9, 10, 32000) THEN [ElapsedDays] ELSE null END 				--,[ElapsedDays]
			,CASE WHEN @nPureDealType IN (13, 16, 18, 32, 9, 10, 32000) THEN [YearLength] ELSE null END 					--,[YearLength]
			,CASE WHEN @nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN [PriceConvention] ELSE null END 				--,[PriceConvention]
			,@sClearingHouse
			,[ClearingAccount]
			,@sOurClearingMember
			,@sTheirClearingMember
			,[OnBehalfOfName]
			,[OnBehalfOfCode]
			,CASE WHEN @nPureDealType IN (7, 32000) THEN [PremiumDate2] ELSE null END 										--,[PremiumDate2]
			,@sUserDefinedTitle1
			,@sUserDefinedData1
			,@sUserDefinedTitle2
			,@sUserDefinedData2
			,@sUserDefinedTitle3
			,@sUserDefinedData3
			,@sCommentText
			,[MidPrice]
			,[BestBid]
			,[BestAsk]
			,[OurLEI]
			,[TheirLEI]
			,[BrokerageAmount]
			,[ReportingParty]
			,[Namespace]
			,[LinkID]
			,[TransactionID2]
			,[TradeRepository]
			,[BrokerageCurrency]
			,[CPUserID]
			,[CPUserName]
			,[UTI1]
			,[UTI2]
			,0				--,[Printed]
			,[OurEmailAddress]
			,[TheirEmailAddress]
			,[TradingInterface]
			,[BenchmarkFixingType1]
			,[BenchmarkFixingDate1]
			,[BenchmarkFixingRate1]
			,[BenchmarkFixingType2]
			,[BenchmarkFixingDate2]
			,[BenchmarkFixingRate2]
			,[Ourjurisdiction]
			,[Theirjurisdiction]
			,[Executionvenuetype]
			,[Ourclearingbroker]
			,[Ourclearingbrokerlei]
			,[Theirclearingbroker]
			,[Theirclearingbrokerlei]
			,[Executionid]
			,[Orderid]
			,[CallInitTime]
			,[AcceptTime]
			,[ConfirmedTime]
			,[ExtractedTime]
			,[FirstEndTime]
			,[SecondEndTime]
			,[QuoteTime]
			,[QuoteRejectTime] 	
			,[AggressorIndicator]			
		FROM conversations 
		WHERE id = @nConv_ID
END
-- End Creation Store Procedure SP_INSERTGENTICKETBYDEALTYPE
GO



/*Store procedure for create manual ticket*/
/*Parameter:
- Conversations.ID											ex:	11111
- Type of manual gen ticket									ex:	1(Single), 2 - 9(Multiple)
- Is SET Tickets.Processed to 1 OR 0						ex: 1
- Is SET Tickets.Processed2 to 1 OR 0						ex: 1
- UserName who create the manual tickets					ex: eTrader1
- Custom Dealing value 1									
- Custom Dealing value 2									
- Custom Dealing value 3
- Custom Dealing value 4									
- Custom Dealing value 5									
- Custom Dealing value 6
- Mid Office Option
- Mid Office Comments
- Confirmation Time
*/
CREATE   PROCEDURE [dbo].[SP_INSERTMANUALGENTICKET] 
	@nConv_ID Numeric(18,0),
	@nCreationType tinyint,
	@nSetChecked1 tinyint,
	@nSetChecked2 tinyint,
	@sUserName VARCHAR(30),
	@sCustomDeal1 VARCHAR(200),
	@sCustomDeal2 VARCHAR(200),
	@sCustomDeal3 VARCHAR(200),
	@sCustomDeal4 VARCHAR(200) = null,
	@sCustomDeal5 VARCHAR(200) = null,
	@sCustomDeal6 VARCHAR(200) = null,
	@nSetMidOfficeOption tinyint,
	@sMidOfficeComment VARCHAR(200),
	@strConfirmDate VARCHAR(200),
	@sPaymentInstructionP1C1 NVARCHAR(200) = null,
	@sPaymentInstructionP1C2 NVARCHAR(200) = null,
	@sPaymentInstructionP2C1 NVARCHAR(200) = null,
	@sPaymentInstructionP2C2 NVARCHAR(200) = null,
	@sClearingHouse VARCHAR(200) = null,
	@sOurClearingMember VARCHAR(200) = null,
	@sTheirClearingMember VARCHAR(200) = null,
	@sSwiftBicC1P1 VARCHAR(200) = null,
	@sSwiftBicC1P2 VARCHAR(200) = null,
	@sSwiftBicC2P1 VARCHAR(200) = null,
	@sSwiftBicC2P2 VARCHAR(200) = null,
	@sUserDefinedTitle1 VARCHAR(200) = null,
	@sUserDefinedData1 NVARCHAR(200) = null,
	@sUserDefinedTitle2 VARCHAR(200) = null,
	@sUserDefinedData2 NVARCHAR(200) = null,
	@sUserDefinedTitle3 VARCHAR(200) = null,
	@sUserDefinedData3 NVARCHAR(200) = null,
	@sCommentText VARCHAR(200) = null,
	@nPureDealType SmallInt
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @nTicketsCount int;
	DECLARE @dProcessDate DATETIME;
	DECLARE @nNewId Numeric(10,0);
	DECLARE @tResults table(DealID_TK VARCHAR(15), ID_TK Numeric(18,0), Status_TK tinyint, PureDealType_TK SmallInt);
	DECLARE @OldTK table(DealID VARCHAR(15), ID Numeric(18,0), PureDealType SmallInt);
	DECLARE @iTKCount int;
	DECLARE @sNewDealID VARCHAR(15);

	-- Convert ConfirmationTime string to DateTime
	SELECT @dProcessDate = convert(datetime, @strConfirmDate);

	-- Create single ticket mode.
	IF(@nCreationType = 1)
	BEGIN;
		-- Get number of old manual ticket relate with conversations.
		INSERT @OldTK(ID, dealID, PureDealType)
			SELECT  Tickets.ID,Tickets.DealId,Tickets.PureDealType  
			FROM Tickets LEFT JOIN Conversations 
				ON Tickets.SourceReference = Conversations.SourceReference
					AND Tickets.TimeOfDeal = Conversations.TimeOfDeal
					AND Tickets.LocalTCID = Conversations.LocalTCID
			WHERE Conversations.ID = @nConv_ID AND Tickets.SourceOfData = 5 
				AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL))

		-- Get number of old single ticket.
		SELECT @iTKCount = COUNT(*) FROM @OldTK WHERE DealID not LIKE '%/%';

		-- No existing single manual tickets THEN create new one
		IF(@iTKCount = 0)
		BEGIN
			-- Get number of old ticket(single AND multiple).
			SELECT @iTKCount = COUNT(*) FROM @OldTK ;
			
			-- Get new running number IN case no old tickets. 
			IF(@iTKCount = 0)
			BEGIN
				EXEC sp_IncrementRunningValue @nNewId OUTPUT, 'ManualTicketDealID'

				SELECT @sNewDealID = Conversations.TCID +'#M'+ cast(@nNewId as VARCHAR) 
				FROM Conversations 
				WHERE Conversations.ID = @nConv_ID
			END
			ELSE
			BEGIN
				SELECT TOP 1 @sNewDealID = SUBSTRING(dealID, 1,(CHARINDEX('/', dealID))-1)  FROM @OldTK WHERE DealID LIKE '%/%'		
			END

			Execute [dbo].[SP_INSERTGENTICKETBYDEALTYPE]  @nConv_ID
														, @nCreationType
														, @nSetChecked1
														, @nSetChecked2
														, @sUserName
														, @sCustomDeal1
														, @sCustomDeal2
														, @sCustomDeal3
														, @sCustomDeal4
														, @sCustomDeal5
														, @sCustomDeal6
														, @nSetMidOfficeOption
														, @sMidOfficeComment
														, @strConfirmDate
														, @sPaymentInstructionP1C1
														, @sPaymentInstructionP1C2
														, @sPaymentInstructionP2C1
														, @sPaymentInstructionP2C2
														, @sClearingHouse
														, @sOurClearingMember
														, @sTheirClearingMember
														, @sSwiftBicC1P1
														, @sSwiftBicC1P2
														, @sSwiftBicC2P1
														, @sSwiftBicC2P2
														, @sUserDefinedTitle1
														, @sUserDefinedData1
														, @sUserDefinedTitle2
														, @sUserDefinedData2
														, @sUserDefinedTitle3
														, @sUserDefinedData3
														, @sCommentText
														, @sNewDealID
														, @dProcessDate
														, @nPureDealType;

			-- Set TicketStatus= yes AND Nodeal= No to conversation record.
			UPDATE conversations SET TicketStatus = 1, NoDeal = 0 WHERE id = @nConv_ID
		
			-- Status_TK
			-- 0 = Old
			-- 1 = New
			INSERT @tResults(ID_TK, DealID_TK, Status_TK, PureDealType_TK)
				SELECT Tickets.ID,Tickets.DealId,1,@nPureDealType FROM Tickets 
				WHERE Tickets.DealId = @sNewDealID AND Tickets.ConfirmationTime = @dProcessDate
		
			-- Return result.
			SELECT * FROM @tResults
		END
		ELSE
		BEGIN
				-- Single ticket already created.
				-- Status_TK
				-- 0 = Old
				-- 1 = New
				INSERT @tResults(ID_TK, DealID_TK, Status_TK, PureDealType_TK)
					SELECT TOP 1 ID,DealID,0, PureDealType FROM @OldTK WHERE DealID not LIKE '%/%'
				
				SELECT * FROM @tResults
		END
	END -- End of create single tickets.
	ELSE
	BEGIN
		-- Get number of old manual ticket relate with conversations.
		INSERT @OldTK(ID, dealID, PureDealType)
		SELECT  Tickets.ID,Tickets.DealId,Tickets.PureDealType 
		FROM Tickets LEFT JOIN Conversations 
			ON Tickets.SourceReference = Conversations.SourceReference
				AND Tickets.TimeOfDeal = Conversations.TimeOfDeal
				AND Tickets.LocalTCID = Conversations.LocalTCID
		WHERE Conversations.ID = @nConv_ID AND Tickets.SourceOfData = 5 
			AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL))
		ORDER BY DealId ASC;
		
		-- Get the running number FROM the previous ticket.
		DECLARE @sPreviousDealID VARCHAR(15);
		DECLARE @sDealID VARCHAR(15);
		DECLARE @iCount tinyint;
		DECLARE @iTicketsCount tinyint;

		-- Get number of old ticket(multiple).
		SELECT @iTKCount = COUNT(*) FROM @OldTK WHERE DealID LIKE '%/%';
		IF(@iTKCount > 0)
		BEGIN
			SELECT TOP 1 @sPreviousDealID = SUBSTRING(DealID, 1,(CHARINDEX('/', DealID))-1)  FROM @OldTK WHERE DealID LIKE '%/%';	
		END
		ELSE		
		BEGIN
			-- Get number of old ticket(single).
			SELECT @iTKCount = COUNT(*) FROM @OldTK WHERE DealID not LIKE '%/%';
			
			IF @iTKCount > 0
			BEGIN
				SELECT TOP 1 @sPreviousDealID = DealID  FROM @OldTK	WHERE DealID not LIKE '%/%';
			END
			ELSE
			BEGIN
				-- No old manual tickets (single AND multiple)
				-- Get the running number FROM the store procedure.
				EXEC sp_IncrementRunningValue @nNewId OUTPUT, 'ManualTicketDealID'
				
				SELECT @sPreviousDealID = Conversations.TCID + '#M' + CAST(@nNewId as varchar) FROM Conversations WHERE Conversations.ID = @nConv_ID;
			END
		END	
			
		SET @iCount = 1
		WHILE @iCount <= @nCreationType
		BEGIN
		-- Generate DealID
		SET @sNewDealID = rtrim(@sPreviousDealID) + '/' + CAST(@iCount as varchar)
			
		-- Check current DealID already created?
		SELECT @iTicketsCount=count(*) FROM @OldTK WHERE DealID = @sNewDealID;
			
		-- If current DealID not created THEN created ticket.
		IF @iTicketsCount = 0
		BEGIN
			Execute [dbo].[SP_INSERTGENTICKETBYDEALTYPE] @nConv_ID
														, @nCreationType
														, @nSetChecked1
														, @nSetChecked2
														, @sUserName
														, @sCustomDeal1
														, @sCustomDeal2
														, @sCustomDeal3
														, @sCustomDeal4
														, @sCustomDeal5
														, @sCustomDeal6
														, @nSetMidOfficeOption
														, @sMidOfficeComment
														, @strConfirmDate
														, @sPaymentInstructionP1C1
														, @sPaymentInstructionP1C2
														, @sPaymentInstructionP2C1
														, @sPaymentInstructionP2C2
														, @sClearingHouse
														, @sOurClearingMember
														, @sTheirClearingMember
														, @sSwiftBicC1P1
														, @sSwiftBicC1P2
														, @sSwiftBicC2P1
														, @sSwiftBicC2P2
														, @sUserDefinedTitle1
														, @sUserDefinedData1
														, @sUserDefinedTitle2
														, @sUserDefinedData2
														, @sUserDefinedTitle3
														, @sUserDefinedData3
														, @sCommentText
														, @sNewDealID
														, @dProcessDate
														, @nPureDealType;
			
			UPDATE conversations SET TicketStatus = 1, NoDeal = 0 WHERE id = @nConv_ID

			-- Status_TK
			-- 0 = Old
			-- 1 = New
			INSERT @tResults(ID_TK, DealID_TK, Status_TK, PureDealType_TK)
				SELECT Tickets.ID,Tickets.DealId, 1, @nPureDealType 
				FROM Tickets 				
				WHERE Tickets.DealId = @sNewDealID AND Tickets.ConfirmationTime = @dProcessDate
		END
		ELSE
		BEGIN
			-- Status_TK
			-- 0 = Old
			-- 1 = New
			INSERT @tResults(ID_TK, DealID_TK, Status_TK, PureDealType_TK)
			SELECT Id, DealId,0,PureDealType FROM @OldTK WHERE DealId = @sNewDealID
		END
		
		SET @iCount = @iCount + 1;
		END
		
		SELECT * FROM @tResults;
	END
END
-- End Creation Store Procedure SP_INSERTMANUALGENTICKET
GO


-- ###Trigger###---
/***** Create new trigger ON the Conversations table *****/
/* This Trigger will check IF an inserted conversation 
check for generate auto ticket AND  
should be nodeal OR not. */
CREATE  TRIGGER [ConvInsertedTrigger] ON [dbo].[Conversations] 
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON 
    
	--INSERT INTO EventLog values (getdate(),'Start trigger');

	DECLARE @count_inserted int 

	SELECT @count_inserted = count(*) FROM INSERTED WHERE localTcid IN (SELECT localTcid FROM tbAutoCheckNoDealTCIDs)

	IF(@count_inserted > 0)
	BEGIN
		DECLARE @DealType tinyint,
			@DealVolumeCurrency1 float,
			@id Numeric(18,0)
		SELECT @id= id,@DealType = DealType, @DealVolumeCurrency1 = DealVolumeCurrency1 FROM INSERTED

		IF @DealType IS NULL OR @DealType = 0 OR @DealVolumeCurrency1 IS NULL OR @DealVolumeCurrency1 = 0
		BEGIN
			UPDATE Conversations SET NoDeal=1,NoDealedBy='System' WHERE id = @id;
		END
	END
	ELSE
	BEGIN
		SELECT @count_inserted = count(*) FROM INSERTED WHERE localTcid IN (SELECT localTcid FROM tbAutoTicketsGenerationTCIDs) AND dealerid <> 'DTPSP'

		IF(@count_inserted > 0)
		BEGIN
			DECLARE @conver_id numeric(18,0);
			DECLARE @conver_localtcid char(4);
			DECLARE @conver_dealtype smallint; 
			DECLARE @conver_volume float;
			DECLARE @conver_currency1 char(3);
			DECLARE @conver_currency2 char(3);
			DECLARE @conver_direction tinyint;
			DECLARE @conver_exchange_rate_p1 float;
			DECLARE @conver_exchange_rate_p2 float; 
			DECLARE @conver_deposit_rate float; 
			DECLARE @conver_swap_rate float;
			DECLARE @conver_value_date_p1c1 datetime; 
			DECLARE @conver_value_date_p1c2 datetime;
			DECLARE @conver_value_date_p2c1 datetime;
			DECLARE @conver_value_date_p2c2 datetime; 
			DECLARE @conver_fla_fixing_date datetime; 
			DECLARE @conver_fra_settlement_date datetime; 
			DECLARE @conver_fra_maturity_date datetime; 
			DECLARE @conver_counterparty char(4);
			DECLARE @conver_autoticket_localtcid char(4);
			DECLARE @conver_interest_day_basis VARCHAR(10);
			DECLARE @conver_reset_frequency smallint;
			DECLARE @conver_index1 VARCHAR(20);
			DECLARE @conver_option_type VARCHAR(10);
			DECLARE @conver_total_net_premium float;
			DECLARE @conver_premium_currency VARCHAR(3);
			DECLARE @conver_expiry_style smallint;
			DECLARE @startdate datetime; 
			DECLARE @ENDdate datetime; 
			DECLARE @deliverydate datetime; 
			DECLARE @expirydate datetime; 
			DECLARE @volatility1 float;
			DECLARE @volatility2 float;
			DECLARE @premiumAmount1 float;
			DECLARE @premiumAmount2 float;
			
			-- query auto gen tickets setting 
			DECLARE @strConfirmStatment VARCHAR(max)
			DECLARE @check1ticket tinyint;
			DECLARE @check2ticket tinyint;

			SELECT @strConfirmStatment = ATG_SqlStatement,@check1ticket = ATG_Check1,@check2ticket = ATG_Check2 FROM tbSystemConfiguration 

			DECLARE @is_gen_full tinyint; 
			DECLARE @is_gen_partial tinyint; 

			IF @count_inserted > 1
			BEGIN 
				DECLARE cCursOR CURSOR 
				FOR (
					SELECT _conv.id,_conv.localtcid,_conv.puredealtype,_conv.dealvolumecurrency1
						,_conv.currency1,_conv.currency2,_conv.dealtype
						,_conv.exchangerateperiod1,_conv.exchangerateperiod2,_conv.depositrate,_conv.swaprate
						,_conv.valuedateperiod1currency1,_conv.valuedateperiod1currency2
						,_conv.valuedateperiod2currency1,_conv.valuedateperiod2currency2
						,_conv.frafixingdate,_conv.frasettlementdate,_conv.framaturitydate
						,_ctp.localtcid,_atg_localtcid.localtcid as atg_localtcid 
						,_conv.interestdaybasis,_conv.resetfrequency,_conv.index1
						,_conv.optiontype,_conv.totalnetpremiumamount,_conv.premiumcurrency,_conv.expirystyle
						,_conv.startdate,_conv.ENDdate,_conv.deliverydate,_conv.expirydate,_conv.Volatility,_conv.Volatility2
						,_conv.PremiumAmount,_conv.PremiumAmount2
					FROM conversations _conv 
					LEFT JOIN tbAutoTicketsGenerationTCIDs _atg_localtcid ON _conv.localtcid = _atg_localtcid.localtcid 
					LEFT JOIN counterparties _ctp ON _conv.bank1dealingcode = _ctp.localtcid 
					WHERE _conv.id IN (SELECT id FROM INSERTED) AND (_atg_localtcid.localtcid is not null) AND _conv.dealerid <> 'DTPSP'  
					)	
				open cCursOR 
				FETCH NEXT FROM cCursor
				INTO @conver_id,@conver_localtcid,@conver_dealtype,@conver_volume
					,@conver_currency1,@conver_currency2,@conver_direction
					,@conver_exchange_rate_p1,@conver_exchange_rate_p2,@conver_deposit_rate,@conver_swap_rate
					,@conver_value_date_p1c1,@conver_value_date_p1c2
					,@conver_value_date_p2c1,@conver_value_date_p2c2
					,@conver_fla_fixing_date,@conver_fra_settlement_date,@conver_fra_maturity_date
					,@conver_counterparty,@conver_autoticket_localtcid 
					,@conver_interest_day_basis,@conver_reset_frequency ,@conver_index1 
					,@conver_option_type,@conver_total_net_premium,@conver_premium_currency,@conver_expiry_style
					,@startdate,@ENDdate,@deliverydate,@expirydate,@volatility1,@volatility2,@premiumAmount1,@premiumAmount2

				While(@@FETCH_STATUS = 0)
				BEGIN
					IF rtrim(@conver_autoticket_localtcid) <> '' AND rtrim(@conver_counterparty) <> ''  
					BEGIN
						-- process auto gen ticket
						--print 'check auto ticket'
						SET @is_gen_full = 0 
						
						-- process check mandatory field 
						EXEC sp_CheckFullAutoGenTicket @is_gen_full OUTPUT, @conver_dealtype, @conver_volume
							,@conver_currency1, @conver_currency2, @conver_direction, @conver_exchange_rate_p1, @conver_exchange_rate_p2, @conver_deposit_rate, @conver_swap_rate
							,@conver_value_date_p1c1, @conver_value_date_p1c2, @conver_value_date_p2c1, @conver_value_date_p2c2
							,@conver_fla_fixing_date, @conver_fra_settlement_date, @conver_fra_maturity_date
							,@conver_interest_day_basis,@conver_reset_frequency ,@conver_index1 
							,@conver_option_type,@conver_total_net_premium,@conver_premium_currency,@conver_expiry_style
							,@startdate, @ENDdate, @deliverydate, @expirydate,@volatility1,@volatility2,@premiumAmount1,@premiumAmount2

						IF @is_gen_full <> 0 
						BEGIN
							-- process gen full ticket
							--print 'gen full ticket'
							EXEC sp_InsertAutoGenTicket @conver_id, 1, @check1ticket, @check2ticket 
						END 
						ELSE
						BEGIN
							-- process check confirm words AND check non-standard words 
							--print 'check confirm words AND check non-standard words'
							SET @is_gen_partial = 0 
							
							IF rtrim(@strConfirmStatment) <> ''
							BEGIN 
								EXEC ('SELECT id FROM conversations WHERE id = '+ @conver_id +' AND (' + @strConfirmStatment + ')') 
								
								IF @@ROWCOUNT > 0 
								BEGIN 
									SET @is_gen_partial = 1 
								END
							END
							ELSE
							BEGIN
								SET @is_gen_partial = 0 
							END

							IF @is_gen_partial <> 0 
							BEGIN
								-- process gen partial ticket
								--print 'gen partial ticket'
								EXEC sp_InsertAutoGenTicket @conver_id, 2, 0, 0 
							END
						END
					END

					FETCH NEXT FROM cCursor
					INTO @conver_id,@conver_localtcid,@conver_dealtype,@conver_volume
						,@conver_currency1,@conver_currency2,@conver_direction
						,@conver_exchange_rate_p1,@conver_exchange_rate_p2,@conver_deposit_rate,@conver_swap_rate
						,@conver_value_date_p1c1,@conver_value_date_p1c2
						,@conver_value_date_p2c1,@conver_value_date_p2c2
						,@conver_fla_fixing_date,@conver_fra_settlement_date,@conver_fra_maturity_date
						,@conver_counterparty,@conver_autoticket_localtcid 
						,@conver_interest_day_basis,@conver_reset_frequency ,@conver_index1 
						,@conver_option_type,@conver_total_net_premium,@conver_premium_currency,@conver_expiry_style
						,@startdate,@ENDdate,@deliverydate,@expirydate,@volatility1,@volatility2,@premiumAmount1,@premiumAmount2
				END
				CLOSE cCursor
				DEALLOCATE cCursor
			END
			ELSE 
			BEGIN
				SELECT @conver_id = _conv.id,@conver_localtcid= _conv.localtcid,@conver_dealtype = _conv.puredealtype,@conver_volume = _conv.dealvolumecurrency1
						,@conver_currency1 = _conv.currency1,@conver_currency2 = _conv.currency2,@conver_direction = _conv.dealtype
						,@conver_exchange_rate_p1 = _conv.exchangerateperiod1,@conver_exchange_rate_p2 = _conv.exchangerateperiod2,@conver_deposit_rate = _conv.depositrate,@conver_swap_rate = _conv.swaprate 
						,@conver_value_date_p1c1 = _conv.valuedateperiod1currency1,@conver_value_date_p1c2 = _conv.valuedateperiod1currency2
						,@conver_value_date_p2c1 = _conv.valuedateperiod2currency1,@conver_value_date_p2c2 = _conv.valuedateperiod2currency2
						,@conver_fla_fixing_date = _conv.frafixingdate,@conver_fra_settlement_date = _conv.frasettlementdate,@conver_fra_maturity_date = _conv.framaturitydate
						,@conver_counterparty = _ctp.localtcid,@conver_autoticket_localtcid = _atg_localtcid.localtcid 
						,@conver_interest_day_basis = _conv.interestdaybasis
						,@conver_reset_frequency = _conv.resetfrequency
						,@conver_index1 = _conv.index1
						,@conver_option_type = _conv.optiontype
						,@conver_total_net_premium = _conv.totalnetpremiumamount
						,@conver_premium_currency = _conv.premiumcurrency
						,@conver_expiry_style = _conv.expirystyle
						,@startdate=_conv.startdate
						,@ENDdate=_conv.ENDdate
						,@deliverydate=_conv.deliverydate
						,@expirydate=_conv.expirydate
						,@volatility1=_conv.Volatility
						,@volatility2=_conv.Volatility2
						,@premiumAmount1=_conv.PremiumAmount
						,@premiumAmount2=_conv.PremiumAmount2
					FROM conversations _conv 
					LEFT JOIN tbAutoTicketsGenerationTCIDs _atg_localtcid ON _conv.localtcid = _atg_localtcid.localtcid 
					LEFT JOIN tbAutoCheckNoDealTCIDs _acn_localtcid ON _conv.localtcid = _acn_localtcid.localtcid 
					LEFT JOIN counterparties _ctp ON _conv.bank1dealingcode = _ctp.localtcid 
					WHERE _conv.id IN (SELECT id FROM INSERTED) AND (_atg_localtcid.localtcid is not null OR _acn_localtcid.localtcid is not null) AND _conv.dealerid <> 'DTPSP'  
				
				
				IF rtrim(@conver_autoticket_localtcid) <> '' AND rtrim(@conver_counterparty) <> ''  
				BEGIN
					-- process auto gen ticket
					--print 'check auto ticket'
					SET @is_gen_full = 0 
					
					-- process check mandatory field 
					EXEC sp_CheckFullAutoGenTicket @is_gen_full OUTPUT, @conver_dealtype, @conver_volume
							, @conver_currency1, @conver_currency2, @conver_direction, @conver_exchange_rate_p1, @conver_exchange_rate_p2
							, @conver_deposit_rate, @conver_swap_rate
							, @conver_value_date_p1c1, @conver_value_date_p1c2, @conver_value_date_p2c1, @conver_value_date_p2c2
							, @conver_fla_fixing_date, @conver_fra_settlement_date, @conver_fra_maturity_date
							,@conver_interest_day_basis,@conver_reset_frequency ,@conver_index1 
							,@conver_option_type,@conver_total_net_premium,@conver_premium_currency,@conver_expiry_style
							,@startdate, @ENDdate, @deliverydate, @expirydate, @volatility1, @volatility2, @premiumAmount1, @premiumAmount2

					IF @is_gen_full <> 0 
					BEGIN
						-- process gen full ticket
						--print 'gen full ticket'
						EXEC sp_InsertAutoGenTicket @conver_id, 1, @check1ticket, @check2ticket 
					END 
					ELSE
					BEGIN
						-- process check confirm words AND check non-standard words 
						--print 'check confirm words AND check non-standard words'
						SET @is_gen_partial = 0 
						
						IF rtrim(@strConfirmStatment) <> ''
						BEGIN 
							EXEC ('SELECT id FROM conversations WHERE id = '+ @conver_id +' AND (' + @strConfirmStatment + ')') 
							IF @@ROWCOUNT > 0 
							BEGIN 
								SET @is_gen_partial = 1 
							END
						END
						ELSE
						BEGIN
							SET @is_gen_partial = 0 
						END

						IF @is_gen_partial <> 0 
						BEGIN
							-- process gen partial ticket
							--print 'gen partial ticket'
							EXEC sp_InsertAutoGenTicket @conver_id, 2, 0, 0 
						END
					END
				END
			END
		END
	END
	--INSERT INTO EventLog values (getdate(),'End trigger');
END
-- End Creation TRIGGER ConvInsertedTrigger 
GO



/***** Create new trigger ON the tickets table *****/
CREATE TRIGGER [AutoCheckTicketsForTCIDs] ON [dbo].[Tickets] 
FOR INSERT
AS
BEGIN
	SET NOCOUNT ON
	
	IF EXISTS (SELECT * FROM tbCheckTicketsTCIDs)
	BEGIN
		DECLARE @dProcessDate DATETIME
		
		SELECT @dProcessDate = GetDate()
		
		UPDATE Tickets
		SET Processed = 1,
			ProcessedBy = 'System',
			ProcessedAt =  @dProcessDate ,
			Processed2 = 1,
			Processed2By = 'System',
			Processed2At =  @dProcessDate,
			LastModifiedBy =  'System',
			LastModifiedAt =  @dProcessDate
		FROM 
			INSERTED INNER JOIN tbCheckTicketsTCIDs
							ON inserted.LocalTCID = tbCheckTicketsTCIDs.LocalTCID
					 INNER JOIN Tickets
							ON inserted.id = tickets.id
		WHERE inserted.sourceofdata IN(2,4) -- MATCHING AND EBS ONLY
	
	END
END
-- End Creation TRIGGER AutoCheckTicketsForTCIDs 
GO


DECLARE @dttm VARCHAR(55)
SELECT  @dttm=convert(varchar,getdate(),113)
raiserror('Ending Database Creation / Update Stored procedures & Trigger script at %s ....',1,1,@dttm) with nowait
PRINT ''

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
