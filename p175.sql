set serveroutput on
set verify off

accept p_num prompt '정렬할 5개의 숫자를 입력하세요 : '


declare

type array_t is varray(100) of number(10);
varray array_t := array_t();
v_temp number(10);


begin

varray.extend(regexp_count('&p_num', ' ')+1);

for i in 1 .. varray.count loop
varray(i) := to_number(regexp_substr('&p_num', '[^ ]+', 1, i));
end loop;

for j in 2 .. varray.count loop
for k in 1 .. j-1 loop

if varray(k) > varray(j) then
v_temp := varray(j);


for z in reverse k .. j-1 loop
varray(z+1) := varray(z);
end loop;

varray(k) := v_temp;
end if;
end loop;
end loop;

for i in 1 .. varray.count loop
dbms_output.put(varray(i) || ' ');
end loop;

dbms_output.new_line;
end;
/


