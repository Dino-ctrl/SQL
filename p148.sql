accept p_deptno prompt '부서 번호를 입력하세요 ~ '

declare
	cursor emp_cursor is
	select ename, sal, deptno
 	from emp
	where deptno = &p_deptno;

begin
	for emp_record in emp_cursor loop
	dbms_output.put_line(emp_record.ename || ' ' || emp_record.sal || ' ' ||
	emp_record.deptno);
end loop;
end;
/

