set serveroutput on

accept p_num prompt '숫자를 입력하세요 ~' 

declare
v_cnt number(10) := 0;

begin
while v_cnt < &p_num loop
v_cnt := v_cnt + 1;
dbms_output.put_line(lpad('★', v_cnt, '★'));
end loop;

end;
/
