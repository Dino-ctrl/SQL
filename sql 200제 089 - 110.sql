select rpad(' ', level*3) || ename as employee, level, sal, job from emp
start with ename = 'KING'
connect by prior empno = mgr;


select rpad(' ', level*3) || ename as employee, level, sal, job from emp
start with ename = 'KING'
connect by prior empno = mgr and ename != 'BLAKE';


select rpad(' ', level*3) || ename as employee, level, sal, job from emp
start with ename = 'KING'
connect by prior empno = mgr
order siblings by sal desc;


select rpad(' ', level*3) || ename as employee, level, sal, job from emp
start with ename = 'KING'
connect by prior empno = mgr
order by sal desc;


select ename, sys_connect_by_path(ename, '/') as path from emp
start with ename = 'KING'
connect by prior empno = mgr;


select ename, ltrim(sys_connect_by_path(ename, '/'), '/') as path from emp
start with ename = 'KING'
connect by prior empno = mgr;



create table emp01
(EMPNO number(10), 
ENAME varchar2(10),
SAL number(10, 2),
HIREDATE date);


create global temporary table emp37
( EMPNO NUMBER(10),
ENAME VARCHAR2(10),
SAL NUMBER(10))
on commit delete rows;



insert into emp37 values(1111, 'scott', 3000);
insert into emp37 values(2222, 'smith', 4000);

select * from emp37;

commit;

select * from emp37;


create view emp_view
as
select empno, ename, sal, job, deptno from emp
where job = 'SALESMAN';



select * from emp_view;



create view emp_view2 as
select deptno, round(avg(sal)) "∆Ú±’ ø˘±ﬁ"
from emp
group by deptno;


select * from emp_view2;


update emp_view2 set "∆Ú±’ ø˘±ﬁ" =3000
where deptno = 30;


create index emp_sal on emp(sal);


/* 1π¯∫Œ≈Õ 100π¯±Ó¡ˆ √‚∑¬«œ¥¬ Ω√ƒˆΩ∫ ª˝º∫«œ±‚ */
create sequence seq1
start with 1
increment by 1
maxvalue 100
nocycle;


insert into emp(empno, ename, sal, job, deptno) values(7935, 'JACKY', 3400, 'ANALYST', 20);


create table emp02
(EMPNO NUMBER(10),
ENAME VARCHAR2(10),
SAL NUMBER(10));


insert into emp02 values(seq1.nextval, 'JACK', 3500);
insert into emp02 values(seq1.nextval, 'JAMES', 4500);


select * from emp02;


select * from emp
as of timestamp(systimestamp - interval '5' minute)
where ename = 'KING';


select systimestamp from dual;

select systimestamp - interval '5' minute from dual;


select ename, sal from emp
as of timestamp '23/07/29 23:41:39' where ename = 'KING';


select name, value from v$parameter where name='undo_retention';


alter table emp enable row movement;

flashback table emp to timestamp (systimestamp - interval '5' minute);


select row_movement from user_tables where table_name = 'EMP';


flashback table emp to before drop;

DROP TABLE emp;

select original_name, DROPTIME from user_recyclebin;


flashback table emp to before drop;

select original_name, DROPTIME from user_recyclebin;


select ename, sal, versions_starttime, versions_endtime, versions_operation from emp
versions between timestamp
to_timestamp('2023-08-06 16:00:00', 'RRRR-MM-DD HH24:MI:SS') and maxvalue
where ename = 'KING'
order by versions_starttime;
/* Undo Ω√∞£ »Æ¿Œ«œ±‚ */


select systimestamp from dual;

select ename, sal, deptno from emp
where ename ='KING';

update emp set sal = 8000
where ename ='KING';

update emp set deptno = 20 where ename = 'KING';

commit;



select ename, sal, versions_starttime, versions_endtime, versions_operation from emp
versions between timestamp
to_timestamp('2023-08-06 16:13:00', 'RRRR-MM-DD HH24:MI:SS') and maxvalue
where ename = 'KING'
order by versions_starttime;


flashback table emp to timestamp (systimestamp - interval '10' minute);

commit;

select * from emp where ename = 'KING';



create table dept2
(DEPTNO number(10) constraint DEPT2_DEPTNO_PK PRIMARY KEY,
DNAME varchar2(14),
LOC varchar2(10));



select a.constraint_name, a.constraint_type, b.column_name
from user_constraints a, user_cons_columns b
where a.table_name = 'DEPT2'
and a.constraint_name = b.constraint_name;


create table dept3
(deptno number(10),
dname varchar2(14) constraint dept3_dname_un unique,
loc varchar2(10));



select a.constraint_name, a.constraint_type, b.column_name
from user_constraints a, user_cons_columns b
where a.table_name = 'DEPT3'
and a.constraint_name = b.constraint_name;


create table dept4
(DEPTNO number(10),
DNAME varchar2(13),
LOC varchar2(10));

alter table dept4 add constraint dept4_DNAME_UN unique(DNAME);


create table dept5
(deptno number(10),
dname varchar2(14),
loc varchar2(10) constraint dept5_loc_nn not null);


create table dept6
(deptno number(10),
dname varchar2(13),
loc varchar2(10));

alter table dept6
modify loc constraint dept6_loc_nn not null;



create table emp6
(empno number(10),
ename varchar2(20),
sal number(10) constraint emp6_sal_ck
check (sal between 0 and 6000));



INSERT  INTO emp6 VALUES (7839, 'KING', 5000);
INSERT  INTO emp6 VALUES (7698, 'BLAKE', 2850);
INSERT  INTO emp6 VALUES (7782, 'CLARK', 2450);
INSERT  INTO emp6 VALUES (7839, 'JONES', 2975);
COMMIT;

SELECT  * FROM emp6;

update emp6 set sal = 9000 where ename = 'CLARK';

insert into emp6 values(7566, 'ADAMS', 9000);

alter table emp6 drop constraint emp6_sal_ck;

insert into emp6 values(7566, 'ADAMS', 9000);


create table dept7
(DEPTNO number(10) constraint dept7_deptno_pk primary key,
dname varchar2(14),
loc varchar2(10));


create table emp7
(empno number(10),
ename varchar2(20),
sal number(10),
deptno number(10)
constraint emp7_deptno_fk references dept7(deptno));



with job_sumsal as (select job, sum(sal) as ≈‰≈ª from emp group by job)
select job, ≈‰≈ª from job_sumsal
where ≈‰≈ª > (select avg(≈‰≈ª) from job_sumsal);


select job, sum(sal) as ≈‰≈ª from emp
group by job
having sum(sal) > (select avg(sum(sal)) from emp group by job);


With job_sumsal as (select job, sum(sal) ≈‰≈ª from emp group by job),
deptno_sumsal as (select deptno, sum(sal) ≈‰≈ª from emp group by deptno
                    having sum(sal) > (select avg(≈‰≈ª) + 3000 from job_sumsal))
                    
select deptno, ≈‰≈ª from deptno_sumsal;

