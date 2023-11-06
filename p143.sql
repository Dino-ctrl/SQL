declare
v_count number(10) := 0;
begin
loop
v_count := v_count + 1;
dbms_output.put_line('2 x ' || v_count || ' = ' || 2*v_count);
exit when v_count = 9;
end loop;

end;
/
