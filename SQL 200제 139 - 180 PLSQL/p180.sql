set serveroutput on
set verify off

accept p_chills prompt '오한이 있습니까(Y/N)? '
accept p_runny_nose prompt '콧물이 있습니까(Y/N)? '
accept p_headache prompt '두통이 있습니까?(STRONG/MILD/NO)? '
accept p_fever prompt '열이 있습니까(Y/N)? '

declare
v_pred varchar2(20);
v_prob number(10, 2);

begin
with test_data as (select upper('&p_chills') chills,
upper('&p_runny_nose') runny_rose,
upper('&p_headache') headache,
upper('&p_fever') fever
from dual)

select prediction (MD_CLASSIFICATION_MODEL using  *),
prediction_probability(MD_CLASSIFICATION_MODEL using *) into v_pred, v_prob
from test_data;


if v_pred = 'Y' then
dbms_output.put_line('머신러닝이 예측한 결과 : 독감입니다. 독감일 확률은 ' || round(v_prob, 2) * 100 || '%입니다');

else
dbms_output.put_line('머신러닝이 예측한 결과 : 독감이 아닙니다. 독감이 아닐 확률은 ' || round(v_prob, 2) * 100 || '%입니다.');

end if;

end;
/

