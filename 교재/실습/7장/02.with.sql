-- WITH 절
/*
    서브쿼리의 한계
    : 복잡한 조건의 조회를 서브쿼리를 이용하면,
      전체적으로 코드가 길어지고 복잡해진다.
*/

-- kor_loan_status 테이블에서
-- 연도별 최종월 기준 가장 대출이 많은 도시와 잔액 조회

-- ⓐ 연도별 최종 : 2011년 최종월은 12월, 2013년 11월
--   * 그룹쿼리로 연도별 가장 큰 월을 조회 - MAX(period)

-- ⓑ 연도별 최종월 기준, 대출잔액이 가장 큰 금액 조회
--   * ⓐ 와 조인하여, 가장 큰 잔액 - MAX(loan_jan_amt)

-- ⓒ 지역별 대출잔액, 월별 대출잔액과 ⓑ 결과와 비교하여 금액이 같은 건은 조회

SELECT a.*
FROM (
        SELECT period, region, SUM(loan_jan_amt) jan_amt
        FROM kor_loan_status
        GROUP BY period, region
     ) a -- 지역별, 월별의 기간, 지역, 대출합계
     ,
     (
        SELECT c.period, MAX(c.jan_amt) max_jan_amt -- 최종월 기준 대출잔액 최댓값
        FROM 
            (
                SELECT period, region, SUM(loan_jan_amt) jan_amt
                FROM kor_loan_status
                GROUP BY period, region
            ) c -- 기간별, 지역별 대출금액 합계
            ,
            (
                SELECT MAX(period) max_month    -- 최종월
                FROM kor_loan_status
                GROUP BY SUBSTR(period, 1, 4)   -- 연도별
            ) d -- 연도별 최종월
        WHERE c.period = d.max_month -- 기간 = 최종월
        GROUP BY c.period -- 연도별

     ) b -- 연도별 최종월 기준 대출잔액 최댓값
WHERE a.period = b.period
  AND a.jan_amt = b.max_jan_amt     --  ⓒ
ORDER BY a.period
;

-- WITH 절을 사용하여 서브쿼리를 개선
WITH
    a AS (
        SELECT period, region, SUM(loan_jan_amt) jan_amt
        FROM kor_loan_status
        GROUP BY period, region
    ),
    b AS (
        SELECT c.period, MAX(c.jan_amt) max_jan_amt -- 최종월 기준 대출잔액 최댓값
        FROM 
            (
                SELECT period, region, SUM(loan_jan_amt) jan_amt
                FROM kor_loan_status
                GROUP BY period, region
            ) c -- 기간별, 지역별 대출금액 합계
            ,
            (
                SELECT MAX(period) max_month   -- 최종월
                FROM kor_loan_status
                GROUP BY SUBSTR(period, 1, 4)   -- 연도별
            ) d -- 연도별 최종월
        WHERE c.period = d.max_month  -- 기간 = 최종월
        GROUP BY c.period
    )
SELECT a.*
  FROM a, b
WHERE a.period = b.period
  AND a.jan_amt = b.max_jan_amt
;

