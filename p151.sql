create or replace function get_loc
(p_deptno in dept.deptno%type)
return dept.loc%type
is
	v_loc dept.loc%type;
begin
	select loc into v_loc
	from dept
	where deptno = p_deptno;
return v_loc;
end;
/
