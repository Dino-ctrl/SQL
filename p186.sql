set serveroutput on
set verify off

accept p_satis prompt 'ȸ�� �������� ��� �ǽó���? ���� : 0 ~ 1 (�� : 0.32) '
accept p_evalu prompt '������ �ٹ� �򰡴� ��� �ǽó���? ���� : 0 ~ 1 (�� : 0.8) '
accept p_project prompt '�����ߴ� ������Ʈ�� ������ ��� �ǽó���? (�� : 3)'
accept p_avg_month_hours prompt '�� ��� �ٹ� �ð��� ��� �ǽó���? (�� : 160) ' 
accept p_time_spend_comp prompt '�ٹ������ ��� �ǳ���? (�� : 3)'
accept p_work_acc prompt '�ٹ��ϴ� ���� ����Ų ��� �Ǽ���? (�� : 2) '
accept p_promo_last_5y prompt '���� 5�⵿�� ������ Ƚ����? (�� : 2)'
prompt 'sales/product_mng/accounting/hr/it/randd/technical/management/marketing/support'
accept p_sales prompt '���ϴ� �μ��� ����Դϱ�? '
accept p_salary prompt '������ ������? (�� : LOW/MEDIUM/HIGH) '


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

dbms_output.put_line('�ӽŷ����� ������ ��� : ����� �����Դϴ�. ����� Ȯ���� ' || round(v_prob, 2) * 100 || '%�Դϴ�.');

else
dbms_output.put_line('�ӽŷ����� ������ ��� : ����� ������ �ƴմϴ�. ������� ���� Ȯ���� ' || round(v_prob, 2) * 100 || '%�Դϴ�.');

end if;

end;
/
