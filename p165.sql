declare
v_loop number(10) := 10000;
v_coin1 number(10);
v_coin2 number(10);
v_0 number(10) := 0;
v_1 number(10) := 0;
v_2 number(10) := 0;

begin 
for i in 1 .. v_loop loop

select round(dbms_random.value(0, 1)), round(dbms_random.value(0, 1)) into v_coin1, v_coin2 from dual;

if v_coin1 = 0 and v_coin2 = 0 then
v_0 := v_0 + 1;

elsif v_coin1 = 1 and v_coin2 = 1 then
v_1 := v_1 + 1;
else
v_2 := v_2 + 1;
end if;
end loop;

dbms_output.put_line('동전 둘 다 앞면이 나올 확률 : ' || round((v_0 / v_loop), 2));
dbms_output.put_line('동전 둘 다 뒷면이 나올 확률 : ' || round((v_1 / v_loop), 2));
dbms_output.put_line('동전 둘 중 하나가 앞면, 다른 하나는 뒷면이 나올 확률 ' || round((v_2 / v_loop), 2));
end;
/
