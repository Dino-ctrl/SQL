set serveroutput on
set verify off

declare
	v_name1 emp145.fruit%type;
	v_name2 emp145.fruit%type;

begin
for i in 1 .. 3 loop
for j in 1 .. 3 loop
select fruit into v_name1 from emp145 where num = i;
select fruit into v_name2 from emp145 where num = j;
if i != j then
dbms_output.put_line(v_name1 || ' , ' || v_name2);
end if;
end loop;
end loop;

end;
/