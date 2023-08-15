select avg(comm) from emp;

select round(avg(nvl(comm, 0))) from emp;

select deptno, sum(sal) from emp
group by deptno;

select job, sum(sal) from emp
group by job
order by sum(sal) desc;

select job, sum(sal) from emp
group by job
having sum(sal) >= 4000;


select job, sum(sal) from emp
where job != 'SALESMAN'
group by job
having sum(sal) >= 4000;


select count(empno) from emp;

select count(comm) from emp;


select ename, job, sal, rank() over(order by sal desc) 순위 from emp
where job in('ANALYST', 'MANAGER');


select ename, sal, job, rank() over (partition by job order by sal desc) as 순위
from emp;


select ename, job, sal, rank() over (order by sal desc) as RANK,
dense_rank() over (order by sal desc) as DENSE_RANK
from emp
where job in ('ANALYST', 'MANAGER');



select job, ename, sal, dense_rank() over (partition by job order by sal desc) as 순위
from emp
where hiredate between to_date('1981/01/01', 'RRRR/MM/DD') and to_date('1981/12/31', 'RRRR/MM/DD');


select dense_rank(2975) within group (order by sal desc) 순위 from emp;


select dense_rank('81/11/17') within group (order by hiredate asc) 순위 from emp;


select ename, job, sal, ntile(4) over (order by sal desc nulls last) 등급
from emp where job in ('ANALYST', 'MANAGER', 'CLERK');


select ename, comm from emp
where deptno = 30
order by comm desc;


select ename, comm from emp
where deptno = 30
order by comm desc nulls last;



select ename, sal, rank() over (order by sal desc) as RANK,
                dense_rank() over (order by sal desc) as DENSE_RANK,
                cume_dist() over (order by sal desc) as CUM_DIST
                from emp;
                
                

select job, ename, sal, rank() over (partition by job order by sal desc) RANK,
                    cume_dist() over (partition by job order by sal desc) CUM_DIST
                    from emp;
                    
                    
select deptno, listagg(ename, ',') within group (order by ename) as EMPLOYEE
from emp
group by deptno;


select job, LISTAGG(ename, ',') within group (order by ename asc) as EMPLOYEE
from emp
group by job;



select job, LISTAGG(ename||'('||sal||')', ',') within group (order by ename asc) EMPLOYEE
from emp
group by job;



select empno, ename, sal, lag(sal, 1) over (order by sal asc) "전 행",
                        lead(sal, 1) over (order by sal asc) "다음 행"
from emp
where job in ('ANALYST', 'MANAGER');




select empno, ename, hiredate, lag(hiredate, 1) over (order by hiredate asc) "전 행",
                            lead(hiredate, 1) over (order by hiredate asc) "다음 행"
                            from emp
where job in ('ANALYST', 'MANAGER');


select deptno, empno, ename, hiredate, lag(hiredate, 1) over (partition by deptno
order by hiredate asc) "전 행",
lead(hiredate, 1) over (partition by deptno order by hiredate asc) "다음 행"
from emp;



select sum(decode(deptno, 10, sal)) as "10",
sum(decode(deptno, 20, sal)) as "20",
sum(decode(deptno, 30, sal)) as "30" from emp;



select sum(decode(job, 'ANALYST', sal)) as "ANALYST",
        sum(decode(job, 'CLERK', sal)) as "CLERK",
        sum(decode(job, 'MANAGER', sal)) as "MANAGER",
        sum(decode(job, 'SALESMAN', sal)) as "SALESMAN" from emp;
        
        

select sum(decode(job, 'ANALYST', sal)) as "ANALYST",
        sum(decode(job, 'CLERK', sal)) as "CLERK",
        sum(decode(job, 'MANAGER', sal)) as "MANAGER",
        sum(decode(job, 'SALESMAN', sal)) as "SALESMAN" from emp
        group by deptno;
        
        
        
select * from (select deptno, sal from emp)
pivot( sum(sal) for deptno in (10, 20, 30));


select * from (select job, sal from emp)
pivot( sum(sal) for job in ('ANALYST' "ANALYST", 'CLERK' "CLERK", 'MANAGER' "MANAGER", 'SALESMAN' "SALESMAN"));


drop  table order2;

create table order2
( ename  varchar2(10),
  bicycle  number(10),
  camera   number(10),
  notebook  number(10) );

insert  into  order2  values('SMITH', 2,3,1);
insert  into  order2  values('ALLEN',1,2,3 );
insert  into  order2  values('KING',3,2,2 );

commit;



select * from order2
unpivot(건수 for 아이템 in (BICYCLE, CAMERA, NOTEBOOK));


select * from order2; 



select * from order2
unpivot(건수 for 아이템 in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));


update order2 set notebook=null where ename = 'SMITH';


select * from order2
unpivot(건수 for 아이템 in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));


select * from order2
unpivot include nulls(건수 for 아이템 in (BICYCLE as 'B', CAMERA as 'C', NOTEBOOK as 'N'));


select empno, ename, sal, sum(sal) over (order by empno rows between unbounded preceding and current row) 누적치
from emp
where job in('ANALYST', 'MANAGER');



select empno, ename, sal, ratio_to_report(sal) over() as 비율
from emp
where deptno = 20;


select empno, ename, sal, ratio_to_report(sal) over() as 비율, sal/sum(sal) over() as "비교 비율"
from emp
where deptno = 20;



select job, sum(sal)
from emp
group by rollup(job);


select deptno, job, sum(sal)
from emp
group by rollup(deptno, job);


select job, sum(sal) from emp
group by cube(job);



select deptno, job, sum(sal) from emp
group by cube(deptno, job);



select deptno, job, sum(sal) from emp
group by grouping sets((deptno), (job), ());


select deptno, job, sum(sal) from emp
group by grouping sets((deptno, job), ());



select empno, ename, sal, rank() over(order by sal desc) RANK,
                    dense_rank() over (order by sal desc) DENSE_RANK,
                    row_number() over (order by sal desc) 번호
from emp
where deptno = 20;


select empno, ename, sal, row_number() over(partition by deptno order by sal desc) 번호
from emp
where deptno in (10, 20);

