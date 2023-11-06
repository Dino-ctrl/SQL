accept p_num1 prompt '데이터를 입력하세요 ~ '

declare

type array_t is varray(10) of varchar2(10);
v_array array_t := array_t(&p_num1);
v_cnt number(10);
v_tmp number(10);
v_max number(10) := 0;
v_tmp2 number(10);

begin
for i in 1 .. v_array.count loop
v_cnt := 1;
for j in i+1 .. v_array.count loop

if v_array(i) = v_array(j) then
v_tmp := v_array(i);
v_cnt := v_cnt + 1;

end if;
end loop;

if v_max <= v_cnt then
v_max := v_cnt;
v_tmp2 := v_tmp;

end if;
end loop;

dbms_output.put_line('최빈값은 ' || v_tmp2 || '이고 ' || v_max || '개입니다.');
end;
/
