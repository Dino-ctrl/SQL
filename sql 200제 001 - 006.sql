select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp;

select dept.*, deptno from dept;


select empno as �����ȣ, ename as ����̸�, sal as "Salary"
from emp;

select ename, sal * (12 + 3000) as ����
from emp
order by ���� desc;


select ename || sal
from emp;

select ename || '�� ������ ' || sal || '�Դϴ�.' as ��������
from emp;



select ename || '�� ������ ' || job || '�Դϴ�. ' as ��������
from emp;


select distinct job
from emp;


/* distinct ���� unique�� ��밡�� */
select unique job from emp;


select ename, sal from emp
order by sal asc;

select ename, sal as ���� from emp
order by ���� asc;


select ename, deptno, sal from emp
order by deptno asc, sal desc;


select ename, deptno, sal
from emp
order by 2 asc, 3 desc;


