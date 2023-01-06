-- Support Oracle database create stored PROCEDURE script
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

CREATE OR REPLACE PACKAGE RTR_DT8N.DTANALYSER_PCK AS
TYPE t_cursor IS REF CURSOR;

PROCEDURE SP_REMOVEJOBPURGEAUDITTRAIL;
PROCEDURE SP_PURGEAUDITTRAIL(numDay IN NUMBER);
PROCEDURE SP_CREATEJOBPURGEAUDITTRAIL(numDay IN NUMBER, startDateTime IN VARCHAR2, DayOfWeek IN VARCHAR2);

PROCEDURE SP_INCREMENTRUNNINGVALUE(NVALUE OUT NUMBER, STRKEYNAME in VARCHAR2);
PROCEDURE SP_INSERTGENTICKETBYDEALTYPE( nConv_ID IN VARCHAR2,
										nCreationType IN NUMBER,
										nSetChecked1 IN NUMBER,
										nSetChecked2 IN NUMBER,
										sUserName IN VARCHAR2,
										sCustomDeal1 IN VARCHAR2,
										sCustomDeal2 IN VARCHAR2,
										sCustomDeal3 IN VARCHAR2,
										sCustomDeal4 IN VARCHAR2 default '',
										sCustomDeal5 IN VARCHAR2 default '',
										sCustomDeal6 IN VARCHAR2 default '',
										nSetMidOfficeOptiON IN NUMBER,
										sMidOfficeComment IN VARCHAR2,
										strConfirmDate IN VARCHAR2,
										sPaymentInstructionP1C1 IN NVARCHAR2 default '',
										sPaymentInstructionP1C2 IN NVARCHAR2 default '', 
										sPaymentInstructionP2C1 IN NVARCHAR2 default '',
										sPaymentInstructionP2C2 IN NVARCHAR2 default '',
										sClearingHouse IN VARCHAR2 default '',
										sOurClearingMember IN VARCHAR2 default '',
										sTheirClearingmember IN VARCHAR2 default '',
										sSwiftBicC1P1 IN VARCHAR2 default '',
										sSwiftBicC1P2 IN VARCHAR2 default '',
										sSwiftBicC2P1 IN VARCHAR2 default '',
										sSwiftBicC2P2 IN VARCHAR2 default '',
										sUserDefinedTitle1 IN VARCHAR2 default '',
										sUserDefinedData1 IN NVARCHAR2 default '',
										sUserDefinedTitle2 IN VARCHAR2 default '',
										sUserDefinedData2 IN NVARCHAR2 default '',
										sUserDefinedTitle3 IN VARCHAR2 default '',
										sUserDefinedData3 IN NVARCHAR2 default '',
										sCommentText IN VARCHAR2 default '',
										sNewDealID IN VARCHAR2 default '',
										dProcessDate DATE,
										nPureDealType IN NUMBER);
PROCEDURE SP_INSERTMANUALGENTICKET( nConv_ID IN VARCHAR2, 
									nCreationType IN NUMBER, 
									nSetChecked1 IN NUMBER, 
									nSetChecked2 IN NUMBER, 
									sUserName IN VARCHAR2, 
									sCustomDeal1 IN VARCHAR2, 
									sCustomDeal2 IN VARCHAR2, 
									sCustomDeal3 IN VARCHAR2, 
									sCustomDeal4 IN VARCHAR2 default '', 
									sCustomDeal5 IN VARCHAR2 default '', 
									sCustomDeal6 IN VARCHAR2 default '', 
									nSetMidOfficeOptiON IN NUMBER, 
									sMidOfficeComment IN VARCHAR2, 
									strConfirmDate IN VARCHAR2,  
									sPaymentInstructionP1C1 IN NVARCHAR2 default '', 
									sPaymentInstructionP1C2 IN NVARCHAR2 default '',  
									sPaymentInstructionP2C1 IN NVARCHAR2 default '',  
									sPaymentInstructionP2C2 IN NVARCHAR2 default '',
									sClearingHouse IN VARCHAR2 default '',
									sOurClearingMember IN VARCHAR2 default '',
									sTheirClearingmember IN VARCHAR2 default '',  
									sSwiftBicC1P1 IN VARCHAR2 default '',
									sSwiftBicC1P2 IN VARCHAR2 default '',
									sSwiftBicC2P1 IN VARCHAR2 default '',
									sSwiftBicC2P2 IN VARCHAR2 default '',
									sUserDefinedTitle1 IN VARCHAR2 default '',
									sUserDefinedData1 IN NVARCHAR2 default '',
									sUserDefinedTitle2 IN VARCHAR2 default '',
									sUserDefinedData2 IN NVARCHAR2 default '',
									sUserDefinedTitle3 IN VARCHAR2 default '',
									sUserDefinedData3 IN NVARCHAR2 default '',
									sCommentText IN VARCHAR2 default '',
									nPureDealType IN NUMBER,
									o_cursor OUT t_cursor);
								
END DTANALYSER_PCK;
/



CREATE OR REPLACE PACKAGE BODY RTR_DT8N.DTANALYSER_PCK AS


PROCEDURE SP_REMOVEJOBPURGEAUDITTRAIL  AS
	CURSOR jobs_cur IS SELECT job FROM user_jobs WHERE what LIKE '%DTANALYSER_PCK.SP_PURGEAUDITTRAIL(%';         
BEGIN
    FOR job_rec IN jobs_cur
    LOOP
        DBMS_JOB.remove(job_rec.job);        
    END LOOP;
    COMMIT;
END SP_REMOVEJOBPURGEAUDITTRAIL;
  
  
  
PROCEDURE SP_PURGEAUDITTRAIL(numDay IN NUMBER) AS
	loginlogLastDate DATE;
	adminlogLastDate DATE;
	tradelogLastDate DATE;  
BEGIN
    SELECT MAX(datetime) INTO loginlogLastDate FROM tbloginlog;
    SELECT MAX(datetime) INTO adminlogLastDate FROM tbadminlog;
    SELECT MAX(accessdatetime) INTO tradelogLastDate FROM tbtradelog;
  
    DELETE FROM tbloginlog WHERE TRUNC(datetime) <= TRUNC(loginlogLastDate) - numDay;
    DELETE FROM tbadminlog WHERE TRUNC(datetime) <= TRUNC(adminlogLastDate) - numDay;
    DELETE FROM tbtradelog WHERE TRUNC(accessdatetime) <= TRUNC(tradelogLastDate) - numDay;
  
    COMMIT;
END SP_PURGEAUDITTRAIL;
  
  
  
PROCEDURE SP_CREATEJOBPURGEAUDITTRAIL(numDay IN NUMBER, startDateTime IN VARCHAR2, DayOfWeek IN VARCHAR2) AS
	JobNo NUMBER;   
	hour_time NUMBER;   
	min_time NUMBER;   
	hour_val VARCHAR2(5);  
	min_val VARCHAR2(5);  
	interval_str VARCHAR2(300);   
	day_str VARCHAR2(20);   
	ShiftDayCode NUMBER(3);   
	next_date_run DATE;   
	dateGmt DATE;   
	dateDb  DATE;  
BEGIN   
    -- Remove Job   
    DTANALYSER_PCK.SP_REMOVEJOBPURGEAUDITTRAIL;   
   
	SELECT EXTRACT(TIMEZONE_HOUR FROM systimestamp) INTO hour_time FROM dual;   
	SELECT EXTRACT(TIMEZONE_MINUTE FROM systimestamp) INTO min_time FROM dual;   
   
    next_date_run := TO_DATE(startDateTime,'YYYY-MM-DD HH24:mi:ss') + hour_time/24 + min_time/60/24 ;   
    dateGmt := TO_DATE(startDateTime,'YYYY-MM-DD HH24:mi:ss');   
    dateDb  := next_date_run;   
	
	IF TRUNC(dateDb) > TRUNC(dateGmt) THEN   
		ShiftDayCode := 3;   
	ELSIF TRUNC(dateDb) < TRUNC(dateGmt) THEN   
		ShiftDayCode := 1;   
	ELSE   
		ShiftDayCode := 2;   
	END IF;   
	
	SELECT TO_CHAR(next_date_run,'HH24') INTO hour_val FROM dual;  
	SELECT TO_CHAR(next_date_run,'mi') INTO min_val FROM dual;    
	--Shift Day   
	-- 1 = Shift to the Left   
	-- 2 = Current Day   
	-- 3 = Shift to the Right   
	IF INSTR(DayOfWeek,'MON',1) > 0 THEN   
	  SELECT DECODE(ShiftDayCode,1,'SUN',2,'MON',3,'TUE') INTO day_str FROM dual;   
	   interval_str := 'FN_GETNEXTDAY('''|| day_str ||''','||hour_val||','||min_val||')';  
	END IF;   
   
	IF INSTR(DayOfWeek,'TUE',1) > 0 THEN   
	  SELECT DECODE(ShiftDayCode,1,'MON',2,'TUE',3,'WED') INTO day_str FROM dual;   
	  IF LENGTH(interval_str) > 0 THEN interval_str := interval_str || ','; END IF;   
	  interval_str := interval_str || 'FN_GETNEXTDAY('''|| day_str ||''','||hour_val||','||min_val||')';   
	END IF;   
   
   IF INSTR(DayOfWeek,'WED',1) > 0 THEN   
      SELECT DECODE(ShiftDayCode,1,'TUE',2,'WED',3,'THU') INTO day_str FROM dual;   
      IF LENGTH(interval_str) > 0 THEN interval_str := interval_str || ','; END IF;   
      interval_str := interval_str || 'FN_GETNEXTDAY('''|| day_str ||''','||hour_val||','||min_val||')';   
   END IF;   
   
   IF INSTR(DayOfWeek,'THU',1) > 0 THEN   
      SELECT DECODE(ShiftDayCode,1,'WED',2,'THU',3,'FRI') INTO day_str FROM dual;   
      IF LENGTH(interval_str) > 0 THEN interval_str := interval_str || ','; END IF;   
      interval_str := interval_str || 'FN_GETNEXTDAY('''|| day_str ||''','||hour_val||','||min_val||')';   
   END IF;   
   
   IF INSTR(DayOfWeek,'FRI',1) > 0 THEN   
      SELECT DECODE(ShiftDayCode,1,'THU',2,'FRI',3,'SAT') INTO day_str FROM dual;   
      IF LENGTH(interval_str) > 0 THEN interval_str := interval_str || ','; END IF;   
      interval_str := interval_str || 'FN_GETNEXTDAY('''|| day_str ||''','||hour_val||','||min_val||')';   
   END IF;   
   
   IF INSTR(DayOfWeek,'SAT',1) > 0 THEN   
      SELECT DECODE(ShiftDayCode,1,'FRI',2,'SAT',3,'SUN') INTO day_str FROM dual;   
      IF LENGTH(interval_str) > 0 THEN interval_str := interval_str || ','; END IF;   
      interval_str := interval_str || 'FN_GETNEXTDAY('''|| day_str ||''','||hour_val||','||min_val||')';   
   END IF;   
   
   IF INSTR(DayOfWeek,'SUN',1) > 0 THEN   
      SELECT DECODE(ShiftDayCode,1,'SAT',2,'SUN',3,'MON') INTO day_str FROM dual;   
      IF LENGTH(interval_str) > 0 THEN interval_str := interval_str || ','; END IF;   
      interval_str := interval_str || 'FN_GETNEXTDAY('''|| day_str ||''','||hour_val||','||min_val||')';   
   END IF;  
   
    -- Set next day FOR first time.
    IF( next_date_run < sysdate ) THEN
        EXECUTE IMMEDIATE 'SELECT TO_DATE(TO_CHAR(LEAST('|| interval_str ||'),''YYYY-MM-DD'')||'' '' || '''|| TO_CHAR(next_date_run,'HH24:mi:ss')  ||''',''YYYY-MM-DD HH24:mi:ss'') FROM DUAL' INTO next_date_run ;        
    END IF;
    
    DBMS_JOB.submit(job => JobNo,   
      what => 'begin DTANALYSER_PCK.SP_PURGEAUDITTRAIL(' || numDay || '); END;',   
       next_date => next_date_run,
      INTERVAL => 'LEAST(' || interval_str || ')' );
    COMMIT;
END SP_CREATEJOBPURGEAUDITTRAIL;



PROCEDURE SP_INCREMENTRUNNINGVALUE(NVALUE OUT NUMBER, STRKEYNAME IN VARCHAR2)
IS
	NMAXVALUE NUMBER(10,0);
BEGIN
  SELECT RUNNINGVALUE,MAXVALUE INTO NVALUE,NMAXVALUE FROM RTR_DT8N.TBRUNNINGNUMBER WHERE KEYNAME = STRKEYNAME FOR UPDATE OF RUNNINGVALUE;
  
  IF((NVALUE + 1) > NMAXVALUE)
  THEN
    UPDATE RTR_DT8N.TBRUNNINGNUMBER SET RUNNINGVALUE = MINVALUE WHERE KEYNAME = STRKEYNAME;
  ELSE
    UPDATE RTR_DT8N.TBRUNNINGNUMBER SET RUNNINGVALUE = RUNNINGVALUE + 1 WHERE KEYNAME = STRKEYNAME;
  END IF;
END SP_INCREMENTRUNNINGVALUE;



PROCEDURE SP_INSERTGENTICKETBYDEALTYPE(
	nConv_ID IN VARCHAR2,
	nCreationType IN NUMBER,
	nSetChecked1 IN NUMBER,
	nSetChecked2 IN NUMBER,
	sUserName IN VARCHAR2,
	sCustomDeal1 IN VARCHAR2,
	sCustomDeal2 IN VARCHAR2,
	sCustomDeal3 IN VARCHAR2,
	sCustomDeal4 IN VARCHAR2 default '',
	sCustomDeal5 IN VARCHAR2 default '',
	sCustomDeal6 IN VARCHAR2 default '',
	nSetMidOfficeOptiON IN NUMBER,
	sMidOfficeComment IN VARCHAR2,
	strConfirmDate IN VARCHAR2,
	sPaymentInstructionP1C1 IN NVARCHAR2 default '',
	sPaymentInstructionP1C2 IN NVARCHAR2 default '', 
	sPaymentInstructionP2C1 IN NVARCHAR2 default '',
	sPaymentInstructionP2C2 IN NVARCHAR2 default '',
	sClearingHouse IN VARCHAR2 default '',
	sOurClearingMember IN VARCHAR2 default '',
	sTheirClearingmember IN VARCHAR2 default '',
	sSwiftBicC1P1 IN VARCHAR2 default '',
	sSwiftBicC1P2 IN VARCHAR2 default '',
	sSwiftBicC2P1 IN VARCHAR2 default '',
	sSwiftBicC2P2 IN VARCHAR2 default '',
	sUserDefinedTitle1 IN VARCHAR2 default '',
	sUserDefinedData1 IN NVARCHAR2 default '',
	sUserDefinedTitle2 IN VARCHAR2 default '',
	sUserDefinedData2 IN NVARCHAR2 default '',
	sUserDefinedTitle3 IN VARCHAR2 default '',
	sUserDefinedData3 IN NVARCHAR2 default '',
	sCommentText IN VARCHAR2 default '',
	sNewDealID IN VARCHAR2 default '',
	dProcessDate DATE,
	nPureDealType IN NUMBER)
IS
BEGIN
	INSERT INTO RTR_DT8N.TICKETS 
		(
			 DealId
			, Processed
			, ProcessedBy
			, ProcessedAt
			, Processed2
			, Processed2By
			, Processed2At
			, LocalTCID
			, SourceReference
			, TimeOfDeal
			, DealerId
			, PureDealType
			, DealType
			, Bank1DealingCode
			, BrokerDealingCode
			, Currency1
			, Currency2
			, DealVolumeCurrency1
			, ExchangeRatePeriod1
			, ExchangeRatePeriod2
			, MethodOfDeal
			, Period1
			, Period2
			, ConfirmationTime
			, ConfirmedById
			, Bank1Name
			, DepositRate
			, SwapRate
			, SourceOfData
			, RateDirection
			, ValueDatePeriod1Currency1
			, ValueDatePeriod1Currency2
			, ValueDatePeriod2Currency1
			, ValueDatePeriod2Currency2
			, DealerName
			, ReviewReferenceNumber
			, BrokerName
			, FRAFixingDate
			, FRASettlementDate
			, FRAMaturityDate
			, IMMIndicator
			, OutrightPointsPremiumRate
			, SpotBasisRate
			, ConversationText
			, ConfirmedByName
			, IDifContra
			, IDPrevious
			, CustomDealingField1
			, CustomDealingField2
			, CustomDealingField3
			, MidOfficeComment
			, AutoGeneratedTicket
			, TransactionID 
			, StartDate
			, EndDate
			, DeliveryDate
			, DeliveryDate2
			, ExpiryDate
			, ExpiryDate2
			, PaymentDate
			, PremiumDate
			, InterestDayBasis
			, InterestDayBasis2
			, Index1
			, Index2
			, ResetFrequency
			, ResetBusinessDayConvention
			, PaymentBusinessDayConvention
			, ResetCalendar
			, PaymentFrequency
			, SecondaryFrequency
			, StubIndicator 
			, StubRate
			, IndexSpread
			, OptionType
			, OptionType2
			, Cutoff
			, Cutoff2
			, ExpiryStyle
			, Direction2
			, TradingStrategy
			, Settlement
			, PremiumAmount
			, PremiumAmount2
			, Volatility
			, Volatility2
			, PremiumQuote
			, PremiumQuote2
			, PremiumCurrency
			, TotalNetPremiumAmount
			, PremiumQuoteConvention
			, DepositRateReference
			, DepositRateReference2
			, SwapPointsReference
			, SwapPointsReference2
			, SwiftBicC1P1
			, SwiftBicC1P2
			, SwiftBicC2P1
			, SwiftBicC2P2
			, PaymentInstructionP1C1
			, PaymentInstructionP1C2
			, PaymentInstructionP2C1
			, PaymentInstructionP2C2
			, FixedRate
			, CalVolumeP2C1
			, CustomDealingField4
			, CustomDealingField5
			, CustomDealingField6
			, InterestVolume
			, ElapsedDays
			, YearLength
			, PriceConvention
			, ClearingHouse
			, ClearingAccount
			, OurClearingMember
			, TheirClearingMember
			, OnBehalfOfName
			, OnBehalfOfCode
			, PremiumDate2
			, UserDefinedTitle1
			, UserDefinedData1
			, UserDefinedTitle2
			, UserDefinedData2
			, UserDefinedTitle3
			, UserDefinedData3
			, CommentText
			, MidPrice
			, BestBid
			, BestAsk
			, OurLEI
			, TheirLEI
			, BrokerageAmount
			, ReportingParty
			, Namespace
			, LinkID
			, TransactionID2
			, TradeRepository
			, BrokerageCurrency
			, CPUserID
			, CPUserName
			, UTI1
			, UTI2
			, Printed
			, OurEmailAddress
			, TheirEmailAddress
			, TradingInterface
			, BenchmarkFixingType1
			, BenchmarkFixingDate1
			, BenchmarkFixingRate1
			, BenchmarkFixingType2
			, BenchmarkFixingDate2
			, BenchmarkFixingRate2
			, Ourjurisdiction
			, Theirjurisdiction
			, Executionvenuetype
			, Ourclearingbroker
			, Ourclearingbrokerlei
			, Theirclearingbroker
			, Theirclearingbrokerlei
			, Executionid
			, Orderid
			, CallInitTime
			, AcceptTime
			, ConfirmedTime
			, ExtractedTime
			, FirstEndTime
			, SecondEndTime
			, QuoteTime
			, QuoteRejectTime
			, AggressorIndicator
		)     
		(SELECT 
			sNewDealID														--[DealId]
			, CASE WHEN nSetChecked1 <> 0 THEN 1 ELSE 0 END					--,[Processed]
			, CASE WHEN nSetChecked1 <> 0 THEN sUserName ELSE null END		--,[ProcessedBy]
			, CASE WHEN nSetChecked1 <> 0 THEN dProcessDate ELSE null END	--,[ProcessedAt]
			, CASE WHEN nSetChecked2 <> 0 THEN 1 ELSE 0 END					--,[Processed2]
			, CASE WHEN nSetChecked2 <> 0 THEN sUserName ELSE null END		--,[Processed2By]
			, CASE WHEN nSetChecked2 <> 0 THEN dProcessDate ELSE null END	--,[Processed2At]
			, LocalTCID
			, SourceReference
			, TimeOfDeal
			, DealerId		
			, nPureDealType
			, DealType
			, Bank1DealingCode		
			, BrokerDealingCode
			, Currency1						
			, CASE WHEN nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN Currency2 ELSE null END 								--,[Currency2]
			, DealVolumeCurrency1				
			, CASE WHEN nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN ExchangeRatePeriod1 ELSE null END 					--,[ExchangeRatePeriod1]	
			, CASE WHEN nPureDealType IN (8, 7, 32000) THEN ExchangeRatePeriod2 ELSE null END 										--,[ExchangeRatePeriod2]	
			, 1							  																							--,[MethodOfDeal]
			, Period1							
			, CASE WHEN nPureDealType IN (8, 13, 16, 18, 32, 9, 10, 7, 32000) THEN Period2 ELSE null END 							--,[Period2]						
			, dProcessDate							  																				--,[ConfirmationTime]
			, SUBSTR(sUserName, 1, 6)							  																	--,[ConfirmedById]
			, Bank1Name				
			, CASE WHEN nPureDealType IN (13, 16, 18, 32, 32000) THEN DepositRate ELSE null END 									--,[DepositRate]		
			, CASE WHEN nPureDealType IN (8, 32000) THEN SwapRate ELSE null END 													--,[SwapRate]						
			, 5							  --,[SourceOfData]
			, CASE WHEN nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN RateDirection ELSE null END 							--,[RateDirection]
			, CASE WHEN nPureDealType IN (2, 21, 64, 4, 128, 8, 13, 16, 18, 32000) THEN ValueDatePeriod1Currency1 ELSE null END 	--,[ValueDatePeriod1Currency1]
			, CASE WHEN nPureDealType IN (2, 21, 64, 4, 128, 8, 32000) THEN ValueDatePeriod1Currency2 ELSE null END 				--,[ValueDatePeriod1Currency2]
			, CASE WHEN nPureDealType IN (8, 13, 16, 18, 32000) THEN ValueDatePeriod2Currency1 ELSE null END 						--,[ValueDatePeriod2Currency1]
			, CASE WHEN nPureDealType IN (8, 32000) THEN ValueDatePeriod2Currency2 ELSE null END 									--,[ValueDatePeriod2Currency2]	
			, DealerName
			, ReviewReferenceNumber
			, BrokerName				
			, CASE WHEN nPureDealType IN (4, 128, 8, 32, 7, 32000) THEN FRAFixingDate ELSE null END 	--,[FRAFixingDate]		
			, CASE WHEN nPureDealType IN (8, 32, 7, 32000) THEN FRASettlementDate ELSE null END 		--,[FRASettlementDate]					
			, CASE WHEN nPureDealType IN (32, 32000) THEN FRAMaturityDate ELSE null END 				--,[FRAMaturityDate]				
			, CASE WHEN nPureDealType IN (32, 9, 10, 32000) THEN IMMIndicator ELSE null END 			--,[IMMIndicator]	
			, CASE WHEN nPureDealType IN (4, 128, 32000) THEN OutrightPointsPremiumRate ELSE null END 	--,[OutrightPointsPremiumRate]		
			, CASE WHEN nPureDealType IN (4, 128, 7, 32000) THEN SpotBasisRate ELSE null END 			--,[SpotBasisRate]						
			, ConversationText					
			, sUserName							    					  								--,[ConfirmedByName]
			, TCID || '#0'							  					  								--,[IDifContra]
			, TCID || '#0'							  					  								--,[IDPrevious]
			, sCustomDeal1							  					  								--,[CustomDealingField1]
			, sCustomDeal2							  					  								--,[CustomDealingField2]
			, sCustomDeal3							  					  								--,[CustomDealingField3]
			, CASE WHEN nSetMidOfficeOptiON <> 0 THEN sMidOfficeComment ELSE null END					--,[MidOfficeComment]
			, 0					  --,AutoGenerate 0 = Manual
			, TransactionID 
			, CASE WHEN nPureDealType IN (9, 10, 32000) THEN StartDate ELSE null END 					--,[StartDate]
			, CASE WHEN nPureDealType IN (9, 10, 32000) THEN EndDate ELSE null END 						--,[EndDate]
			, CASE WHEN nPureDealType IN (7, 32000) THEN DeliveryDate ELSE null END 					--,[DeliveryDate]
			, CASE WHEN nPureDealType IN (7, 32000) THEN DeliveryDate2 ELSE null END 					--,[DeliveryDate2]
			, CASE WHEN nPureDealType IN (7, 32000) THEN ExpiryDate ELSE null END 						--,[ExpiryDate]
			, CASE WHEN nPureDealType IN (7, 32000) THEN ExpiryDate2 ELSE null END 						--,[ExpiryDate2]
			, CASE WHEN nPureDealType IN (9, 32000) THEN PaymentDate ELSE null END 						--,[PaymentDate]
			, CASE WHEN nPureDealType IN (7, 32000) THEN PremiumDate ELSE null END 						--,[PremiumDate]
			, CASE WHEN nPureDealType IN (9, 10, 32000) THEN InterestDayBasis ELSE null END 			--,[InterestDayBasis]
			, CASE WHEN nPureDealType IN (9, 10, 32000) THEN InterestDayBasis2 ELSE null END 			--,[InterestDayBasis2]
			, CASE WHEN nPureDealType IN (32, 9, 10, 32000) THEN Index1 ELSE null END 					--,[Index1]
			, CASE WHEN nPureDealType IN (10, 32000) THEN Index2 ELSE null END 							--,[Index2]
			, CASE WHEN nPureDealType IN (32, 9, 10, 32000) THEN ResetFrequency ELSE null END 			--,[ResetFrequency]
			, CASE WHEN nPureDealType IN (9, 10, 32000) THEN ResetBusinessDayConventiON ELSE null END 	--,[ResetBusinessDayConvention]
			, CASE WHEN nPureDealType IN (10, 32000) THEN PaymentBusinessDayConventiON ELSE null END 	--,[PaymentBusinessDayConvention]
			, CASE WHEN nPureDealType IN (9, 10, 32000) THEN ResetCalendar ELSE null END 				--,[ResetCalendar]
			, CASE WHEN nPureDealType IN (10, 32000) THEN PaymentFrequency ELSE null END 				--,[PaymentFrequency]
			, CASE WHEN nPureDealType IN (10, 32000) THEN SecondaryFrequency ELSE null END 				--,[SecondaryFrequency]
			, CASE WHEN nPureDealType IN (10, 32000) THEN StubIndicator ELSE null END 					--,[StubIndicator] 
			, CASE WHEN nPureDealType IN (10, 32000) THEN StubRate ELSE null END 						--,[StubRate]
			, CASE WHEN nPureDealType IN (10, 32000) THEN IndexSpread ELSE null END 					--,[IndexSpread]
			, CASE WHEN nPureDealType IN (7, 32000) THEN OptionType ELSE null END 						--,[OptionType]
			, CASE WHEN nPureDealType IN (7, 32000) THEN OptionType2 ELSE null END 						--,[OptionType2]
			, CASE WHEN nPureDealType IN (7, 32000) THEN Cutoff ELSE null END 							--,[Cutoff]
			, CASE WHEN nPureDealType IN (7, 32000) THEN Cutoff2 ELSE null END 							--,[Cutoff2]
			, CASE WHEN nPureDealType IN (7, 32000) THEN ExpiryStyle ELSE null END 						--,[ExpiryStyle]
			, CASE WHEN nPureDealType IN (7, 32000) THEN Direction2 ELSE null END 						--,[Direction2]
			, CASE WHEN nPureDealType IN (7, 32000) THEN TradingStrategy ELSE null END 					--,[TradingStrategy]
			, CASE WHEN nPureDealType IN (4, 128, 8, 7, 32000) THEN Settlement ELSE null END 			--,[Settlement]
			, CASE WHEN nPureDealType IN (7, 32000) THEN PremiumAmount ELSE null END 					--,[PremiumAmount]
			, CASE WHEN nPureDealType IN (7, 32000) THEN PremiumAmount2 ELSE null END 					--,[PremiumAmount2]
			, CASE WHEN nPureDealType IN (7, 32000) THEN Volatility ELSE null END 						--,[Volatility]
			, CASE WHEN nPureDealType IN (7, 32000) THEN Volatility2 ELSE null END 						--,[Volatility2]
			, CASE WHEN nPureDealType IN (7, 32000) THEN PremiumQuote ELSE null END 					--,[PremiumQuote]
			, CASE WHEN nPureDealType IN (7, 32000) THEN PremiumQuote2 ELSE null END 					--,[PremiumQuote2]
			, CASE WHEN nPureDealType IN (7, 32000) THEN PremiumCurrency ELSE null END 					--,[PremiumCurrency]
			, CASE WHEN nPureDealType IN (7, 32000) THEN TotalNetPremiumAmount ELSE null END 			--,[TotalNetPremiumAmount]
			, CASE WHEN nPureDealType IN (7, 32000) THEN PremiumQuoteConventiON ELSE null END 			--,[PremiumQuoteConvention]
			, CASE WHEN nPureDealType IN (7, 32000) THEN DepositRateReference ELSE null END 			--,[DepositRateReference]
			, CASE WHEN nPureDealType IN (7, 32000) THEN DepositRateReference2 ELSE null END 			--,[DepositRateReference2]
			, CASE WHEN nPureDealType IN (7, 32000) THEN SwapPointsReference ELSE null END 				--,[SwapPointsReference]
			, CASE WHEN nPureDealType IN (7, 32000) THEN SwapPointsReference2 ELSE null END 			--,[SwapPointsReference2]
			, sSwiftBicC1P1
			, CASE WHEN nPureDealType IN (8, 13, 16, 18, 32, 9, 10, 7, 32000) THEN sSwiftBicC1P2 ELSE null END 				--,[SwiftBicC1P2]
			, CASE WHEN nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN sSwiftBicC2P1 ELSE null END 					--,[SwiftBicC2P1]
			, CASE WHEN nPureDealType IN (8, 7, 32000) THEN sSwiftBicC2P2 ELSE null END 									--,[sSwiftBicC2P2]
			, sPaymentInstructionP1C1
			, CASE WHEN nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN sPaymentInstructionP1C2 ELSE null END 		--,[PaymentInstructionP1C2]
			, CASE WHEN nPureDealType IN (8, 13, 16, 18, 32, 9, 10, 7, 32000) THEN sPaymentInstructionP2C1 ELSE null END 	--,[PaymentInstructionP2C1]
			, CASE WHEN nPureDealType IN (8, 7, 32000) THEN sPaymentInstructionP2C2 ELSE null END 							--,[PaymentInstructionP2C2]
			, CASE WHEN nPureDealType IN (9, 10, 32000) THEN FixedRate ELSE null END 										--,[FixedRate]
			, CASE WHEN nPureDealType IN (8, 13, 16, 18, 7, 32000) THEN CalVolumeP2C1 ELSE null END 						--,[CalVolumeP2C1]
			, sCustomDeal4						  					  														--,[CustomDealingField4]
			, sCustomDeal5						  					  														--,[CustomDealingField5]
			, sCustomDeal6						  					  														--,[CustomDealingField6]
			, CASE WHEN nPureDealType IN (13, 16, 18, 32000) THEN InterestVolume ELSE null END 								--,[InterestVolume]
			, CASE WHEN nPureDealType IN (8, 13, 16, 18, 32, 9, 10, 32000) THEN ElapsedDays ELSE null END 					--,[ElapsedDays]
			, CASE WHEN nPureDealType IN (13, 16, 18, 32, 9, 10, 32000) THEN YearLength ELSE null END 						--,[YearLength]
			, CASE WHEN nPureDealType IN (2, 21, 64, 4, 128, 8, 7, 32000) THEN PriceConventiON ELSE null END 				--,[PriceConvention]
			, sClearingHouse
			, ClearingAccount
			, sOurClearingMember
			, sTheirClearingMember
			, OnBehalfOfName
			, OnBehalfOfCode
			, CASE WHEN nPureDealType IN (7, 32000) THEN PremiumDate2 ELSE null END 										--,[PremiumDate2]
			, sUserDefinedTitle1
			, sUserDefinedData1
			, sUserDefinedTitle2
			, sUserDefinedData2
			, sUserDefinedTitle3
			, sUserDefinedData3
			, sCommentText
			, MidPrice
			, BestBid
			, BestAsk
			, OurLEI
			, TheirLEI
			, BrokerageAmount
			, ReportingParty
			, Namespace
			, LinkID
			, TransactionID2
			, TradeRepository
			, BrokerageCurrency
			, CPUserID
			, CPUserName
			, UTI1
			, UTI2
			, 0 			--,[PRINTED]
			, OurEmailAddress
			, TheirEmailAddress
			, TradingInterface
			, BenchmarkFixingType1
			, BenchmarkFixingDate1
			, BenchmarkFixingRate1
			, BenchmarkFixingType2
			, BenchmarkFixingDate2
			, BenchmarkFixingRate2
			, Ourjurisdiction
			, Theirjurisdiction
			, Executionvenuetype
			, Ourclearingbroker
			, Ourclearingbrokerlei
			, Theirclearingbroker
			, Theirclearingbrokerlei
			, Executionid
			, Orderid
			, CallInitTime
			, AcceptTime
			, ConfirmedTime
			, ExtractedTime
			, FirstEndTime
			, SecondEndTime
			, QuoteTime
			, QuoteRejectTime
			, AggressorIndicator
		FROM Conversations 
		WHERE ROWID =  nConv_ID ) ;
END SP_INSERTGENTICKETBYDEALTYPE;



PROCEDURE SP_INSERTMANUALGENTICKET(
	nConv_ID IN VARCHAR2, 
	nCreationType IN NUMBER, 
	nSetChecked1 IN NUMBER, 
	nSetChecked2 IN NUMBER, 
	sUserName IN VARCHAR2, 
	sCustomDeal1 IN VARCHAR2, 
	sCustomDeal2 IN VARCHAR2, 
	sCustomDeal3 IN VARCHAR2, 
	sCustomDeal4 IN VARCHAR2 default '', 
	sCustomDeal5 IN VARCHAR2 default '', 
	sCustomDeal6 IN VARCHAR2 default '',  
	nSetMidOfficeOptiON IN NUMBER, 
	sMidOfficeComment IN VARCHAR2, 
	strConfirmDate IN VARCHAR2, 
	sPaymentInstructionP1C1 IN NVARCHAR2 default '', 
	sPaymentInstructionP1C2 IN NVARCHAR2 default '',  
	sPaymentInstructionP2C1 IN NVARCHAR2 default '',  
	sPaymentInstructionP2C2 IN NVARCHAR2 default '',
	sClearingHouse IN VARCHAR2 default '',
	sOurClearingMember IN VARCHAR2 default '',
	sTheirClearingmember IN VARCHAR2 default '',  
	sSwiftBicC1P1 IN VARCHAR2 default '',
	sSwiftBicC1P2 IN VARCHAR2 default '',
	sSwiftBicC2P1 IN VARCHAR2 default '',
	sSwiftBicC2P2 IN VARCHAR2 default '',
	sUserDefinedTitle1 IN VARCHAR2 default '',
	sUserDefinedData1 IN NVARCHAR2 default '',
	sUserDefinedTitle2 IN VARCHAR2 default '',
	sUserDefinedData2 IN NVARCHAR2 default '',
	sUserDefinedTitle3 IN VARCHAR2 default '',
	sUserDefinedData3 IN NVARCHAR2 default '',
	sCommentText IN VARCHAR2 default '',
	nPureDealType IN NUMBER,
	o_cursor OUT t_cursor)
IS 
	iOldTicketsCount integer;
	nticketid number(10,0);
	sNewDealID VARCHAR2(15);
	dProcessDate DATE;
	iCount integer;
	sDealID varchar2(15);
	iTicketsCount integer;
BEGIN
	-- Convert ConfirmationTime string to DateTime.
	dProcessDate := TO_DATE(strConfirmDate, 'MM/dd/yyyy HH24:MI:SS');
	--
	IF nCreationType = 1 THEN
		-- Start create a single manual ticket.

		-- Find the number of the old single manual ticket.
		SELECT COUNT(*) 
		INTO iOldTicketsCount 
		FROM Tickets LEFT JOIN Conversations 
			ON Tickets.SourceReference = Conversations.SourceReference 
				AND Tickets.TimeOfDeal = Conversations.TimeOfDeal 
				AND Tickets.LocalTCID = Conversations.LocalTCID 
		WHERE Conversations.ROWID = nConv_ID AND Tickets.SourceOfData = 5 AND Tickets.DealId NOT LIKE '%/%' 
			AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL)); 
		 
		-- No existing single manual tickets THEN create new one.
		IF iOldTicketsCount = 0 THEN
			-- Get number of both single AND multiple ticket.
			SELECT count(*) 
			INTO iTicketsCount  
			FROM Tickets LEFT JOIN Conversations 
				ON Tickets.SourceReference = Conversations.SourceReference 
					AND Tickets.TimeOfDeal = Conversations.TimeOfDeal 
					AND Tickets.LocalTCID = Conversations.LocalTCID
			WHERE Conversations.ROWID = nConv_ID
				AND Tickets.SourceOfData = 5 AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL))
			;
			  
			-- If no old tickets both single AND multiple tickets, so get the new running number.
			IF iTicketsCount = 0
			THEN
				-- Get the running number FROM TBRUNNINGNUMBER.
				DTANALYSER_PCK.SP_INCREMENTRUNNINGVALUE(nticketid, 'ManualTicketDealID');

				-- Generate new DealID  
				SELECT Conversations.TCID || '#M' || nticketid INTO sNewDealID FROM Conversations 
				WHERE Conversations.ROWID = nConv_ID;
			ELSE
				-- If have multiple tickets, so get the running number FROM that ticket.
				-- Find the number of the old manual ticket.          
				SELECT SUBSTR(Tickets.DealID, 1,(INSTR(Tickets.DealID,'/'))-1) 
				INTO sNewDealID  
				FROM Tickets LEFT JOIN Conversations 
					ON Tickets.SourceReference = Conversations.SourceReference 
						AND Tickets.TimeOfDeal = Conversations.TimeOfDeal 
						AND Tickets.LocalTCID = Conversations.LocalTCID 
				WHERE Conversations.ROWID = nConv_ID
					AND Tickets.DealID LIKE '%/%'
					AND Tickets.SourceOfData = 5 AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL))
					AND (ROWNUM  = 1)
				;
			END IF;

			--Insert new record to tickets table.
			RTR_DT8N.DTANALYSER_PCK.SP_INSERTGENTICKETBYDEALTYPE( nConv_ID, nCreationType, nSetChecked1, nSetChecked2, sUserName
																, sCustomDeal1, sCustomDeal2, sCustomDeal3, sCustomDeal4, sCustomDeal5, sCustomDeal6, nSetMidOfficeOption
																, sMidOfficeComment, strConfirmDate, sPaymentInstructionP1C1, sPaymentInstructionP1C2, sPaymentInstructionP2C1
																, sPaymentInstructionP2C2, sClearingHouse, sOurClearingMember, sTheirClearingMember, sSwiftBicC1P1, sSwiftBicC1P2
																, sSwiftBicC2P1, sSwiftBicC2P2, sUserDefinedTitle1, sUserDefinedData1, sUserDefinedTitle2, sUserDefinedData2
																, sUserDefinedTitle3, sUserDefinedData3, sCommentText, sNewDealID, dProcessDate, nPureDealType);

			-- Set TicketStatus= yes AND Nodeal= No to conversatiON record.
			UPDATE conversations SET TicketStatus = 1, NoDeal = 0 WHERE ROWID = nConv_ID;

			-- Commit all change.
			commit;
		END IF; -- End create single manual ticket.

		-- Return all tickets related with the conversations.
		OPEN o_cursor FOR  
			SELECT Tickets.ROWID, Tickets.dealid, Tickets.ConfirmationTime, Tickets.PureDealType  
			FROM Tickets LEFT JOIN Conversations 
				ON Tickets.SourceReference = Conversations.SourceReference 
					AND Tickets.TimeOfDeal = Conversations.TimeOfDeal 
					AND Tickets.LocalTCID = Conversations.LocalTCID
			WHERE Conversations.ROWID = nConv_ID
				AND Tickets.SourceOfData = 5 AND Tickets.DealId not LIKE '%/%' 
				AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL))
			;
	ELSE  
		-- Start create multiple tickets.
	  
		-- Find the number of the old multiple manual ticket.
		SELECT count(*) 
		INTO iOldTicketsCount  
		FROM Tickets LEFT JOIN Conversations 
			ON Tickets.SourceReference = Conversations.SourceReference 
				AND Tickets.TimeOfDeal = Conversations.TimeOfDeal 
				AND Tickets.LocalTCID = Conversations.LocalTCID
		WHERE Conversations.ROWID = nConv_ID
			AND Tickets.SourceOfData = 5 
			AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL))
		;
	  
		IF iOldTicketsCount = 0 THEN
			-- No existing manual tickets THEN get new running number.
			DTANALYSER_PCK.SP_INCREMENTRUNNINGVALUE(nticketid, 'ManualTicketDealID');
			-- Generate new DealID  
			SELECT Conversations.TCID || '#M' || nticketid INTO sDealID FROM Conversations WHERE Conversations.ROWID = nConv_ID;
		ELSE
			-- Get number of multiple ticket.
			SELECT count(*) 
			INTO iTicketsCount 
			FROM Tickets LEFT JOIN Conversations 
				ON Tickets.SourceReference = Conversations.SourceReference 
					AND Tickets.TimeOfDeal = Conversations.TimeOfDeal 
					AND Tickets.LocalTCID = Conversations.LocalTCID
			WHERE Conversations.ROWID = nConv_ID
				AND Tickets.SourceOfData = 5 AND Tickets.DealID LIKE '%/%'
				AND ((Tickets.AutoGeneratedTicket= 0) or (Tickets.AutoGeneratedTicket IS NULL))
			;
		  
			-- If no old multiple tickets, let try to get running number FROM single ticket.
			IF iTicketsCount = 0 THEN
				SELECT SUBSTR(Tickets.DealID, 1) 
				INTO sDealID  
				FROM Tickets LEFT JOIN Conversations 
					ON Tickets.SourceReference = Conversations.SourceReference 
						AND Tickets.TimeOfDeal = Conversations.TimeOfDeal 
						AND Tickets.LocalTCID = Conversations.LocalTCID 
				WHERE Conversations.ROWID = nConv_ID
					AND Tickets.DealID not LIKE '%/%'
					AND Tickets.SourceOfData = 5 AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL))
					AND (ROWNUM  = 1)
				;
			ELSE
				-- If have old multiple tickets, let try to get running number FROM one of them.
				SELECT SUBSTR(Tickets.DealID, 1,(INSTR(Tickets.DealID,'/'))-1) 
				INTO sDealID 
				FROM Tickets LEFT JOIN Conversations 
					ON Tickets.SourceReference = Conversations.SourceReference 
						AND Tickets.TimeOfDeal = Conversations.TimeOfDeal 
						AND Tickets.LocalTCID = Conversations.LocalTCID 
				WHERE Conversations.ROWID = nConv_ID
					AND Tickets.SourceOfData = 5 AND Tickets.DealID LIKE '%/%'
					AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL))
					AND (ROWNUM  = 1)
				;
			END IF;
		END IF;
		  
		iCount := 1;
		WHILE iCount <= nCreationType LOOP
			-- Generate the DealID
			sNewDealID := trim(sDealID) || '/' || iCount;

			-- Check existing ticket of current DealID.
			SELECT count(*) 
			INTO iTicketsCount 
			FROM Tickets LEFT JOIN Conversations 
				ON Tickets.SourceReference = Conversations.SourceReference
					AND Tickets.TimeOfDeal = Conversations.TimeOfDeal 
					AND Tickets.LocalTCID = Conversations.LocalTCID 
			WHERE Conversations.ROWID = nConv_ID AND Tickets.SourceOfData = 5 
				AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL))
				AND Tickets.DealID = rpad(sNewDealID, 15, ' ')
			;
		
			-- No existing manual tickets  THEN create new one.
			IF iTicketsCount = 0 THEN
				-- Create FOR the new tickets.    
				RTR_DT8N.DTANALYSER_PCK.SP_INSERTGENTICKETBYDEALTYPE( nConv_ID, nCreationType, nSetChecked1, nSetChecked2, sUserName
																	, sCustomDeal1, sCustomDeal2, sCustomDeal3, sCustomDeal4, sCustomDeal5, sCustomDeal6, nSetMidOfficeOption
																	, sMidOfficeComment, strConfirmDate, sPaymentInstructionP1C1, sPaymentInstructionP1C2, sPaymentInstructionP2C1
																	, sPaymentInstructionP2C2, sClearingHouse, sOurClearingMember, sTheirClearingMember, sSwiftBicC1P1, sSwiftBicC1P2
																	, sSwiftBicC2P1, sSwiftBicC2P2, sUserDefinedTitle1, sUserDefinedData1, sUserDefinedTitle2, sUserDefinedData2
																	, sUserDefinedTitle3, sUserDefinedData3, sCommentText, sNewDealID, dProcessDate, nPureDealType );

				-- Set TicketStatus= yes AND Nodeal= No to conversatiON record.
				UPDATE conversations SET TicketStatus = 1, NoDeal = 0 WHERE ROWID = nConv_ID;

				-- Commit all change.
				commit;
			END IF;
				   
			iCount := iCount + 1;
		END LOOP;
		
		-- Return all tickets related with the conversations.
		OPEN o_cursor FOR 
			SELECT Tickets.ROWID, Tickets.dealid, Tickets.ConfirmationTime, Tickets.PureDealType 
			FROM Tickets LEFT JOIN Conversations 
				ON Tickets.SourceReference = Conversations.SourceReference 
					AND Tickets.TimeOfDeal = Conversations.TimeOfDeal 
					AND Tickets.LocalTCID = Conversations.LocalTCID
			WHERE Conversations.ROWID = nConv_ID
				AND Tickets.SourceOfData = 5 AND Tickets.DealId LIKE '%/%' 
				AND ((Tickets.AutoGeneratedTicket= 0) OR (Tickets.AutoGeneratedTicket IS NULL))
			ORDER BY Tickets.DealID ASC
			;
	END IF; -- End of create multiple manual tickets.
END SP_INSERTMANUALGENTICKET;
END DTANALYSER_PCK;
/

CREATE OR REPLACE FUNCTION RTR_DT8N.FN_GETNEXTDAY ( DayOfWeek VARCHAR2, hour_time INTEGER, min_time INTEGER)
RETURN DATE IS
BEGIN
  RETURN next_day(TRUNC(SYSDATE)+hour_time/24+min_time/60/24,DayOfWeek);
END FN_GETNEXTDAY;
/

SET TIMING OFF;