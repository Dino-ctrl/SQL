accept p_arr prompt '숫자를 입력하세요 ~ '

declare
type arr_type is varray(10) of number(10);
v_num_arr arr_type := arr_type(&p_arr);
v_n number(10);
v_medi number(10, 2);

begin
v_n := v_num_arr.count;
if mod(v_n, 2) = 1 then
v_medi := v_num_arr((v_n+1)/2);
else
v_medi := (v_num_arr(v_n/2) + v_num_arr((v_n/2)+1))/2;
end if;
dbms_output.put_line(v_medi);
end;
/
