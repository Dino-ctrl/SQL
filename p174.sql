set serveroutput on
set verify off
accept p_num prompt '정렬할 5개의 숫자를 입력하세요 : '

declare

type array_t is varray(10) of number(10);
array array_t := array_t();
tmp number := 0;
v_num varchar2(50) := '&p_num';
v_cnt number := regexp_count(v_num, ' ') + 1;

begin

array.extend(v_cnt);
dbms_output.put('정렬 전 숫자 : ');

for i in 1 .. array.count loop
array(i) := regexp_substr('&p_num', '[^ ]+', 1, i);
dbms_output.put(array(i) || ' ');

end loop;

dbms_output.new_line;

for i in 1 .. array.count - 1 loop
for j in i+1 .. array.count loop
if array(i) > array(j) then
tmp := array(i);
array(i) := array(j);
array(j) := tmp;

end if;
end loop;
end loop;
dbms_output.put('정렬 후 숫자 : ');

for i in 1.. array.count loop
dbms_output.put(array(i) || ' ');
end loop;


dbms_output.new_line;
end;
/

