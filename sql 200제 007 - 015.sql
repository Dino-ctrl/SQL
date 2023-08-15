select ename, sal, job from emp
where sal = 3000;


select ename as 이름, sal as 월급
from emp
where sal >= 3000;


select ename as 이름, sal as 월급 from emp
where 월급 >= 3000;



select ename, sal, job, hiredate, deptno from emp
where ename ='SCOTT';



select ename, hiredate from emp
where hiredate = '81/11/17';


select * from NLS_SESSION_PARAMETERS
where parameter = 'NLS_DATE_FORMAT';


alter session set nls_date_format = 'YY/MM/DD';

select ename, sal from emp
where hiredate = '81/11/17';


alter session set nls_date_format = 'RR/MM/DD';



select ename, sal from emp
where hiredate = '81/11/17';



select ename, sal*12 as 연봉 from emp
where sal*12 >= 36000;



select ename, sal, comm, sal + comm
from emp
where deptno = 10;


select sal + NVL(comm, 0)
from emp
where ename = 'KING';


select ename, sal, job, deptno from emp
where sal <= 1200;


select ename, sal from emp
where sal between 1000 and 3000;

select ename, sal from emp
where (sal >= 1000 and sal <= 3000);


SELECT ename, sal from emp
where sal not between 1000 and 3000;


select ename, sal from emp
where (sal < 1000 or sal > 3000);

select ename, hiredate from emp
where hiredate between '1982/01/10' and '1982/12/31';


select ename, sal from emp
where ename like 'S%';


select ename from emp
where ename like '_M%';


select ename from emp
where ename like '%T';


select ename from emp
where ename like '%A%';


select ename, comm from emp
where comm is null;


select ename, sal, job from emp
where job in ('SALESMAN', 'ANALYST', 'MANAGER');


select ename, sal, job from emp
where (job = 'SALESMAN' or job = 'ANALYST' or job = 'MANAGER');


select ename, sal, job from emp
where job not in ('SALESMAN', 'ANALYST', 'MANAGER');



select ename, sal, job from emp
where (job != 'SALESMAN' AND JOB != 'ANALYST' AND JOB != 'MANAGER');



select ename, sal, job from emp
where job = 'SALESMAN' and sal >= 1200;


select ename, sal, job from emp
where job = 'ABCDEFG' and sal >= 1200;



