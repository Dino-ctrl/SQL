select rownum, empno, ename, job, sal from emp
where rownum <= 5;

select empno, ename, job, sal from emp
order by sal desc fetch first 4 rows only;


select empno, ename, job, sal from emp
order by sal desc 
fetch first 20 percent rows only;


select empno, ename, job, sal from emp
order by sal desc fetch first 2 rows with ties;


select empno, ename, job, sal from emp
order by sal desc offset 9 rows;


select empno, ename, job, sal from emp
order by sal desc offset 9 rows fetch first 2 rows only;


select ename, loc from emp, dept
where emp.deptno = dept.deptno;


select ename, loc from emp, dept;


select ename, loc, job from emp, dept
where emp.deptno = dept.deptno and emp.job = 'ANALYST';


select ename, loc, job, emp.deptno from emp, dept
where emp.deptno = dept.deptno and emp.job = 'ANALYST';


select emp.ename, dept.loc, emp.job from emp, dept
where emp.deptno = dept.deptno and emp.job = 'ANALYST';


select e.ename, d.loc,  e.job from emp e, dept d
where e.deptno = d.deptno and e.job = 'ANALYST';


select emp.ename, d.loc,  e.job from emp e, dept d
where e.deptno = d.deptno and e.job = 'ANALYST';


select e.ename, e.sal, s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal;


select * from salgrade;


select e.ename, d.loc from emp e, dept d
where e.deptno (+) = d.deptno;


select e.ename as 사원, e.job as 직업, m.ename as 관리자, m.job as 직업
from emp e, emp m
where e.mgr = m.empno and e.job = 'SALESMAN';



select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
from emp e join dept d
on (e.deptno = d.deptno)
where e.job ='SALESMAN';




select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
from emp e join dept d
using (deptno)
where e.job ='SALESMAN';




select e.ename, d.loc, s.grade 
from emp e join dept d using(deptno)
join salgrade s on (e.sal between s.losal and s.hisal);



select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
from emp e natural join dept d
where e.job = 'SALESMAN' and deptno = 30;


select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
from emp e right outer join dept d
on (e.deptno = d.deptno);



insert into emp(empno, ename, sal, job, deptno) values(8282, 'JACK', 3000, 'ANALYST', 50);


select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
from emp e left outer join dept d
on (e.deptno = d.deptno);


select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc as "부서 위치"
from emp e full outer join dept d
on (e.deptno = d.deptno);



select e.ename as 이름, e.job as 직업, e.sal as 월급, d.loc "부서 위치"
from emp e left outer join dept d
on (e.deptno = d.deptno)
union
select e.ename, e.job, e.sal, d.loc
from emp e right outer join dept d
on (e.deptno = d.deptno);



select deptno, sum(sal) from emp
group by deptno
union all
select to_number(null) as deptno, sum(sal) from emp;



create table A (COL1 NUMBER(10));
insert into a values(1);
insert into a values(2);
insert into a values(3);
insert into a values(4);
insert into a values(5);



create table B (COL1 NUMBER(10));
insert into B values(3);
insert into B values(4);
insert into B values(5);
insert into B values(6);
insert into B values(7);


select col1 from a
union all
select col1 from b;



select deptno, sum(sal) from emp
group by deptno
union
select null, sum(sal) from emp;



select col1 from a
union
select col1 from b;



select ename, sal, job, deptno from emp
where deptno in(10, 20)
intersect
select ename, sal, job, deptno from emp
where deptno in (20, 30);



select ename, sal, job, deptno from emp
where deptno in (10, 20)
MINUS
select ename, sal, job, deptno from emp
where deptno in (20, 30);


