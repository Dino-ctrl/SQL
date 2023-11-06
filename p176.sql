set serveroutput on
set verify off

accept p_num prompt '랜덤으로 생성할 숫자들의 개수를 입력하세요 ~ '
accept p_a prompt '검색할 숫자를 입력하세요 ~ '

declare

type array_t is varray(1000) of number(30);
array_s array_t := array_t();
v_cnt number(10) :=  &p_num;
v_a number(10) := &p_a;
v_chk number(10) := 0;


begin

array_s.extend(v_cnt);

for i in 1 .. v_cnt loop
array_s(i) := round(dbms_random.value(1, v_cnt));
dbms_output.put(array_s(i) || ',');
end loop;

dbms_output.new_line;

for i in array_s.first .. array_s.last loop

if v_a = array_s(i) then
v_chk := 1;
dbms_output.put(i || '번째에서 숫자 ' || v_a || '를 발견했습니다.');
end if;

end loop;

dbms_output.new_line;

if v_chk = 0 then
dbms_output.put_line('숫자를 발견하지 못했습니다.');
end if;

end;
/
