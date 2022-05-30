CREATE TABLE CONTRACT_MANAGEMENT(
  CTM_CODE VARCHAR2(20) PRIMARY KEY,
  CLI_NUM VARCHAR2(100),
  STATUS VARCHAR2(10),
  CT_DATE_YEAR_SUM NUMBER,
  CONSTRAINT "CLI_NUM_FK" FOREIGN KEY ("CLI_NUM") REFERENCES CLIENT("CLI_NUM")
);
 

SELECT * FROM CONTRACT_MANAGEMENT;

DROP TABLE CONTRACT_MANAGEMENT;

--거래처 상태별 조회
SELECT c.CTM_CODE, cm.CLI_NUM,
CASE WHEN TO_DATE(CT_START,'YYYY-MM-DD') > TO_DATE(SYSDATE,'YYYY-MM-DD')
       THEN '대기'
     WHEN TO_DATE(CT_END,'YYYY-MM-DD') < TO_DATE(SYSDATE,'YYYY-MM-DD')
       THEN '종료'
            ELSE '진행'
       END AS STATUS,
TRUNC(TO_NUMBER(TO_CHAR(TO_DATE(CT_END,'yyyy-mm-dd')-TO_DATE(CT_START,'yyyy-mm-dd')))/365) CT_DATE_YEAR_SUM
  FROM CONTRACT c 
    JOIN CONTRACT_MANAGEMENT cm 
    ON c.CTM_CODE = cm.CTM_CODE;
