set serveroutput on


declare
v_cnt number(10, 2) := 0;
v_a number(10, 2);
v_b number(10, 2);
v_pi number(10, 2);


begin
for i in 1 .. 1000000 loop
v_a := dbms_random.value(0, 1);
v_b := dbms_random.value(0, 1);

if power(v_a, 2) + power(v_b, 2) <= 1 then
v_cnt := v_cnt + 1;
end if;
end loop;

v_pi := (v_cnt / 1000000) * 4;
dbms_output.put_line(v_pi);

end;
/
