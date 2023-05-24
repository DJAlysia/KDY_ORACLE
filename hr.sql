-- 데이터 조회 명령어 - SELECT
-- SELECT 컬럼명, ...
-- FROM 테이블명
-- WHERE 조건;

-- 커서 실행 단축키 : ctrl + enter
-- 전체 실행 단축키 : F5

-- 01
conn system/123456

-- 02
SELECT USER_ID, USERNAME
FROM ALL_USERS
WHERE USERNAME = 'HR'
;

-- HR 계정 생성하기
-- 11g 버전 이하는 어떤 이름으로도 계정 생성 가능
-- 12c 버전 이상에서는 'c##' 접두어를 붙여서 생성하도록 규칙을 정함

-- c## 없이 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- CREATE USER HR IDENTIFIED BY 123456;
CREATE USER HR IDENTIFIED BY 123456;
-- 테이블 스페이스 변경
ALTER USER HR DEFAULT TABLESPACE users;
-- 계정이 사용할 수 있는 용량 설정(무한대)
ALTER USER HR QUOTA UNLIMITED ON users;
-- 계정 권한부여
GRANT connect, resource TO HR;

-- 계정 삭제
DROP USER HR CASCADE;

-- HR 계정이 잠겨 있는 경우,
-- HR 계정 잠금 해제
ALTER USER HR ACCOUNT UNLOCK;

--hr_main.sql - HR 샘플 데이터 가져오기
-- 1. SQL PLUS
-- 2. HR 계정으로 접속
-- 3. 명령어 입력 : @[경로]\hr_main.sql
--    @? : 오라클 설치 기본경로
--    @?/demo/schema/human_resources/hr_main.sql
--> 1 : 123465 [비밀번호]
--> 2 : users [tablespace]
--> 3 : temp [temp tablespace]
--> 4 : [log]경로 - @?/demo/schema/log




-- 3.
-- 테이블 EMPLOYEES 의 테이블 구조를 조회하는 SQL 문을 작성하시오.
-- 테이블 : 행과 열로 데이터를 관리하는 기본 구조
-- 행 = row = 레코드    : 각 속성에 대한 하나의 데이터를 의미
-- 열 = column = 속성   : 데이터의 이름(특성)을 정의
DESC employees;

-- 3.
-- 테이블 EMPLOYEES 에서 EMPLOYEE_ID, FIRST_NAME (회원번호, 이름) 를
-- 조회하는 SQL 문을 작성하시오.
SELECT employee_id, first_name
FROM employees;

-- 4. 
-- 테이블 EMPLOYEES 이 <예시>와 같이 출력되도록 조회하는 SQL 문을 작성하시오.
SELECT *        -- (*) [에스터리크] : 모든 컬럼 지정
FROM employees;

-- AS (alias) : 출력되는 컬럼명에 별명을 짓는 명령어
SELECT employee_id AS "사원 번호"   -- 띄어쓰기가 있으면, " " 로 표기
       ,first_name AS 이름
       ,last_name AS 성
       ,email AS 이메일
       ,phone_number AS 전화번호
       ,hire_date AS 입사일자
       ,salary AS 급여
FROM employees;


-- 5.
-- 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고
-- 조회하는 SQL 문을 작성하시오.
SELECT DISTINCT job_id
FROM employees;


-- 6.
-- 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary > 6000;

-- 7.
-- 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을 
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary = 10000;



-- 8.
-- 테이블 EMPLOYEES 의 모든 속성들을 SALARY 를 기준으로 내림차순 정렬하고,
-- FIRST_NAME을 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성하시오.

-- 정렬 명령어
-- ORDER BY 컬럼명 [ASC/DESC];
-- * ASC        : 오름차순
-- * DESC       : 내림차순
-- * (생략)      : 오름차순이 기본값
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC;


-- 9.
-- 테이블 EMPLOYEES 의 JOB_ID 가 'FI_ACCOUNT'이거나 'IT_PROG'인 사원의
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 조건 연산
-- OR 연산 : ~또는, ~이거나
-- WHERE A OR B;
SELECT *
FROM employees
WHERE JOB_ID = 'FI_ACCOUNT' 
   OR JOB_ID = 'IT_PROG'
;

-- 10.
-- 테이블 EMPLOYEES 의 JOB_ID가 'FI_ACCOUNT' 이거나 'IT_PROG'인 사원의 모든 컬럼을 
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE JOB_ID IN ('FI_ACCOUNT', 'IT_PROG')
;


-- 11.
-- 테이블 EMPLOYEES 의 JOB_ID가 'FI_ACCOUNT' 이거나 'IT_PROG' 아닌 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE JOB_ID NOT IN ('FI_ACCOUNT', 'IT_PROG')
;


-- 12.
-- 테이블 EMPLOYEES 의 JOB_ID가 'IT_PROG' 이면서 SALARY 가 6000 이상인 사원의 
-- 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE JOB_ID = 'IT_PROG'
  AND SALARY >= 6000
;
  
-- 13.
-- 테이블 EMPLOYEES의 FIRST_NAME 이 'S'로 시작하는 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE FIRST_NAME LIKE 'S%'
;

-- 14.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 's'로 끝나는 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE FIRST_NAME LIKE '%s'
;

-- 15.
-- 테이블 EMPLOYEES 의 FIST_NAME 에 's'가 포함되는 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE FIRST_NAME LIKE '%S%'
;

-- 16.
-- 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인 사원의 모든 컬럼을 
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE FIRST_NAME LIKE '_____'
;

-- LENGTH(컬럼명) : 글자 수를 반환하는 함수
SELECT *
FROM employees
WHERE LENGTH (FIRST_NAME) = 5
;

-- 17.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT 가 NULL 인 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE COMMISSION_PCT IS NULL
;

-- 18.
-- 테이블 EMPLOYEES 의 COMMISSION_PCT 가 NULL 이 아닌 사원의 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE COMMISSION_PCT IS NOT NULL
;

-- 19.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인 모든 컬럼을 
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE EXTRACT (YEAR FROM HIRE_DATE) >= '2004'
;

SELECT *
FROM employees
WHERE HIRE_DATE >= '04/01/01'
;

-- 20.
-- 테이블 EMPLOYEES 의 사원의 HIRE_DATE 가 04년도부터 05년도인 모든 컬럼을
-- 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE EXTRACT (YEAR FROM HIRE_DATE) <= '2005'
  AND EXTRACT (YEAR FROM HIRE_DATE) >= '2004'
;
        
SELECT *
FROM employees
WHERE HIRE_DATE <= '05/12/31'
  AND HIRE_DATE >= '04/01/01'
;

-- 컬럼 BETWEEN A AND B;
-- : A 보다 크거나 같고 B 보다 작거나 같은 조건 (사이)
SELECT *
FROM employees
WHERE HIRE_DATE BETWEEN '04/01/01' AND '05/12/31'
;

-- (추가 문제)
-- first_name 이 A~D로 시작하는 사원을 조회
SELECT *
FROM employees
WHERE first_name BETWEEN 'A' AND 'D'      -- (A~CZZ 사이의 이름을 갖는 사람)
;

-- first_name 이 Al~Am로 시작하는 사원을 조회
SELECT *
FROM employees
WHERE first_name BETWEEN 'Al' AND 'Am'      -- (Al로 시작하는 이름을 갖는 사람)
;


-- 21.
-- 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를 계산하는 SQL 문을 작성하시오.
-- * dual ?
-- : 산술 연산, 함수 결과 등을 확인해볼 수 있는 임시 테이블
-- CEIL() "천정"
-- : 지정한 값보다 크거나 같은 정수 중 제일 작은 수를 반환하는 함수
SELECT CEIL(12.45) FROM dual;
SELECT CEIL(-12.45) FROM dual;
SELECT CEIL(12.45), CEIL(-12.45) FROM dual;


-- 22.
-- 12.55와 -12.55보다 작거나 같은 정수 중 가장 큰 수를 계산하는 SQL 문을 각각 작성하시오.

SELECT FLOOR(12.55) FROM dual;
SELECT FLOOR(-12.55) FROM dual;
SELECT FLOOR(12.55), FLOOR(-12.55) FROM dual;

-- 23.
-- ROUND(값, 자리수)
-- : 지정한 값을, 해당 자리수에서 반올림하는 함수
-- a a a a a.bbbb
-- ... -2-1.0123
-- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오
SELECT ROUND(0.54, 0) FROM dual;

-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오
SELECT ROUND(0.54, 1) FROM dual;

-- 124.67을 일의 자리에서 반올림하시오.
SELECT ROUND(125.67, -1) FROM dual;

-- 124.67을 십의 자리에서 반올림하시오.
SELECT ROUND(125.67, -2) FROM dual;

-- 24.
-- 각 소문제에 제시된 두 수를 이용하여 나머지를 구하는 SQL문을 작성하시오.
-- MOD( A, B )
-- : A를 B로 나눈 나머지를 구하는 함수

-- 3을 8로 나눈 나머지를 구하시오.
SELECT MOD(3, 8) FROM dual;

-- 30을 4로 나눈 나머지를 구하시오. 
SELECT MOD(30, 4) FROM dual;


-- 25. 제곱수 구하기
-- POWER( A, B )
-- : A의 B 제곱을 구하는 함수
-- 2의 10 제곱을 구하시오.
SELECT POWER(2,10) FROM dual;

-- 2의 31 제곱을 구하시오.
SELECT POWER(2,31) FROM dual;


-- 26. 제곱근 구하기
-- SQRT( A )
-- : A의 제곱근을 구하는 함수
--   A는 양의 정수와 실수만 사용 가능
--   2의 제곱근을 구하시오.
SELECT SQRT(2) FROM dual;

-- 100의 제곱근을 구하시오.
SELECT SQRT(100) FROM dual;

-- 27.
-- TRUNC(실수, 자리수)
-- : 해당 수를 절삭하는 함수

-- 각 소문제에 제시된 수와 자리 수를 이용하여 해당 수를 절삭하는 SQL 문을 작성하시오.
-- 12.34 소수점 아래 첫째 자리에서 절삭
SELECT TRUNC(12.34, 0) FROM dual;

-- 12.34 소수점 아래 둘째 자리에서 절삭
SELECT TRUNC(12.34, 1) FROM dual;

-- 527425.1234 을 소수점 아래 첫째 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, 0) FROM dual;

-- 527425.1234 을 소수점 아래 둘째 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, 1) FROM dual;

-- 527425.1234 을 일의 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, -1) FROM dual;

-- 527425.1234 을 십의 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, -2) FROM dual;


-- 28.
-- 절댓값 구하기
-- ABS( A )
-- : 값 A의 절댓값을 구하여 변환하는 함수

-- -20 의 절댓값 구하기
SELECT ABS(-20) FROM dual;

-- -12.456 의 절댓값 구하기
SELECT ABS(-12.456) FROM dual;


-- 날짜 변환
SELECT first_name
       ,TO_CHAR(hire_date, 'YYYY.MM.DD')
       ,TO_CHAR(hire_date, 'YYYY"년"MM"월"DD"일"')
FROM employees;

--29.
-- <예시>와 같이 문자열을 대문자, 소문자, 첫글자만 대문자로
-- 변환하는 SQL 문을 작성하시오.
SELECT 'AlOhA WoRlD~!' AS 원문
        , UPPER('AlOhA WoRlD~!') AS 대문자
        , LOWER('AlOhA WoRlD~!') AS 소문자
        , INITCAP('AlOhA WoRlD~!') AS "첫글자만 대문자"
FROM dual;

--30.
-- <예시>와 같이 문자열의 글자 수와 바이트 수를
-- 출력하는 SQL문을 작성하시오.
-- LENGTH('문자열') : 글자 수
-- LENGTHB('문자열') : 바이트 수
-- * 영문, 숫자, 빈칸 : 1 byte
-- * 한글           : 3 byte
SELECT LENGTH('ALOHA WORLD') AS "글자 수"
       ,LENGTHB('ALOHA WROLD') AS "바이트 수"
FROM dual;

SELECT LENGTH('알로하 월드') AS "글자 수"
       ,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;

-- 31.
-- 두 문자열을 연결하기
SELECT CONCAT('ALOHA', 'WORLD') AS "함수"
             ,'ALOHA' || 'WORLD' AS "기호"
FROM dual;

SELECT CONCAT('안녕', '하세요') AS "함수"
             ,'안녕' || '하세요' AS "기호"
FROM dual;

-- 32.
-- <예시>와 같이 주어진 문자열의 일부만 출력하는 SQL문을 작성하시오.
-- 문자열 부분 출력하기
-- SUBSTR( 문자열, 시작번호, 글자수 )
-- 'www.alohacampus.com'
SELECT SUBSTR('www.alohacampus.com', 1, 3) AS "1"
      ,SUBSTR('www.alohacampus.com', 5, 11) AS "2"
      ,SUBSTR('www.alohacampus.com', -3, 3) AS "3"
FROM dual;
SELECT SUBSTRB('www.alohacampus.com', 1, 3) AS "1"
      ,SUBSTRB('www.alohacampus.com', 5, 11) AS "2"
      ,SUBSTRB('www.alohacampus.com', -3, 3) AS "3"
FROM dual;
SELECT REGEXP_SUBSTR('www.alohacampus.com', 'alo[[:alpha:]]+') AS "4"
FROM dual;

-- 'www.알로하캠퍼스.com'
SELECT SUBSTR('www.알로하캠퍼스.com', 1, 3) AS "1"
      ,SUBSTR('www.알로하캠퍼스.com', 5, 6) AS "2"
      ,SUBSTR('www.알로하캠퍼스.com', -3, 3) AS "3"
FROM dual;
-- BYTE의 경우 한글은 3BYTE 로 측정
SELECT SUBSTRB('www.알로하캠퍼스.com', 1, 3) AS "1"
      ,SUBSTRB('www.알로하캠퍼스.com', 5, 18) AS "2"
      ,SUBSTRB('www.알로하캠퍼스.com', -3, 3) AS "3"
FROM dual;

-- 33. 
-- 문자열에서 특정 문자의 위치를 구하는 함수
-- INSTR( 문자열, 찾을 문자, 시작 번호, 순서 )
-- ex) 'ALOHACAMPUS'
-- 해당 문자열에서 첫글자 부터 찾아서, 2번째 A의 위치를 구하시오.
-- INSTR('ALOHACAMPUS', 'A', 1, 2)

SELECT INSTR('ALOHACAMPUS', 'A', 1, 1) AS "1번째 A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 2) AS "2번째 A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 3) AS "3번째 A"
FROM dual;

-- 34.
-- <예시>와 같이 대상 문자열을 왼쪽/오른쪽에 출력하고 빈공간을 특정 문자로 채우는 SQL문을 작성하시오.
-- 문자열을 왼쪽/오른쪽에 출력하고, 빈공간을 특정 문자로 채우는 함수
-- LPAD( 문자열, 칸의 수, 채울 문자 )
-- : 문자열에 지정한 칸을 확보하고, 왼쪽에 특정 문자로 채움

-- RPAD( 문자열, 칸의 수, 채울 문자 )
-- : 문자열에 지정한 칸을 확보하고, 오른쪽에 특정 문자로 채움

SELECT LPAD('ALOHACAMPUS', 20, '#') AS "왼쪽"
      ,RPAD('ALOHACAMPUS', 20, '#') AS "오른쪽"
FROM dual;

-- 35. 
-- HIRE_DATE 입사일자를 날짜 형식을 지정하여 출력하시오.
-- TO_CHAR( 데이터, '날짜/숫자 형식' )
-- : 특정 데이터를 문자열 형식으로 변환하는 함수
-- : 날짜 -> 문자
SELECT first_name AS 이름
      ,TO_CHAR(hire_date, 'YYYY-MM-DD (dy) HH:MI:SS') AS 입사일자
FROM employees;

-- 36.
-- SALARY 급여를 통화형식으로 지정하여 출력하시오.
-- 숫자형식 = 9/유효범위가 아니면 00
-- : 숫자 -> 문자
SELECT first_name 이름
      ,TO_CHAR(salary, '$999,999,999.00') AS 급여
FROM employees;

--> 37.
-- <예시>와 같이 문자형으로 주어진 데이터를 날짜형 데이터로 변환하는 SQL 문을 작성하시오.
-- TO_DATE( 데이터 )
-- : 문자형 데이터를 날짜형 데이터로 변환하는 함수
SELECT 20230522 AS 문자
      ,TO_DATE(20230522) AS 날짜
FROM employees;

--> 38.
-- <예시>와 같이 문자형으로 주어진 데이터를 숫자형 데이터로 변환하는 SQL 문을 작성하시오.
-- TO_NUMBER( 데이터 )
-- : 문자형 데이터를 숫자형 데이터로 변환하는 함수
SELECT '1,200,000' AS 문자
      ,TO_NUMBER('1,200,000', '999,999,999') AS 숫자
FROM dual;
SELECT '158,966,654' AS 문자
      ,TO_NUMBER('158,966,654', '999,999,999') AS 숫자
FROM dual;

-- 39.
-- <예시>와 같이 현재 날짜를 반환하는 SQL 문을 작성하시오.
-- 어제, 오늘, 내일 날짜를 출력하시오.
-- sysdate : 현재 날짜/시간 정보를 가지고 있는 키워드
-- 2023/05/22 - YYYY/MM/DD 형식으로 출력
-- 날짜 데이터 --> 문자 데이터 변환
SELECT sysdate FROM dual;

SELECT sysdate -1 AS 어제
      ,sysdate AS 오늘
      ,sysdate +1 AS 내일
      ,sysdate +2 AS 모레
      ,sysdate +3 AS 기념일
      ,sysdate -5 AS 특정일
FROM dual;

-- 40.
-- <예시>와 같이 입사일자와 오늘 날짜를 계산하여 근무달수와 근속연수를 구하는 SQL문을 작성하시오.
-- 사원의 근무달수와 근속연수를 구하시오.
-- MONTHS_BETWEEN( A, B)
-- 날짜 A부터 B까지 개월 수 차이를 반환하는 함수
-- (단, A > B 즉, A가 더 최근 날짜로 지정해야 양수로 반환)
--  MONTHS_BETWEEN 쓸 경우 첫번째 인자가 더 커야함 !
SELECT first_name 이름
      ,TO_CHAR(hire_date, 'YYYY.MM.DD') 입사일자
      ,TO_CHAR(SYSDATE, 'YYYY.MM.DD') 오늘
      ,TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) || '개월' 근무달수 -- 절삭
      ,TRUNC(MONTHS_BETWEEN(sysdate, hire_date) / 12) || '년' 근속연수
FROM employees;

-- 41.
-- <예시>와 같이 오늘 날짜와 6개월 후의 날짜를 출력하는 SQL문을 작성하시오.
SELECT sysdate 오늘
      ,ADD_MONTHS(sysdate, 6) "6개월 후"
FROM dual;

SELECT sysdate 오늘
      ,ADD_MONTHS(sysdate, 12) "12개월 후" -- YEAR는 안됨. 
FROM dual;

SELECT '2023/04/17' 개강
      ,ADD_MONTHS('2023/04/17', 6) 종강
FROM dual;

-- 42.
-- 오늘 이후 돌아오는 토요일을 구하시오.
-- NEXT_DAY( 날짜, 요일 )
-- : 지정한 날짜 이후 돌아오는 요일을 반환하는 함수
-- 일 월 화 수 목 금 토
-- 1  2 3  4  5 6  7
SELECT sysdate 오늘
      ,NEXT_DAY( sysdate, 7 ) "다음 토요일"
FROM dual;

SELECT NEXT_DAY( sysdate, 1 ) "다음 일요일"
      ,NEXT_DAY( sysdate, 2 ) "다음 월요일"
      ,NEXT_DAY( sysdate, 3 ) "다음 화요일"
      ,NEXT_DAY( sysdate, 4 ) "다음 수요일"
      ,NEXT_DAY( sysdate, 5 ) "다음 목요일"
      ,NEXT_DAY( sysdate, 6 ) "다음 금요일"
      ,NEXT_DAY( sysdate, 7 ) "다음 토요일"
FROM dual;

-- 43.
-- <예시>와 같이 오늘 날짜와 월초, 월말 일자를 구하는 SQL문을 작성하시오.
-- 오늘 날짜와 해당 월의 월초, 월말 일자를 구하시오.
-- LAST_DAY( 날짜 )
-- : 지정한 날짜와 동일한 월의 월말 일자를 반환하는 함수
-- 날짜 : XXXXXX.YYYYYYY
-- 1970년01월01일 00시00분00ms → 2023년5월22일 ....
-- 지난 일자를 정수로 계산, 시간정보는 소수부분으로 계산
-- xxxx.yyyyy --> 2023년5월22일
-- 월 단위 아래로 절삭하면, 월초를 구할 수 있다
SELECT TRUNC( sysdate, 'MM' ) 월초
      ,sysdate 오늘
      ,LAST_DAY( sysdate ) 월말
FROM dual;

-- 44. 
-- 테이블 EMPLOYEES의 COMMISSION_PCT 를 중복없이 검색하되,
-- NULL 이면 0으로 조회하고 내림차순으로 정렬하는 SQL 문을 작성하시오.

-- NVL( 값, 대체할 값 ) : 해당 값이 NULL 이면 지정된 값으로 변환하는 함수
SELECT DISTINCT NVL(commission_pct, 0) "커미션(%)"
FROM employees
ORDER BY NVL(commission_pct, 0) DESC    -- SELECT에서 NVL 처리 한 변수를 이용해야 함 
;

-- 조회한 컬럼의 별칭으로 ORDER BY 절에서 사용할 수 있다.
SELECT DISTINCT NVL(commission_pct, 0) "커미션(%)"
FROM employees
ORDER BY "커미션(%)" DESC     
;

-- 45.
-- 테이블 EMPLOYEES의 FIRST_NAME, SALARY, COMMISSION_PCT 속성을 이용하여 
-- 급여, 커미션, 최종급여를 조회하시오.
-- * 최종급여 = 급여 + (급여 * 커미션)
-- * NVL2( 값, NULL 아닐 때 값, NULL 일 때 값 )

SELECT first_name 이름
      ,salary 급여
      ,NVL(commission_pct, 0) 커미션
      ,NVL2(commission_pct, salary+(salary*commission_pct), salary) 최종급여
FROM employees
ORDER BY 최종급여 DESC
;

-- 46.
-- DEPARTMENTS 테이블을 참조하여, 사원의 이름과 부서명을 출력하시오.
-- DECODE( 컬럼명, 조건값1, 반환값1, 조건값2, 반환값2, ... )
-- : 지정한 컬럼의 값이 조건값에 일치하면 바로 뒤의 반환값을 출력하는 함수
SELECT first_name 이름
      ,DECODE( department_id, 10, 'Administration',
                              20, 'Marketing',
                              30, 'Purchasing',
                              40, 'Human Resources',
                              50, 'Shipping',
                              60, 'IT',
                              70, 'Public Relations',
                              80, 'Sales',
                              90, 'Executive',
                              100, 'Finance'
     ) 부서
FROM employees;

SELECT *
FROM employees;

-- 47.
-- CASE 문
-- : 조건식을 만족할 때, 출력할 값을 지정하는 구문
-- 한 줄 복사 : ctrl + shift + D
SELECT first_name 이름
      ,CASE WHEN department_id = 10 THEN 'Administration'
            WHEN department_id = 20 THEN 'Marketing'
            WHEN department_id = 30 THEN 'Purchasing'
            WHEN department_id = 40 THEN 'Human Resources'
            WHEN department_id = 50 THEN 'Shipping'
            WHEN department_id = 60 THEN 'IT'
            WHEN department_id = 70 THEN 'Public Relations'
            WHEN department_id = 80 THEN 'Sales'
            WHEN department_id = 90 THEN 'Executive'
            WHEN department_id = 100 THEN 'Finance'
        END 부서
FROM employees;

-- 그룹함수
-- 48.
-- 다음 <예시>와 같이 테이블 EMPLOYEES 의 사원 수를 구하는 SQL 문을 작성하시오.
-- EMPLOYEES 테이블로 부터 전체 사원 수를 구하시오.
-- COUNT(컬럼명)
-- : 컬럼을 지정하여 NULL 을 제외한 데이터 개수를 반환하는 함수
-- * NULL 이 없는 데이터라면 어떤 컬럼을 지정하더라도 개수가 같으므로,
--   일반적으로 COUNT(*) 로 개수를 구한다.
SELECT COUNT(*) 사원수
FROM employees;

SELECT COUNT(commission_pct) 사원수 -- 특정 변수의 NULL 값 제외 후 COUNT
FROM employees;

-- 49.
-- 다음 <예시> 와 같이 테이블 EMPLOYEES의 최고급여, 최저급여를 구하는 SQL 문을 작성하시오.
-- 사원들의 최고급여와 최저급여를 구하시오.
SELECT MAX(salary) 최고급여
      ,MIN(salary) 최저급여
FROM employees;

-- 50.
-- 사원들의 급여 합계와 평균을 구하시오.
SELECT SUM(salary) 급여합계
      ,ROUND(AVG(salary), 2) 급여평균
FROM employees;

-- 51.
-- 사원들의 급여 표준편차와 분산을 구하시오.
SELECT ROUND( STDDEV(salary), 2 ) 급여표준편차
      ,ROUND( VARIANCE(salary), 2 ) 급여분산
FROM employees;

-- 52.
-- MS_STUDENT 테이블을 생성하시오. 
-- * 테이블 생성
/*
    CREATE TABLE 테이블명 (
        컬럼명1 타입     [NOT NULL/NULL] [제약조건],
        컬럼명2 타입     [NOT NULL/NULL] [제약조건],
        컬럼명3 타입     [NOT NULL/NULL] [제약조건],
        ...
    );
*/
-- * 테이블 삭제
/*
    DROP TABLE 테이블명;
*/
DROP TABLE MS_STUDENT;

CREATE TABLE MS_STUDENT (
    ST_NO       NUMBER          NOT NULL
   ,NAME        VARCHAR2(20)    NOT NULL   -- 20byte 크기 지정
   ,CTZ_NO      CHAR(14)        NOT NULL
   ,EMAIL       VARCHAR2(100)   NOT NULL
   ,ADDRESS     VARCHAR2(1000)  NULL
   ,DEPT_NO     NUMBER          NOT NULL
   ,MJ_NO       NUMBER          NOT NULL
   ,REG_DATE    DATE    DEFAULT sysdate NOT NULL
   ,UPD_DATE    DATE    DEFAULT sysdate NOT NULL
   ,ETC         VARCHAR2(1000)      DEFAULT '없음' NULL
   ,
   CONSTRAINT MS_STUDENT_PK PRIMARY KEY(ST_NO) ENABLE
);

-- UQ (고유키) 추가
ALTER TABLE MS_STUDENT ADD CONSTRAINT MS_STUDENT_UK1 UNIQUE ( EMAIL ) ENABLE;

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '부서번호';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 53.
-- MS_STUDENT 테이블에 성별, 재적, 입학일자, 졸업일자 속성을 추가하시오.
-- 테이블에 속성 추가
-- ALTER TABLE 테이블명 ADD 컬럼명 타입 DEFAULT 기본값 [NOT NULL];
ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '기타' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';

ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '대기' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';

ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';

ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

-- 테이블 속성 삭제
-- ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
ALTER TABLE MS_STUDENT DROP COLUMN GENDER;
ALTER TABLE MS_STUDENT DROP COLUMN STATUS;
ALTER TABLE MS_STUDENT DROP COLUMN ADM_DATE;
ALTER TABLE MS_STUDENT DROP COLUMN GRD_DATE;

-- 54. MS_STUDENT 테이블의 CTZ_NO 속성을 BIRTH 로 이름을 변경하고
-- 데이터 타입을 DATE로 수정하시오.
-- 그리고, 설명도 '생년월일'로 변경하시오.
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';

-- 속성 변경 - 타입 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
-- 속성 변경 - NULL 여부 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH NULL;
-- 속성 변경 - DEFAULT 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DEFAULT sysdate;
   
-- 동시에 적용 가능 
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE DEFAULT sysdate NOT NULL;

-- 55.
-- MS_STUDENT 테이블의 학부 번호(DEPT_NO) 속성을 삭제하시오.
ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;

-- 56. 
-- MS_STUDENT 테이블을 삭제하시오.
 DROP TABLE MS_STUDENT;

-- 57.
-- 
CREATE TABLE MS_STUDENT (
    ST_NO       NUMBER          NOT NULL
   ,NAME        VARCHAR2(20)    NOT NULL   -- 20byte 크기 지정
   ,BIRTH       DATE            NOT NULL
   ,EMAIL       VARCHAR2(100)   NOT NULL
   ,ADDRESS     VARCHAR2(1000)  NULL
   ,MJ_NO       VARCHAR2(10)    NOT NULL
   ,GENDER      CHAR(6)         DEFAULT '기타'    NOT NULL
   ,STATUS      VARCHAR2(10)    DEFAULT '대기'    NOT NULL
   ,ADM_DATE    DATE    NULL
   ,GRD_DATE    DATE    NULL
   ,REG_DATE    DATE    DEFAULT sysdate NOT NULL
   ,UPD_DATE    DATE    DEFAULT sysdate NOT NULL
   ,ETC         VARCHAR2(1000)      DEFAULT '없음' NULL
   ,
   CONSTRAINT MS_STUDENT_PK PRIMARY KEY(ST_NO) ENABLE
);
 
 -- UQ (고유키) 추가
ALTER TABLE MS_STUDENT ADD CONSTRAINT MS_STUDENT_UK1 UNIQUE ( EMAIL ) ENABLE;

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';

COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 58.
-- 데이터 삽입 (INSERT)
INSERT INTO MS_STUDENT 
( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO,
    GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20180001', '최서아', '991005', 'csa@univ.ac.kr', '서울', 'I01',
         '여', '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT        -- VSCODE 날짜 FORMAT 주의하기 
( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO,
    GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210001', '박서준', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'psj@univ.ac.kr', '서울', 'B02',
         '남', '재학', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT 
( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO,
    GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210002', '김아윤', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'kay@univ.ac.kr', '인천', 'S01',
         '여', '재학', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT 
( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO,
    GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20160001', '정수안', TO_DATE('1997/02/10', 'YYYY/MM/DD'), 'jsa@univ.ac.kr', '경남', 'J01',
         '여', '재학', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT 
( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO,
    GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20150010', '윤도현', TO_DATE('1996/03/11', 'YYYY/MM/DD'), 'ydh@univ.ac.kr', '제주도', 'K01',
         '남', '재학', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT 
( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO,
    GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20130007', '안아람', TO_DATE('1994/11/24', 'YYYY/MM/DD'), 'aar@univ.ac.kr', '경기', 'Y01',
         '여', '재학', TO_DATE('2013/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, '영상예술 특기자' );

INSERT INTO MS_STUDENT 
( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO,
    GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20110002', '한성호', TO_DATE('1992/10/07', 'YYYY/MM/DD'), 'hsh@univ.ac.kr', '서울', 'E03',
         '남', '재학', TO_DATE('2015/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

SELECT * FROM MS_STUDENT;

-- 59.
-- MS_STUDENT 테이블의 데이터를 수정
-- UPDATE
/*
      UPDATE 테이블명
         SET 컬럼1 = 변경할 값,
             컬럼2 = 변경할 값,
             ...
      [WHERE] 조건;
*/
-- 1) 학생번호가 20160001 인 학생의 주소를 '서울'로,
--    재적상태를 '휴학'으로 수정하시오.
UPDATE MS_STUDENT
   SET address = '서울'
      ,status = '휴학'
WHERE st_no = 20160001;

-- 2) 학생번호가 20150010 인 학생의 주소를 '서울'로,
-- 재적 상태를 '졸업', 졸업일자를 '20200220', 수정일자 현재날짜로
-- 그리고 특이사항을 '수석'으로 수정하시오.
UPDATE MS_STUDENT
   SET address = '서울', status = '졸업', grd_date = '2020/02/02',
       upd_date = sysdate, etc = '수석'
 WHERE st_no = 20150010;

 -- 3) 학생번호가 20130007 인 학생의 재적 상태를 '졸업', 졸업일자를 '20200220',
 --    수정일자 현재날짜로 수정하시오.
UPDATE MS_STUDENT
   SET status = '졸업',
       grd_date = '2020/02/20',
       upd_date = SYSDATE
WHERE st_no = 20130007;

 -- 4) 학생번호가 20110002 인 학생의 재적 상태를 '퇴학',
 --    수정일자 현재날짜, 특이사항 '자진 퇴학' 으로 수정하시오.
UPDATE MS_STUDENT
   SET status = '퇴학',
       upd_date = SYSDATE,
       etc = '자진 퇴학'
WHERE st_no = 20110002;

-- 60.
-- MS_STUDENT 테이블에서 학번이 20110002 인 학생을 삭제하시오.
DELETE FROM MS_STUDENT WHERE ST_NO = 20110002;

SELECT * FROM MS_STUDENT;

-- 61.
-- MS_STUDENT 테이블의 모든 속성을 조회하시오.
SELECT *
FROM MS_STUDENT;

-- 62.
-- MS_STUDENT 테이블을 조회하여 MS_STUDENT_BACK 테이블을 생성하시오.
-- 백업 데이터 만들기
CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;

SELECT * FROM MS_STUDENT_BACK;

-- 63.
-- MS_STUDENT 테이블의 튜플을 삭제하시오.
DELETE FROM MS_STUDENT;

SELECT * FROM MS_STUDENT;

-- 64.
-- MS_STUDENT_BACK 테이블의 모든 속성을 조회하여
-- MS_STUDENT 테이블에 삽입하시오.
INSERT INTO MS_STUDENT
SELECT * FROM MS_STUDENT_BACK;

SELECT * FROM MS_STUDENT;

-- 65.
-- MS_STUDENT 테이블의 성별(gender) 속성에 대하여,
-- ('여', '남', '기타') 값만 입력가능하도록 제약조건을 추가하시오.
ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STD_GENDER_CHECK
CHECK (gender IN ('여', '남', '기타') );

UPDATE MS_STUDENT
SET gender = '???'
;
 
-- * 지정한 값이 아닌 다른 값을 입력/수정하는 경우
-- "체크 제약조건(HR.MS_STD_GENDER_CHECK)이 위배되었습니다" 에러 발생

-- KEY
-- 기본키 (PRIMARY KEY)
-- : 중복 불가, NULL 불가(필수 입력)
--    * 해당 테이블의 데이터를 고유하게 구분할 수 있는 속성으로 지정

-- 고유키 (UNIQUE KEY)
-- : 중복 불가, NULL 허용
--    * 중복되지 않아야할 데이터(ID, 주민번호, 이메일, ...)

-- 66.
-- 테이블 기술서를 참고하여 MS_USER 테이블을 생성하시오.
CREATE TABLE MS_USER (
      USER_NO           NUMBER                  NOT NULL
     ,USER_ID           VARCHAR2(100)           NOT NULL
     ,USER_PW           VARCHAR2(200)           NOT NULL
     ,USER_NAME         VARCHAR2(50)            NOT NULL
     ,BIRTH             DATE                    NOT NULL
     ,TEL               VARCHAR2(20)            NOT NULL
     ,ADDRESS           VARCHAR2(200)           NULL
     ,REG_DATE          DATE  DEFAULT sysdate   NOT NULL
     ,UPD_DATE          DATE  DEFAULT sysdate   NOT NULL
     ,
     CONSTRAINT MS_USER_PD PRIMARY KEY(USER_NO) ENABLE
);

-- UQ (고유키) 추가
ALTER TABLE MS_USER ADD CONSTRAINT MS_USER_UK1 UNIQUE ( USER_ID ) ENABLE;
ALTER TABLE MS_USER ADD CONSTRAINT MS_USER_UK2 UNIQUE ( TEL ) ENABLE;

COMMENT ON TABLE MS_USER IS '커뮤니티 회원의 정보를 관리한다.';
COMMENT ON COLUMN MS_USER.USER_NO IS '회원정보';
COMMENT ON COLUMN MS_USER.USER_ID IS '아이디';
COMMENT ON COLUMN MS_USER.USER_PW IS '비밀번호';
COMMENT ON COLUMN MS_USER.USER_NAME IS '이름';
COMMENT ON COLUMN MS_USER.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_USER.TEL IS '전화번호';
COMMENT ON COLUMN MS_USER.ADDRESS IS '주소';
COMMENT ON COLUMN MS_USER.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_USER.UPD_DATE IS '수정일자';

-- 67.
-- MS_BOARD 테이블을 생성하시오.
CREATE TABLE MS_BOARD (
      BOARD_NO          NUMBER                    NOT NULL PRIMARY KEY
     ,TITLE             VARCHAR2(200)             NOT NULL
     ,CONTENT           CLOB                      NOT NULL
     ,WRITER            VARCHAR2(100)             NOT NULL
     ,HIT               NUMBER                    NOT NULL
     ,LIKE_CNT          NUMBER                    NOT NULL
     ,DEL_YN            CHAR(2)                   NULL
     ,DEL_DATE          DATE                      NULL
     ,REG_DATE          DATE  DEFAULT SYSDATE     NOT NULL
     ,UPD_DATE          DATE  DEFAULT SYSDATE     NOT NULL   
);

COMMENT ON TABLE MS_BOARD IS '커뮤니티 게시판 정보를 관리한다.';
COMMENT ON COLUMN MS_BOARD.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_BOARD.TITLE IS '제목';
COMMENT ON COLUMN MS_BOARD.CONTENT IS '내용';
COMMENT ON COLUMN MS_BOARD.WRITER IS '작성자';
COMMENT ON COLUMN MS_BOARD.HIT IS '조회수';
COMMENT ON COLUMN MS_BOARD.LIKE_CNT IS '좋아요 수';
COMMENT ON COLUMN MS_BOARD.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_BOARD.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_BOARD.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_BOARD.UPD_DATE IS '수정일자';

-- 68.
-- MS_FILE 테이블을 생성하시오.
CREATE TABLE MS_FILE (
      FILE_NO          NUMBER                      NOT NULL PRIMARY KEY
     ,BOARD_NO         NUMBER                      NOT NULL
     ,FILE_NAME        VARCHAR2(2000)              NOT NULL
     ,FILE_DATA        BLOB                        NOT NULL
     ,REG_DATE         DATE  DEFAULT SYSDATE       NOT NULL
     ,UPD_DATE         DATE  DEFAULT SYSDATE       NOT NULL
);

COMMENT ON TABLE MS_FILE IS '커뮤니티 게시판 첨부파일의 정보를 관리한다.';
COMMENT ON COLUMN MS_FILE.FILE_NO IS '파일번호';
COMMENT ON COLUMN MS_FILE.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_FILE.FILE_NAME IS '파일명';
COMMENT ON COLUMN MS_FILE.FILE_DATA IS '파일';
COMMENT ON COLUMN MS_FILE.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_FILE.UPD_DATE IS '수정일자';

-- 69.
-- MS_REPLY 테이블을 생성하시오.
CREATE TABLE MS_REPLY (
      REPLY_NO          NUMBER                     NOT NULL
     ,BOARD_NO          NUMBER                     NOT NULL
     ,CONTENT           VARCHAR2(2000)             NOT NULL
     ,WRITER            NUMBER                     NOT NULL
     ,DEL_YN            CHAR(2) DEFAULT 'N'        NULL
     ,DEL_DATE          DATE                       NULL
     ,REG_DATE          DATE  DEFAULT SYSDATE      NOT NULL
     ,UPD_DATE          DATE  DEFAULT SYSDATE      NOT NULL
     ,CONSTRAINT MS_REPLY PRIMARY KEY(REPLY_NO) ENABLE
);

COMMENT ON TABLE MS_REPLY IS '커뮤니티 게시판의 댓글 정보를 관리한다.';
COMMENT ON COLUMN MS_REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN MS_REPLY.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_REPLY.CONTENT IS '내용';
COMMENT ON COLUMN MS_REPLY.WRITER IS '작성자';
COMMENT ON COLUMN MS_REPLY.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_REPLY.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_REPLY.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_REPLY.UPD_DATE IS '수정일자';

SELECT * FROM MS_REPLY;

-- 70.
-- human 계정에 있는 모든 데이터를 human2 계정으로 가져오기 위해서
-- human.dmp 파일을 만들었다.
-- human2 계정으로 접속하여, human.dmp 파일을 import 하시오.


-- 1. human, human2 계정 생성
-- 2. human.dmp 파일 import

-- human 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER human IDENTIFIED BY 123456;
ALTER USER human QUOTA UNLIMITED ON users;
GRANT DBA TO human;

-- human2 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE; 
CREATE USER human2 IDENTIFIED BY 123456;
ALTER USER human2 QUOTA UNLIMITED ON users;
GRANT DBA TO human2; 

-- community.dmp 를 human 계정으로 가져오기 (CMD)
imp userid=system/123456 file=C:\KDY\ORACLE\community.dmp fromuser=human touser=human

-- human.dmp 를 human2 계정으로 가져오기 (CMD)
imp userid=system/123456 file=C:\KDY\ORACLE\human.dmp fromuser=human touser=human2

-- 71.
-- human 계정이 소유하고 있는 데이터를
-- "human_exp.dmp" 덤프파일로 export 하는 명령어를 작성하시오.

-- human_exp.dmp 덤프파일 생성하기 (CMD)
exp userid=human/123456 file=C:\KDY\ORACLE\human_exp.dmp log=C:\KDY\ORACLE\human_exp.log

-- 72.
-- MS_BOARD의 WRITER 속성을 NUMBER 타입으로 변경하고
-- MS_USER의 USER_NO 를 참조하는 외래키로 지정하시오.

-- 1)
-- 데이터 타입 변경
ALTER TABLE MS_BOARD MODIFY WRITER NUMBER;

-- 외래 키 지정
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명
-- FOREIGN KEY (외래키컬럼) REFERENCES 참조테이블(기본키);
ALTER TABLE MS_BOARD ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY ( WRITER ) REFERENCES MS_USER(USER_NO);

-- 2)
-- 외래 키 : MS_FILE (BOARD_NO) ----> MS_BOARD (BOARD_NO)
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

-- 3)
-- 외래 키 : MS_REPLY (BOARD_NO) ----> MS_BOARD (BOARD_NO)
ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

-- 제약조건 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

-- 73.
-- MS_USER 테이블에 속성을 추가하시오.
ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NOT NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6) NOT NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_USER.GENDER IS '성별';

DESC MS_USER;

-- 74.
-- MS_USER의 GENDER 속성이 ('여', '남', '기타') 값만 갖도록
-- 제약조건을 추가하시오.
-- CHECK 제약조건 추가
ALTER TABLE MS_USER
ADD CONSTRAINT MS_USER_GENDER_CHECK
CHECK (gender IN ('여', '남', '기타'))
;

-- 75.
-- MS_FILE 테이블에 확장자(EXT) 속성을 추가하시오.
ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NULL;
COMMENT ON COLUMN MS_FILE.EXT IS '확장자';

-- 76.
-- 
MERGE INTO MS_FILE T            -- 대상 테이블 지정
-- 사용할 데이터의 자원을 지정
USING ( SELECT FILE_NO, FILE_NAME FROM MS_FILE ) F
-- ON (update 될 조건)
ON (T.FILE_NO = F.FILE_NO)
-- 매치조건에 만족한 경우
WHEN MATCHED THEN
    -- SUBSTR( 문자열, 시작번호 )
    -- ex. SUBSTR( '/upload/강아지.png', 12 ) --> png
    UPDATE SET T.EXT = SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) +1)
    DELETE WHERE SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) +1)
                NOT IN ('jpeg', 'jpg', 'gif', 'png')
-- WHEN NOT MATCHED THEN
-- [매치가 안 될 때,]
;

-- 파일 추가
INSERT INTO MS_FILE (
                FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
                )
VALUES (1, 1, '강아지.png', '123', sysdate, sysdate, 'jpg' );

INSERT INTO MS_FILE (
                FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT
                )
VALUES (2, 1, 'main.html', '123', sysdate, sysdate, 'jpg' );

-- 게시글 추가
INSERT INTO MS_BOARD (
                BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT, 
                DEL_YN, DEL_DATE, REG_DATE, UPD_DATE
                )
VALUES (
        1, '제목', '내용', 1, 0, 0, 'N', NULL, sysdate, sysdate
        );
        
-- 유저 추가
INSERT INTO MS_USER (
                USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH,
                TEL, ADDRESS, REG_DATE, UPD_DATE,
                CTZ_NO, GENDER
                )
VALUES ( 1, 'ALOHA', '123456', '김휴먼', TO_DATE('2003/01/01', 'YYYY/MM/DD'),
         '010-1234-1234', '영등포', sysdate, sysdate,
         '030101-3334444', '기타');
         
         
SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
DELETE FROM MS_FILE; 
SELECT * FROM MS_FILE;

-- 77.
-- 테이블 MS_FILE 의 EXT 속성이
-- ('jpg', 'jpeg', 'gif', 'png') 값을 갖도록 하는 제약조건을 추가하시오.

ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_EXT_CHECK
CHECK (EXT IN('jpg', 'jpeg', 'gif', 'png') );

ALTER TABLE MS_FILE
DROP CONSTRAINT MS_FILE_EXT_CHECK;

-- 78.
-- MS_USER, MS_BOARD, MS_FILE, MS_REPLY 테이블의
-- 모든 데이터를 삭제하는 명령어를 작성하시오.
-- 역순으로 실행
TRUNCATE TABLE MS_USER;
TRUNCATE TABLE MS_BOARD;
TRUNCATE TABLE MS_FILE;
TRUNCATE TABLE MS_REPLY;

DELETE FROM MS_USER;
DELETE FROM MS_BOARD;
DELETE FROM MS_FILE;
DELETE FROM MS_REPLY;

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
SELECT * FROM MS_REPLY;

-- DDL, DML, DCL
-- DELETE vs TRUNCATE
-- * DELETE - 데이터 조작어(DML)
--  - 한 행 단위로 데이터를 삭제한다
--  - COMMIT, ROLLBACK을 이용하여 변경사항을 적용하거나 되돌릴 수 있음

-- * TRUNCATE - 데이터 정의어 (DDL)
--  - 모든 행을 삭제한다
--  - 삭제된 데이터를 되돌릴 수 없음

-- 79.
-- 테이블의 속성을 삭제하시오.
-- * MS_BOARD 테이블의 WRITER 속성
-- * MS_FILE 테이블의 BOARD_NO 속성
-- * MS_REPLY 테이블의 BOARD_NO 속성
ALTER TABLE MS_BOARD DROP COLUMN WRITER;
ALTER TABLE MS_FILE DROP COLUMN BOARD_NO;
ALTER TABLE MS_REPLY DROP COLUMN BOARD_NO;

-- 80.
-- 각 테이블에 속성들을 추가한 뒤, 외래키로 지정하시오.
-- 해당 외래키에 대하여 참조 테이블의 데이터 삭제 시,
-- 연결된 속성의 값도 삭제하는 옵션도 지정하시오.

-- 1)
-- MS_BOARD 에 WRITER 속성 추가
ALTER TABLE MS_BOARD ADD WRITER NUMBER NOT NULL;

-- WRITER 속성을 외래키로 지정
-- + 참조 테이블 데이터 삭제 시, 연쇄적으로 함께 삭제하는 옵션 지정
ALTER TABLE MS_BOARD
ADD CONSTRAINT MS_BOARD_WRITER_FK
FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO)
ON DELETE CASCADE;
-- ON DELETE [NO ACTION, RESTRICT, CASCADE, SET NULL]
-- * RESTRICT : 자식 테이블의 데이터가 존재하면, 삭제 안 함
-- * CASCADE  : 자식 테이블의 데이터도 함께 삭제
-- * SET NULL : 자식 테이블의 데이터를 NULL 로 지정

 
 
-- 2)
-- MS_FILE 에 BOARD_NO 속성 추가
ALTER TABLE MS_FILE ADD BOARD_NO NUMBER NOT NULL;
-- BOARD_NO 속성을 외래키로 추가
-- 참조테이블 : MS_BOARD, 참조 속성 : BOARD_NO
-- + 참조 테이블 데이터 삭제 시, 연쇄적으로 함께 삭제하는 옵션 지정
ALTER TABLE MS_FILE
ADD CONSTRAINT MS_FILE_BOARD_NO_FK FOREIGN KEY(BOARD_NO)
REFERENCES MS_BOARD(BOARD_NO)
ON DELETE CASCADE;
 
 
-- 3)
-- MS_REPLY 에 BOARD_NO 속성 추가
ALTER TABLE MS_REPLY ADD BOARD_NO NUMBER NOT NULL;
-- BOARD_NO 속성을 외래키로 추가
-- 참조테이블 : MS_BOARD, 참조 속성 : BOARD_NO
-- + 참조 테이블 데이터 삭제 시, 연쇄적으로 함께 삭제하는 옵션 지정
ALTER TABLE MS_REPLY
ADD CONSTRAINT MS_REPLY_BOARD_NO_FK FOREIGN KEY(BOARD_NO)
REFERENCES MS_BOARD(BOARD_NO)
ON DELETE CASCADE;

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;

-- 회원탈퇴 (회원번호:1)
DELETE FROM MS_USER WHERE USER_NO = 1;

-- ON DELETE CASCADE 옵션으로 외래키 지정 시,
-- MS_USER 의 데이터를 삭제 하면, 
-- MS_BOARD 의 참조된 데이터도 연쇄적으로 삭제된다.

-- MS_BOARD 의 데이터가 삭제 되면,
-- MS_FILE의 참조된 데이터도 연쇄적으로 삭제된다. 

-- 외래키 제약조건 정리
ALTER TABLE 테이블명
ADD CONSTRAINT 제약조건명 FOREIGN KEY (외래키 속성)
REFERENCES 참조테이블(참조 속성);
-- 옵션(UPDATE)
-- ON UPDATE        -- 참조 테이블 수정 시,
--  * CASCADE       : 자식 데이터 수정
--  * SET NULL      : 자식 데이터는 NULL
--  * SET DEFAULT   : 자식 데이터는 기본값
--  * RESTRICT      : 자식 테이블의 참조하는 데이터가 존재하면, 부모 데이터 수정 불가
--  * NO ACTION     : 아무런 행위도 취하지 않는다 (기본값)

-- 옵션(DELETE)
-- ON DELETE        -- 참조 테이블 삭제 시,
--  * CASCADE       : 자식 데이터 삭제
--  * SET NULL      : 자식 데이터는 NULL
--  * SET DEFAULT   : 자식 데이터는 기본값
--  * RESTRICT      : 자식 테이블의 참조하는 데이터가 존재하면, 부모 데이터 삭제 불가
--  * NO ACTION     : 아무런 행위도 취하지 않는다 (기본값)

-- ▶ 서브쿼리
/*
    : SQL 문 내부에 사용하는 SELECT 문
    * 메인쿼리 : 서브쿼리를 사용하는 최종적인 SELECT 문
    
    * 서브쿼리 종류
    - 스칼라 서브쿼리  : SELECT 절에서 사용하는 서브쿼리
    - 인라인 뷰       : FROM 절에서 사용하는 서브쿼리
    - 서브 쿼리       : WHERE 절에서 사용하는 서브쿼리
*/

-- 81.
-- EMPLOYEE, DEPARTMENT, JOB 테이블을 사용하여
-- 스칼라 서브쿼리로 출력결과와 같이 조회하시오.
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;

-- 테이블 이름의 약어를 만들어 파악하기 쉽게 함
SELECT emp_id AS 사원번호
      ,emp_name AS 직원명
      ,(SELECT dept_title FROM department d WHERE d.dept_id = e.dept_code) 부서명 
      ,(SELECT job_name FROM job j WHERE j.job_code = e.job_code) 직급명
FROM employee e;

-- JOIN

-- INNER JOIN(내부조인)
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급명
FROM employee e
     JOIN department d ON e.dept_code = d.dept_id
     JOIN job j ON e.job_code = j.job_code
;

-- EQUI JOIN
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급명
FROM employee e, department d, job j
WHERE e.dept_code = d.dept_id
  AND e.job_code = j.job_code
;

-- 82.
-- 출력결과를 참고하여,
-- 인라인 뷰를 이용해 부서별로 최고급여를 받는 직원을 조회하시오.

-- 1. 부서별로 최고급여를 조회
SELECT dept_code
      ,MAX(salary) MAX_SAL
      ,MIN(salary) MIN_SAL
      ,AVG(salary) AVG_SAL
FROM employee
GROUP BY dept_code
;

-- 2. 부서별 최고급여 조회결과를 서브쿼리(인라인 뷰)로 지정
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,e.salary 급여
      ,t.max_sal 최고급여
      ,t.min_sal 최저급여
      ,ROUND(t.avg_sal, 2) 평균급여
FROM employee e, department d,
      (SELECT dept_code
             ,MAX(salary) MAX_SAL
             ,MIN(salary) MIN_SAL
             ,AVG(salary) AVG_SAL
      FROM employee
      GROUP BY dept_code) t
WHERE e.dept_code = d.dept_id
  AND e.salary = t.max_sal;

-- 83.
-- 서브쿼리를 이용하여,
-- 직원명이 '이태림' 인 사원과 같은 부서의 직원들을 조회하시오.
SELECT emp_id 사원번호
      ,emp_name 직원명
      ,email 이메일
      ,phone 전화번호
FROM employee
WHERE dept_code = (
                    SELECT dept_code
                    FROM employee
                    WHERE emp_name = '이태림'
                  )
;

-- 84.
-- 사원 테이블에 존재하는 부서코드만 포함하는 부서를 조회하시오.
-- (사원이 존재하는 부서만 조회하시오.)
SELECT dept_id FROM department;                 -- D1~D9
SELECT DISTINCT dept_code FROM employee;        -- D1, D2, D5, D6, D8, D9
-- 사원이 없는 부서 : D3, D4, D7

-- 1) 서브쿼리
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department
WHERE dept_id IN (
                    SELECT DISTINCT dept_code
                    FROM employee
                    WHERE dept_code IS NOT NULL
                  )
;
-- 2) EXISTS
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department d
WHERE EXISTS ( SELECT * FROM employee e WHERE e.dept_code = d.dept_id )
ORDER BY dept_id ASC
;

-- 85.
-- 사원 테이블에 존재하지 않는 부서코드만 포함하는 부서를 조회하시오.
-- (사원이 존재하지 않는 부서만 조회하시오.)
SELECT dept_id FROM department;                 -- D1~D9
SELECT DISTINCT dept_code FROM employee;        -- D1, D2, D5, D6, D8, D9
-- 사원이 없는 부서 : D3, D4, D7

-- 1) 서브쿼리
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department
WHERE dept_id NOT IN (
                    SELECT DISTINCT dept_code
                    FROM employee
                    WHERE dept_code IS NOT NULL
                  )
;
-- 2) EXISTS
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department d
WHERE NOT EXISTS ( SELECT * FROM employee e WHERE e.dept_code = d.dept_id )
ORDER BY dept_id ASC
;

-- 86.
-- EMPLOYEE 테이블의 DEPT_CODE 가 'D1'인 부서의 최대급여 보다 
-- 더 큰 급여를 받는 사원을 조회하시오.
SELECT *
FROM employee, department     -- 23 x 9 = 207
;

SELECT * FROM employee;       -- 23건
SELECT * FROM department;     -- 9건

SELECT *
FROM employee e, department d
WHERE e.dept_code = d.dept_id
;

SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,e.salary 급여 
FROM employee e, department d
WHERE e.dept_code = d.DEPT_id
;

-- 1)
-- 1. 부서코드가 'D1'인 사원의 최대급여
SELECT MAX(salary)
FROM employee
WHERE dept_code = 'D1';

-- 2. 급여가 366000 보다 큰 사원 조회
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,e.salary 급여
FROM employee e, department d
WHERE e.dept_code = d.dept_id
  AND e.salary > 3660000
;

-- 3. 366000 자리에 1번을 서브쿼리로 변경
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,TO_CHAR(e.salary, '999,999,999') 급여
FROM employee e, department d
WHERE e.dept_code = d.dept_id
  AND e.salary > (
                  SELECT MAX(salary)
                  FROM employee
                  WHERE dept_code = 'D1'
                  )
;

-- 2)
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,TO_CHAR(e.salary, '999,999,999') 급여
FROM employee e, department d
WHERE e.dept_code = d.dept_id
  AND e.salary > ALL (
                        SELECT salary
                        FROM employee
                        WHERE dept_code = 'D1'
                     )
;


-- 87.
-- EMPLOYEE 테이블의 DEPT_CODE 가 'D9' 인 부서의 최저급여 보다
-- 더 큰 급여를 받는 사원을 조회하시오.

-- 1)
-- 1. DEPT_CODE 가 'D9'인 부서의 최저급여
SELECT MIN(salary)
FROM employee
WHERE dept_code = 'D9';

-- 2. 급여 > 최저급여
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,TO_CHAR(e.salary, '999,999,999') 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND e.salary > (
                  SELECT MIN(salary)
                  FROM employee
                  WHERE dept_code = 'D9'
                  )
;

-- 2)
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,TO_CHAR(e.salary, '999,999,999') 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND e.salary > ANY (
                        SELECT salary
                        FROM employee
                        WHERE dept_code = 'D9'
                     )
;


-- 88.
-- EMPLOYEE 와 DEPARTMENT 테이블을 조인하여 출력하되,
-- 부서가 없는 직원도 포함하여 출력하시오.

SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,NVL(d.dept_id, '(없음)') 부서번호
      ,NVL(d.dept_title, '(없음)') 부서명
FROM employee e
     LEFT JOIN department d
     ON ( e.dept_code = d.dept_id ) 
;

-- NULL 로 나오는 데이터 : 부서가 없는 사원

-- 89.
-- EMPLOYEE 와 DEPARTMENT 테이블을 조인하여 출력하되,
-- 직원이 없는 부서도 포함하여 출력하시오.

SELECT NVL(e.emp_id, '(없음)') 사원번호
      ,NVL(e.emp_name, '(없음)') 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
FROM employee e
     RIGHT JOIN department d
     ON (e.dept_code = d.dept_id)
;

-- null 나오는 데이터 : 사원이 없는 부서


-- 90.
-- 직원 및 부서 유무에 상관 없이 출력하는 SQL 문을 작성하시오.

SELECT NVL( e.emp_id, '(없음)') 사원번호
      ,NVL( e.emp_name, '(없음)') 직원명
      ,NVL( d.dept_id, '(없음)') 부서번호
      ,NVL( d.dept_title, '(없음)') 부서명
FROM employee e
      FULL JOIN department d
      ON ( e.dept_code = d.dept_id )
;

-- 91.
-- 사원번호, 직원명, 부서번호, 지역명, 국가명, 급여, 입사일자를 출력하시오.
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM location;
SELECT * FROM national;

SELECT e.emp_id 사원번호
      ,NVL( e.emp_name, '(없음)') 직원명
      ,NVL( e.dept_code, '(없음)') 부서번호
      ,NVL( d.dept_title, '(없음)') 부서명
      ,NVL( l.local_name, '(없음)') 지역명
      ,NVL( n.national_name, '(없음)') 국가명
      ,e.salary 급여
      ,hire_date 입사일자
FROM employee e
      LEFT JOIN department d ON e.dept_code = d.dept_id
      LEFT JOIN location l ON d.location_id = l.local_code
      LEFT JOIN national n ON l.national_code = n.national_code
;

-- 92.
-- 사원들 중 매니저를 출력하시오.
-- 사원번호, 직원명, 부서명, 직급, 구분('매니저')

-- 1.
-- manager_id 컬럼이 NULL 이 아닌 사원을 중복 없이 조회
-- 매니저들의 사원 번호
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;

SELECT DISTINCT manager_id
FROM employee
WHERE manager_id IS NOT NULL;

-- 2. 
-- employee, department, job 테이블을 조인하여 조회
SELECT *
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
    JOIN job j ON e.job_code = j.job_code
;

-- 3.
-- 조인 결과 중, emp_id 가 매니저 사원번호인 경우만을 조회

SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'매니저' 구분
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
    JOIN job j ON e.job_code = j.job_code
WHERE emp_id IN ( 
                  SELECT DISTINCT manager_id
                  FROM employee
                  WHERE manager_id IS NOT NULL
                )
;

-- 93. 
-- 사원(매니저가 아닌)만 조회하시오. 
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'사원' 구분
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
    JOIN job j ON e.job_code = j.job_code
WHERE emp_id NOT IN ( 
                  SELECT DISTINCT manager_id
                  FROM employee
                  WHERE manager_id IS NOT NULL 
                )
;

-- 94. 
-- UNION 키워드를 사용하여 
-- 매니저, 사원을 구분하여 조회하시오.
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'매니저' 구분
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
    JOIN job j ON e.job_code = j.job_code
WHERE emp_id IN ( 
                  SELECT DISTINCT manager_id
                  FROM employee
                  WHERE manager_id IS NOT NULL
                )

UNION

SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'사원' 구분
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
    JOIN job j ON e.job_code = j.job_code
WHERE emp_id NOT IN ( 
                  SELECT DISTINCT manager_id
                  FROM employee
                  WHERE manager_id IS NOT NULL 
                    )
;

-- 95. CASE 키워드를 사용하여
-- 매니저, 사원을 구분하여 조회하시오.
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      --
      , CASE
            WHEN emp_id IN (
                              SELECT DISTINCT manager_id
                              FROM employee
                              WHERE manager_id IS NOT NULL 
                           )
            THEN '매니저'
            ELSE '사원'
        END 구분
FROM employee e
    LEFT JOIN department d ON e.dept_code = d.dept_id
    JOIN job j ON e.job_code = j.job_code
;

-- 96.
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;




