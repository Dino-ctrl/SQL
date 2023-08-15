/* 서브쿼리 사용하기 */
select ename, sal from emp
where sal > (select sal from emp where ename = 'JONES');


select ename, sal from emp where sal = (select sal from emp where ename = 'SCOTT');

select ename, sal from emp
where sal = (select sal from emp where ename = 'SCOTT')
and ename != 'SCOTT';


select ename, sal from emp
where sal in (select sal from emp where job = 'SALESMAN');


select ename, sal, job from emp
where empno not in (select mgr from emp where mgr is not null);


select * from dept d
where exists (select * from emp e where e.deptno = d.deptno);

select * from dept d
where not exists (select * from emp e where e.deptno = d.deptno);



select job, sum(sal) from emp
group by job
having sum(sal) > (select sum(sal) from emp where job ='SALESMAN');


select v.ename, v.sal, v.순위
from (select ename, sal, rank() over(order by sal desc) 순위 from emp) v
where v.순위 = 1;


select ename, sal, (select max(sal) from emp where job ='SALESMAN') as "최대 월급", 
(select min(sal) from emp where job = 'SALESMAN') as "최소 월급"
from emp
where job ='SALESMAN';



update emp set sal = 3200 where ename = 'SCOTT';

update emp set sal = (select sal from emp where ename = 'KING') where ename ='SCOTT';



insert into emp(empno, ename, sal, deptno) values(1122, 'JACKY', 3000, 20);

commit;

update emp set sal = 4000 where ename = 'SCOTT';

rollback;


alter table emp add loc varchar2(10);


merge into emp e
using dept d
on(e.deptno = d.deptno)
when matched then /* 이게 merge update절 */
update set e.loc = d.loc
when not matched then /* -> merge insert절 */
insert (e.empno, e.deptno, e.loc) values (1111, d.deptno, d.loc);


select ename, sal, deptno from emp
where ename = 'JONES' for update;

update emp set sal = 9000 where ename = 'JONES';

commit;

CREATE TABLE emp2 as
       SELECT * FROM emp WHERE 1=2;

SELECT * FROM emp2;


insert into emp2 (empno, ename, sal, deptno)
select empno, ename, sal, deptno from emp
where deptno = 10;

SELECT * FROM emp2;

DROP  TABLE  emp2;


update emp set sal = (select sal from emp where ename ='ALLEN')
where job = 'SALESMAN';


UPDATE emp set (sal, comm) = (select sal, comm from emp where ename ='ALLEN')
where ename = 'SCOTT';


delete from emp where sal > (select sal from emp where ename ='SCOTT');

rollback;

select * from emp;


merge into dept d
using (select deptno, sum(sal) sumsal from emp
group by deptno) v
on (d.deptno = v.deptno)
when matched then
update set d.sumsal = v.sumsal;


alter table dept add sumsal number(10);


