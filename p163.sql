accept p_arr1 prompt '키를 입력하세요 ~ '
accept p_arr2 prompt '체중을 입력하세요 ~ '

declare
type arr_type is varray(10) of number(10, 2);
v_num_arr1 arr_type := arr_type(&p_arr1);
v_sum1 number(10, 2) := 0;
v_avg1 number(10, 2) := 0;


v_num_arr2 arr_type := arr_type(&p_arr2);
v_sum2 number(10, 2) := 0;
v_avg2 number(10, 2) := 0;

v_cnt number(10, 2);
cov_var number(10, 2) := 0;

v_num_arr1_var number(10, 2) := 0;
v_num_arr2_var number(10, 2) := 0;
v_corr number(10, 2);


begin

v_cnt := v_num_arr1.count;

for i in 1 .. v_num_arr1.count loop
v_sum1 := v_sum1 + v_num_arr1(i);
end loop;

v_avg1 := v_sum1 / v_cnt;

for i in 1 .. v_num_arr2.count loop
v_sum2 := v_sum2 + v_num_arr2(i);
end loop;

v_avg2 := v_sum2 / v_cnt;


for i in 1 .. v_cnt loop
cov_var := cov_var + (v_num_arr1(i) - v_avg1) * (v_num_arr2(i) - v_avg2) / v_cnt;
v_num_arr1_var := v_num_arr1_var + power(v_num_arr1(i) - v_avg1, 2);
v_num_arr2_var := v_num_arr2_var + power(v_num_arr2(i) - v_avg2, 2);
end loop;

v_corr := cov_var / sqrt(v_num_arr1_var * v_num_arr2_var);
dbms_output.put_line('상관관계는 ' || v_corr);
end;
/

