select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp;

select dept.*, deptno from dept;


select empno as 사원번호, ename as 사원이름, sal as "Salary"
from emp;

select ename, sal * (12 + 3000) as 월급
from emp
order by 월급 desc;


select ename || sal
from emp;

select ename || '의 월급은 ' || sal || '입니다.' as 월급정보
from emp;



select ename || '의 직업은 ' || job || '입니다. ' as 직업정보
from emp;


select distinct job
from emp;


/* distinct 말고 unique도 사용가능 */
select unique job from emp;


select ename, sal from emp
order by sal asc;

select ename, sal as 월급 from emp
order by 월급 asc;


select ename, deptno, sal from emp
order by deptno asc, sal desc;


select ename, deptno, sal
from emp
order by 2 asc, 3 desc;


