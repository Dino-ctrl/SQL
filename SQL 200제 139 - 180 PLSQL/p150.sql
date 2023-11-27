create or replace procedure pro_ename_sal
( p_ename in emp.ename%type)
is 
	v_sal emp.sal%type;
begin
	select sal into v_sal
	from emp
	where ename = p_ename;


dbms_output.put_line(v_sal || '입니다.');

end;
/
