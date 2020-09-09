DROP PROCEDURE ADD_MTLR_INFO;

CREATE OR REPLACE PROCEDURE ADD_MTLR_INFO (   
    h_mtlr_info     IN  VARCHAR2,   
    m_mtlr_info     IN  VARCHAR2,   
    item_nm         IN  VARCHAR2,   
    spec1           IN  VARCHAR2,
    spec2           IN  VARCHAR2,
    spec_etc        IN  VARCHAR2,
    unit            IN  VARCHAR2,   
    etc             IN  VARCHAR2,   
    create_dept     IN  VARCHAR2,   
    user_id         IN  VARCHAR2,
    use             IN  VARCHAR2,   
    use_flag        IN  VARCHAR2,
    content         IN  VARCHAR2,
    max_mtlr_no     OUT  VARCHAR2    
)   
IS 
    MAX_M_NO VARCHAR2(6); 
           
BEGIN  
  
    INSERT INTO MTLR_INFO   
    (   
        MTLR_NO,
        H_MTLR_INFO,
        M_MTLR_INFO,
        item_nm,
        SPEC1,
        SPEC2,
        SPEC_ETC,
        UNIT,
        ETC,
        CREATE_DATE,
        CREATE_DEPT,
        CREATER_ID,
        USE,
        USE_FLAG,
        CONTENT,
        MASTER_YN   
    )   
    VALUES  
    (   
        (SELECT LPAD(NVL(MAX(MTLR_NO),0)+1,6,0) FROM MTLR_INFO), 
        h_mtlr_info, 
        m_mtlr_info, 
        item_nm, 
        spec1, 
        spec2,
        spec_etc,
        unit, 
        etc, 
        SYSDATE, 
        create_dept, 
        user_id, 
        use, 
        use_flag, 
        content,
        'N'  
    ); 
    
    COMMIT;
        
 select NVL(MAX(MTLR_NO),0) INTO MAX_M_NO --no얻어오기
  from MTLR_INFO; 
    
  max_mtlr_no :=  MAX_M_NO;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
          
END ADD_MTLR_INFO;
/



DROP PROCEDURE UPDATE_TEST_STATE;

CREATE OR REPLACE PROCEDURE UPDATE_TEST_STATE(
    P_TEST_SAMPLE_SEQ IN VARCHAR2,
    P_TEST_ITEM_SEQ   IN VARCHAR2,
    P_STATE           IN VARCHAR2)
IS
  V_SAMPLE_STATE VARCHAR2(1);
  V_COUNT        NUMBER;
  V_JDG_TYPE     VARCHAR2(6);
BEGIN
  -- 항목 프로세스 변경
  UPDATE TEST_SAMPLE_ITEM
  SET STATE             = P_STATE
  WHERE TEST_SAMPLE_SEQ = P_TEST_SAMPLE_SEQ
  AND TEST_ITEM_SEQ     =P_TEST_ITEM_SEQ;
  -- 시료내 항목의 상태값 조회
  SELECT MIN(STATE)
  INTO V_SAMPLE_STATE
  FROM TEST_SAMPLE_ITEM
  WHERE TEST_SAMPLE_SEQ = P_TEST_SAMPLE_SEQ ;
  -- 항목의 상태값이 같으면 시료 상태값 수정
  IF P_STATE = V_SAMPLE_STATE THEN
    UPDATE TEST_SAMPLE
    SET STATE             = P_STATE
    WHERE TEST_SAMPLE_SEQ = P_TEST_SAMPLE_SEQ;
    
  END IF;
  SELECT MIN(STATE)
  INTO V_SAMPLE_STATE
  FROM TEST_SAMPLE
  WHERE TEST_REQ_NO = SUBSTR(P_TEST_SAMPLE_SEQ, 1, 7);
  -- 시료의 상태값이 같으면 의뢰 상태값 수정
  IF P_STATE   = V_SAMPLE_STATE THEN
    IF P_STATE = 'Q' THEN --주관승인
      UPDATE TEST_REQ
      SET STATE         = P_STATE ,
        DEPT_APPR_DATE  = TO_CHAR(SYSDATE, 'YYYYmmdd')
      WHERE TEST_REQ_NO = SUBSTR(P_TEST_SAMPLE_SEQ, 1, 7);
    ELSE
      UPDATE TEST_REQ
      SET STATE         = P_STATE
      WHERE TEST_REQ_NO = SUBSTR(P_TEST_SAMPLE_SEQ, 1, 7);
    END IF;
  END IF;
END UPDATE_TEST_STATE;
/


