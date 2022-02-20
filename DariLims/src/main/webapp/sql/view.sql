/* Formatted on 2016-01-14 ���� 10:46:56 (QP5 v5.115.810.9015) */
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



/* Formatted on 2016-01-14 ���� 10:46:57 (QP5 v5.115.810.9015) */
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



/* Formatted on 2016-01-14 ���� 10:46:58 (QP5 v5.115.810.9015) */
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
   SELECT                                                   -- ǰ��� �׸�����
         PRDLST_CD ǰ��з��ڵ�,
            PRDLST_CD_NM ǰ���,
            TESTITM_CD AS �����׸��ڵ�,
            TESTITM_NM �����׸��,
            ATTRB_SEQ �ܼ������Ϸù�ȣ,
            PIAM_KOR_NM �ܼ����׸�,
            UPDT_PRVNS ��������,
            LAST_UPDT_DTM ���������Ͻ�                     --,SORC        ��ó
                                      ,
            VALD_BEGN_DT ��ȿ������,
            VALD_END_DT ��ȿ������                                 -- ��������
                                  ,
            JDGMNT_FOM_CD ��������,
            A079_FNPRT_CD_NM �������ĸ�,
            SPEC_VAL ���ر԰�,
            SPEC_VAL_SUMUP ���ر԰ݿ��,
            UNIT_CD �����ڵ�,
            UNIT_NM ������,
            VALD_MANLI ��ȿ�ڸ���,
            MIMM_VAL �ּҰ�,
            MXMM_VAL �ִ밪,
            MIMM_VAL_DVS_CD �ּҰ������ڵ�,
            A080_FNPRT_CD_NM �ּҰ����и�,
            MXMM_VAL_DVS_CD �ִ밪�����ڵ�,
            A081_FNPRT_CD_NM �ִ밪���и�,
            MCRRGNSM_2N �̻���2N,
            MCRRGNSM_2M �̻���2M,
            MCRRGNSM_2C �̻���2C,
            MCRRGNSM_3M �̻���3M,
            CHOIC_FIT ���������ڵ�,
            A082_CF_FNPRT_CD_NM �������հ���,
            CHOIC_IMPROPT ���ú������ڵ�,
            A082_CI_FNPRT_CD_NM ���ú����ո�,
            LOQ_HVAL �������Ѱ�,
            LOQ_LVAL �������Ѱ�                                    -- �ΰ�����
                               ,
            INJRY_YN ���ؿ���,
            FNPRT_ITM_INCLS_YN �����׸����Կ���,
            INDV_SPEC_SEQ �����Ϸù�ȣ,
            '' ���ر԰������ڵ�,
            NTR_PRSEC_ITM_YN ��ǰ�˻�����׸񿩺�,
            MONTRNG_TESTITM_YN ���ý����׸񿩺�,
            EMPHS_PRSEC_TESTITM_YN �����˻�����׸񿩺�,
            RVLV_ELSE_TESTITM_YN �����ܽ����׸񿩺�          -- ���� �߰� ����
                                                   ,
            'I' ���ر԰ݱ����ڵ�,
            KFDA_YN �ľ�ó����,
            'I01' �����Ϸù�ȣ,
            CREATER_ID ������,
            CREATE_DATE ������,
            DEPT_CD �μ��ڵ�,
            '001' ������ȣ,
            FEE ������,
            FEE_GROUP_NO ������׷��ȣ
     FROM   INDV_SPEC
    WHERE       KFDA_YN = 'Y'
            AND VALD_BEGN_DT <= TO_CHAR (SYSDATE, 'YYYYMMDD')
            AND VALD_END_DT >= TO_CHAR (SYSDATE, 'YYYYMMDD')
   UNION
   SELECT                                                   -- ǰ��� �׸�����
         PRDLST_CD ǰ��з��ڵ�,
            PRDLST_CD_NM ǰ���,
            TESTITM_CD AS �����׸��ڵ�,
            TESTITM_NM �����׸��,
            ATTRB_SEQ �ܼ������Ϸù�ȣ,
            PIAM_KOR_NM �ܼ����׸�,
            UPDT_PRVNS ��������,
            LAST_UPDT_DTM ���������Ͻ�                     --,SORC        ��ó
                                      ,
            VALD_BEGN_DT ��ȿ������,
            VALD_END_DT ��ȿ������                                 -- ��������
                                  ,
            JDGMNT_FOM_CD ��������,
            A079_FNPRT_CD_NM �������ĸ�,
            SPEC_VAL ���ر԰�,
            SPEC_VAL_SUMUP ���ر԰ݿ��,
            UNIT_CD �����ڵ�,
            UNIT_NM ������,
            VALD_MANLI ��ȿ�ڸ���,
            MIMM_VAL �ּҰ�,
            MXMM_VAL �ִ밪,
            MIMM_VAL_DVS_CD �ּҰ������ڵ�,
            A080_FNPRT_CD_NM �ּҰ����и�,
            MXMM_VAL_DVS_CD �ִ밪�����ڵ�,
            A081_FNPRT_CD_NM �ִ밪���и�,
            MCRRGNSM_2N �̻���2N,
            MCRRGNSM_2M �̻���2M,
            MCRRGNSM_2C �̻���2C,
            MCRRGNSM_3M �̻���3M,
            CHOIC_FIT ���������ڵ�,
            A082_CF_FNPRT_CD_NM �������հ���,
            CHOIC_IMPROPT ���ú������ڵ�,
            A082_CI_FNPRT_CD_NM ���ú����ո�,
            '' �������Ѱ�,
            '' �������Ѱ�                                          -- �ΰ�����
                         ,
            INJRY_YN ���ؿ���,
            FNPRT_ITM_INCLS_YN �����׸����Կ���,
            CMMN_SPEC_SEQ �����Ϸù�ȣ,
            CMMN_SPEC_CD ���ر԰������ڵ�,
            NTR_PRSEC_ITM_YN ��ǰ�˻�����׸񿩺�,
            MONTRNG_TESTITM_YN ���ý����׸񿩺�,
            EMPHS_PRSEC_TESTITM_YN �����˻�����׸񿩺�,
            RVLV_ELSE_TESTITM_YN �����ܽ����׸񿩺�          -- ���� �߰� ����
                                                   ,
            'C' ���ر԰ݱ����ڵ�,
            'Y' �ľ�ó����,
            'I01' �����Ϸù�ȣ,
            '' ������,
            '' ������,
            '' �μ��ڵ�,
            '001' ������ȣ,
            FEE ������,
            '' ������׷��ȣ
     FROM   CMMN_SPEC
    WHERE       1 = 1
            AND VALD_BEGN_DT <= TO_CHAR (SYSDATE, 'YYYYMMDD')
            AND VALD_END_DT >= TO_CHAR (SYSDATE, 'YYYYMMDD');


