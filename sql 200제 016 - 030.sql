select upper(ename), lower(ename), initcap(ename) from emp;


SELECT ENAME, SAL from emp
where lower(ename)  = 'scott';



select substr('SMITH', 1, 3) from dual;

select substr('smith', -2, 2) from dual;

select substr('smith', 2) from dual;


select ename, length(ename) from emp;


select length('가나다라마') from dual;


select instr('SMITH', 'M') FROM DUAL;


select instr('abcdefg@naver.com', '@') from dual;

select substr('abcdefg@naver.com', instr('abcdefg@naver.com', '@')+1)
from dual;

select rtrim(substr('abcdefg@naver.com', instr('abcdefg@naver.com', '@')+1), '.com')
from dual;



select ename, replace(sal, 0, '*') from emp;


select ename, regexp_replace(sal, '[0-3]', '*') as salary from emp;



create table TEST_ENAME
(ENAME VARCHAR2(10));

INSERT INTO TEST_ENAME VALUES('김인호');
INSERT INTO TEST_ENAME VALUES('안상수');
INSERT INTO TEST_ENAME VALUES('최영희');
COMMIT;


select replace(ename, substr(ename, 2, 1), '*') as "전광판_이름"
from test_ename;


select ename, lpad(sal, 10, '*') as salary1, rpad(sal, 10, '*') as salary2
from emp;


select ename, sal, lpad('■', round(sal/100), '■') as bar_chart from emp;


select 'smith', ltrim('smith', 's'), rtrim('smith', 'h'), trim('s' from 'smiths')
from dual;


insert into emp(empno, ename, sal, job, deptno) values(8291, 'JACK ', 3000,
'SALESMAN', 30);
commit;

select ename, sal from emp
where ename = 'JACK';

select ename, sal from emp
where trim(ename) = 'JACK';


delete from emp where trim(ename)='JACK';
commit;


select '876.567' as 숫자, round(876.567, 1) from dual;

select '876.567' as 숫자, trunc(876.567, 1) from dual;

select '876.567' as 숫자, trunc(876.567, -1) from dual;

select '876.567' as 숫자, trunc(876.567, -2) from dual;

select mod(10, 3) from dual;

select empno, mod(empno, 2) from emp;

select empno, ename from emp
where mod(empno, 2) = 0;

select floor(10/3) from dual;


Select ename, months_between(sysdate, hiredate) from emp;


select to_date('2019-06-01', 'RRRR-MM-DD') - to_date('2018-10-01', 'RRRR-MM-DD')
from dual;


select round((to_date('2019-06-01', 'RRRR-MM-DD') - to_date('2018-10-01', 'RRRR-MM-DD')) / 7) as "총 주수"
from dual;


SELECT ADD_MONTHS(TO_DATE('2019-05-01', 'RRRR-MM-DD'), 100) FROM DUAL;

SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + 100 FROM DUAL;

SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + INTERVAL '100' MONTH FROM DUAL;


SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + INTERVAL '1-3' YEAR(1) TO MONTH
FROM DUAL;


select to_date('2019-05-01', 'RRRR-MM-DD') + interval '3' year from dual;


SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + TO_YMINTERVAL('03-05') AS 날짜
FROM DUAL;


SELECT '2019/05/22' AS 날짜, NEXT_DAY('2019/05/22', '월요일') FROM DUAL;

SELECT SYSDATE AS "오늘 날짜"  FROM DUAL;

SELECT NEXT_DAY(SYSDATE, '화요일') AS "다음 날짜" FROM DUAL;

SELECT NEXT_DAY(ADD_MONTHS('2019/05/22', 100), '화요일') AS "다음 날짜"
FROM DUAL;


SELECT NEXT_DAY(ADD_MONTHS(SYSDATE, 100), '월요일') AS "다음 날짜"
FROM DUAL;


SELECT '2019/05/22' AS 날짜, LAST_DAY('2019/05/22') AS "마지막 날짜" FROM DUAL;


SELECT LAST_DAY(SYSDATE) - SYSDATE AS "남은 날짜" FROM DUAL;


SELECT ENAME, HIREDATE, LAST_DAY(HIREDATE) FROM EMP
WHERE ENAME='KING';


SELECT ename, to_char(hiredate, 'DAY') as 요일, to_char(sal, '999,999') as 월급
from emp
where ename = 'SCOTT';


select hiredate, to_char(hiredate, 'RRRR') as 연도, to_char(hiredate, 'MM') as 달,
                to_char(hiredate, 'DD') as 일, to_char(hiredate, 'DAY') as 요일
from emp
where ename  = 'KING';


SELECT ename, hiredate from emp
where to_char(hiredate, 'RRRR') = '1981';


select ename as 이름, extract(year from hiredate) as 연도,
                    extract(month from hiredate) as 달,
                    extract(day from hiredate) as 요일
from emp;


select ename as 이름, to_char(sal, '999,999') as 월급 from emp;

select ename as 이름, to_char(sal*200, '999,999,999') as 월급 from emp;


select ename as 이름, to_char(sal*200, 'L999,999,999') as 월급 from emp;
