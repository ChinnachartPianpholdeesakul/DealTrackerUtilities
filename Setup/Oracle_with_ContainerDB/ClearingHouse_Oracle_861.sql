-- Support Oracle database create clearing house script     
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

DELETE FROM C##RTR_DT8N.TBCLEARINGHOUSE;

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName)VALUES(4, 'AUSTRALIAN STOCK EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName)VALUES(6, 'BMF BOVESPA');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (8, 'BOLSA MEXICANA DE VALORES');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (10, 'BANK NATIONAL CLEARING CENTRE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (12, 'BOURSE DE MONTREAL');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (14, 'BOMBAY STOCK EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (16, 'BUCHAREST EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (18, 'BUDAPEST EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (20, 'BURSA MALAYSIA DERIVATIVES EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (22, 'CASSA DI COMPENSAZIONE E GARANZIA');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (24, 'CLEARING CORPORATION OF INDIA');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (26, 'CANADIAN DEPOSITARY CLEARING CORPORATION');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (28, 'CHINA FINANCIAL FUTURES EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (30, 'CLEARSTREAM');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (32, 'CME CLEARPORT');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (34, 'INTERNATIONAL DERIVATIVES CLEARINGHOUSE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (36, 'DUBAI GOLD COMMODITY EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (38, 'DEPOSITARY TRUST CLEARING CORPORATION');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (40, 'EUROPEAN CENTRAL COUNTERPARTY');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (42, 'EUROPEAN MULTILATERAL CLEARING FACILITY');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (44, 'EUREX');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (46, 'EUROCLEAR');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (48, 'COPENHAGEN FUTOP CLEARING CENNTRE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (50, 'GLOBAL BOARD OF TRADE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (52, 'HONG KONG EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (54, 'INTERCONTINENTAL EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (56, 'ITALIAN DERIVATIVES EXCHANGE MARKET');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (58, 'INDONESIAN STOCK EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (60, 'KARACHI STOCK EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (62, 'NATIONAL DEPOSITORY FOR SECURITIES');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (66, 'KOREA EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (68, 'LCH CLEARNET');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (70, 'LCH CLEARNET FCM');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (72, 'THE LONDON METAL EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (74, 'LONDON STOCK EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (76, 'MIDAMERICA COMMODITY EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (78, 'MERCADO A TERMINO DE BUENOS AIRES');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (80, 'MERCADO ESPANOL DE FUTUROS FINANCIEROS');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (82, 'MERCADO MEXICANO DE DERIVADOS');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (84, 'MICEX');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (86, 'NORTH AMERICAN DERIVATIVES EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (88, 'NASDAQ OMX');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (90, 'NATIONAL STOCK EXCHANGE OF INDIA');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (92, 'NYMEX');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (96, 'NYSE EURONEXT');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (98, 'NEW ZEALAND STOCK EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (100, 'OPTIONS CLEARING CORPORATION');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (102, 'OSAKA SECURITIES EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (104, 'AUSTRIAN DERVIATIVES MARKET');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (106, 'PHILIPPINE DEALING AND EXCHANGE CORPORATION');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (108, 'PRAGUE STOCK EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (110, 'AUSTRALIAN SECURITIES EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (112, 'SOUTH AFRICAN FUTURES EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (114, 'SINGAPORE EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (116, 'SHANGHAI CLEARING HOUSE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (118, 'SHANGHAI FUTURES EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (120, 'SWISS EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (122, 'TAIWAN FUTURES EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (124, 'TEL AVIV STOCK EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (126, 'TURKISH DERIVATIVES EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (128, 'THAILAND FUTURES EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (130, 'TOKYO FINANCIAL EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (132, 'TOKYO STOCK EXCHANGE');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (232, 'CME CLEARPORT CONFIRMATION MARKITSERV');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (244, 'EUREX CONFIRMATION MARKITSERV');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (252, 'HONG KONG EXCHANGE CONFIRMATION MARKITSERV');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (254, 'INTERCONTINENTAL EXCHANGE CONFIRMATION MARKITSERV');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (268, 'LCH CLEARNET CONFIRMATION MARKITSERV');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (314, 'SINGAPORE EXCHANGE CONFIRMATION MARKITSERV');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (332, 'CME CLEARPORT CONFIRMATION TRAIANA HARMONY');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (344, 'EUREX CONFIRMATION TRAIANA HARMONY');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (352, 'HONG KONG EXCHANGE CONFIRMATION TRAIANA HARMONY');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (354, 'INTERCONTINENTAL EXCHANGE CONFIRM TRAIANA HARMONY');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (368, 'LCH CLEARNET CONFIRMATION TRAIANA HARMONY');

INSERT INTO C##RTR_DT8N.TBCLEARINGHOUSE (ClearerNumber, ClearerFullName) VALUES (414, 'SINGAPORE EXCHANGE CONFIRMATION TRAIANA HARMONY');

SET TIMING OFF