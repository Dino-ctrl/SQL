set serveroutput on
set verify off
accept p_num1 prompt '밑변을 입력하세요 ~ '
accept p_num2 prompt '높이를 입력하세요 ~ '
accept p_num3 prompt '빗변을 입력하세요 ~ '

begin
if power(&p_num1, 2) + power(&p_num2, 2) = power(&p_num3, 2)
then
dbms_output.put_line('직각삼각형입니다.');
else
dbms_output.put_line('직각삼각형이 아닙니다. ');

end if;
end;
/

