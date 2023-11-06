set serveroutput on
set verify off

accept p_id prompt '환자 번호를 입력하세요 ~ (예 : 845636)'

declare
v_pred varchar2(20);
v_prob number(10, 2);

begin
select prediction(wc_model using *),
prediction_probability(wc_model using *) into v_pred, v_prob
from wisc_bc_data_test
where id = '&p_id';

if v_pred = 'M' then

dbms_output.put_line('머신러닝이 예측한 결과 : 유방암 환자입니다. 유방암일 확률은 ' || round(v_prob, 2) * 100 || '%입니다.');

else
dbms_output.put_line('머신러닝이 예측한 결과 : 유방암 환자가 아닙니다. 유방암 환자가 아닐 확률은 ' || round(v_prob, 2) * 100 || '%입니다.');

end if;

end;
/
