set serveroutput on
accept p_a prompt '가로의 숫자를 입력하세요 ~ '
accept p_b prompt '세로의 숫자를 입력하세요 ~ '

begin
for i in 1 .. &p_b loop
dbms_output.put_line(lpad('★', &p_a, '★'));
end loop;
end;
/
