set serveroutput on
set verify off

accept p_num prompt '숫자를 입력하세요 '

declare
v_num1 number(10) := &p_num;
v_num2 number(10) := &p_num;


begin
loop
v_num1 := v_num1 - 1;
v_num2 := v_num2*v_num1;
exit when v_num1 = 1;

end loop;

dbms_output.put_line(v_num2);
end;
/
