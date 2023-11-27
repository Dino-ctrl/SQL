set serveroutput on
set verify off
accept p_num1 prompt '첫 번째 숫자를 입력하세요 ~ '
accept p_num2 prompt '두 번째 숫자를 입력하세요 ~ '

declare
v_num1 number(10) := &p_num1;
v_num2 number(10) := &p_num2;
v_cnt number(10);
v_mod number(10);
v_result number(10);

begin

for i in reverse 1 .. v_num1 loop
v_mod := mod(v_num1, i) + mod(v_num2, i);
v_cnt := i;
exit when v_mod = 0;

end loop;

v_result := (v_num1 / v_cnt) * (v_num2 / v_cnt) * v_cnt;
dbms_output.put_line(v_result);

end; 
/
