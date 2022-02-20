DROP FUNCTION GET_STATE_NM;

CREATE OR REPLACE FUNCTION  GET_STATE_NM(V_STATE_CD VARCHAR2, V_FLAG VARCHAR2, SIMPLE_FLAG VARCHAR2) RETURN VARCHAR2 IS
VN_STATE_NM VARCHAR2(40);
/******************************************************************************
   NAME:       GET_STATE_NM
   진행상태명 조회
******************************************************************************/
BEGIN
IF SIMPLE_FLAG = 'N' THEN
        IF V_STATE_CD = 'A' THEN VN_STATE_NM := '의뢰' ;
        ELSIF  V_STATE_CD = 'B' THEN VN_STATE_NM := '접수'  ;
        ELSIF  V_STATE_CD = 'C' THEN VN_STATE_NM := '결과입력'  ;
        ELSIF  V_STATE_CD = 'D' THEN VN_STATE_NM := '시험부서결과확인' ; 
        ELSIF  V_STATE_CD = 'E' THEN VN_STATE_NM := '시험부서결과승인대기'  ;
        ELSIF  V_STATE_CD = 'F' THEN VN_STATE_NM := '시험부서승인완료' ;
        ELSIF  V_STATE_CD = 'Q' THEN VN_STATE_NM := '결과승인완료' ;
        ELSIF  V_STATE_CD = 'Z' THEN VN_STATE_NM := '재접수' ;
        ELSIF  V_STATE_CD = 'X' THEN VN_STATE_NM := '업무관리시스템연계' ;
        ELSIF  V_STATE_CD = 'T' THEN VN_STATE_NM := '업무관리시스템전송완료' ;
        ELSIF  V_STATE_CD = 'U' THEN VN_STATE_NM := '업무관리시스템승인중' ;
        ELSIF  V_STATE_CD = 'V' THEN VN_STATE_NM := '업무관리시스템승인완료' ;
        ELSIF  V_STATE_CD = 'R' THEN VN_STATE_NM := '업무관리시스템반려' ;
        ELSIF  V_STATE_CD = 'G' THEN VN_STATE_NM := '승인자승인완료' ;
        ELSIF  V_STATE_CD = 'H' THEN VN_STATE_NM := '반려' ;
        ELSIF  V_STATE_CD = 'I' THEN VN_STATE_NM := '시험부서승인회수' ;
        ELSIF  V_STATE_CD = 'J' THEN VN_STATE_NM := '주관부서승인회수' ;
        ELSIF  V_STATE_CD = 'K' THEN VN_STATE_NM := '대리자승인완료' ;
        END IF;
ELSE
        IF V_STATE_CD = 'A' THEN VN_STATE_NM := '민원접수' ;
        ELSIF  V_STATE_CD = 'B' THEN VN_STATE_NM := '접수'  ;
        ELSIF  V_STATE_CD = 'C' THEN VN_STATE_NM := '결과입력'  ;
        ELSIF  V_STATE_CD = 'D' THEN VN_STATE_NM := '시험부서결과확인' ; 
        ELSIF  V_STATE_CD = 'E' THEN VN_STATE_NM := '시험부서결과승인대기'  ;
        ELSIF  V_STATE_CD = 'F' THEN VN_STATE_NM := '시험부서승인완료' ;
        ELSIF  V_STATE_CD = 'O' THEN VN_STATE_NM := '주관부서결과확인' ;
        ELSIF  V_STATE_CD = 'P' THEN VN_STATE_NM := '주관부서결과승인대기' ;
        ELSIF  V_STATE_CD = 'Q' THEN VN_STATE_NM := '주관부서결과승인완료' ;
        ELSIF  V_STATE_CD = 'Z' THEN VN_STATE_NM := '재접수' ;
        ELSIF  V_STATE_CD = 'X' THEN VN_STATE_NM := '업무관리시스템연계' ;
        ELSIF  V_STATE_CD = 'T' THEN VN_STATE_NM := '업무관리시스템전송완료' ;
        ELSIF  V_STATE_CD = 'U' THEN VN_STATE_NM := '업무관리시스템승인중' ;
        ELSIF  V_STATE_CD = 'V' THEN VN_STATE_NM := '업무관리시스템승인완료' ;
        ELSIF  V_STATE_CD = 'R' THEN VN_STATE_NM := '업무관리시스템반려' ;
        ELSIF  V_STATE_CD = 'G' THEN VN_STATE_NM := '승인자승인완료' ;
        ELSIF  V_STATE_CD = 'H' THEN VN_STATE_NM := '반려' ;
        ELSIF  V_STATE_CD = 'I' THEN VN_STATE_NM := '시험부서승인회수' ;
        ELSIF  V_STATE_CD = 'J' THEN VN_STATE_NM := '주관부서승인회수' ;
        ELSIF  V_STATE_CD = 'K' THEN VN_STATE_NM := '대리자승인완료' ;
        END IF;
END IF;        
    RETURN VN_STATE_NM;
END GET_STATE_NM
;
/



DROP FUNCTION GET_USER_NM;

CREATE OR REPLACE FUNCTION      GET_USER_NM(V_USER_ID VARCHAR2) RETURN VARCHAR2 IS
VN_USER_NM VARCHAR2(30);
/******************************************************************************
   NAME:       GET_USER_NM
   사용자 ID로 사용자명을 가저온다.
******************************************************************************/
BEGIN
    
   SELECT 
   USER_NM INTO VN_USER_NM
   FROM USER_INFO
   WHERE USER_ID = V_USER_ID;

   RETURN VN_USER_NM;
   
END GET_USER_NM;
/



DROP FUNCTION GET_COMMON_CODE;

CREATE OR REPLACE FUNCTION      GET_COMMON_CODE(V_CODE VARCHAR2) RETURN VARCHAR2 IS
        VN_CODE_NM VARCHAR2(100);
        /******************************************************************************
           NAME:       GET_COMMON_CODE
           공통코드명을 리턴한다.
        ******************************************************************************/
        BEGIN
            
           SELECT 
           CODE_NAME INTO VN_CODE_NM
           FROM COMMON_CODE_DETAIL
           WHERE CODE = V_CODE;

           RETURN VN_CODE_NM;
           
        END GET_COMMON_CODE;
/



DROP FUNCTION GET_DEPT_NM;

CREATE OR REPLACE FUNCTION GET_DEPT_NM(
    V_DEPT_CD VARCHAR2)
  RETURN VARCHAR2
IS
  VN_DEPT_NM VARCHAR2(60);
  /******************************************************************************
  NAME:       GET_DEPT_NM
  부서코드로 부서명을 가저온다.
  ******************************************************************************/
BEGIN
  SELECT DEPT_NM INTO VN_DEPT_NM FROM DEPART WHERE DEPT_CD = V_DEPT_CD;
  RETURN VN_DEPT_NM;
END GET_DEPT_NM;
/





DROP FUNCTION GET_PRDLST_CD;

CREATE OR REPLACE FUNCTION      GET_PRDLST_CD
  RETURN VARCHAR2
IS
    v_tmp VARCHAR(14);

  /******************************************************************************
  NAME:       GET_PRDLST_CD
  자가품목코드를 생성하여 리턴
    
  ******************************************************************************/
     BEGIN
        
     
        SELECT 
            'PL000000' || LPAD(SUBSTR(MAX(PRDLST_CD),9,14) +1 ,6, 0) INTO v_tmp
        FROM PRDLST_CL
        WHERE KFDA_YN = 'N'
        AND LV = 'X'; 
             

        RETURN(v_tmp);


  END;
/



DROP FUNCTION GET_RESULT_NUMBER;

CREATE OR REPLACE FUNCTION GET_RESULT_NUMBER(
    P_TEST_SAMPLE_SEQ VARCHAR2,
    P_TEST_ITEM_SEQ   VARCHAR2 )
  RETURN NUMBER
IS
  V_RESULT NUMBER;
BEGIN
  SELECT TO_NUMBER(RESULT_CD)
  INTO V_RESULT
  FROM TEST_SAMPLE_ITEM
  WHERE TEST_SAMPLE_SEQ = P_TEST_SAMPLE_SEQ
  AND TEST_ITEM_SEQ     = P_TEST_ITEM_SEQ;
  RETURN V_RESULT;
EXCEPTION
WHEN OTHERS THEN
  V_RESULT:=0;
  RETURN V_RESULT;
END GET_RESULT_NUMBER;
/



DROP FUNCTION GET_REQ_ORG_NM;

CREATE OR REPLACE FUNCTION      GET_REQ_ORG_NM(V_CODE VARCHAR2) RETURN VARCHAR2 IS
        VN_ORG_NM VARCHAR2(100);
        /******************************************************************************
           NAME:       GET_REQ_ORG_NM
           업체명명을 리턴한다.
        ******************************************************************************/
        BEGIN
            
           SELECT 
           ORG_NM INTO VN_ORG_NM
           FROM REQ_ORG
           WHERE REQ_ORG_NO = V_CODE;

           RETURN VN_ORG_NM;
           
        END GET_REQ_ORG_NM;
/



DROP FUNCTION GET_PRDLST_GUBUN_CD;

CREATE OR REPLACE FUNCTION      GET_PRDLST_GUBUN_CD
  RETURN VARCHAR2
IS
    v_tmp VARCHAR(14);
    v_tmpCode VARCHAR(1);
    v_tmpNum NUMBER(3);

  /******************************************************************************
  NAME:       GET_PRDLST_GUBUN
  품목분류코드를 생성하여 리턴
  V_GUBUN_CD : 대분류, 중분류 구분  
  ******************************************************************************/
     BEGIN
        
         

         SELECT 
             NVL(SUBSTR(MAX(PRDLST_CD),3,2),'A0') INTO v_tmp
         FROM PRDLST_CL
         WHERE KFDA_YN = 'N'
         AND LV = 'X'; 

               
         v_tmpCode := SUBSTR(v_tmp,1,1);
         v_tmpNum := SUBSTR(v_tmp,2,1);
         
         IF v_tmpNum = 9 THEN
                v_tmp := CHR(ASCII(v_tmpCode) + 1) || 1;
         ELSE
            v_tmp := v_tmpCode || TO_CHAR(v_tmpNum + 1);
            
         END IF;
         
         v_tmp := RPAD('PL' || v_tmp,14,0);
         --DBMS_OUTPUT.PUT_LINE(v_tmp);

        RETURN(v_tmp);


  END;
/



DROP FUNCTION SF_SMP_CNT;

CREATE OR REPLACE FUNCTION SF_SMP_CNT(P_TEST_REQ_NO IN VARCHAR2) RETURN NUMBER IS
  O_COUNT NUMBER;
BEGIN
  /*==================================================
  시료 카운트 
  ===================================================*/
      
   SELECT COUNT(*)  INTO O_COUNT
      FROM TEST_SAMPLE
   WHERE TEST_REQ_NO = P_TEST_REQ_NO;  
      
  RETURN(O_COUNT);
END SF_SMP_CNT;
/



DROP FUNCTION SF_UNFIT_ITEM;

CREATE OR REPLACE FUNCTION SF_UNFIT_ITEM(P_TEST_SAMPLE_SEQ IN VARCHAR2) RETURN VARCHAR2 IS
  O_TESTITM         VARCHAR2(100);
  O_TESTITM_LIST VARCHAR2(1000);
  I                          NUMBER;
  
  CURSOR C1 IS
  
  SELECT C.TEST_ITEM_NM
        FROM TEST_SAMPLE_ITEM B, TEST_ITEM C
      WHERE B.TEST_ITEM_CD = C. TEST_ITEM_CD
           AND B.JDG_TYPE  IS NOT NULL
           --AND B.JDG_TYPE <> 'C37001'
           AND B.JDG_TYPE = 'C37002'
           AND B.TEST_SAMPLE_SEQ = P_TEST_SAMPLE_SEQ
           ORDER BY C.TEST_ITEM_CD;      
     
BEGIN
  /*==================================================
   적합이 아닌 항목들 리턴
  ===================================================*/
  OPEN C1;
  
  I := 0;
  
  LOOP
  
  FETCH C1 INTO O_TESTITM;
  EXIT WHEN C1%NOTFOUND;
  
  IF I = 0 THEN
    O_TESTITM_LIST := O_TESTITM;
  ELSE
    O_TESTITM_LIST := O_TESTITM_LIST||', '||O_TESTITM;
  END IF;
  
  I := I + 1;
  
  END LOOP;
  
  CLOSE C1;
  
  RETURN(O_TESTITM_LIST);
  
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN('');
END SF_UNFIT_ITEM;
/



DROP FUNCTION SF_ITEM_LST;

CREATE OR REPLACE FUNCTION           SF_ITEM_LST(

P_TEST_SAMPLE_SEQ IN VARCHAR2

) RETURN VARCHAR2 IS

    V_ITEM_COUNT NUMBER(3);
    V_TEST_ITEM_NAME VARCHAR2(100);
    V_TOT_STR VARCHAR2(200);
  
  
BEGIN
  /*==================================================
  첫번째 항목명과 항목 카운트 리턴
  ===================================================*/
      
    SELECT B.TEST_ITEM_NM INTO V_TEST_ITEM_NAME
       FROM TEST_SAMPLE_ITEM A, TEST_ITEM B
     WHERE A.TEST_ITEM_CD = B.TEST_ITEM_CD
          AND A.TEST_SAMPLE_SEQ = P_TEST_SAMPLE_SEQ
          AND A.DISP_ORDER = '0';
          
          
    SELECT COUNT(*) INTO V_ITEM_COUNT
       FROM TEST_SAMPLE_ITEM 
 WHERE TEST_SAMPLE_SEQ = P_TEST_SAMPLE_SEQ;
    
        V_TOT_STR := V_TEST_ITEM_NAME|| ' 등 ' || V_ITEM_COUNT  ||'항목';


  RETURN(V_TOT_STR);
END SF_ITEM_LST;
/



DROP FUNCTION SF_ITEM_METHOD;

CREATE OR REPLACE FUNCTION      SF_ITEM_METHOD(P_TEST_SAMPLE_SEQ IN VARCHAR2)

 RETURN VARCHAR2 IS
  O_ITEM_COUNT   NUMBER(3);
  O_TESTITM         VARCHAR2(100);
  O_TESTITM_LIST VARCHAR2(500);
  I                          NUMBER;
  
         
BEGIN
  /*==================================================
    항목의 시험방법 목록 및 카운트 반환
  ===================================================*/
  
   SELECT MIN(C.TEST_METHOD_NM) INTO O_TESTITM
       FROM TEST_SAMPLE_ITEM B, TEST_METHOD C
     WHERE B.TEST_METHOD = C.TEST_METHOD_NO(+)       
          AND B.TEST_METHOD IS NOT NULL
          AND B.TEST_SAMPLE_SEQ = P_TEST_SAMPLE_SEQ ;
  

 SELECT COUNT(*) INTO O_ITEM_COUNT
       FROM TEST_SAMPLE_ITEM B, TEST_METHOD C
     WHERE B.TEST_METHOD = C.TEST_METHOD_NO(+)       
          AND B.TEST_METHOD IS NOT NULL
          AND B.TEST_SAMPLE_SEQ = P_TEST_SAMPLE_SEQ ;
  
 
    O_TESTITM_LIST := O_TESTITM||' 등 '||O_ITEM_COUNT ||'종';
  

  
  RETURN(O_TESTITM_LIST);
  
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN('');
END SF_ITEM_METHOD;
/



DROP FUNCTION SF_ITEM_CNT;

CREATE OR REPLACE FUNCTION SF_ITEM_CNT(P_TEST_SAMPLE_SEQ IN VARCHAR2) RETURN NUMBER IS
  O_COUNT NUMBER;
BEGIN
  /*==================================================
  항목 카운트 
  ===================================================*/
      
   SELECT COUNT(*)  INTO O_COUNT
      FROM TEST_SAMPLE_ITEM
   WHERE TEST_SAMPLE_SEQ = P_TEST_SAMPLE_SEQ;  
      
  RETURN(O_COUNT);
END SF_ITEM_CNT;
/


