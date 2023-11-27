set serveroutput on
set verify off
accept p_arr prompt '숫자를 입력하세요 ~ ';

declare
type arr_type is varray(5) of number(10);
v_num_arr arr_type := arr_type(&p_arr);
v_sum number(10) := 0;
v_cnt number(10) := 0;

begin
for i in 1 .. v_num_arr.count loop
v_sum := v_sum + v_num_arr(i);
v_cnt := v_cnt + 1;
end loop;

dbms_output.put_line(v_sum / v_cnt);

end;
/