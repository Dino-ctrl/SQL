set serveroutput on
accept p_num1 prompt '첫 번째 숫자를 입력하세요~ '
accept p_num2 prompt '두 번째 숫자를 입력하세요~ '

declare
    v_sum number(10);
begin
    v_sum := &p_num1 + &p_num2;
    
    dbms_output.put_line('총합은: '|| v_sum);
end;
/