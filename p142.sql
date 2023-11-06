set serveroutput on
set verify off
accept p_ename prompt '사원 이름을 입력합니다 ~ '

declare
	v_ename emp.ename%type := upper('&p_ename');
	v_sal emp.sal%type;


begin
	select sal into v_sal
	from emp
	where ename = v_ename;

	
	if v_sal >= 3000 then
	dbms_output.put_line('고소득자입니다.');
	elsif v_sal >= 2000 then
	dbms_output.put_line('중간 소득자입니다.');
	else	
	dbms_output.put_line('저소득자입니다.');
	end if;

end;
/
