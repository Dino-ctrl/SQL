accept p_deptno prompt '부서 번호를 입력하세요 ~ '
begin
	for emp_record in (select ename, sal, deptno from emp
			    where deptno = &p_deptno) loop
	
	dbms_output.put_line(emp_record.ename || ' ' || emp_record.sal || ' ' || 				emp_record.deptno);

end loop;
end;
/
