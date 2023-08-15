select upper(ename), lower(ename), initcap(ename) from emp;


SELECT ENAME, SAL from emp
where lower(ename)  = 'scott';



select substr('SMITH', 1, 3) from dual;

select substr('smith', -2, 2) from dual;

select substr('smith', 2) from dual;


select ename, length(ename) from emp;


select length('�����ٶ�') from dual;


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

INSERT INTO TEST_ENAME VALUES('����ȣ');
INSERT INTO TEST_ENAME VALUES('�Ȼ��');
INSERT INTO TEST_ENAME VALUES('�ֿ���');
COMMIT;


select replace(ename, substr(ename, 2, 1), '*') as "������_�̸�"
from test_ename;


select ename, lpad(sal, 10, '*') as salary1, rpad(sal, 10, '*') as salary2
from emp;


select ename, sal, lpad('��', round(sal/100), '��') as bar_chart from emp;


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


select '876.567' as ����, round(876.567, 1) from dual;

select '876.567' as ����, trunc(876.567, 1) from dual;

select '876.567' as ����, trunc(876.567, -1) from dual;

select '876.567' as ����, trunc(876.567, -2) from dual;

select mod(10, 3) from dual;

select empno, mod(empno, 2) from emp;

select empno, ename from emp
where mod(empno, 2) = 0;

select floor(10/3) from dual;


Select ename, months_between(sysdate, hiredate) from emp;


select to_date('2019-06-01', 'RRRR-MM-DD') - to_date('2018-10-01', 'RRRR-MM-DD')
from dual;


select round((to_date('2019-06-01', 'RRRR-MM-DD') - to_date('2018-10-01', 'RRRR-MM-DD')) / 7) as "�� �ּ�"
from dual;


SELECT ADD_MONTHS(TO_DATE('2019-05-01', 'RRRR-MM-DD'), 100) FROM DUAL;

SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + 100 FROM DUAL;

SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + INTERVAL '100' MONTH FROM DUAL;


SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + INTERVAL '1-3' YEAR(1) TO MONTH
FROM DUAL;


select to_date('2019-05-01', 'RRRR-MM-DD') + interval '3' year from dual;


SELECT TO_DATE('2019-05-01', 'RRRR-MM-DD') + TO_YMINTERVAL('03-05') AS ��¥
FROM DUAL;


SELECT '2019/05/22' AS ��¥, NEXT_DAY('2019/05/22', '������') FROM DUAL;

SELECT SYSDATE AS "���� ��¥"  FROM DUAL;

SELECT NEXT_DAY(SYSDATE, 'ȭ����') AS "���� ��¥" FROM DUAL;

SELECT NEXT_DAY(ADD_MONTHS('2019/05/22', 100), 'ȭ����') AS "���� ��¥"
FROM DUAL;


SELECT NEXT_DAY(ADD_MONTHS(SYSDATE, 100), '������') AS "���� ��¥"
FROM DUAL;


SELECT '2019/05/22' AS ��¥, LAST_DAY('2019/05/22') AS "������ ��¥" FROM DUAL;


SELECT LAST_DAY(SYSDATE) - SYSDATE AS "���� ��¥" FROM DUAL;


SELECT ENAME, HIREDATE, LAST_DAY(HIREDATE) FROM EMP
WHERE ENAME='KING';


SELECT ename, to_char(hiredate, 'DAY') as ����, to_char(sal, '999,999') as ����
from emp
where ename = 'SCOTT';


select hiredate, to_char(hiredate, 'RRRR') as ����, to_char(hiredate, 'MM') as ��,
                to_char(hiredate, 'DD') as ��, to_char(hiredate, 'DAY') as ����
from emp
where ename  = 'KING';


SELECT ename, hiredate from emp
where to_char(hiredate, 'RRRR') = '1981';


select ename as �̸�, extract(year from hiredate) as ����,
                    extract(month from hiredate) as ��,
                    extract(day from hiredate) as ����
from emp;


select ename as �̸�, to_char(sal, '999,999') as ���� from emp;

select ename as �̸�, to_char(sal*200, '999,999,999') as ���� from emp;


select ename as �̸�, to_char(sal*200, 'L999,999,999') as ���� from emp;
