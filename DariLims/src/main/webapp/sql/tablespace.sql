DROP TABLESPACE TEMP INCLUDING CONTENTS AND DATAFILES;

CREATE TEMPORARY TABLESPACE TEMP TEMPFILE 
  'D:\limsOracle\TABLESPACE.DBF' SIZE 1000M AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED
TABLESPACE GROUP ''
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M;  
  
  
CREATE  TABLESPACE LIMS DATAFILE 
  'D:\limsOracle\TABLESPACE\LIMS.DBF' SIZE 1000M AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;



DROP TABLESPACE RDMS INCLUDING CONTENTS AND DATAFILES;

CREATE TABLESPACE RDMS DATAFILE 
  'D:\ORADATA\RDMS.DBF' SIZE 1000M AUTOEXTEND ON NEXT 1000M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


