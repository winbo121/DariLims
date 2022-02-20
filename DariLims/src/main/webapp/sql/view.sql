/* Formatted on 2016-01-14 오전 10:46:56 (QP5 v5.115.810.9015) */
--
-- RDMS_VW_ITEM  (View)
--
--  Dependencies:
--   DEPART (Table)
--   PROCESS (Table)
--   TEST_ITEM (Table)
--   TEST_SAMPLE_ITEM (Table)
--   USER_INFO (Table)
--

CREATE OR REPLACE FORCE VIEW RDMS_VW_ITEM
(
   RDMS_TEST_ITEM_NM,
   TEST_SAMPLE_SEQ,
   TEST_ITEM_SEQ,
   TEST_ITEM_CD,
   TEST_ITEM_NM,
   TEST_DEPT_CD,
   TEST_DEPT_NM,
   TESTER_ID,
   TESTER_NM,
   ITEM_STATE_CD,
   ITEM_STATE_NM
)
AS
   SELECT      TEST_SAMPLE_SEQ
            || TEST_ITEM_SEQ
            || ' : '
            || (SELECT   TEST_ITEM_NM
                  FROM   TEST_ITEM TI
                 WHERE   TSI.TEST_ITEM_CD = TI.TEST_ITEM_CD)
               AS RDMS_TEST_ITEM_NM,
            TEST_SAMPLE_SEQ,
            TEST_ITEM_SEQ,
            TEST_ITEM_CD,
            (SELECT   TEST_ITEM_NM
               FROM   TEST_ITEM TI
              WHERE   TSI.TEST_ITEM_CD = TI.TEST_ITEM_CD)
               AS TEST_ITEM_NM,
            TEST_DEPT_CD,
            (SELECT   DEPT_NM
               FROM   DEPART DP
              WHERE   TSI.TEST_DEPT_CD = DP.DEPT_CD)
               AS TEST_DEPT_NM,
            TESTER_ID,
            (SELECT   USER_NM
               FROM   USER_INFO UI
              WHERE   TSI.TESTER_ID = UI.USER_ID)
               AS TESTER_NM,
            STATE AS ITEM_STATE_CD,
            (SELECT   PRC_NM
               FROM   PROCESS PR
              WHERE   TSI.STATE = PR.PRC_CD)
               AS ITEM_STATE_NM
     FROM   TEST_SAMPLE_ITEM TSI;



/* Formatted on 2016-01-14 오전 10:46:57 (QP5 v5.115.810.9015) */
--
-- RDMS_VW_SAMPLE  (View)
--
--  Dependencies:
--   COMMON_CODE_DETAIL (Table)
--   DEPART (Table)
--   PROCESS (Table)
--   SAMPLE (Table)
--   TEST_REQ (Table)
--   TEST_SAMPLE (Table)
--   TEST_SAMPLE_ITEM (Table)
--   USER_INFO (Table)
--

CREATE OR REPLACE FORCE VIEW RDMS_VW_SAMPLE
(
   RDMS_TEST_SAMPLE_NM,
   TEST_SAMPLE_SEQ,
   TEST_REQ_NO,
   SAMPLE_REG_NM,
   SAMPLE_CD,
   SAMPLE_NM,
   TITLE,
   TEST_DEPT_CD,
   TEST_DEPT_NM,
   TESTER_ID,
   TESTER_NM,
   REQ_TYPE,
   SAMPLE_STATE_NM,
   REQ_STATE_NM,
   SAMPLE_STATE_CD,
   REQ_STATE_CD
)
AS
   SELECT      TS.TEST_SAMPLE_SEQ
            || ' : '
            || SAMPLE_REG_NM
            || ' : '
            || (SELECT   SAMPLE_NM
                  FROM   SAMPLE SP
                 WHERE   TS.SAMPLE_CD = SP.SAMPLE_CD)
               AS RDMS_TEST_SAMPLE_NM,
            TS.TEST_SAMPLE_SEQ,
            TS.TEST_REQ_NO,
            TS.SAMPLE_REG_NM,
            TS.SAMPLE_CD,
            (SELECT   SAMPLE_NM
               FROM   SAMPLE SP
              WHERE   TS.SAMPLE_CD = SP.SAMPLE_CD)
               AS SAMPLE_NM,
            TR.TITLE,
            TEST_DEPT_CD,
            (SELECT   DEPT_NM
               FROM   DEPART DP
              WHERE   TSI.TEST_DEPT_CD = DP.DEPT_CD)
               AS TEST_DEPT_NM,
            TESTER_ID,
            (SELECT   USER_NM
               FROM   USER_INFO UI
              WHERE   TSI.TESTER_ID = UI.USER_ID)
               AS TESTER_NM,
            (SELECT   CODE_NAME
               FROM   COMMON_CODE_DETAIL CCD
              WHERE   TR.REQ_TYPE = CCD.CODE)
               REQ_TYPE,
            (SELECT   PRC_NM
               FROM   PROCESS PR
              WHERE   TS.STATE = PR.PRC_CD)
               AS SAMPLE_STATE_NM,
            (SELECT   PRC_NM
               FROM   PROCESS PR
              WHERE   TR.STATE = PR.PRC_CD)
               AS REQ_STATE_NM,
            TS.STATE AS SAMPLE_STATE_CD,
            TR.STATE AS REQ_STATE_CD
     FROM   TEST_SAMPLE_ITEM TSI, TEST_SAMPLE TS, TEST_REQ TR
    WHERE       TSI.TEST_SAMPLE_SEQ = TS.TEST_SAMPLE_SEQ
            AND TS.TEST_REQ_NO = TR.TEST_REQ_NO
            AND TS.STATE IN ('B', 'C', 'D', 'E');



/* Formatted on 2016-01-14 오전 10:46:58 (QP5 v5.115.810.9015) */
--
-- STD_SPEC  (View)
--
--  Dependencies:
--   INDV_SPEC (Table)
--   CMMN_SPEC (Table)
--

CREATE OR REPLACE FORCE VIEW STD_SPEC
(
   PRDLST_CD,
   PRDLST_CD_NM,
   TEST_ITEM_CD,
   TEST_ITEM_NM,
   ATTRB_SEQ,
   PIAM_KOR_NM,
   UPDT_PRVNS,
   LAST_UPDT_DTM,
   VALD_BEGN_DT,
   VALD_END_DT,
   RESULT_TYPE,
   RESULT_TYPE_CD_NM,
   STD_VAL,
   SPEC_VAL_SUMUP,
   UNIT,
   UNIT_NM,
   VALID_POSITION,
   STD_LVAL,
   STD_HVAL,
   LVAL_TYPE,
   LVAL_TYPE_CD_NM,
   HVAL_TYPE,
   HVAL_TYPE_CD_NM,
   MCRRGNSM_2N,
   MCRRGNSM_2M,
   MCRRGNSM_2C,
   MCRRGNSM_3M,
   STD_FIT_VAL,
   STD_FIT_VAL_CD_NM,
   STD_UNFIT_VAL,
   STD_UNFIT_VAL_CD_NM,
   LOQ_HVAL,
   LOQ_LVAL,
   INJRY_YN,
   FNPRT_ITM_INCLS_YN,
   INDV_SPEC_SEQ,
   CMMN_SPEC_CD,
   NTR_PRSEC_ITM_YN,
   MONTRNG_TESTITM_YN,
   EMPHS_PRSEC_TESTITM_YN,
   RVLV_ELSE_TESTITM_YN,
   SPEC_GUBUN_CD,
   KFDA_YN,
   TEST_STD_NO,
   CREATER_ID,
   CREATE_DATE,
   DEPT_CD,
   REV_NO,
   FEE,
   FEE_GROUP_NO
)
AS
   SELECT                                                   -- 품목및 항목정보
         PRDLST_CD 품목분류코드,
            PRDLST_CD_NM 품목명,
            TESTITM_CD AS 시험항목코드,
            TESTITM_NM 시험항목명,
            ATTRB_SEQ 단서조항일련번호,
            PIAM_KOR_NM 단서조항명,
            UPDT_PRVNS 수정사유,
            LAST_UPDT_DTM 최종수정일시                     --,SORC        출처
                                      ,
            VALD_BEGN_DT 유효개시일,
            VALD_END_DT 유효종료일                                 -- 기준정보
                                  ,
            JDGMNT_FOM_CD 판정형식,
            A079_FNPRT_CD_NM 판정형식명,
            SPEC_VAL 기준규격,
            SPEC_VAL_SUMUP 기준규격요약,
            UNIT_CD 단위코드,
            UNIT_NM 단위명,
            VALD_MANLI 유효자리수,
            MIMM_VAL 최소값,
            MXMM_VAL 최대값,
            MIMM_VAL_DVS_CD 최소값구분코드,
            A080_FNPRT_CD_NM 최소값구분명,
            MXMM_VAL_DVS_CD 최대값구분코드,
            A081_FNPRT_CD_NM 최대값구분명,
            MCRRGNSM_2N 미생물2N,
            MCRRGNSM_2M 미생물2M,
            MCRRGNSM_2C 미생물2C,
            MCRRGNSM_3M 미생물3M,
            CHOIC_FIT 선택접합코드,
            A082_CF_FNPRT_CD_NM 선택적합값명,
            CHOIC_IMPROPT 선택부적합코드,
            A082_CI_FNPRT_CD_NM 선택부적합명,
            LOQ_HVAL 정량상한값,
            LOQ_LVAL 정량하한값                                    -- 부가정보
                               ,
            INJRY_YN 위해여부,
            FNPRT_ITM_INCLS_YN 세부항목포함여부,
            INDV_SPEC_SEQ 기준일련번호,
            '' 기준규격종류코드,
            NTR_PRSEC_ITM_YN 자품검사시험항목여부,
            MONTRNG_TESTITM_YN 감시시험항목여부,
            EMPHS_PRSEC_TESTITM_YN 중점검사시험항목여부,
            RVLV_ELSE_TESTITM_YN 공전외시험항목여부          -- 별도 추가 정보
                                                   ,
            'I' 기준규격구분코드,
            KFDA_YN 식약처여부,
            'I01' 기준일련번호,
            CREATER_ID 생성자,
            CREATE_DATE 생성일,
            DEPT_CD 부서코드,
            '001' 개정번호,
            FEE 수수료,
            FEE_GROUP_NO 수수료그룹번호
     FROM   INDV_SPEC
    WHERE       KFDA_YN = 'Y'
            AND VALD_BEGN_DT <= TO_CHAR (SYSDATE, 'YYYYMMDD')
            AND VALD_END_DT >= TO_CHAR (SYSDATE, 'YYYYMMDD')
   UNION
   SELECT                                                   -- 품목및 항목정보
         PRDLST_CD 품목분류코드,
            PRDLST_CD_NM 품목명,
            TESTITM_CD AS 시험항목코드,
            TESTITM_NM 시험항목명,
            ATTRB_SEQ 단서조항일련번호,
            PIAM_KOR_NM 단서조항명,
            UPDT_PRVNS 수정사유,
            LAST_UPDT_DTM 최종수정일시                     --,SORC        출처
                                      ,
            VALD_BEGN_DT 유효개시일,
            VALD_END_DT 유효종료일                                 -- 기준정보
                                  ,
            JDGMNT_FOM_CD 판정형식,
            A079_FNPRT_CD_NM 판정형식명,
            SPEC_VAL 기준규격,
            SPEC_VAL_SUMUP 기준규격요약,
            UNIT_CD 단위코드,
            UNIT_NM 단위명,
            VALD_MANLI 유효자리수,
            MIMM_VAL 최소값,
            MXMM_VAL 최대값,
            MIMM_VAL_DVS_CD 최소값구분코드,
            A080_FNPRT_CD_NM 최소값구분명,
            MXMM_VAL_DVS_CD 최대값구분코드,
            A081_FNPRT_CD_NM 최대값구분명,
            MCRRGNSM_2N 미생물2N,
            MCRRGNSM_2M 미생물2M,
            MCRRGNSM_2C 미생물2C,
            MCRRGNSM_3M 미생물3M,
            CHOIC_FIT 선택접합코드,
            A082_CF_FNPRT_CD_NM 선택적합값명,
            CHOIC_IMPROPT 선택부적합코드,
            A082_CI_FNPRT_CD_NM 선택부적합명,
            '' 정량상한값,
            '' 정량하한값                                          -- 부가정보
                         ,
            INJRY_YN 위해여부,
            FNPRT_ITM_INCLS_YN 세부항목포함여부,
            CMMN_SPEC_SEQ 기준일련번호,
            CMMN_SPEC_CD 기준규격종류코드,
            NTR_PRSEC_ITM_YN 자품검사시험항목여부,
            MONTRNG_TESTITM_YN 감시시험항목여부,
            EMPHS_PRSEC_TESTITM_YN 중점검사시험항목여부,
            RVLV_ELSE_TESTITM_YN 공전외시험항목여부          -- 별도 추가 정보
                                                   ,
            'C' 기준규격구분코드,
            'Y' 식약처여부,
            'I01' 기준일련번호,
            '' 생성자,
            '' 생성일,
            '' 부서코드,
            '001' 개정번호,
            FEE 수수료,
            '' 수수료그룹번호
     FROM   CMMN_SPEC
    WHERE       1 = 1
            AND VALD_BEGN_DT <= TO_CHAR (SYSDATE, 'YYYYMMDD')
            AND VALD_END_DT >= TO_CHAR (SYSDATE, 'YYYYMMDD');


