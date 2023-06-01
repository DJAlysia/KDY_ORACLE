-- PLSQL
-- 익명 블록
SET SERVEROUTPUT ON                 -- 실행결과 출력하도록 설정
DECLARE
    vi_num NUMBER;                  -- 선언부
BEGIN
    vi_num := 100;                  -- 실행부
    DBMS_OUTPUT.PUT_LINE(vi_num);
END;
/



-- 조회 결과 변수에 대입하기 (INTO)
DECLARE
    -- vs_emp_name VARCHAR2(100);      -- 사원명
    -- vs_dept_name VARCHAR2(100);     -- 부서명
    vs_emp_name employee.emp_name%TYPE;         -- 참조형 : 테이블명.컬럼명%TYPE
    vs_dept_name department.dept_title%TYPE;    
BEGIN
    SELECT e.emp_name, d.dept_title
      INTO vs_emp_name, vs_dept_name        -- 조회결과를 변수에 대입
    FROM employee e
        ,department d
    WHERE e.dept_code = d.dept_id
      AND e.emp_id = 200;

    DBMS_OUTPUT.PUT_LINE(vs_emp_name || ' : ' || vs_dept_name);
END
;
/

-- 조건문
-- IF
DECLARE
    vn_num1 NUMBER := 10;
    vn_num2 NUMBER := 20;
BEGIN
    IF vn_num1 > vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE(vn_num1 || '이 더 큽니다');
    ELSE
        DBMS_OUTPUT.PUT_LINE(vn_num2 || '이 더 큽니다');
    END IF;
END;
/


SELECT * FROM department;
-- IF ~ ELSIF
DECLARE
    vn_dept_code department.dept_id%TYPE := 'D1';   -- 부서 ID
    vn_salary NUMBER := 0;
BEGIN

    SELECT MAX(salary)
      INTO vn_salary
      FROM employee
     WHERE dept_code = vn_dept_code;

    DBMS_OUTPUT.PUT_LINE('D1 부서 최대급여 : ' || vn_salary);

    IF vn_salary BETWEEN 1000000 AND 2000000 THEN
        DBMS_OUTPUT.PUT_LINE('1');
    ELSIF vn_salary BETWEEN 2000001 AND 3000000 THEN
        DBMS_OUTPUT.PUT_LINE('2');
    ELSE    
        DBMS_OUTPUT.PUT_LINE('3');
    END IF;
END;
/

-- CASE
DECLARE
    vn_dept_code department.dept_id%TYPE := 'D1';     -- 부서ID
    vn_salary NUMBER := 0;
BEGIN
    SELECT MAX(salary)
      INTO vn_salary
      FROM employee
     WHERE dept_code = vn_dept_code;
    DBMS_OUTPUT.PUT_LINE('D1 부서 최대급여 : ' || vn_salary);
    
    CASE WHEN vn_salary BETWEEN 1000000 AND 2000000 THEN
            DBMS_OUTPUT.PUT_LINE(1);
        WHEN vn_salary BETWEEN 2000001 AND 3000000 THEN
            DBMS_OUTPUT.PUT_LINE(2);
        ELSE
            DBMS_OUTPUT.PUT_LINE(3);
    END CASE;
END;
/


-- 반복문
-- LOOP
DECLARE
    vn_base_num NUMBER := 3;
    vn_cnt NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '=' ||
                                vn_base_num * vn_cnt);
        vn_cnt := vn_cnt + 1;

        EXIT WHEN vn_cnt > 9;
    END LOOP;
END;
/

-- WHILE LOOP
DECLARE
    vn_base_num NUMBER := 3;
    vn_cnt NUMBER := 1;
BEGIN
    WHILE vn_cnt <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '=' ||
                                vn_base_num * vn_cnt);
        vn_cnt := vn_cnt + 1;
    END LOOP;
END;
/

-- FOR LOOP
DECLARE
    vn_base_num NUMBER := 3;
BEGIN
    FOR i IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '=' ||
                                vn_base_num * i);
    END LOOP;
END;
/

-- FOR LOOP (REVERSE)
DECLARE
    vn_base_num NUMBER := 3;
BEGIN
    FOR i IN REVERSE 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '=' ||
                                vn_base_num * i);
    END LOOP;
END;
/


-- CONTINUE
DECLARE
    vn_num NUMBER := 1;
BEGIN
    FOR i IN 1..20
    LOOP
        CONTINUE WHEN MOD(i, 2) = 0;
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/

-- NULL 문
DECLARE
    vn_var VARCHAR2(10) := 'A';
BEGIN
    CASE
        WHEN vn_var = 'A' THEN
            DBMS_OUTPUT.PUT_LINE('A');
        WHEN vn_var = 'B' THEN
            DBMS_OUTPUT.PUT_LINE('B');
        ELSE
            NULL;       -- 아무것도 처리하지 않는 NULL DELETE
    END CASE;
END;
/




-- 함수 생성
-- 사원번호로 부서명을 구하는 함수
CREATE OR REPLACE FUNCTION get_dept_title( p_emp_id NUMBER )
RETURN VARCHAR2
IS  
    out_title department.dept_title%TYPE ;
BEGIN
    SELECT dept_title
      INTO out_title
      FROM employee e
          ,department d
     WHERE e.dept_code = d.dept_id
       AND e.emp_id = p_emp_id;
    RETURN out_title;
END;
/

-- SELECT 문에서 함수 실행
SELECT emp_name
      ,get_dept_title(emp_id) 부서명
FROM employee;

-- 블록에서 함수 실행
DECLARE
    result department.dept_title%TYPE;
BEGIN
    result := get_dept_title( 200 );
    DBMS_OUTPUT.PUT_LINE(result);
END;
/


-- 함수 생성2
-- 세후 급여
CREATE OR REPLACE FUNCTION func_sal_tax (
    IN_SALARY IN NUMBER
)
RETURN NUMBER
IS
    tax NUMBER := 0.10;
    result NUMBER;
BEGIN
    result := TRUNC( IN_SALARY - ( IN_SALARY * tax ), 2 );
    return result;
END;
/

SELECT emp_id, emp_name,
       salary 세전급여
       ,func_sal_tax( salary ) 세후급여
FROM employee;


-- 함수 생성
-- emp_id를 인자로 넘겨주면,
-- 사원 구분을 '매니저', '사원' 으로 반환하는 함수를 정의해보세요.
-- 함수명: get_emp_type( )
SELECT emp_id
      ,emp_name
      ,get_dept_title( emp_id )
      ,get_emp_type( emp_id )
FROM employee;

--
CREATE OR REPLACE FUNCTION get_emp_type( p_emp_id NUMBER )
RETURN VARCHAR2
IS
    result VARCHAR2(10);
BEGIN
    -- 직원 타입 조회
    SELECT
        CASE
            WHEN EXISTS (SELECT 1 FROM employee WHERE manager_id = p_emp_id)
            THEN '매니저'
            ELSE '사원'
        END
    INTO result
    FROM dual;
    
    RETURN result;
END;
/



-- 프로시저 생성
CREATE OR REPLACE PROCEDURE pro_print
IS
    V_A NUMBER := 10;
    V_B NUMBER := 20;
    V_C NUMBER;
BEGIN
    V_C := V_A + V_B;
    DBMS_OUTPUT.PUT_LINE('V_C : ' || V_C);
END;
/


SET SERVEROUTPUT ON;
-- 프로시저 실행
EXECUTE pro_print();

-- human 스키마
-- board 테이블 생성 
CREATE TABLE board (
     board_no NUMBER PRIMARY KEY
    ,title VARCHAR2(100) NOT NULL
    ,writer VARCHAR2(100) NOT NULL
    ,content VARCHAR2(2000) NULL
    ,reg_date DATE DEFAULT sysdate NOT NULL
    ,upd_date DATE DEFAULT sysdate NOT NULL
);

-- SEQ_BOARD 시퀀스 생성
CREATE SEQUENCE seq_board
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 10000;

-- 프로시저 (파라미터 사용)
-- 입력 : 사원번호, 제목, 내용
-- board 테이블에 사원명으로 글쓰기를 하는 프로그램
CREATE OR REPLACE PROCEDURE pro_emp_write
(
    IN_EMP_ID IN employee.emp_id%TYPE,
    IN_TITLE IN VARCHAR2 DEFAULT '제목없음',
    IN_CONTENT IN VARCHAR2 DEFAULT '내용없음'
) 
IS
    V_EMP_NAME employee.emp_name%TYPE;
BEGIN
    SELECT emp_name INTO V_EMP_NAME
    FROM employee
    WHERE emp_id = IN_EMP_ID;

    INSERT INTO board( board_no, title, writer, content )
    VALUES ( SEQ_BOARD.nextval, IN_TITLE, V_EMP_NAME, IN_CONTENT );
END;
/

EXECUTE pro_emp_write( '200', '제목', '내용' );
EXECUTE pro_emp_write( '206' );

SELECT * FROM board;

-- 프로시저 + 조건문
-- 사원의 업무 이력을 갱신하는 프로시저
CREATE OR REPLACE PROCEDURE pro_app_emp (
    -- 파라미터
    IN_EMP_ID IN employees.employee_id%TYPE,     -- 사원번호
    IN_JOB_ID IN jobs.job_id%TYPE,              -- 직무ID
    IN_STD_DATE IN DATE,                        -- 직무 시작일
    IN_END_DATE IN DATE                         -- 직무 종료일
)
IS
    -- 선언부
    V_DEPT_ID employees.department_id%TYPE;
    V_CNT NUMBER := 0;                          -- 업무이력 개수
BEGIN
    -- 실행부
    -- 1. 사원정보 조회
    SELECT department_id INTO V_DEPT_ID
      FROM employees
     WHERE employee_id = IN_EMP_ID;

    -- 2. 사원 테이블의 JOB_ID 수정
    -- AC_MAG --> IT_PROG
    UPDATE employees
       SET job_id = IN_JOB_ID
    WHERE employee_id = IN_EMP_ID; 

    -- 3. 직무이력 테이블에 업무이력 갱신
    -- 현재 날짜에 포함되는 직무이력 확인
    SELECT COUNT(*) INTO V_CNT
      FROM job_history
     WHERE sysdate BETWEEN start_date AND end_date
       AND employee_id = IN_EMP_ID;

    DBMS_OUTPUT.PUT_LINE('기존직무 개수 : ' || V_CNT);

    -- 해당 기간에
    -- 업무 이력이 없으면, 새로 추가
    IF V_CNT = 0 THEN
        INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
        VALUES ( IN_EMP_ID, IN_STD_DATE, IN_END_DATE, IN_JOB_ID, V_DEPT_ID );
    -- 업무 이력이 있으면, 시작일 종료일 변경
    ELSE
        UPDATE job_history
           SET start_date = IN_STD_DATE
              ,end_date = IN_END_DATE
              ,job_id = IN_JOB_ID           
         WHERE employee_id = IN_EMP_ID
           AND job_id = IN_JOB_ID;
    END IF;
END;
/


-- 
EXECUTE pro_app_emp( '200', 'IT_PROG', '2025/01/01', '2026/01/01' );
EXECUTE pro_app_emp( '200', 'MK_MAN', '2026/02/01', '2030/01/01' );

EXECUTE pro_app_emp( '103', 'AC_MGR', '2026/01/01', '2026/12/31' );
EXECUTE pro_app_emp( '103', 'IT_PROG', '2027/01/01', '2028/12/31' );

EXECUTE pro_app_emp( '103', 'IT_PROG', '2027/01/01', '2030/12/31' );

SELECT * 
FROM job_history
WHERE employee_id = 103
ORDER BY start_date ASC;

SELECT * FROM jobs;


-- OUT 파라미터로 프로시저 사용하기
CREATE OR REPLACE PROCEDURE pro_out_emp (
    IN_EMP_ID IN employee.emp_id%TYPE,
    OUT_RESULT_STR OUT CLOB
)
IS
    V_EMP employee%ROWTYPE;
    -- %ROWTYPE
    -- : 해당 테이블 또는 뷰의 컬럼들을 참조타입으로 선언
BEGIN
    SELECT * INTO V_EMP
      FROM employee
     WHERE emp_id = IN_EMP_ID;

     OUT_RESULT_STR := V_EMP.emp_id
                        || '/' || V_EMP.emp_name
                        || '/' || V_EMP.salary;
END;
/

SET SERVEROUTPUT ON;
DECLARE
    out_result_str CLOB;
BEGIN
    pro_out_emp( '200', out_result_str );
    DBMS_OUTPUT.PUT_LINE( out_result_str );
END;
/




-- 프로시저로 OUT 파라미터 2개 이상 사용하기
CREATE OR REPLACE PROCEDURE pro_out_mul (
    IN_EMP_ID IN employee.emp_id%TYPE,
    OUT_DEPT_CODE OUT employee.dept_code%TYPE,
    OUT_JOB_CODE OUT employee.job_code%TYPE
)
IS
    V_EMP employee%ROWTYPE;
BEGIN
    SELECT * INTO V_EMP
    FROM employee
    WHERE emp_id = IN_EMP_ID;

    OUT_DEPT_CODE := V_EMP.dept_code;
    OUT_JOB_CODE := V_EMP.job_code;
END;
/


-- 프로시저 호출
-- 1) 매개변수가 없거나, IN 매개변수 만 : EXECUTE 프로시저명(인자1, 인자2);
-- 2) OUT 매개변수                     : PL/SQL 블록 안에서 호출

-- EXECUTE pro_out_mul( 1, 2, 3 )     -- OUT 파라미터가 있어서, 블록 안에서 호출해야함
DECLARE
    out_dept_code employee.dept_code%TYPE;
    out_job_code employee.job_code%TYPE;
BEGIN
    pro_out_mul('200', out_dept_code, out_job_code);
    DBMS_OUTPUT.PUT_LINE( out_dept_code );
    DBMS_OUTPUT.PUT_LINE( out_job_code );
END;
/


-- 프로시저에서 예외처리
CREATE OR REPLACE PROCEDURE pro_print_emp (
    IN_EMP_ID IN employee.emp_id%TYPE
)
IS
    STR_EMP_INFO CLOB;
    V_EMP employee%ROWTYPE;
BEGIN
    SELECT * INTO V_EMP
    FROM employee
    WHERE emp_id = IN_EMP_ID;
    -- CHR(10) : 줄바꿈(엔터)
    STR_EMP_INFO := '사원정보' || CHR(10) ||
                    '사원명 : ' || V_EMP.emp_name || CHR(10) ||
                    '이메일 : ' || V_EMP.email || CHR(10) ||
                    '전화번호 : ' || V_EMP.phone;

    DBMS_OUTPUT.PUT_LINE(STR_EMP_INFO);

    EXCEPTION
        WHEN OTHERS THEN
            BEGIN
            STR_EMP_INFO := '존재하지 않는 사원ID 입니다.';
            DBMS_OUTPUT.PUT_LINE(STR_EMP_INFO);
            END;
END;
/

EXECUTE pro_print_emp('200');
-- 존재하지 않는 사원번호 (예외발생)
EXECUTE pro_print_emp('300');   

