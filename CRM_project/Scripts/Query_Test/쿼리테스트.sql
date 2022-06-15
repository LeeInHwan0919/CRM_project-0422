SELECT SEQ, EMP_CODE, TITLE, CONTENT, REGDATE, S_COUNT, POST_DATE, POST_USE
 	FROM BOARD 
 	WHERE POST_USE ='N';SELECT SEQ, EMP_CODE, TITLE, CONTENT, REGDATE, S_COUNT, POST_DATE, POST_USE
	FROM BOARD 
		WHERE SEQ='21';INSERT INTO BOARD
(SEQ, EMP_CODE, TITLE, CONTENT, REGDATE, S_COUNT, POST_DATE, POST_USE)
VALUES(BOARD_SEQ.NEXTVAL,'SYS_45282','5월 공지사항8', '회사가 가난합니다. 휴지를 아껴써주세요.8',
SYSDATE,0,TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'YYYY-MM-DD'),'Y');

UPDATE BOARD SET TITLE='4월 공지사항 수정', CONTENT='수정 회사가 가난합니다. 휴지를 아껴써주세요.' WHERE SEQ = '29' AND EMP_CODE='SYS_45282'; UPDATE BOARD SET POST_USE ='N' 
	WHERE TO_DATE(SYSDATE, 'YYYY-MM-DD') = TO_DATE(POST_DATE, 'YYYY-MM-DD');SELECT SEQ, EMP_CODE, TITLE, CONTENT, REGDATE, S_COUNT, POST_DATE, POST_USE
	FROM BOARD
		WHERE TITLE LIKE '%공지사항%';SELECT CLI_NUM, EMP_CODE, CLI_NAME, CLI_ADDR, CLI_TEL, CLI_AREA
 	FROM CLIENT ;
 
 SELECT c.CLI_NUM, c.EMP_CODE, c.CLI_NAME, c.CLI_ADDR, c.CLI_TEL,cd.RATE,cg.G_NAME,gd.RATE AS G_CODE,
 CASE WHEN SYSDATE > c2.CT_START AND SYSDATE <c2.CT_END THEN '진행중' 
 WHEN SYSDATE < c2.CT_START THEN '대기중'
 WHEN SYSDATE > c2.CT_END THEN '종료'
 END AS STATUS,TRUNC(TO_NUMBER(TO_CHAR(TO_DATE(CT_END,'yyyy-mm-dd')-TO_DATE(CT_START,'yyyy-mm-dd')))/365) CT_DATE_YEAR_SUM, c2.CT_START ,c2.CT_END
	FROM CLIENT c
		JOIN CONTRACT_MANAGEMENT cm 
		ON c.CLI_NUM = cm.CLI_NUM 
	    JOIN CONTRACT c2 
	    ON c2.CTM_CODE =cm.CTM_CODE 
		JOIN CLIENT_DISCOUNT cd 
		ON c2.DCODE_CLIENT = cd.DCODE_CLIENT 
		JOIN CONTRACT_GOODS cg 
		ON c2.CT_CODE = cg.CT_CODE 
		JOIN INVENTORY_GOODS ig 
		ON cg.G_CODE = ig.G_CODE 
		JOIN GOODS_DISCOUNT gd 
		ON ig.DCODE_GOODS = gd.DCODE_GOODS
		WHERE c.CLI_NUM='380-75-10619'
		ORDER BY gd.RATE DESC;
	
	UPDATE CLIENT SET CLI_USE ='N' 
	WHERE CLI_NUM='380-75-10619';

SELECT CLI_NUM, EMP_CODE, CLI_NAME, CLI_ADDR, CLI_TEL, CLI_AREA
	FROM CLIENT
		WHERE CLI_NAME LIKE '%소소한%';
	
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
   
   SELECT EMP_PW, EMP_AUTH
FROM USER_INFO;SELECT COUNT(*)
FROM USER_INFO
WHERE EMP_CODE='SYS_45282';

NSERT INTO USER_INFO
(EMP_CODE, AREA_CODE, EMP_NAME, EMP_PW, EMP_GENDER, EMP_USE, EMP_IMG,EMP_AUTH)
VALUES('CAD_33873', 'LC01', '이인환', 'inhwan1234', '남자', 'Y', EMPTY_BLOB(),'ADMIN');UPDATE USER_INFO
SET AREA_CODE='LC01', EMP_NAME='이인환', EMP_PW='inhwan1234', EMP_GENDER='남자', EMP_USE='Y', EMP_IMG=EMPTY_BLOB() 
WHERE EMP_CODE='CAD_33873';

DELETE FROM USER_INFO
WHERE EMP_CODE='CAD_33873';

SELECT EMP_CODE, l.AREA , EMP_NAME, EMP_GENDER, CASE WHEN EMP_USE='Y' THEN '계정활성화' ELSE '계정 비활성화' END AS EMP_USE, EMP_IMG
FROM USER_INFO
LEFT JOIN LOCATION l
USING (AREA_CODE)
WHERE EMP_AUTH!='SYSTEM';

--사원 정보수정
SELECT EMP_CODE,l.AREA , EMP_NAME, EMP_GENDER, CASE WHEN EMP_USE='Y' THEN '계정활성화' ELSE '계정 비활성화' END AS EMP_USE,
EMP_IMG,
CASE WHEN SUBSTR(EMP_AUTH,1,2)='CL' THEN '거래처관리'
WHEN SUBSTR(EMP_AUTH,1,2)='SY' THEN '시스템관리' ELSE '재고관리' END AS EMP_AUTH 
, EMP_TEL ,EMP_ADDR
FROM USER_INFO
LEFT JOIN LOCATION l
USING (AREA_CODE)
WHERE EMP_CODE='SYS_123456';

SELECT *  FROM USER_INFO ui ;

--꺽은선 차트 연도별 거래처계약건수
SELECT COUNT(cm.CLI_NUM)
FROM CONTRACT c 
JOIN CONTRACT_MANAGEMENT cm 
ON c.CTM_CODE = cm.CTM_CODE  
WHERE ADD_MONTHS(SYSDATE,0) > c.CT_START 
AND ADD_MONTHS(SYSDATE,0) < c.CT_END
GROUP BY TO_CHAR(c.CT_START,'YYYY')
ORDER BY TO_CHAR(c.CT_START,'YYYY');

-- 파이 차트 상품별 판매량 합계
SELECT SUM_DU
FROM
(SELECT G_NAME, SUM_DU, ROWNUM RM
FROM(
SELECT G_NAME, SUM(DU_CNT) SUM_DU
FROM CONTRACT_GOODS cg
JOIN CONTRACT c
ON cg.CT_CODE = c.CT_CODE
GROUP BY G_NAME
ORDER BY SUM(DU_CNT) desc)) 
WHERE RM =3
OR RM >=19;

--(공통) 가로 막대 차트 지역별 계약 건수

SELECT COUNT(*)
FROM USER_INFO ui 
JOIN LOCATION l 
ON ui.AREA_CODE = l.AREA_CODE 
JOIN CLIENT c 
ON c.EMP_CODE = ui.EMP_CODE
GROUP BY l.AREA
ORDER BY COUNT(*) DESC;

SELECT * FROM LOCATION l ;
SELECT * FROM user_info;

INSERT INTO CLIENT
(CLI_NUM, EMP_CODE, CLI_NAME, CLI_ADDR, CLI_TEL)
VALUES('999-99-99999', 'CAD_23156', '카페이름', '카페상세주소', '거래처 전화번호');
SELECT * FROM CLIENT;INSERT INTO CONTRACT_MANAGEMENT
(CTM_CODE, CLI_NUM, STATUS, CT_DATE_YEAR_SUM)
VALUES('CM'||TO_CHAR(2403+CONTRACT_MANAGEMENT_SEQ.NEXTVAL), '999-99-99999', NULL, 0);INSERT INTO CONTRACT
(CT_CODE, CTM_CODE, DCODE_CLIENT, DU_PRICE, DU_DATE, CT_START, CT_END)
VALUES(11438+CONTRACT_SEQ.NEXTVAL, 'CM'||TO_CHAR(2403+CONTRACT_MANAGEMENT_SEQ.CURRVAL), 'C01', 0, '2022-06-26', '2022-05-26', '2025-05-26');INSERT INTO ADMIN.CONTRACT_GOODS
(SEQ, CT_CODE, G_CODE, G_NAME, G_PRICE, DU_CNT)
VALUES(33074+CONTRACT_GOODS_SEQ.NEXTVAL, 11438+CONTRACT_SEQ.CURRVAL,
'D010', '케냐AA', 20000, 10);SELECT * FROM INVENTORY_MANAGEMENT im ORDER BY SEQ DESC;
INSERT INTO ADMIN.INVENTORY_MANAGEMENT
(SEQ, EMP_CODE, G_CODE, G_NAME, IN_DATE, IN_CNT)
VALUES(33074+INVENMANAGE_SEQ.NEXTVAL, 'IAD_13397', 'D010', '케냐AA', '2022-06-26', 10);

--0531 비밀번호 찾을때 사원코드와 해당 전화번호가 일치하는지에 대한 코드
SELECT EMP_TEL
FROM USER_INFO
WHERE EMP_CODE='SYS_123456';

--사진 올리기

UPDATE USER_INFO
SET EMP_IMG='string'
;

UPDATE USER_INFO
SET AREA_CODE='', EMP_NAME='', EMP_PW='', EMP_GENDER='', EMP_USE='', EMP_AUTH='', EMP_TEL='', EMP_ADDR='', EMP_IMG=''
WHERE EMP_CODE='';


SELECT c.CLI_NUM, 
c.EMP_CODE, 
c.CLI_NAME, 
c.CLI_ADDR, 
c.CLI_TEL,
cd.RATE,
cg.G_NAME,
gd.RATE AS G_CODE,
CASE WHEN SYSDATE  > c2.CT_START AND SYSDATE < c2.CT_END THEN '진행중'
WHEN SYSDATE < c2.CT_START THEN '대기중'
WHEN SYSDATE > c2.CT_END THEN '종료'
 END AS STATUS,TRUNC(TO_NUMBER(TO_CHAR(TO_DATE(CT_END,'yyyy-mm-dd')-TO_DATE(CT_START,'yyyy-mm-dd')))/365) CT_DATE_YEAR_SUM, c2.CT_START ,c2.CT_END
	FROM CLIENT c
		JOIN CONTRACT_MANAGEMENT cm 
		ON c.CLI_NUM = cm.CLI_NUM 
	    JOIN CONTRACT c2 
	    ON c2.CTM_CODE =cm.CTM_CODE 
		JOIN CLIENT_DISCOUNT cd 
		ON c2.DCODE_CLIENT = cd.DCODE_CLIENT 
		JOIN CONTRACT_GOODS cg 
		ON c2.CT_CODE = cg.CT_CODE 
		JOIN INVENTORY_GOODS ig 
		ON cg.G_CODE = ig.G_CODE 
		JOIN GOODS_DISCOUNT gd 
		ON ig.DCODE_GOODS = gd.DCODE_GOODS
		WHERE c.CLI_NUM='380-75-10619'
		ORDER BY gd.RATE DESC;
		
	
	
SELECT * FROM CLIENT c ;
SELECT * FROM CONTRACT c ;
SELECT *FROM CLIENT_DISCOUNT cd ;
SELECT * FROM GOODS_DISCOUNT gd ;
SELECT *FROM INVENTORY_GOODS ig ;
SELECT * FROM USER_INFO ui ;

--성별 전화번호 주소 계정여부 변경
UPDATE USER_INFO
SET EMP_GENDER='', EMP_USE='', EMP_IMG='', EMP_TEL='', EMP_ADDR=''
WHERE EMP_CODE='SYS_45282';

-- 사원코드에 해당하는 전화번호가 맞는지 확인
SELECT COUNT(*)
FROM USER_INFO ui
WHERE EMP_CODE='SYS_12345' AND EMP_TEL ='01033097483';

UPDATE USER_INFO
SET EMP_PW=
WHERE EMP_CODE='SYS_45282';
