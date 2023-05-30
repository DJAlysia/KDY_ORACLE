-- note 계정생성 (system 접속)
-- note 계정생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER note IDENTIFIED BY 123456;
ALTER USER note DEFAULT TABLESPACE users;
ALTER USER note QUOTA UNLIMITED ON users;
GRANT dba TO note;

DROP USER note CASCADE;

## 덤프파일 import (CMD)
cd 덤프파일 경로
imp note/123456 file=expall.dmp log=expall.log ignore=y grants=y rows=y indexes=y full=y

-- 
SELECT *
FROM kor_loan_status;