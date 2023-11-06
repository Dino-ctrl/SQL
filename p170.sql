set serveroutput on
set verify off
accept p_num1 prompt '밑변의 길이를 입력하세요 : '
accept p_num2 prompt '높이를 입력하세요 : '
accept p_num3 prompt '빗변의 길이를 입력하세요 : '

declare
v_num1 number(10) := &p_num1;
v_num2 number(10) := &p_num2;
v_num3 number(10) := &p_num3;

begin
if (v_num1)**2 + (v_num2)**2 = (v_num3)**2 then
dbms_output.put_line('직각삼각형이 맞습니다');
else
dbms_output.put_line('직각삼각형이 아닙니다');

end if;
end;
/
