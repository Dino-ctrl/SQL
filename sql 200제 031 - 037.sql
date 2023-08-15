select ename, hiredate from emp
where hiredate = TO_DATE('81/11/17', 'RR/MM/DD');

select * from nls_session_parameters
where parameter = 'NLS_DATE_FORMAT';

create table emp32
(ename varchar2(10), sal varchar2(10));

insert into emp32 values('scott', '3000');
insert into emp32 values('smith', '1200');
commit;

select ename, sal from emp32
where sal = '3000';

select ename, sal from emp32 where sal = 3000;


set autot on

select ename, sal from emp32
where sal = 3000;


select ename, comm, NVL(comm, 0) from emp;


select ename, sal, comm, sal+comm from emp
where job in ('SALESMAN', 'ANALYST');


select ename, sal, comm, NVL(comm, 0), sal+NVL(comm, 0) from emp
where job in ('SALESMAN', 'ANALYST');


select ename, sal, comm, NVL2(comm, sal + comm, sal) from emp
where job in ('SALESMAN', 'ANALYST');


select ename, deptno, DECODE(deptno, 10, 300, 20, 400, 0) as 보너스
from emp;


select empno, mod(empno, 2), decode(mod(empno, 2), 0, '짝수', 1, '홀수') as 보너스
from emp;


select ename, job, decode(job, 'SALESMAN', 5000, 2000) as 보너스 from emp;



select ename, job, sal, case when sal >= 3000 then 500
when sal >= 2000 then 300
when sal >= 1000 then 200
else 0 end as BONUS
from emp
where job in ('SALESMAN', 'ANALYST');


select ename, job, comm, case when comm is null then 500
else 0 
end as BONUS
from emp
where job in ('SALESMAN', 'ANALYST');


select ename, job, case when job in('SALESMAN', 'ANALYST') then 500
                    when job in('CLERK', 'MANAGER') then 400
                    else 0 end 
                    as 보너스 
from emp;



select max(sal) from emp;

select max(sal) from emp
where job = 'SALESMAN';


select job, max(sal) from emp
where job = 'SALESMAN'
group by job;


select deptno, max(sal) from emp
group by deptno;


select min(sal) from emp
where job='SALESMAN';


select job, min(sal) 최소값 from emp
group by job
order by 2 desc;



select nvl(min(sal), 0) from emp
where 1 = 2;


select job, min(sal) from emp
where job != 'SALESMAN'
group by job
order by min(sal) desc;

