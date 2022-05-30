CREATE TABLE CONTRACT(
  CT_CODE VARCHAR2(20) PRIMARY KEY,
  CTM_CODE VARCHAR2(20) NOT NULL,
  DCODE_CLIENT VARCHAR2(20),
  DU_PRICE NUMBER NOT NULL,
  DU_DATE DATE NOT NULL,
  CT_START DATE NOT NULL,
  CT_END DATE NOT NULL,
  CONSTRAINT "CON_CTM_CODE_FK" FOREIGN KEY ("CTM_CODE") REFERENCES CONTRACT_MANAGEMENT("CTM_CODE"),
  CONSTRAINT "CON_DCODE_CLIENT_FK" FOREIGN KEY ("DCODE_CLIENT") REFERENCES CLIENT_DISCOUNT("DCODE_CLIENT")
);

 
SELECT * FROM CONTRACT;

DROP TABLE CONTRACT;


UPDATE CONTRACT SET DCODE_CLIENT=NULL
WHERE SYSDATE-TO_DATE(CT_START,'YYYY-MM-DD') > 5;

-- 5년이상 C03 0.05프로 할인율
UPDATE CONTRACT SET DCODE_CLIENT='C03'
WHERE TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') >= 1826;

-- 1년초과 5년미만 C01 0프로 할인율
UPDATE CONTRACT SET DCODE_CLIENT='C01'
WHERE TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') > 365  
AND TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') < 1826;

-- 1년이하 C02 0.03프로 할인율
UPDATE CONTRACT SET DCODE_CLIENT='C02'
WHERE TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') <= 365  
AND TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') > 0;

-- 계약 대기중 (0년이하) C01 0프로 할인율
UPDATE CONTRACT SET DCODE_CLIENT='C01'
WHERE TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') <= 0;

-- 거래처 기간별 할인율 적용 
SELECT c.CT_CODE, c.CTM_CODE,
CASE WHEN TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') >= 1826 
       THEN 'C03'
     WHEN TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') < 1826 
      AND TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') > 365
       THEN 'C01'
     WHEN TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') <= 365
      AND TO_DATE(SYSDATE,'YYYY-MM-DD')-TO_DATE(CT_START,'YYYY-MM-DD') > 0
       THEN 'C02'
            ELSE 'C01'
       END AS DCODE_CLIENT,
c.DU_PRICE, c.DU_DATE, c.CT_START, c.CT_END ,c.DU_PRICE-(c.DU_PRICE*cd.RATE) PRE_SUM,1 SUM_PRICE
FROM CONTRACT c JOIN CLIENT_DISCOUNT cd ON c.DCODE_CLIENT = cd.DCODE_CLIENT
ORDER BY CTM_CODE;

INSERT INTO CONTRACT
(CT_CODE, CTM_CODE, DCODE_CLIENT, DU_PRICE, DU_DATE, CT_START, CT_END)
VALUES('1001', 'CM1000', 'C01', 1111111, '2022-01-01', '2021-12-01', '2023-12-01');

UPDATE CONTRACT SET DU_PRICE =1111111 WHERE CT_CODE = '10001';

-- 납품원가 한달에 한번 스케쥴링을 통해 실행
UPDATE CONTRACT
SET DU_PRICE=(SELECT SUM(CONTRACT_GOODS.G_PRICE*CONTRACT_GOODS.DU_CNT) 
FROM CONTRACT_GOODS
WHERE CONTRACT.CT_CODE = CONTRACT_GOODS.CT_CODE);

SELECT * FROM CONTRACT c ;