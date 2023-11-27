declare
v_loop number(10) := 10000;
v_coin number(10);
v_0 number(10) := 0;
v_1 number(10) := 0;


begin
for i in 1 .. v_loop loop

select round(dbms_random.value(1, 2)) into v_coin from dual;

if v_coin = 1 then
v_0 := v_0 + 1;

else
v_1 := v_1 + 1;
end if;
end loop;

dbms_output.put_line('동전의 앞면이 나올 확률 : ' || round((v_0/v_loop), 2));
dbms_output.put_line('동전의 뒷면이 나올 확률 : ' || round((v_1 /v_loop), 2));
end;
/

