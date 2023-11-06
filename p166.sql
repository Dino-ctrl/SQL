create or replace function mybin
(p_h in number)
return number
is
v_h number(10) := p_h;
v_sim number(10) := 100000;
v_cnt number(10) := 0;
v_cnt2 number(10) := 0;
v_res number(10, 2);


begin
for n in 1..v_sim loop
v_cnt := 0;
for i in 1..10 loop
if dbms_random.value < 0.5 then
v_cnt := v_cnt + 1;
end if;
end loop;
if v_cnt = v_h then
v_cnt2 := v_cnt2 + 1;
end if;
end loop;

v_res := v_cnt2 / v_sim;
return v_res;
end;
/

