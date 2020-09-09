-- 
-- Non Foreign Key Constraints for Table EDU_RESULT 
-- 
ALTER TABLE EDU_RESULT ADD (
  CONSTRAINT PK_EDU_RESULT
 PRIMARY KEY
 (EDU_RESULT_NO));


-- 
-- Non Foreign Key Constraints for Table INST_CRT_HIS 
-- 
ALTER TABLE INST_CRT_HIS ADD (
  CONSTRAINT PK_INST_CRT_HIS
 PRIMARY KEY
 (CRT_NO));


-- 
-- Non Foreign Key Constraints for Table INST_RPR_HIS 
-- 
ALTER TABLE INST_RPR_HIS ADD (
  CONSTRAINT PK_INST_RPR_HIS
 PRIMARY KEY
 (RPR_NO));


-- 
-- Non Foreign Key Constraints for Table INST_USE_HIS 
-- 
ALTER TABLE INST_USE_HIS ADD (
  CONSTRAINT PK_INST_USE_HIS
 PRIMARY KEY
 (USE_NO));


-- 
-- Non Foreign Key Constraints for Table TEST_REPORT_ATTACH 
-- 
ALTER TABLE TEST_REPORT_ATTACH ADD (
  CHECK ("TEST_SAMPLE_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ACCOUNT_APPLY 
-- 
ALTER TABLE ACCOUNT_APPLY ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));




-- 
-- Non Foreign Key Constraints for Table ACCOUNT_DETAIL 
-- 
ALTER TABLE ACCOUNT_DETAIL ADD (
  CHECK ("ACCOUNT_TYPE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ACCOUNT_APPLY 
-- 
ALTER TABLE ACCOUNT_APPLY ADD (
  CHECK ("TEST_SAMPLE_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_TEAM 
-- 
ALTER TABLE DEPT_TEAM ADD (
  CONSTRAINT DEPT_TEAM_PK
 PRIMARY KEY
 (DEPT_CD, TEAM_CD));


-- 
-- Non Foreign Key Constraints for Table DEPT_TEAM_USER 
-- 
ALTER TABLE DEPT_TEAM_USER ADD (
  CONSTRAINT DEPT_TEAM_USER_PK
 PRIMARY KEY
 (TEAM_CD, USER_ID));


-- 
-- Non Foreign Key Constraints for Table DOCUMENT 
-- 
ALTER TABLE DOCUMENT ADD (
  CONSTRAINT DOCUMENT_PK
 PRIMARY KEY
 (DOC_SEQ));




-- 
-- Non Foreign Key Constraints for Table ACCOUNT_APPLY 
-- 
ALTER TABLE ACCOUNT_APPLY ADD (
  CHECK ("ACCOUNT_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE_ITEM_FEE 
-- 
ALTER TABLE ESTIMATE_ITEM_FEE ADD (
  CHECK ("EST_FEE_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE_FEE_GUBUN 
-- 
ALTER TABLE ESTIMATE_FEE_GUBUN ADD (
  CHECK ("EST_FEE_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_DISUSE 
-- 
ALTER TABLE TEST_SAMPLE_DISUSE ADD (
  CHECK ("TEST_SAMPLE_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table FORM 
-- 
ALTER TABLE FORM ADD (
  CHECK ("FORM_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DOCUMENT 
-- 
ALTER TABLE DOCUMENT ADD (
  CHECK ("DOC_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DOCUMENT 
-- 
ALTER TABLE DOCUMENT ADD (
  CHECK ("DOC_REVISION_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DOC_ATTACH 
-- 
ALTER TABLE DOC_ATTACH ADD (
  CHECK ("DOC_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE 
-- 
ALTER TABLE SAMPLE ADD (
  CONSTRAINT PK_SAMPLE
 PRIMARY KEY
 (SAMPLE_CD));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_TEMP 
-- 
ALTER TABLE SAMPLE_TEMP ADD (
  CONSTRAINT PK_SAMPLE_TEMP
 PRIMARY KEY
 (SAMPLE_TEMP_CD));


-- 
-- Non Foreign Key Constraints for Table SAMPLING_POINT 
-- 
ALTER TABLE SAMPLING_POINT ADD (
  CONSTRAINT PK_SAMPLING_POINT
 PRIMARY KEY
 (SAMPLING_POINT_NO));



-- 
-- Non Foreign Key Constraints for Table COUNSEL_PERSONAL 
-- 
ALTER TABLE COUNSEL_PERSONAL ADD (
  CONSTRAINT PK_KEY
 PRIMARY KEY
 (TOTAL_NO, PERSONAL_NO));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ATTACH 
-- 
ALTER TABLE TEST_SAMPLE_ATTACH ADD (
  CHECK ("TEST_SAMPLE_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INST_RENT 
-- 
ALTER TABLE INST_RENT ADD (
  PRIMARY KEY
 (INSTRENT_RECEIPT_NO));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_METHOD 
-- 
ALTER TABLE TEST_ITEM_METHOD ADD (
  CONSTRAINT TEST_ITEM_METHOD_PK
 PRIMARY KEY
 (TEST_ITEM_CD, TEST_METHOD_NO, TEST_STD_NO));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ATTACH 
-- 
ALTER TABLE TEST_SAMPLE_ATTACH ADD (
  CHECK ("ATT_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_GROUP_ITEM 
-- 
ALTER TABLE TEST_ITEM_GROUP_ITEM ADD (
  PRIMARY KEY
 (TEST_ITEM_GROUP_NO, TEST_ITEM_CD));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ITEM_ATTACH 
-- 
ALTER TABLE TEST_SAMPLE_ITEM_ATTACH ADD (
  CHECK ("ATT_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ITEM_HISTORY 
-- 
ALTER TABLE TEST_SAMPLE_ITEM_HISTORY ADD (
  CHECK ("TEST_SAMPLE_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ZIP_ADDR 
-- 
ALTER TABLE ZIP_ADDR ADD (
  CONSTRAINT ZIP_ADDR_PK
 PRIMARY KEY
 (BUILDING_NO));


-- 
-- Non Foreign Key Constraints for Table EDU_RESULT_DOC 
-- 
ALTER TABLE EDU_RESULT_DOC ADD (
  CONSTRAINT PK_EDU_RESULT_DOC
 PRIMARY KEY
 (EDU_DOC_NO));


-- 
-- Non Foreign Key Constraints for Table MENU 
-- 
ALTER TABLE MENU ADD (
  CONSTRAINT PK_MENU
 PRIMARY KEY
 (MENU_CD));


-- 
-- Non Foreign Key Constraints for Table MTLR_MST 
-- 
ALTER TABLE MTLR_MST ADD (
  CONSTRAINT PK_MTLR_MST
 PRIMARY KEY
 (MTLR_MST_NO));


-- 
-- Non Foreign Key Constraints for Table NOTICE 
-- 
ALTER TABLE NOTICE ADD (
  CONSTRAINT PK_NOTICE
 PRIMARY KEY
 (NOTICE_NO));


-- 
-- Non Foreign Key Constraints for Table PROCESS 
-- 
ALTER TABLE PROCESS ADD (
  CONSTRAINT PK_PROCESS
 PRIMARY KEY
 (PRC_CD));


-- 
-- Non Foreign Key Constraints for Table BOARD 
-- 
ALTER TABLE BOARD ADD (
  CONSTRAINT BOARD_PK
 PRIMARY KEY
 (BOARD_NO));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_LOG 
-- 
ALTER TABLE CMMN_SPEC_KIND_LOG ADD (
  CONSTRAINT CMMN_SPEC_KIND_LOG_PK
 PRIMARY KEY
 (CMMN_SPEC_CD, LAST_UPDT_DTM));


-- 
-- Non Foreign Key Constraints for Table FEE_GROUP 
-- 
ALTER TABLE FEE_GROUP ADD (
  CONSTRAINT PK_FEE_GROUP
 PRIMARY KEY
 (FEE_GROUP_NO));


-- 
-- Non Foreign Key Constraints for Table FORM 
-- 
ALTER TABLE FORM ADD (
  CONSTRAINT FORM_PK
 PRIMARY KEY
 (FORM_SEQ));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CONSTRAINT INDV_SPEC_LOG_PK
 PRIMARY KEY
 (INDV_SPEC_SEQ, LAST_UPDT_DTM));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CONSTRAINT INDV_SPEC_PK
 PRIMARY KEY
 (INDV_SPEC_SEQ));


-- 
-- Non Foreign Key Constraints for Table INSTRUMENT 
-- 
ALTER TABLE INSTRUMENT ADD (
  CONSTRAINT INSTRUMENT_PK
 PRIMARY KEY
 (INST_NO));


-- 
-- Non Foreign Key Constraints for Table MTLR_INFO 
-- 
ALTER TABLE MTLR_INFO ADD (
  CONSTRAINT MTLR_INFO_PK
 PRIMARY KEY
 (MTLR_NO));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_EXPT_PRDLST_LOG 
-- 
ALTER TABLE CMMN_SPEC_KIND_EXPT_PRDLST_LOG ADD (
  CONSTRAINT CMMN_EXPT_PRDLST_LOG_PK
 PRIMARY KEY
 (CMMN_SPEC_CD, PRDLST_CD, TESTITM_CD, LAST_UPDT_DTM));


-- 
-- Non Foreign Key Constraints for Table TEST_REPORT_ATTACH 
-- 
ALTER TABLE TEST_REPORT_ATTACH ADD (
  CONSTRAINT TEST_REPORT_ATTACH_PK
 PRIMARY KEY
 (ATT_SEQ));


-- 
-- Non Foreign Key Constraints for Table TEST_REPORT 
-- 
ALTER TABLE TEST_REPORT ADD (
  CONSTRAINT TEST_REPORT_PK
 PRIMARY KEY
 (TEST_SAMPLE_SEQ, TEST_ITEM_CD));


-- 
-- Non Foreign Key Constraints for Table TEST_STD 
-- 
ALTER TABLE TEST_STD ADD (
  CONSTRAINT PK_TEST_STD
 PRIMARY KEY
 (TEST_STD_NO));


-- 
-- Non Foreign Key Constraints for Table TEST_STD_REV 
-- 
ALTER TABLE TEST_STD_REV ADD (
  CONSTRAINT PK_TEST_STD_REV
 PRIMARY KEY
 (REV_NO, TEST_STD_NO));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL_LOG 
-- 
ALTER TABLE PRDLST_CL_LOG ADD (
  CONSTRAINT PRDLST_CL_LOG_PK
 PRIMARY KEY
 (PRDLST_CD, LAST_UPDT_DTM));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL 
-- 
ALTER TABLE PRDLST_CL ADD (
  CONSTRAINT PRDLST_CL_PK
 PRIMARY KEY
 (PRDLST_CD));


-- 
-- Non Foreign Key Constraints for Table REPORT_DOC 
-- 
ALTER TABLE REPORT_DOC ADD (
  CONSTRAINT REPORT_DOC_PK
 PRIMARY KEY
 (REPORT_DOC_SEQ));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_EXPT_PRDLST 
-- 
ALTER TABLE CMMN_SPEC_KIND_EXPT_PRDLST ADD (
  CONSTRAINT CMMN_SPEC_KIND_EXPT_PRDLST_PK
 PRIMARY KEY
 (CMMN_SPEC_CD, PRDLST_CD, TESTITM_CD));


-- 
-- Non Foreign Key Constraints for Table REPORT_NAME 
-- 
ALTER TABLE REPORT_NAME ADD (
  CONSTRAINT REPORT_NAME_PK
 PRIMARY KEY
 (REPORT_SEQ));


-- 
-- Non Foreign Key Constraints for Table ACCOUNT_APPLY 
-- 
ALTER TABLE ACCOUNT_APPLY ADD (
  CONSTRAINT ACCOUNT_APPLY_PK
 PRIMARY KEY
 (TEST_SAMPLE_SEQ, TEST_ITEM_CD, ACCOUNT_NO, ACCOUNT_DETAIL_NO));


-- 
-- Non Foreign Key Constraints for Table TEST_REQ 
-- 
ALTER TABLE TEST_REQ ADD (
  CONSTRAINT PK_TEST_REQ
 PRIMARY KEY
 (TEST_REQ_NO));




-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE 
-- 
ALTER TABLE TEST_SAMPLE ADD (
  CONSTRAINT PK_TEST_SAMPLE
 PRIMARY KEY
 (TEST_SAMPLE_SEQ));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ITEM 
-- 
ALTER TABLE TEST_SAMPLE_ITEM ADD (
  CONSTRAINT PK_TEST_SAMPLE_ITEM
 PRIMARY KEY
 (TEST_SAMPLE_SEQ, TEST_ITEM_SEQ));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_DISUSE 
-- 
ALTER TABLE TEST_SAMPLE_DISUSE ADD (
  CONSTRAINT TEST_SAMPLE_DISUSE_PK
 PRIMARY KEY
 (TEST_SAMPLE_SEQ));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ITEM_HISTORY 
-- 
ALTER TABLE TEST_SAMPLE_ITEM_HISTORY ADD (
  CONSTRAINT TEST_SAMPLE_ITEM_HISTORY_PK
 PRIMARY KEY
 (ITEM_HIS_SEQ));


-- 
-- Non Foreign Key Constraints for Table USER_INFO 
-- 
ALTER TABLE USER_INFO ADD (
  CONSTRAINT USER_INFO_PK
 PRIMARY KEY
 (USER_ID));


-- 
-- Non Foreign Key Constraints for Table ACCOUNT 
-- 
ALTER TABLE ACCOUNT ADD (
  CONSTRAINT ACCOUNT_PK
 PRIMARY KEY
 (ACCOUNT_NO));




-- 
-- Non Foreign Key Constraints for Table INST_RENT_ITEM 
-- 
ALTER TABLE INST_RENT_ITEM ADD (
  CONSTRAINT EQUIPRENT_ITEM_PK
 PRIMARY KEY
 (INSTRENT_SAMPLE_NO, TEST_ITEM_CD));


-- 
-- Non Foreign Key Constraints for Table TEST_COMMENT 
-- 
ALTER TABLE TEST_COMMENT ADD (
  CONSTRAINT PK_TEST_COMMENT
 PRIMARY KEY
 (TEST_REQ_NO, TESTER_ID));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM 
-- 
ALTER TABLE TEST_ITEM ADD (
  CONSTRAINT PK_TEST_ITEM
 PRIMARY KEY
 (TEST_ITEM_CD));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_GROUP 
-- 
ALTER TABLE TEST_ITEM_GROUP ADD (
  CONSTRAINT PK_TEST_ITEM_GROUP
 PRIMARY KEY
 (TEST_ITEM_GROUP_NO));




-- 
-- Non Foreign Key Constraints for Table AUDIT_TRAIL 
-- 
ALTER TABLE AUDIT_TRAIL ADD (
  CHECK ("AT_PROC" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ANALYSIS_LOG 
-- 
ALTER TABLE ANALYSIS_LOG ADD (
  CONSTRAINT ANALYSIS_LOG_PK
 PRIMARY KEY
 (TESTITM_CD, LAST_UPDT_DTM));


-- 
-- Non Foreign Key Constraints for Table ANALYSIS 
-- 
ALTER TABLE ANALYSIS ADD (
  CONSTRAINT ANALYSIS_PK
 PRIMARY KEY
 (TESTITM_CD));


-- 
-- Non Foreign Key Constraints for Table AUDIT_TRAIL 
-- 
ALTER TABLE AUDIT_TRAIL ADD (
  CONSTRAINT AUDIT_TRAIL_PK
 PRIMARY KEY
 (AT_SEQ));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ITEM_ATTACH 
-- 
ALTER TABLE TEST_SAMPLE_ITEM_ATTACH ADD (
  CONSTRAINT TEST_ITEM_ATTACH_PK
 PRIMARY KEY
 (ATT_SEQ));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_INST 
-- 
ALTER TABLE TEST_ITEM_INST ADD (
  CONSTRAINT TEST_ITEM_INST_PK
 PRIMARY KEY
 (TEST_ITEM_CD, INST_NO, TEST_STD_NO));



-- 
-- Non Foreign Key Constraints for Table UNIT_WORK 
-- 
ALTER TABLE UNIT_WORK ADD (
  CONSTRAINT PK_UNIT_WORK
 PRIMARY KEY
 (UNIT_WORK_CD));


-- 
-- Non Foreign Key Constraints for Table REPORT_SAMPLE 
-- 
ALTER TABLE REPORT_SAMPLE ADD (
  CONSTRAINT REPORT_SAMPLE_PK
 PRIMARY KEY
 (REPORT_SEQ));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_HISTORY 
-- 
ALTER TABLE SAMPLE_HISTORY ADD (
  CONSTRAINT SAMPLE_HISTORY_PK
 PRIMARY KEY
 (TEST_SAMPLE_SEQ, SAMPLE_HIS_SEQ));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_TEMP_ITEM 
-- 
ALTER TABLE SAMPLE_TEMP_ITEM ADD (
  CONSTRAINT SAMPLE_TEMP_ITEM_PK
 PRIMARY KEY
 (SAMPLE_TEMP_CD, TEMP_SEQ, TEST_ITEM_CD));


-- 
-- Non Foreign Key Constraints for Table BAK_STD_TEST_ITEM 
-- 
ALTER TABLE BAK_STD_TEST_ITEM ADD (
  CONSTRAINT STD_TEST_ITEM_PK
 PRIMARY KEY
 (TEST_ITEM_CD, TEST_STD_NO, REV_NO));


-- 
-- Non Foreign Key Constraints for Table ORG_COMMISSION_DEPOSIT 
-- 
ALTER TABLE ORG_COMMISSION_DEPOSIT ADD (
  PRIMARY KEY
 (DEPOSIT_NO));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ATTACH 
-- 
ALTER TABLE TEST_SAMPLE_ATTACH ADD (
  CONSTRAINT TEST_SAMPLE_ATTACH_PK
 PRIMARY KEY
 (ATT_SEQ));


-- 
-- Non Foreign Key Constraints for Table ACCOUNT_DETAIL 
-- 
ALTER TABLE ACCOUNT_DETAIL ADD (
  CONSTRAINT ACCOUNT_DETAIL_PK
 PRIMARY KEY
 (ACCOUNT_NO, ACCOUNT_DETAIL_NO));


-- 
-- Non Foreign Key Constraints for Table APPR_DEPT_DTL 
-- 
ALTER TABLE APPR_DEPT_DTL ADD (
  PRIMARY KEY
 (APPR_MST_SEQ, APPR_DTL_SEQ));


-- 
-- Non Foreign Key Constraints for Table APPR_DEPT_MST 
-- 
ALTER TABLE APPR_DEPT_MST ADD (
  PRIMARY KEY
 (APPR_MST_SEQ));


-- 
-- Non Foreign Key Constraints for Table COUNSEL_TOTAL 
-- 
ALTER TABLE COUNSEL_TOTAL ADD (
  PRIMARY KEY
 (TOTAL_NO));


-- 
-- Non Foreign Key Constraints for Table ABSENCE 
-- 
ALTER TABLE ABSENCE ADD (
  CONSTRAINT ABSENCE_PK
 PRIMARY KEY
 (USER_ID));


-- 
-- Non Foreign Key Constraints for Table ACCESS_IP_MANAGE 
-- 
ALTER TABLE ACCESS_IP_MANAGE ADD (
  CONSTRAINT ACCESS_IP_MANAGE_PK
 PRIMARY KEY
 (IP_SEQ));


-- 
-- Non Foreign Key Constraints for Table USER_LOG_HISTORY 
-- 
ALTER TABLE USER_LOG_HISTORY ADD (
  CONSTRAINT PK_USER_LOG_HISTORY
 PRIMARY KEY
 (LOG_ID));


-- 
-- Non Foreign Key Constraints for Table MTLR_REQ 
-- 
ALTER TABLE MTLR_REQ ADD (
  CONSTRAINT MTLR_REQ_PK
 PRIMARY KEY
 (MTLR_MST_NO, MTLR_REQ_NO));


-- 
-- Non Foreign Key Constraints for Table APPR_LINE 
-- 
ALTER TABLE APPR_LINE ADD (
  CONSTRAINT PK_APPR_LINE
 PRIMARY KEY
 (APPR_SEQ, APPR_MST_SEQ));


-- 
-- Non Foreign Key Constraints for Table ROLE_GROUP 
-- 
ALTER TABLE ROLE_GROUP ADD (
  CONSTRAINT PK_ROLE_GROUP
 PRIMARY KEY
 (ROLE_NO));


-- 
-- Non Foreign Key Constraints for Table ROLE_GROUP_MENU 
-- 
ALTER TABLE ROLE_GROUP_MENU ADD (
  CONSTRAINT PK_ROLE_GROUP_MENU
 PRIMARY KEY
 (ROLE_NO, MENU_CD));


-- 
-- Non Foreign Key Constraints for Table ROLE_GROUP_USER 
-- 
ALTER TABLE ROLE_GROUP_USER ADD (
  CONSTRAINT PK_ROLE_GROUP_USER
 PRIMARY KEY
 (ROLE_NO, USER_ID));


-- 
-- Non Foreign Key Constraints for Table INST_RENT_SAMPLE 
-- 
ALTER TABLE INST_RENT_SAMPLE ADD (
  CONSTRAINT EQUIPRENT_SAMPLE_PK
 PRIMARY KEY
 (INSTRENT_RENT_NO, INSTRENT_SAMPLE_NO));



-- 
-- Non Foreign Key Constraints for Table DOC_ATTACH 
-- 
ALTER TABLE DOC_ATTACH ADD (
  CONSTRAINT DOC_ATTACH_PK
 PRIMARY KEY
 (DOC_SEQ));


-- 
-- Non Foreign Key Constraints for Table INST_RENT_INST 
-- 
ALTER TABLE INST_RENT_INST ADD (
  CONSTRAINT EQUIPRENT_EQUIP_PK
 PRIMARY KEY
 (INSTRENT_RECEIPT_NO, INSTRENT_RENT_NO));


-- 
-- Non Foreign Key Constraints for Table INST_MNG_HIS 
-- 
ALTER TABLE INST_MNG_HIS ADD (
  CONSTRAINT INST_MNG_HIS_PK
 PRIMARY KEY
 (INST_NO, MNG_NO));


-- 
-- Non Foreign Key Constraints for Table KOLAS_ADD_FILE 
-- 
ALTER TABLE KOLAS_ADD_FILE ADD (
  CONSTRAINT KOLAS_ADD_FILE_PK
 PRIMARY KEY
 (FILE_NO));


-- 
-- Non Foreign Key Constraints for Table REQ_ORG 
-- 
ALTER TABLE REQ_ORG ADD (
  CONSTRAINT PK_REQ_ORG
 PRIMARY KEY
 (REQ_ORG_NO));


-- 
-- Non Foreign Key Constraints for Table KOLAS_DOC 
-- 
ALTER TABLE KOLAS_DOC ADD (
  CONSTRAINT KOLAS_DOC_PK
 PRIMARY KEY
 (KOLAS_DOC_NO));


-- 
-- Non Foreign Key Constraints for Table TEST_METHOD 
-- 
ALTER TABLE TEST_METHOD ADD (
  CONSTRAINT PK_TEST_METHOD
 PRIMARY KEY
 (TEST_METHOD_NO));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ITEM_HISTORY 
-- 
ALTER TABLE TEST_SAMPLE_ITEM_HISTORY ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ITEM_HISTORY 
-- 
ALTER TABLE TEST_SAMPLE_ITEM_HISTORY ADD (
  CHECK ("ITEM_HIS_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table AUDIT_TRAIL 
-- 
ALTER TABLE AUDIT_TRAIL ADD (
  CHECK ("CREATE_DATE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table AUDIT_TRAIL 
-- 
ALTER TABLE AUDIT_TRAIL ADD (
  CHECK ("CREATER_ID" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE_ITEM_FEE 
-- 
ALTER TABLE ESTIMATE_ITEM_FEE ADD (
  CONSTRAINT ESTIMATE_ITEM_FEE_PK
 PRIMARY KEY
 (EST_NO, EST_FEE_NO));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE 
-- 
ALTER TABLE ESTIMATE ADD (
  CONSTRAINT ESTIMATE_PK
 PRIMARY KEY
 (EST_NO, EST_ORG_NO));


-- 
-- Non Foreign Key Constraints for Table DEPT_UNIT_WORK 
-- 
ALTER TABLE DEPT_UNIT_WORK ADD (
  CONSTRAINT PK_DEPT_UNIT_WORK
 PRIMARY KEY
 (UNIT_WORK_CD, DEPT_CD));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE_FEE_GUBUN 
-- 
ALTER TABLE ESTIMATE_FEE_GUBUN ADD (
  CONSTRAINT ESTIMATE_FEE_GUBUN_PK
 PRIMARY KEY
 (EST_FEE_CD));



-- 
-- Non Foreign Key Constraints for Table ESTIMATE_ITEM 
-- 
ALTER TABLE ESTIMATE_ITEM ADD (
  CONSTRAINT ESTIMATE_DETAIL_PK
 PRIMARY KEY
 (EST_ITEM_NO, EST_NO));


-- 
-- Non Foreign Key Constraints for Table EDU_ATTEND 
-- 
ALTER TABLE EDU_ATTEND ADD (
  CONSTRAINT PK_EDU_ATTEND
 PRIMARY KEY
 (ATTEND_NO));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC 
-- 
ALTER TABLE CMMN_SPEC ADD (
  CONSTRAINT CMMN_SPEC_PK
 PRIMARY KEY
 (CMMN_SPEC_SEQ));


-- 
-- Non Foreign Key Constraints for Table ACCOUNT_DETAIL 
-- 
ALTER TABLE ACCOUNT_DETAIL ADD (
  CHECK ("ACCOUNT_DETAIL_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_USER_ITEM 
-- 
ALTER TABLE DEPT_USER_ITEM ADD (
  CONSTRAINT PK_DEPT_USER_ITEM
 PRIMARY KEY
 (DEPT_USER_ITEM_NO));




-- 
-- Non Foreign Key Constraints for Table ACCOUNT 
-- 
ALTER TABLE ACCOUNT ADD (
  CHECK ("ACCOUNT_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ACCOUNT_DETAIL 
-- 
ALTER TABLE ACCOUNT_DETAIL ADD (
  CHECK ("ACCOUNT_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COMMON_CODE 
-- 
ALTER TABLE COMMON_CODE ADD (
  CONSTRAINT PK_COMMON_CODE
 PRIMARY KEY
 (CODE));


-- 
-- Non Foreign Key Constraints for Table COMMON_CODE_DETAIL 
-- 
ALTER TABLE COMMON_CODE_DETAIL ADD (
  CONSTRAINT PK_COMMON_CODE_DETAIL
 PRIMARY KEY
 (CODE));


-- 
-- Non Foreign Key Constraints for Table DEPART 
-- 
ALTER TABLE DEPART ADD (
  CONSTRAINT PK_DEPART
 PRIMARY KEY
 (DEPT_CD));



-- 
-- Non Foreign Key Constraints for Table ACCOUNT_APPLY 
-- 
ALTER TABLE ACCOUNT_APPLY ADD (
  CHECK ("ACCOUNT_DETAIL_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ACCOUNT_APPLY 
-- 
ALTER TABLE ACCOUNT_APPLY ADD (
  CHECK ("ACCOUNT_TYPE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND 
-- 
ALTER TABLE CMMN_SPEC_KIND ADD (
  CONSTRAINT CMMN_SPEC_KIND_PK
 PRIMARY KEY
 (CMMN_SPEC_CD));


-- 
-- Non Foreign Key Constraints for Table TEST_REPORT_ATTACH 
-- 
ALTER TABLE TEST_REPORT_ATTACH ADD (
  CHECK ("ATT_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_LOG 
-- 
ALTER TABLE CMMN_SPEC_LOG ADD (
  CONSTRAINT CMMN_SPEC_LOG_PK
 PRIMARY KEY
 (CMMN_SPEC_SEQ, LAST_UPDT_DTM));


-- 
-- Non Foreign Key Constraints for Table COUNSEL_TOTAL 
-- 
ALTER TABLE COUNSEL_TOTAL ADD (
  CHECK ("COUNSEL_CLIENT_NM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COUNSEL_PERSONAL 
-- 
ALTER TABLE COUNSEL_PERSONAL ADD (
  CHECK ("COUNSEL_PROGRESS_STS" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CHECK ("VALD_END_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table BOARD 
-- 
ALTER TABLE BOARD ADD (
  CHECK ("BOARD_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table USER_LOG_HISTORY 
-- 
ALTER TABLE USER_LOG_HISTORY ADD (
  CHECK ("LOG_ID" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL 
-- 
ALTER TABLE PRDLST_CL ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL 
-- 
ALTER TABLE PRDLST_CL ADD (
  CHECK ("VALD_BEGN_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC 
-- 
ALTER TABLE CMMN_SPEC ADD (
  CHECK ("VALD_END_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC 
-- 
ALTER TABLE CMMN_SPEC ADD (
  CHECK ("TESTITM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CHECK ("JDGMNT_FOM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table USER_INFO 
-- 
ALTER TABLE USER_INFO ADD (
  CHECK ("USER_ID" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table UNIT_WORK 
-- 
ALTER TABLE UNIT_WORK ADD (
  CHECK ("UNIT_WORK_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_STD_REV 
-- 
ALTER TABLE TEST_STD_REV ADD (
  CHECK ("TEST_STD_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_STD_REV 
-- 
ALTER TABLE TEST_STD_REV ADD (
  CHECK ("REV_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_STD_REV 
-- 
ALTER TABLE TEST_STD_REV ADD (
  CHECK ("REV_DATE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_STD 
-- 
ALTER TABLE TEST_STD ADD (
  CHECK ("TEST_STD_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ITEM 
-- 
ALTER TABLE TEST_SAMPLE_ITEM ADD (
  CHECK ("TEST_ITEM_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE_ITEM 
-- 
ALTER TABLE TEST_SAMPLE_ITEM ADD (
  CHECK ("TEST_SAMPLE_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE 
-- 
ALTER TABLE TEST_SAMPLE ADD (
  CHECK ("TEST_REQ_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CHECK ("PRDLST_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CHECK ("TESTITM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table EDU_RESULT 
-- 
ALTER TABLE EDU_RESULT ADD (
  CHECK ("EDU_RESULT_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_USER_ITEM 
-- 
ALTER TABLE DEPT_USER_ITEM ADD (
  CHECK ("DEPT_USER_ITEM_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ABSENCE 
-- 
ALTER TABLE ABSENCE ADD (
  CHECK ("START_DATE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ABSENCE 
-- 
ALTER TABLE ABSENCE ADD (
  CHECK ("USER_ID" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table MTLR_INOUT 
-- 
ALTER TABLE MTLR_INOUT ADD (
  CHECK ("MTLR_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table MTLR_INOUT 
-- 
ALTER TABLE MTLR_INOUT ADD (
  CHECK ("INOUT_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table MENU 
-- 
ALTER TABLE MENU ADD (
  CHECK ("MENU_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table MTLR_INFO 
-- 
ALTER TABLE MTLR_INFO ADD (
  CHECK ("MTLR_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table KOLAS_DOC 
-- 
ALTER TABLE KOLAS_DOC ADD (
  CHECK ("KOLAS_DOC_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COMMON_CODE 
-- 
ALTER TABLE COMMON_CODE ADD (
  CHECK ("CODE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table AUDIT_TRAIL 
-- 
ALTER TABLE AUDIT_TRAIL ADD (
  CHECK ("AT_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table APPR_LINE 
-- 
ALTER TABLE APPR_LINE ADD (
  CHECK ("APPR_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PROCESS 
-- 
ALTER TABLE PROCESS ADD (
  CHECK ("PRC_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table NOTICE 
-- 
ALTER TABLE NOTICE ADD (
  CHECK ("NOTICE_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_LOG 
-- 
ALTER TABLE CMMN_SPEC_LOG ADD (
  CHECK ("TESTITM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL 
-- 
ALTER TABLE PRDLST_CL ADD (
  CHECK ("USE_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_TEAM 
-- 
ALTER TABLE DEPT_TEAM ADD (
  CHECK ("TEAM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_TEAM 
-- 
ALTER TABLE DEPT_TEAM ADD (
  CHECK ("DEPT_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_METHOD 
-- 
ALTER TABLE TEST_METHOD ADD (
  CHECK ("TEST_METHOD_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table EDU_RESULT_DOC 
-- 
ALTER TABLE EDU_RESULT_DOC ADD (
  CHECK ("EDU_RESULT_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table EDU_RESULT_DOC 
-- 
ALTER TABLE EDU_RESULT_DOC ADD (
  CHECK ("EDU_DOC_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table EDU_ATTEND 
-- 
ALTER TABLE EDU_ATTEND ADD (
  CHECK ("EDU_RESULT_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND 
-- 
ALTER TABLE CMMN_SPEC_KIND ADD (
  CHECK ("CMMN_SPEC_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CHECK ("FNPRT_ITM_INCLS_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table BAK_STD_TEST_ITEM 
-- 
ALTER TABLE BAK_STD_TEST_ITEM ADD (
  CHECK ("REV_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table BAK_STD_TEST_ITEM 
-- 
ALTER TABLE BAK_STD_TEST_ITEM ADD (
  CHECK ("TEST_STD_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table BAK_STD_TEST_ITEM 
-- 
ALTER TABLE BAK_STD_TEST_ITEM ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLING_POINT 
-- 
ALTER TABLE SAMPLING_POINT ADD (
  CHECK ("SAMPLING_POINT_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_TEMP_ITEM 
-- 
ALTER TABLE SAMPLE_TEMP_ITEM ADD (
  CHECK ("TEMP_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_TEMP_ITEM 
-- 
ALTER TABLE SAMPLE_TEMP_ITEM ADD (
  CHECK ("SAMPLE_TEMP_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_TEMP 
-- 
ALTER TABLE SAMPLE_TEMP ADD (
  CHECK ("DEPT_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table BAK_SELF_SPEC 
-- 
ALTER TABLE BAK_SELF_SPEC ADD (
  CHECK ("PRDLST_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table BAK_SELF_SPEC 
-- 
ALTER TABLE BAK_SELF_SPEC ADD (
  CHECK ("TESTITM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ZIP_ADDR 
-- 
ALTER TABLE ZIP_ADDR ADD (
  CHECK ("BUILDING_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ACCESS_IP_MANAGE 
-- 
ALTER TABLE ACCESS_IP_MANAGE ADD (
  CHECK ("IP_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table USER_INFO 
-- 
ALTER TABLE USER_INFO ADD (
  CHECK ("DEPT_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_GROUP_ITEM 
-- 
ALTER TABLE TEST_ITEM_GROUP_ITEM ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_TEMP_ITEM 
-- 
ALTER TABLE SAMPLE_TEMP_ITEM ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CHECK ("VALD_END_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CHECK ("PRDLST_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CHECK ("TESTITM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INST_CRT_HIS 
-- 
ALTER TABLE INST_CRT_HIS ADD (
  CHECK ("CRT_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table FEE_GROUP 
-- 
ALTER TABLE FEE_GROUP ADD (
  CHECK ("FEE_GROUP_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table MTLR_REQ 
-- 
ALTER TABLE MTLR_REQ ADD (
  CHECK ("MTLR_MST_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table MTLR_REQ 
-- 
ALTER TABLE MTLR_REQ ADD (
  CHECK ("MTLR_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table MTLR_REQ 
-- 
ALTER TABLE MTLR_REQ ADD (
  CHECK ("MTLR_REQ_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_INST 
-- 
ALTER TABLE TEST_ITEM_INST ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_GROUP_ITEM 
-- 
ALTER TABLE TEST_ITEM_GROUP_ITEM ADD (
  CHECK ("TEST_ITEM_GROUP_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_GROUP 
-- 
ALTER TABLE TEST_ITEM_GROUP ADD (
  CHECK ("TEST_ITEM_GROUP_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM 
-- 
ALTER TABLE TEST_ITEM ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_COMMENT 
-- 
ALTER TABLE TEST_COMMENT ADD (
  CHECK ("TESTER_ID" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_COMMENT 
-- 
ALTER TABLE TEST_COMMENT ADD (
  CHECK ("TEST_REQ_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ANALYSIS 
-- 
ALTER TABLE ANALYSIS ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ANALYSIS 
-- 
ALTER TABLE ANALYSIS ADD (
  CHECK ("USE_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ANALYSIS 
-- 
ALTER TABLE ANALYSIS ADD (
  CHECK ("TESTITM_NM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INST_RPR_HIS 
-- 
ALTER TABLE INST_RPR_HIS ADD (
  CHECK ("RPR_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INST_MNG_HIS 
-- 
ALTER TABLE INST_MNG_HIS ADD (
  CHECK ("MNG_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ROLE_GROUP_USER 
-- 
ALTER TABLE ROLE_GROUP_USER ADD (
  CHECK ("ROLE_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_USER_ITEM 
-- 
ALTER TABLE DEPT_USER_ITEM ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table REPORT_SAMPLE 
-- 
ALTER TABLE REPORT_SAMPLE ADD (
  CHECK ("REPORT_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table REPORT_NAME 
-- 
ALTER TABLE REPORT_NAME ADD (
  CHECK ("REPORT_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC 
-- 
ALTER TABLE CMMN_SPEC ADD (
  CHECK ("JDGMNT_FOM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC 
-- 
ALTER TABLE CMMN_SPEC ADD (
  CHECK ("FNPRT_ITM_INCLS_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC 
-- 
ALTER TABLE CMMN_SPEC ADD (
  CHECK ("INJRY_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CHECK ("FNPRT_ITM_INCLS_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CHECK ("INJRY_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CHECK ("VALD_BEGN_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_EXPT_PRDLST 
-- 
ALTER TABLE CMMN_SPEC_KIND_EXPT_PRDLST ADD (
  CHECK ("TESTITM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_LOG 
-- 
ALTER TABLE CMMN_SPEC_LOG ADD (
  CHECK ("JDGMNT_FOM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ANALYSIS_LOG 
-- 
ALTER TABLE ANALYSIS_LOG ADD (
  CHECK ("USE_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_REQ 
-- 
ALTER TABLE TEST_REQ ADD (
  CHECK ("TEST_REQ_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_METHOD 
-- 
ALTER TABLE TEST_ITEM_METHOD ADD (
  CHECK ("TEST_METHOD_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CHECK ("JDGMNT_FOM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CHECK ("INDV_SPEC_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_EXPT_PRDLST_LOG 
-- 
ALTER TABLE CMMN_SPEC_KIND_EXPT_PRDLST_LOG ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_EXPT_PRDLST_LOG 
-- 
ALTER TABLE CMMN_SPEC_KIND_EXPT_PRDLST_LOG ADD (
  CHECK ("PRDLST_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL_LOG 
-- 
ALTER TABLE PRDLST_CL_LOG ADD (
  CHECK ("USE_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL_LOG 
-- 
ALTER TABLE PRDLST_CL_LOG ADD (
  CHECK ("LV" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL_LOG 
-- 
ALTER TABLE PRDLST_CL_LOG ADD (
  CHECK ("PRDLST_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ROLE_GROUP_MENU 
-- 
ALTER TABLE ROLE_GROUP_MENU ADD (
  CHECK ("MENU_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ROLE_GROUP_MENU 
-- 
ALTER TABLE ROLE_GROUP_MENU ADD (
  CHECK ("ROLE_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table REQ_ORG 
-- 
ALTER TABLE REQ_ORG ADD (
  CHECK ("REQ_ORG_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ROLE_GROUP 
-- 
ALTER TABLE ROLE_GROUP ADD (
  CHECK ("ROLE_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ANALYSIS_LOG 
-- 
ALTER TABLE ANALYSIS_LOG ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COUNSEL_TOTAL 
-- 
ALTER TABLE COUNSEL_TOTAL ADD (
  CHECK ("COUNSEL_DATE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE 
-- 
ALTER TABLE ESTIMATE ADD (
  CHECK ("EST_ORG_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_EXPT_PRDLST_LOG 
-- 
ALTER TABLE CMMN_SPEC_KIND_EXPT_PRDLST_LOG ADD (
  CHECK ("TESTITM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_EXPT_PRDLST 
-- 
ALTER TABLE CMMN_SPEC_KIND_EXPT_PRDLST ADD (
  CHECK ("CMMN_SPEC_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_EXPT_PRDLST 
-- 
ALTER TABLE CMMN_SPEC_KIND_EXPT_PRDLST ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_EXPT_PRDLST 
-- 
ALTER TABLE CMMN_SPEC_KIND_EXPT_PRDLST ADD (
  CHECK ("PRDLST_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL 
-- 
ALTER TABLE PRDLST_CL ADD (
  CHECK ("VALD_END_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table MTLR_MST 
-- 
ALTER TABLE MTLR_MST ADD (
  CHECK ("MTLR_MST_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INST_USE_HIS 
-- 
ALTER TABLE INST_USE_HIS ADD (
  CHECK ("USE_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC 
-- 
ALTER TABLE CMMN_SPEC ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INSTRUMENT 
-- 
ALTER TABLE INSTRUMENT ADD (
  CHECK ("INST_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL 
-- 
ALTER TABLE PRDLST_CL ADD (
  CHECK ("LV" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_STD_FEE 
-- 
ALTER TABLE TEST_STD_FEE ADD (
  CHECK ("TEST_STD_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table BAK_SELF_SPEC 
-- 
ALTER TABLE BAK_SELF_SPEC ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PROCESS 
-- 
ALTER TABLE PROCESS ADD (
  CHECK ("PRC_NM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE 
-- 
ALTER TABLE ESTIMATE ADD (
  CHECK ("EST_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE_ITEM_FEE 
-- 
ALTER TABLE ESTIMATE_ITEM_FEE ADD (
  CHECK ("EST_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC 
-- 
ALTER TABLE CMMN_SPEC ADD (
  CHECK ("SPEC_VAL" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC 
-- 
ALTER TABLE CMMN_SPEC ADD (
  CHECK ("CMMN_SPEC_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC 
-- 
ALTER TABLE CMMN_SPEC ADD (
  CHECK ("VALD_BEGN_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_HISTORY 
-- 
ALTER TABLE SAMPLE_HISTORY ADD (
  CHECK ("USER_ID" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_HISTORY 
-- 
ALTER TABLE SAMPLE_HISTORY ADD (
  CHECK ("DEPT_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_HISTORY 
-- 
ALTER TABLE SAMPLE_HISTORY ADD (
  CHECK ("SAMPLE_HIS_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE 
-- 
ALTER TABLE SAMPLE ADD (
  CHECK ("SAMPLE_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ROLE_GROUP_USER 
-- 
ALTER TABLE ROLE_GROUP_USER ADD (
  CHECK ("USER_ID" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CHECK ("SPEC_VAL" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE_ITEM 
-- 
ALTER TABLE ESTIMATE_ITEM ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE_ITEM 
-- 
ALTER TABLE ESTIMATE_ITEM ADD (
  CHECK ("EST_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ESTIMATE_ITEM 
-- 
ALTER TABLE ESTIMATE_ITEM ADD (
  CHECK ("EST_ITEM_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COUNSEL_TOTAL 
-- 
ALTER TABLE COUNSEL_TOTAL ADD (
  CHECK ("USER_FLAG" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COUNSEL_TOTAL 
-- 
ALTER TABLE COUNSEL_TOTAL ADD (
  CHECK ("REQ_ORG_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL 
-- 
ALTER TABLE PRDLST_CL ADD (
  CHECK ("PRDLST_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_USER_ITEM 
-- 
ALTER TABLE DEPT_USER_ITEM ADD (
  CHECK ("USER_ID" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_LOG 
-- 
ALTER TABLE CMMN_SPEC_LOG ADD (
  CHECK ("FNPRT_ITM_INCLS_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_LOG 
-- 
ALTER TABLE CMMN_SPEC_LOG ADD (
  CHECK ("INJRY_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_LOG 
-- 
ALTER TABLE CMMN_SPEC_LOG ADD (
  CHECK ("VALD_BEGN_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_LOG 
-- 
ALTER TABLE CMMN_SPEC_LOG ADD (
  CHECK ("SPEC_VAL" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_LOG 
-- 
ALTER TABLE CMMN_SPEC_LOG ADD (
  CHECK ("CMMN_SPEC_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_LOG 
-- 
ALTER TABLE CMMN_SPEC_LOG ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_LOG 
-- 
ALTER TABLE CMMN_SPEC_LOG ADD (
  CHECK ("VALD_END_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INST_MNG_HIS 
-- 
ALTER TABLE INST_MNG_HIS ADD (
  CHECK ("INST_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ANALYSIS_LOG 
-- 
ALTER TABLE ANALYSIS_LOG ADD (
  CHECK ("TESTITM_NM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ANALYSIS_LOG 
-- 
ALTER TABLE ANALYSIS_LOG ADD (
  CHECK ("TESTITM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ANALYSIS 
-- 
ALTER TABLE ANALYSIS ADD (
  CHECK ("TESTITM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_LOG 
-- 
ALTER TABLE CMMN_SPEC_KIND_LOG ADD (
  CHECK ("CMMN_SPEC_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_LOG 
-- 
ALTER TABLE CMMN_SPEC_KIND_LOG ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CHECK ("INDV_SPEC_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_METHOD 
-- 
ALTER TABLE TEST_ITEM_METHOD ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_INST 
-- 
ALTER TABLE TEST_ITEM_INST ADD (
  CHECK ("TEST_STD_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_INST 
-- 
ALTER TABLE TEST_ITEM_INST ADD (
  CHECK ("INST_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table REPORT_DOC 
-- 
ALTER TABLE REPORT_DOC ADD (
  CHECK ("REPORT_DOC_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_TEMP 
-- 
ALTER TABLE SAMPLE_TEMP ADD (
  CHECK ("SAMPLE_TEMP_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_TEMP 
-- 
ALTER TABLE SAMPLE_TEMP ADD (
  CHECK ("SAMPLE_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_HISTORY 
-- 
ALTER TABLE SAMPLE_HISTORY ADD (
  CHECK ("WORK_DATE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table SAMPLE_HISTORY 
-- 
ALTER TABLE SAMPLE_HISTORY ADD (
  CHECK ("SAMPLE_STATE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_UNIT_WORK 
-- 
ALTER TABLE DEPT_UNIT_WORK ADD (
  CHECK ("DEPT_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_UNIT_WORK 
-- 
ALTER TABLE DEPT_UNIT_WORK ADD (
  CHECK ("UNIT_WORK_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_SAMPLE 
-- 
ALTER TABLE TEST_SAMPLE ADD (
  CHECK ("TEST_SAMPLE_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table EDU_ATTEND 
-- 
ALTER TABLE EDU_ATTEND ADD (
  CHECK ("ATTEND_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COUNSEL_PERSONAL 
-- 
ALTER TABLE COUNSEL_PERSONAL ADD (
  CHECK ("COUNSEL_CONTENT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COUNSEL_PERSONAL 
-- 
ALTER TABLE COUNSEL_PERSONAL ADD (
  CHECK ("COUNSEL_PATH" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COUNSEL_PERSONAL 
-- 
ALTER TABLE COUNSEL_PERSONAL ADD (
  CHECK ("COUNSEL_DATE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_TEAM_USER 
-- 
ALTER TABLE DEPT_TEAM_USER ADD (
  CHECK ("USER_ID" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COUNSEL_PERSONAL 
-- 
ALTER TABLE COUNSEL_PERSONAL ADD (
  CHECK ("COUNSEL_DIV" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_TEAM_USER 
-- 
ALTER TABLE DEPT_TEAM_USER ADD (
  CHECK ("TEAM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPART 
-- 
ALTER TABLE DEPART ADD (
  CHECK ("DEPT_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table COMMON_CODE_DETAIL 
-- 
ALTER TABLE COMMON_CODE_DETAIL ADD (
  CHECK ("CODE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CHECK ("INJRY_YN" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CHECK ("VALD_BEGN_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INDV_SPEC_LOG 
-- 
ALTER TABLE INDV_SPEC_LOG ADD (
  CHECK ("SPEC_VAL" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INST_RENT_ITEM 
-- 
ALTER TABLE INST_RENT_ITEM ADD (
  CHECK ("TEST_ITEM_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table INST_RENT_ITEM 
-- 
ALTER TABLE INST_RENT_ITEM ADD (
  CHECK ("INSTRENT_SAMPLE_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table TEST_ITEM_METHOD 
-- 
ALTER TABLE TEST_ITEM_METHOD ADD (
  CHECK ("TEST_STD_NO" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table APPR_LINE 
-- 
ALTER TABLE APPR_LINE ADD (
  CHECK ("APPR_MST_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table AUDIT_TRAIL 
-- 
ALTER TABLE AUDIT_TRAIL ADD (
  CHECK ("MENU_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ZIP_ADDR_OLD 
-- 
ALTER TABLE ZIP_ADDR_OLD ADD (
  CHECK ("GUN_MNG_NUM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND 
-- 
ALTER TABLE CMMN_SPEC_KIND ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL_LOG 
-- 
ALTER TABLE PRDLST_CL_LOG ADD (
  CHECK ("LAST_UPDT_DTM" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL_LOG 
-- 
ALTER TABLE PRDLST_CL_LOG ADD (
  CHECK ("VALD_BEGN_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table PRDLST_CL_LOG 
-- 
ALTER TABLE PRDLST_CL_LOG ADD (
  CHECK ("VALD_END_DT" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table CMMN_SPEC_KIND_EXPT_PRDLST_LOG 
-- 
ALTER TABLE CMMN_SPEC_KIND_EXPT_PRDLST_LOG ADD (
  CHECK ("CMMN_SPEC_CD" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table APPR_DEPT_MST 
-- 
ALTER TABLE APPR_DEPT_MST ADD (
  CHECK ("APPR_MST_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table APPR_DEPT_DTL 
-- 
ALTER TABLE APPR_DEPT_DTL ADD (
  CHECK ("APPR_DTL_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table APPR_DEPT_DTL 
-- 
ALTER TABLE APPR_DEPT_DTL ADD (
  CHECK ("APPR_MST_SEQ" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ABSENCE 
-- 
ALTER TABLE ABSENCE ADD (
  CHECK ("SUBSTITUTE_ID" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table ABSENCE 
-- 
ALTER TABLE ABSENCE ADD (
  CHECK ("END_DATE" IS NOT NULL));


-- 
-- Non Foreign Key Constraints for Table DEPT_TEAM 
-- 
ALTER TABLE DEPT_TEAM ADD (
  CHECK ("TEAM_NM" IS NOT NULL));

-- 
-- Foreign Key Constraints for Table TEST_SAMPLE_ITEM 
-- 
ALTER TABLE TEST_SAMPLE_ITEM ADD (
  CONSTRAINT TEST_SAMPLE_ITEM_FK3 
 FOREIGN KEY (TEST_ITEM_GROUP_NO) 
 REFERENCES TEST_ITEM_GROUP (TEST_ITEM_GROUP_NO));


-- 
-- Foreign Key Constraints for Table TEST_SAMPLE_ITEM 
-- 
ALTER TABLE TEST_SAMPLE_ITEM ADD (
  CONSTRAINT TEST_SAMPLE_ITEM_FK2 
 FOREIGN KEY (FEE_GROUP_NO) 
 REFERENCES FEE_GROUP (FEE_GROUP_NO));



-- 
-- Foreign Key Constraints for Table DEPT_TEAM 
-- 
ALTER TABLE DEPT_TEAM ADD (
  CONSTRAINT DEPT_TEAM_R01 
 FOREIGN KEY (DEPT_CD) 
 REFERENCES DEPART (DEPT_CD));


-- 
-- Foreign Key Constraints for Table BAK_STD_TEST_ITEM 
-- 
ALTER TABLE BAK_STD_TEST_ITEM ADD (
  CONSTRAINT STD_TEST_ITEM_FK1 
 FOREIGN KEY (TEST_ITEM_CD) 
 REFERENCES TEST_ITEM (TEST_ITEM_CD));



-- 
-- Foreign Key Constraints for Table EDU_ATTEND 
-- 
ALTER TABLE EDU_ATTEND ADD (
  CONSTRAINT EDU_ATTEND_FK1 
 FOREIGN KEY (EDU_RESULT_NO) 
 REFERENCES EDU_RESULT (EDU_RESULT_NO));


-- 
-- Foreign Key Constraints for Table EDU_RESULT_DOC 
-- 
ALTER TABLE EDU_RESULT_DOC ADD (
  CONSTRAINT EDU_RESULT_DOC_FK1 
 FOREIGN KEY (EDU_RESULT_NO) 
 REFERENCES EDU_RESULT (EDU_RESULT_NO));


-- 
-- Foreign Key Constraints for Table INDV_SPEC 
-- 
ALTER TABLE INDV_SPEC ADD (
  CONSTRAINT INDV_SPEC_R01 
 FOREIGN KEY (TESTITM_CD) 
 REFERENCES ANALYSIS (TESTITM_CD));


 
-- 
-- Foreign Key Constraints for Table REPORT_SAMPLE 
-- 
ALTER TABLE REPORT_SAMPLE ADD (
  CONSTRAINT REPORT_SAMPLE_FK1 
 FOREIGN KEY (REPORT_DOC_SEQ) 
 REFERENCES REPORT_DOC (REPORT_DOC_SEQ));


-- 
-- Foreign Key Constraints for Table REPORT_SAMPLE 
-- 
ALTER TABLE REPORT_SAMPLE ADD (
  CONSTRAINT REPORT_SAMPLE_FK2 
 FOREIGN KEY (TEST_SAMPLE_SEQ) 
 REFERENCES TEST_SAMPLE (TEST_SAMPLE_SEQ));


-- 
-- Foreign Key Constraints for Table SAMPLE_TEMP 
-- 
ALTER TABLE SAMPLE_TEMP ADD (
  CONSTRAINT SAMPLE_TEMP_R01 
 FOREIGN KEY (SAMPLE_CD) 
 REFERENCES SAMPLE (SAMPLE_CD));


 
-- 
-- Foreign Key Constraints for Table ACCOUNT_DETAIL 
-- 
ALTER TABLE ACCOUNT_DETAIL ADD (
  CONSTRAINT ACCOUNT_DETAIL_R01 
 FOREIGN KEY (ACCOUNT_NO) 
 REFERENCES ACCOUNT (ACCOUNT_NO));


-- 
-- Foreign Key Constraints for Table ACCOUNT 
-- 
ALTER TABLE ACCOUNT ADD (
  CONSTRAINT ACCOUNT_R01 
 FOREIGN KEY (TEST_METHOD_NO) 
 REFERENCES TEST_METHOD (TEST_METHOD_NO));

 
-- 
-- Foreign Key Constraints for Table DOC_ATTACH 
-- 
ALTER TABLE DOC_ATTACH ADD (
  CONSTRAINT DOC_ATTACH_FK1 
 FOREIGN KEY (DOC_SEQ) 
 REFERENCES DOCUMENT (DOC_SEQ));



-- 
-- Foreign Key Constraints for Table DEPT_UNIT_WORK 
-- 
ALTER TABLE DEPT_UNIT_WORK ADD (
  CONSTRAINT DEPT_UNIT_WORK_R01 
 FOREIGN KEY (UNIT_WORK_CD) 
 REFERENCES UNIT_WORK (UNIT_WORK_CD));


-- 
-- Foreign Key Constraints for Table TEST_REQ 
-- 
ALTER TABLE TEST_REQ ADD (
  CONSTRAINT TEST_REQ_FK2 
 FOREIGN KEY (UNIT_WORK_CD) 
 REFERENCES UNIT_WORK (UNIT_WORK_CD));



-- 
-- Foreign Key Constraints for Table DEPT_TEAM_USER 
-- 
ALTER TABLE DEPT_TEAM_USER ADD (
  CONSTRAINT DEPT_TEAM_USER_R02 
 FOREIGN KEY (USER_ID) 
 REFERENCES USER_INFO (USER_ID));


-- 
-- Foreign Key Constraints for Table TEST_SAMPLE_ITEM_HISTORY 
-- 
ALTER TABLE TEST_SAMPLE_ITEM_HISTORY ADD (
  CONSTRAINT TEST_SAMPLE_ITEM_HISTORY_FK3 
 FOREIGN KEY (TEST_DEPT_CD, TEAM_CD) 
 REFERENCES DEPT_TEAM (DEPT_CD,TEAM_CD));


-- 
-- Foreign Key Constraints for Table DEPT_UNIT_WORK 
-- 
ALTER TABLE DEPT_UNIT_WORK ADD (
  CONSTRAINT DEPT_UNIT_WORK_R02 
 FOREIGN KEY (DEPT_CD) 
 REFERENCES DEPART (DEPT_CD));



-- 
-- Foreign Key Constraints for Table APPR_DEPT_DTL 
-- 
ALTER TABLE APPR_DEPT_DTL ADD (
  FOREIGN KEY (APPR_MST_SEQ) 
 REFERENCES APPR_DEPT_MST (APPR_MST_SEQ));



-- 
-- Foreign Key Constraints for Table TEST_SAMPLE_ITEM_HISTORY 
-- 
ALTER TABLE TEST_SAMPLE_ITEM_HISTORY ADD (
  CONSTRAINT TEST_SAMPLE_ITEM_HISTORY_FK2 
 FOREIGN KEY (TESTER_ID) 
 REFERENCES USER_INFO (USER_ID));


-- 
-- Foreign Key Constraints for Table BAK_STD_TEST_ITEM 
-- 
ALTER TABLE BAK_STD_TEST_ITEM ADD (
  CONSTRAINT STD_TEST_ITEM_R02 
 FOREIGN KEY (TEST_STD_NO) 
 REFERENCES TEST_STD (TEST_STD_NO));




-- 
-- Foreign Key Constraints for Table TEST_ITEM_GROUP_ITEM 
-- 
ALTER TABLE TEST_ITEM_GROUP_ITEM ADD (
  CONSTRAINT TEST_ITEM_GROUP_ITEM_FK1 
 FOREIGN KEY (TEST_ITEM_GROUP_NO) 
 REFERENCES TEST_ITEM_GROUP (TEST_ITEM_GROUP_NO));


-- 
-- Foreign Key Constraints for Table ACCOUNT_APPLY 
-- 
ALTER TABLE ACCOUNT_APPLY ADD (
  CONSTRAINT ACCOUNT_APPLY_R01 
 FOREIGN KEY (TEST_ITEM_CD) 
 REFERENCES TEST_ITEM (TEST_ITEM_CD));


-- 
-- Foreign Key Constraints for Table ACCOUNT_APPLY 
-- 
ALTER TABLE ACCOUNT_APPLY ADD (
  CONSTRAINT ACCOUNT_APPLY_R02 
 FOREIGN KEY (ACCOUNT_NO, ACCOUNT_DETAIL_NO) 
 REFERENCES ACCOUNT_DETAIL (ACCOUNT_NO,ACCOUNT_DETAIL_NO));



-- 
-- Foreign Key Constraints for Table TEST_ITEM_INST 
-- 
ALTER TABLE TEST_ITEM_INST ADD (
  CONSTRAINT TEST_ITEM_INST_FK1 
 FOREIGN KEY (TEST_ITEM_CD) 
 REFERENCES TEST_ITEM (TEST_ITEM_CD));


-- 
-- Foreign Key Constraints for Table TEST_ITEM_METHOD 
-- 
ALTER TABLE TEST_ITEM_METHOD ADD (
  CONSTRAINT TEST_ITEM_METHOD_R01 
 FOREIGN KEY (TEST_METHOD_NO) 
 REFERENCES TEST_METHOD (TEST_METHOD_NO));


-- 
-- Foreign Key Constraints for Table TEST_ITEM_METHOD 
-- 
ALTER TABLE TEST_ITEM_METHOD ADD (
  CONSTRAINT TEST_ITEM_METHOD_R02 
 FOREIGN KEY (TEST_ITEM_CD) 
 REFERENCES TEST_ITEM (TEST_ITEM_CD));


-- 
-- Foreign Key Constraints for Table TEST_REPORT_ATTACH 
-- 
ALTER TABLE TEST_REPORT_ATTACH ADD (
  CONSTRAINT TEST_REPORT_ATTACH_FK1 
 FOREIGN KEY (TEST_SAMPLE_SEQ) 
 REFERENCES TEST_SAMPLE (TEST_SAMPLE_SEQ));


-- 
-- Foreign Key Constraints for Table TEST_REQ 
-- 
ALTER TABLE TEST_REQ ADD (
  CONSTRAINT TEST_REQ_FK1 
 FOREIGN KEY (DEPT_CD) 
 REFERENCES DEPART (DEPT_CD));



 
-- 
-- Foreign Key Constraints for Table TEST_REQ 
-- 
ALTER TABLE TEST_REQ ADD (
  CONSTRAINT TEST_REQ_FK3 
 FOREIGN KEY (ACT_USER_ID) 
 REFERENCES USER_INFO (USER_ID));


-- 
-- Foreign Key Constraints for Table TEST_SAMPLE 
-- 
ALTER TABLE TEST_SAMPLE ADD (
  CONSTRAINT TEST_SAMPLE_FK1 
 FOREIGN KEY (SAMPLE_CD) 
 REFERENCES PRDLST_CL (PRDLST_CD));


-- 
-- Foreign Key Constraints for Table TEST_SAMPLE_ITEM_ATTACH 
-- 
ALTER TABLE TEST_SAMPLE_ITEM_ATTACH ADD (
  CONSTRAINT TEST_SAMPLE_ITEM_ATTACH_FK1 
 FOREIGN KEY (TEST_SAMPLE_SEQ) 
 REFERENCES TEST_SAMPLE (TEST_SAMPLE_SEQ));


-- 
-- Foreign Key Constraints for Table TEST_SAMPLE_ITEM_HISTORY 
-- 
ALTER TABLE TEST_SAMPLE_ITEM_HISTORY ADD (
  CONSTRAINT TEST_SAMPLE_ITEM_HISTORY_FK1 
 FOREIGN KEY (TEST_SAMPLE_SEQ) 
 REFERENCES TEST_SAMPLE (TEST_SAMPLE_SEQ));
