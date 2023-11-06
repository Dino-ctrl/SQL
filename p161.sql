set serveroutput on
set verify off
accept p_arr prompt '숫자를 입력하세요 ~ ';

declare
	type arr_type is varray(10) of number(10);
	v_num_arr arr_type := arr_type(&p_arr);
	v_sum number(10, 2) := 0;
 	v_cnt number(10, 2) := 0;
	v_avg number(10, 2) := 0;
	v_var number(10, 2) := 0;

begin
	for i in 1 .. v_num_arr.count loop
	v_sum := v_sum + v_num_arr(i);
	v_cnt := v_cnt + 1;
	end loop;

	v_avg := v_sum / v_cnt;
	
	for i in 1 .. v_num_arr.count loop
	v_var := v_var + power(v_num_arr(i) - v_avg, 2);
	end loop;

v_var := v_var / v_cnt;

dbms_output.put_line('분산값은 : ' || v_var);
dbms_output.put_line('표준편차는 : ' || round(sqrt(v_var), 1));

end;
/
 