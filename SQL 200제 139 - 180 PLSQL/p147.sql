declare
	v_ename emp.ename%type;
	v_sal emp.sal%type;
	v_deptno emp.deptno%type;

	cursor emp_cursor is
	select ename, sal, deptno
	from emp
	where deptno = &p_deptno;

begin
	open emp_cursor;
	loop
	fetch emp_cursor into v_ename, v_sal, v_deptno;
	exit when emp_cursor%notfound;
	dbms_output.put_line(v_ename || ' ' || v_sal || ' ' || v_deptno);
	end loop;
close emp_cursor;

end;
/

