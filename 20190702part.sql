	 -----------------------------------------------------------------------------------
	  -- CREATE INDEXES RPO
	  -----------------------------------------------------------------------------------
	  -- Description : partitioning tables TLS
	  -----------------------------------------------------------------------------------
	  -- Historique :
	  -- 07/2019
	  -----------------------------------------------------------------------------------
	  




--creating copies
create table BNC_NOT_CONFORM_1 as select *  from sultxx1.BNC_NOT_CONFORM;--768ms

create table ARG_ITM8_BASE_1 as select *  from sultxx1.ARG_ITM8_BASE;--3s

create table ARG_ITM8_BASE_GS_1 as select *  from sultxx1.ARG_ITM8_BASE_GS;--3s

create table  REP_PACKAGES_ORDERS_REJECTED_1 as select *  from sultxx1.REP_PACKAGES_ORDERS_REJECTED -- 7s

create table  INF_SUPPORT_DISPATCHED_1 as select *  from sultxx1.INF_SUPPORT_DISPATCHED --11s

create table  FFL_ORDER_DATA_1 as select *  from sultxx1.FFL_ORDER_DATA --9s

create table   REP_PACKAGES_NOT_SERVED_1 as select *  from sultxx1.REP_PACKAGES_NOT_SERVED --2s

create table   INF_SUPPORT_PREPARED_1 as select *  from  sultxx1.INF_SUPPORT_PREPARED -- 6s

create table   PRO_FLYER_1 as select *  from  sultxx1.PRO_FLYER -- 10s

create table ARG_CATEGORY_BASE_OPERATION_1 as select * from sultxx1.ARG_CATEGORY_BASE_OPERATION -- 23s




/*

 drop table  REP_PACKAGES_ORDERS_REJECTED_1 
 
drop table  INF_SUPPORT_DISPATCHED_1 

drop table  FFL_ORDER_DATA_1 

drop table   REP_PACKAGES_NOT_SERVED_1 

drop table   INF_SUPPORT_PREPARED_1 

drop table   PRO_FLYER_1

drop table ARG_CATEGORY_BASE_OPERATION_1
*/



select * from test_part.indexes

select *  from dba_ind_columns;

select * from dba_tables

--saving the indexe's structure
--select DBMS_METADATA.GET_DDL('INDEX','BNC_NOT_CONFORM_1') from dual;

--select DBMS_METADATA.GET_DDL('INDEX','PK_BNC_NOT_CONFORM') from sultxx1.BNC_NOT_CONFORM;


--drop indexes
/*
drop table BNC_NOT_CONFORM_1

drop table ARG_ITM8_BASE_1 

drop table ARG_ITM8_BASE_GS_1*/



--creating partitions


alter table BNC_NOT_CONFORM_1 modify partition by hash(BNC_CODE_LBNC) partitions 3;

alter table ARG_ITM8_BASE_1 modify  partition by hash(AIB_CODE_ITM8) partitions 3

alter table ARG_ITM8_BASE_GS_1 modify  partition by hash(AIBG_CODE_ITM8) partitions 3

select RPOR_DATE_REJECTED, count(*) from REP_PACKAGES_ORDERS_REJECTED_1 group by RPOR_DATE_REJECTED

select count(*) from REP_PACKAGES_ORDERS_REJECTED_1


select min(RPOR_DATE_REJECTED), max(RPOR_DATE_REJECTED) from REP_PACKAGES_ORDERS_REJECTED_1

--chaque 2 jours ?

alter table REP_PACKAGES_ORDERS_REJECTED_1 modify  partition by range(RPOR_DATE_REJECTED) interval(NUMTOYMINTERVAL(1,'MONTH'))
(
  partition P_18_JAN values less than (TO_DATE('01-02-2018','DD-MM-RRRR')),
  partition P_18_FEB values less than (to_date('01-03-2018','DD-MM-RRRR')),
  partition P_18_MAR values less than (TO_DATE('01-04-2018','DD-MM-RRRR')),
  partition P_18_APR values less than (TO_DATE('01-05-2018','DD-MM-RRRR')),
  partition P_18_MAY values less than (TO_DATE('01-06-2018','DD-MM-RRRR')),
  partition P_18_JUN values less than (TO_DATE('01-07-2018','DD-MM-RRRR')),
  partition P_18_JUL values less than (TO_DATE('01-08-2018','DD-MM-RRRR')),
  partition P_18_AUG values less than (TO_DATE('01-09-2018','DD-MM-RRRR')),
  partition P_18_SEP values less than (TO_DATE('01-10-2018','DD-MM-RRRR')),
  partition P_18_OCT values less than (TO_DATE('01-11-2018','DD-MM-RRRR')),
  partition P_18_NOV values less than (TO_DATE('01-12-2018','DD-MM-RRRR')),
  partition P_18_DEC values less than (TO_DATE('01-01-2019','DD-MM-RRRR')),
  partition P_19_JAN values less than (TO_DATE('01-02-2019','DD-MM-RRRR')),
  partition P_19_FEB values less than (TO_DATE('01-03-2019','DD-MM-RRRR')),
  partition P_19_MAR values less than (TO_DATE('01-04-2019','DD-MM-RRRR')),
  partition P_19_APR values less than (TO_DATE('01-05-2019','DD-MM-RRRR')),
  partition P_19_MAY values less than (TO_DATE('01-06-2019','DD-MM-RRRR')),
  partition P_19_JUN values less than (TO_DATE('01-07-2019','DD-MM-RRRR')),
  partition P_19_JUL values less than (TO_DATE('01-08-2019','DD-MM-RRRR')),
  partition P_19_AUG values less than (TO_DATE('01-09-2019','DD-MM-RRRR')),
  partition P_19_SEP values less than (TO_DATE('01-10-2019','DD-MM-RRRR')),
  partition P_19_OCT values less than (TO_DATE('01-11-2019','DD-MM-RRRR')),
  partition P_19_NOV values less than (TO_DATE('01-12-2019','DD-MM-RRRR')),
  partition P_19_DEC values less than (TO_DATE('01-01-2020','DD-MM-RRRR'))
  
) enable row movement; --8sec 


select ISD_DATE_DISPATCHED, count(*) from INF_SUPPORT_DISPATCHED_1 group by ISD_DATE_DISPATCHED

select min(ISD_DATE_DISPATCHED), max(ISD_DATE_DISPATCHED) from INF_SUPPORT_DISPATCHED_1

--semaines

alter table INF_SUPPORT_DISPATCHED_1 modify  partition by range(ISD_DATE_DISPATCHED) interval(NUMTOYMINTERVAL(1,'MONTH'))
(
  partition P_17_NOV values less than (TO_DATE('01-12-2017','DD-MM-RRRR')),
  partition P_17_DEC values less than (TO_DATE('01-01-2018','DD-MM-RRRR')),
  partition P_18_JAN values less than (TO_DATE('01-02-2018','DD-MM-RRRR')),
  partition P_18_FEB values less than (TO_DATE('01-03-2018','DD-MM-RRRR')),
  partition P_18_MAR values less than (TO_DATE('01-04-2018','DD-MM-RRRR')),
  partition P_18_APR values less than (TO_DATE('01-05-2018','DD-MM-RRRR')),
  partition P_18_MAY values less than (TO_DATE('01-06-2018','DD-MM-RRRR')),
  partition P_18_JUN values less than (TO_DATE('01-07-2018','DD-MM-RRRR')),
  partition P_18_JUL values less than (TO_DATE('01-08-2018','DD-MM-RRRR')),
  partition P_18_AUG values less than (TO_DATE('01-09-2018','DD-MM-RRRR')),
  partition P_18_SEP values less than (TO_DATE('01-10-2018','DD-MM-RRRR')),
  partition P_18_OCT values less than (TO_DATE('01-11-2018','DD-MM-RRRR')),
  partition P_18_NOV values less than (TO_DATE('01-12-2018','DD-MM-RRRR')),
  partition P_18_DEC values less than (TO_DATE('01-01-2019','DD-MM-RRRR')),
  partition P_19_JAN values less than (TO_DATE('01-02-2019','DD-MM-RRRR')),
  partition P_19_FEB values less than (TO_DATE('01-03-2019','DD-MM-RRRR')),
  partition P_19_MAR values less than (TO_DATE('01-04-2019','DD-MM-RRRR')),
  partition P_19_APR values less than (TO_DATE('01-05-2019','DD-MM-RRRR')),
  partition P_19_MAY values less than (TO_DATE('01-06-2019','DD-MM-RRRR')),
  partition P_19_JUN values less than (TO_DATE('01-07-2019','DD-MM-RRRR')),
  partition P_19_JUL values less than (TO_DATE('01-08-2019','DD-MM-RRRR')),
  partition P_19_AUG values less than (TO_DATE('01-09-2019','DD-MM-RRRR')),
  partition P_19_SEP values less than (TO_DATE('01-10-2019','DD-MM-RRRR')),
  partition P_19_OCT values less than (TO_DATE('01-11-2019','DD-MM-RRRR')),
  partition P_19_NOV values less than (TO_DATE('01-12-2019','DD-MM-RRRR')),
  partition P_19_DEC values less than (TO_DATE('01-01-2020','DD-MM-RRRR'))

  
  
) enable row movement;--10s


select FOD_SYSTEM_DATE, count(*) from FFL_ORDER_DATA_1 group by FOD_SYSTEM_DATE

select min(FOD_SYSTEM_DATE), max(FOD_SYSTEM_DATE) from FFL_ORDER_DATA_1
--chaque 1 jours

alter table FFL_ORDER_DATA_1 modify  partition by range(FOD_SYSTEM_DATE) interval(NUMTOYMINTERVAL(1,'MONTH'))(
  partition P_17_DEC values less than (TO_DATE('01-01-2018','DD-MM-RRRR')),
  partition P_18_JAN values less than (TO_DATE('01-02-2018','DD-MM-RRRR')),
  partition P_18_FEB values less than (TO_DATE('01-03-2018','DD-MM-RRRR')),
  partition P_18_MAR values less than (TO_DATE('01-04-2018','DD-MM-RRRR')),
  partition P_18_APR values less than (TO_DATE('01-05-2018','DD-MM-RRRR')),
  partition P_18_MAY values less than (TO_DATE('01-06-2018','DD-MM-RRRR')),
  partition P_18_JUN values less than (TO_DATE('01-07-2018','DD-MM-RRRR')),
  partition P_18_JUL values less than (TO_DATE('01-08-2018','DD-MM-RRRR')),
  partition P_18_AUG values less than (TO_DATE('01-09-2018','DD-MM-RRRR')),
  partition P_18_SEP values less than (TO_DATE('01-10-2018','DD-MM-RRRR')),
  partition P_18_OCT values less than (TO_DATE('01-11-2018','DD-MM-RRRR')),
  partition P_18_NOV values less than (TO_DATE('01-12-2018','DD-MM-RRRR')),
  partition P_18_DEC values less than (TO_DATE('01-01-2019','DD-MM-RRRR')),
  partition P_19_JAN values less than (TO_DATE('01-02-2019','DD-MM-RRRR')),
  partition P_19_FEB values less than (TO_DATE('01-03-2019','DD-MM-RRRR')),
  partition P_19_MAR values less than (TO_DATE('01-04-2019','DD-MM-RRRR')),
  partition P_19_APR values less than (TO_DATE('01-05-2019','DD-MM-RRRR')),
  partition P_19_MAY values less than (TO_DATE('01-06-2019','DD-MM-RRRR')),
  partition P_19_JUN values less than (TO_DATE('01-07-2019','DD-MM-RRRR')),
  partition P_19_JUL values less than (TO_DATE('01-08-2019','DD-MM-RRRR')),
  partition P_19_AUG values less than (TO_DATE('01-09-2019','DD-MM-RRRR')),
  partition P_19_SEP values less than (TO_DATE('01-10-2019','DD-MM-RRRR')),
  partition P_19_OCT values less than (TO_DATE('01-11-2019','DD-MM-RRRR')),
  partition P_19_NOV values less than (TO_DATE('01-12-2019','DD-MM-RRRR')),
  partition P_19_DEC values less than (TO_DATE('01-01-2020','DD-MM-RRRR'))
) enable row movement;--8s

select RPOR_DATE_REJECTED, count(*) from REP_PACKAGES_ORDERS_REJECTED_1 group by RPOR_DATE_REJECTED

select min(RPOR_DATE_REJECTED), max(RPOR_DATE_REJECTED) from REP_PACKAGES_ORDERS_REJECTED_1
--3 semaines

alter table REP_PACKAGES_NOT_SERVED_1 modify  partition by range(RPNS_DATE_REJECTED) interval(NUMTOYMINTERVAL(1,'MONTH'))(
  partition P_18_JAN values less than (TO_DATE('01-02-2018','DD-MM-RRRR')),
  partition P_18_FEB values less than (TO_DATE('01-03-2018','DD-MM-RRRR')),
  partition P_18_MAR values less than (TO_DATE('01-04-2018','DD-MM-RRRR')),
  partition P_18_APR values less than (TO_DATE('01-05-2018','DD-MM-RRRR')),
  partition P_18_MAY values less than (TO_DATE('01-06-2018','DD-MM-RRRR')),
  partition P_18_JUN values less than (TO_DATE('01-07-2018','DD-MM-RRRR')),
  partition P_18_JUL values less than (TO_DATE('01-08-2018','DD-MM-RRRR')),
  partition P_18_AUG values less than (TO_DATE('01-09-2018','DD-MM-RRRR')),
  partition P_18_SEP values less than (TO_DATE('01-10-2018','DD-MM-RRRR')),
  partition P_18_OCT values less than (TO_DATE('01-11-2018','DD-MM-RRRR')),
  partition P_18_NOV values less than (TO_DATE('01-12-2018','DD-MM-RRRR')),
  partition P_18_DEC values less than (TO_DATE('01-01-2019','DD-MM-RRRR')),
  partition P_19_JAN values less than (TO_DATE('01-02-2019','DD-MM-RRRR')),
  partition P_19_FEB values less than (TO_DATE('01-03-2019','DD-MM-RRRR')),
  partition P_19_MAR values less than (TO_DATE('01-04-2019','DD-MM-RRRR')),
  partition P_19_APR values less than (TO_DATE('01-05-2019','DD-MM-RRRR')),
  partition P_19_MAY values less than (TO_DATE('01-06-2019','DD-MM-RRRR')),
  partition P_19_JUN values less than (TO_DATE('01-07-2019','DD-MM-RRRR')),
  partition P_19_JUL values less than (TO_DATE('01-08-2019','DD-MM-RRRR')),
  partition P_19_AUG values less than (TO_DATE('01-09-2019','DD-MM-RRRR')),
  partition P_19_SEP values less than (TO_DATE('01-10-2019','DD-MM-RRRR')),
  partition P_19_OCT values less than (TO_DATE('01-11-2019','DD-MM-RRRR')),
  partition P_19_NOV values less than (TO_DATE('01-12-2019','DD-MM-RRRR')),
  partition P_19_DEC values less than (TO_DATE('01-01-2020','DD-MM-RRRR'))
) enable row movement; -- 1s


select ISP_DATE_SUPPORT , count(*) from INF_SUPPORT_PREPARED_1 group by ISP_DATE_SUPPORT 

select min(ISP_DATE_SUPPORT), max(ISP_DATE_SUPPORT) from INF_SUPPORT_PREPARED_1

--chaque 2 semaines

alter table INF_SUPPORT_PREPARED_1 modify  partition by range(ISP_DATE_SUPPORT ) interval(NUMTOYMINTERVAL(1,'MONTH'))(
  partition P_17_NOV values less than (TO_DATE('01-12-2017','DD-MM-RRRR')),
  partition P_17_DEC values less than (TO_DATE('01-01-2018','DD-MM-RRRR')),
  partition P_18_JAN values less than (TO_DATE('01-02-2018','DD-MM-RRRR')),
  partition P_18_FEB values less than (TO_DATE('01-03-2018','DD-MM-RRRR')),
  partition P_18_MAR values less than (TO_DATE('01-04-2018','DD-MM-RRRR')),
  partition P_18_APR values less than (TO_DATE('01-05-2018','DD-MM-RRRR')),
  partition P_18_MAY values less than (TO_DATE('01-06-2018','DD-MM-RRRR')),
  partition P_18_JUN values less than (TO_DATE('01-07-2018','DD-MM-RRRR')),
  partition P_18_JUL values less than (TO_DATE('01-08-2018','DD-MM-RRRR')),
  partition P_18_AUG values less than (TO_DATE('01-09-2018','DD-MM-RRRR')),
  partition P_18_SEP values less than (TO_DATE('01-10-2018','DD-MM-RRRR')),
  partition P_18_OCT values less than (TO_DATE('01-11-2018','DD-MM-RRRR')),
  partition P_18_NOV values less than (TO_DATE('01-12-2018','DD-MM-RRRR')),
  partition P_18_DEC values less than (TO_DATE('01-01-2019','DD-MM-RRRR')),
  partition P_19_JAN values less than (TO_DATE('01-02-2019','DD-MM-RRRR')),
  partition P_19_FEB values less than (TO_DATE('01-03-2019','DD-MM-RRRR')),
  partition P_19_MAR values less than (TO_DATE('01-04-2019','DD-MM-RRRR')),
  partition P_19_APR values less than (TO_DATE('01-05-2019','DD-MM-RRRR')),
  partition P_19_MAY values less than (TO_DATE('01-06-2019','DD-MM-RRRR')),
  partition P_19_JUN values less than (TO_DATE('01-07-2019','DD-MM-RRRR')),
  partition P_19_JUL values less than (TO_DATE('01-08-2019','DD-MM-RRRR')),
  partition P_19_AUG values less than (TO_DATE('01-09-2019','DD-MM-RRRR')),
  partition P_19_SEP values less than (TO_DATE('01-10-2019','DD-MM-RRRR')),
  partition P_19_OCT values less than (TO_DATE('01-11-2019','DD-MM-RRRR')),
  partition P_19_NOV values less than (TO_DATE('01-12-2019','DD-MM-RRRR')),
  partition P_19_DEC values less than (TO_DATE('01-01-2020','DD-MM-RRRR'))

) enable row movement;--4s




select min(PF_DELIVERY_DATE), max(PF_DELIVERY_DATE) from  PRO_FLYER_1


select PF_DELIVERY_DATE, count(*) from  PRO_FLYER_1 group by PF_DELIVERY_DATE

--creating a partitionned  index 

CREATE INDEX PF_CODE_OPERATION_INDEX ON PRO_FLYER_1(PF_CODE_OPERATION) global partition by hash(PF_CODE_OPERATION) partitions 23--9s

CREATE INDEX ACBO_OPERATION_START_INDEX ON ARG_CATEGORY_BASE_OPERATION_1(ACBO_OPERATION_START) global partition by hash(ACBO_OPERATION_START) partitions 16--9s



alter table PRO_FLYER_1  modify  partition by range(PF_DELIVERY_DATE) interval(NUMTOYMINTERVAL(1,'MONTH'))
(
  partition P_17_AUG values less than (TO_DATE('01-09-2017','DD-MM-RRRR')),
  partition P_17_SEP values less than (TO_DATE('01-10-2017','DD-MM-RRRR')),
  partition P_17_OCT values less than (TO_DATE('01-11-2017','DD-MM-RRRR')),
  partition P_17_NOV values less than (TO_DATE('01-12-2017','DD-MM-RRRR')),
  partition P_17_DEC values less than (TO_DATE('01-01-2018','DD-MM-RRRR')),
  partition P_18_JAN values less than (TO_DATE('01-02-2018','DD-MM-RRRR')),
  partition P_18_FEB values less than (TO_DATE('01-03-2018','DD-MM-RRRR')),
  partition P_18_MAR values less than (TO_DATE('01-04-2018','DD-MM-RRRR')),
  partition P_18_APR values less than (TO_DATE('01-05-2018','DD-MM-RRRR')),
  partition P_18_MAY values less than (TO_DATE('01-06-2018','DD-MM-RRRR')),
  partition P_18_JUN values less than (TO_DATE('01-07-2018','DD-MM-RRRR')),
  partition P_18_JUL values less than (TO_DATE('01-08-2018','DD-MM-RRRR')),
  partition P_18_AUG values less than (TO_DATE('01-09-2018','DD-MM-RRRR')),
  partition P_18_SEP values less than (TO_DATE('01-10-2018','DD-MM-RRRR')),
  partition P_18_OCT values less than (TO_DATE('01-11-2018','DD-MM-RRRR')),
  partition P_18_NOV values less than (TO_DATE('01-12-2018','DD-MM-RRRR')),
  partition P_18_DEC values less than (TO_DATE('01-01-2019','DD-MM-RRRR')),
  partition P_19_JAN values less than (TO_DATE('01-02-2019','DD-MM-RRRR')),
  partition P_19_FEB values less than (TO_DATE('01-03-2019','DD-MM-RRRR')),
  partition P_19_MAR values less than (TO_DATE('01-04-2019','DD-MM-RRRR')),
  partition P_19_APR values less than (TO_DATE('01-05-2019','DD-MM-RRRR')),
  partition P_19_MAY values less than (TO_DATE('01-06-2019','DD-MM-RRRR')),
  partition P_19_JUN values less than (TO_DATE('01-07-2019','DD-MM-RRRR')),
  partition P_19_JUL values less than (TO_DATE('01-08-2019','DD-MM-RRRR')),
  partition P_19_AUG values less than (TO_DATE('01-09-2019','DD-MM-RRRR')),
  partition P_19_SEP values less than (TO_DATE('01-10-2019','DD-MM-RRRR')),
  partition P_19_OCT values less than (TO_DATE('01-11-2019','DD-MM-RRRR')),
  partition P_19_NOV values less than (TO_DATE('01-12-2019','DD-MM-RRRR')),
  partition P_19_DEC values less than (TO_DATE('01-01-2020','DD-MM-RRRR'))
  
) enable row movement; 



--purging tables 

 
CREATE PROCEDURE purger(tablename VARCHAR2) 
is
   
    DECLARE
        guid number :=to_number(to_char(sysdate,'YYYYMMDDHH24MISS'));
         pck varchar2(10):= 'CREA I';
         prc varchar2(10):= 'RPO'
    BEGIN
        record_log(guid, 'pck', 'prc', 'crea index RPO_TEST1','DEBUT',  null, 0); 
        tablename := tablename || 'arch' ;
        execute immediate 'create table ' ||tablename || '_arch  as
        select * from '  || tablename  '  where 1=2 ';
        execute immediate 'for cur  in select PARTITION_NAME from user_tab_partitions where table_name=' || tablename || ' and partition_name not in (P_19_DEC, P_19_NOV, P_19_OCT, P_19_SEP
        , P_19_AUG, P_19_JUL , P_19_JUN, P_19_MAY ) LOOP 
        ALTER TABLE  || ' || tablename || ' EXCHANGE PARTITION  CUR WITH TABLE ' || tablename || '_arch ; ' 
            
        ' end loop';

    EXCEPTION
        when others then record_error(guid);
    END;


create table REP_PACKAGES_ORDERS_REJECTED_1_arch  as select * from REP_PACKAGES_ORDERS_REJECTED_1  where 1=2 



 
ALTER TABLE REP_PACKAGES_ORDERS_REJECTED_1 EXCHANGE PARTITION   P_18_JAN WITH TABLE REP_PACKAGES_ORDERS_REJECTED_1_arch  


drop table REP_PACKAGES_ORDERS_REJECTED_1_arch

--creation new global indexes

CREATE INDEX PK_BNC_NOT_CONFORM_1 ON BNC_NOT_CONFORM_1 (BNC_CODE_LBNC) global partition by hash(BNC_CODE_LBNC) partitions 3


CREATE INDEX PK_ITM8_BASE_1 ON ARG_ITM8_BASE_1 (AIB_CODE_COUNTRY, AIB_CODE_ITM8, AIB_CODE_BASE) global partition by hash(AIB_CODE_COUNTRY) partitions 3 -- 4s


CREATE INDEX PK_ITM8_BASE_GS_1 ON ARG_ITM8_BASE_GS_1 (AIBG_CODE_COUNTRY, AIBG_CODE_ITM8, AIBG_CODE_BASE) global partition by hash(AIBG_CODE_COUNTRY) partitions 3 -- 4s



CREATE INDEX PK_REP_PACKAGES_ORDERS_REJECTE_1 ON REP_PACKAGES_ORDERS_REJECTED_1 (RPOR_DATE_REJECTED, RPOR_CODE_ITM8, RPOR_BASE, RPOR_CODE_CLIENT, RPOR_DELIVERY_REFERENCE) global partition by hash(RPOR_DATE_REJECTED) partitions 30--16s

CREATE INDEX PK_SUPPORT_DISPATCHED_1 ON  INF_SUPPORT_DISPATCHED_1 (ISD_BASE, ISD_CODE_CLIENT, ISD_CODE_SUPPORT, ISD_SUB_CODE_SUPPORT) global partition by hash(ISD_BASE) partitions 21--9s

CREATE INDEX PK_FFL_ORDER_DATA_1  ON FFL_ORDER_DATA_1 (FOD_SYSTEM_DATE, FOD_CODE_CLIENT, FOD_CODE_BASE, FOD_ORDER_NUMBER, FOD_CODE_ITM8, FOD_CODE_UL) global partition by hash(FOD_SYSTEM_DATE) partitions 32--13s

CREATE INDEX PK_REP_PACKAGES_NOT_SERVED_1  ON  REP_PACKAGES_NOT_SERVED_1(RPNS_DATE_REJECTED, RPNS_BASE, RPNS_CODE_ITM8) global partition by hash(RPNS_DATE_REJECTED) partitions 3--1s

CREATE INDEX PK_SUPPORTS_PREPARED_1  ON INF_SUPPORT_PREPARED_1 (ISP_BASE, ISP_CODE_CLIENT, ISP_CODE_SUPPORT, ISP_SUB_CODE_SUPPORT) global partition by hash(ISP_BASE) partitions 3--9s

CREATE INDEX PK_PRO_FLYER_1 ON PRO_FLYER_1(PF_CODE_CLIENT, PF_CODE_ITM8, PF_CODE_OPERATION) global partition by hash(PF_CODE_CLIENT) partitions 23--9s

--verifying
select * from user_tab_partitions where table_name='INF_SUPPORT_DISPATCHED_1' ;

select * from user_tab_partitions where table_name='INF_SUPPORT_DISPATCHED_1' ;

select * from REP_PACKAGES_ORDERS_REJECTED_1;

select table_name,partition_name,num_rows from user_tab_partitions where table_name='REP_PACKAGES_ORDERS_REJECTED_1' ;

select * from user_ind_partitions where index_name ='PK_REP_PACKAGES_ORDERS_REJECTE_1' ;

select RPOR_DATE_REJECTED, count(*) from REP_PACKAGES_ORDERS_REJECTED_1 group by RPOR_DATE_REJECTED

select * from user_tables

exec dbms_stats.gather_table_stats('TEST_PART','INF_SUPPORT_DISPATCHED_1',estimate_percent=>100,degree=>4);



         WHERE     ACBO_OPERATION_START BETWEEN TO_DATE ('20181126',
                                                             'YYYYMMDD')
                                                AND TO_DATE ('20181130',
                                                             'YYYYMMDD')
                                                             
                                                             ARG_CATEGORY_BASE_OPERATION
                                                             
                                                             
             création d'index partitionné sur        ACBO_OPERATION_START
                      création d'index partitionné            PRO_FLYER       (code operation)
             
             purge de la table
             
             
             drop des 2 indexes
             
             
                                       
    SELECT * FROM sultxx1.ARG_CATEGORY_BASE_OPERATION WHERE ACBO_OPERATION_START = Null 
    
    
    
    
    
    select * from dba_hist_sql_plan where object_name like 'PRO_FLYER%'

select * from dba_hist_sqltext where sql_id='80wmwab46v1vs'


explain plan for
SELECT  ....
        
SELECT * FROM TABLE(dbms_xplan.display);


	DECLARE
	guid number :=to_number(to_char(sysdate,'YYYYMMDDHH24MISS'));
	 pck varchar2(10):= 'CREA I';
	 prc varchar2(10):= 'RPO';
	   BEGIN
		record_log(guid, 'pck', 'prc', 'crea index RPO_TEST1','DEBUT',  null, 0); 
		execute immediate 'ALTER SESSION FORCE PARALLEL DDL PARALLEL 32';
		execute immediate 'CREATE INDEX RPO_TEST1 ON REP_PACKAGES_ORDERS(RPO_CODE_ITM8, RPO_CODE_CLIENT, RPO_BASE)  
		TABLESPACE TBS_LT_INDEX GLOBAL PARTITION BY HASH (RPO_CODE_ITM8)
		PARTITIONS 1028 PARALLEL';
		execute immediate 'alter index RPO_TEST1 PARALLEL ';
		record_log(guid, 'pck', 'prc', 'crea index RPO_TEST1', 'FIN', null, 0);
		execute immediate 'alter index RPO_TEST1 monitoring usage )';
	exception
	when others then record_error(guid);raise;
			end;
	/
	
	LOG_ERROR
	
	select * from v$index_usage_info
	
	SELECT index_name,
       table_name,
       monitoring,
       used,
       start_monitoring,
       end_monitoring
FROM   dba_object_usage
ORDER BY index_name;