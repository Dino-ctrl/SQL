set serveroutput on
set verify off

accept p_satis prompt '회사 만족도는 어떻게 되시나요? 범위 : 0 ~ 1 (예 : 0.32) '
accept p_evalu prompt '마지막 근무 평가는 어떻게 되시나요? 범위 : 0 ~ 1 (예 : 0.8) '
accept p_project prompt '진행했던 프로젝트의 갯수는 어떻게 되시나요? (예 : 3)'
accept p_avg_month_hours prompt '월 평균 근무 시간은 어떻게 되시나요? (예 : 160) ' 
accept p_time_spend_comp prompt '근무년수는 어떻게 되나요? (예 : 3)'
accept p_work_acc prompt '근무하는 동안 일으킨 사고 건수는? (예 : 2) '
accept p_promo_last_5y prompt '지난 5년동안 승진한 횟수는? (예 : 2)'
prompt 'sales/product_mng/accounting/hr/it/randd/technical/management/marketing/support'
accept p_sales prompt '일하는 부서는 어디입니까? '
accept p_salary prompt '월급의 수준은? (예 : LOW/MEDIUM/HIGH) '


declare
v_pred varchar2(20);
v_prob number(10, 2);

begin
with test_data as (select upper('&p_satis') satisfaction_level,
upper('&p_evalu') last_evaluation,
upper('&p_project') number_project,
upper('&p_avg_month_hours') average_montly_hours,
upper('&p_time_spend_comp') time_spend_company,
upper('&p_work_acc') work_accident,
upper('&p_promo_last_5y') promotion_last_5years,
upper('&p_sales') sales,
upper('&p_salary') salary
from dual)


select prediction (dt_model4 using *), prediction_probability(dt_model4 using *) into v_pred, v_prob from test_data;

if v_pred = 1 then

dbms_output.put_line('머신러닝이 예측한 결과 : 퇴사할 직원입니다. 퇴사할 확률은 ' || round(v_prob, 2) * 100 || '%입니다.');

else
dbms_output.put_line('머신러닝이 예측한 결과 : 퇴사할 직원이 아닙니다. 퇴사하지 않을 확률은 ' || round(v_prob, 2) * 100 || '%입니다.');

end if;

end;
/
