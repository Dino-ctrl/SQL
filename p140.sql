set serveroutput on
accept p_empno prompt '사원 번호를 입력하세요 ~ '


declare
		v_sal number(10);
begin
		select sal into v_sal
		from emp
		where empno = &p_empno;

	dbms_output.put_line('해당 사원의 월급은 ' || v_sal);

end;
/