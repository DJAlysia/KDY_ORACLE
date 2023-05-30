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
MAXVALUE 10000
;
