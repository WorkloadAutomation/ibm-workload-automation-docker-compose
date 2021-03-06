CREATE DATABASE TWS
 USING CODESET UTF-8 TERRITORY US
 COLLATE USING IDENTITY
 WITH 'IWS Database'
;

UPDATE DB CFG FOR TWS USING LOGBUFSZ 512
;

UPDATE DB CFG FOR TWS USING LOGFILSIZ 1000
;

UPDATE DB CFG FOR TWS USING LOGPRIMARY 40
;

UPDATE DB CFG FOR TWS USING LOGSECOND 20
;

UPDATE DB CFG FOR TWS USING LOCKTIMEOUT 180
;

UPDATE DB CFG FOR TWS USING LOCKLIST 8192
;

UPDATE DB CFG FOR TWS USING APP_CTL_HEAP_SZ 1024
;

UPDATE DB CFG FOR TWS USING DFT_QUERYOPT 3
;

UPDATE DB CFG FOR TWS USING AUTO_MAINT ON
;

UPDATE DB CFG FOR TWS USING AUTO_TBL_MAINT ON
;

UPDATE DB CFG FOR TWS USING AUTO_RUNSTATS ON
;

CREATE DATABASE DWC
USING CODESET UTF-8 TERRITORY US
COLLATE USING IDENTITY
WITH 'DWC Database';


CONNECT TO TWS;

CREATE BUFFERPOOL TWS_BUFFPOOL IMMEDIATE  SIZE 1000 PAGESIZE 8 K ;
CREATE REGULAR TABLESPACE TWS_DATA PAGESIZE 8K MANAGED BY AUTOMATIC STORAGE EXTENTSIZE 8 BUFFERPOOL TWS_BUFFPOOL;
CREATE REGULAR TABLESPACE TWS_LOG PAGESIZE 8K MANAGED BY AUTOMATIC STORAGE EXTENTSIZE 8 BUFFERPOOL TWS_BUFFPOOL;

CREATE BUFFERPOOL TWS_PLN_BUFFPOOL IMMEDIATE SIZE 51200;
CREATE LARGE TABLESPACE TWS_PLAN MANAGED BY AUTOMATIC STORAGE AUTORESIZE YES BUFFERPOOL TWS_PLN_BUFFPOOL;
