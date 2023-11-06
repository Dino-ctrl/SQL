set serveroutput on
set verify off

accept p_id prompt 'ȯ�� ��ȣ�� �Է��ϼ��� ~ (�� : 845636)'

declare
v_pred varchar2(20);
v_prob number(10, 2);

begin
select prediction(wc_model using *),
prediction_probability(wc_model using *) into v_pred, v_prob
from wisc_bc_data_test
where id = '&p_id';

if v_pred = 'M' then

dbms_output.put_line('�ӽŷ����� ������ ��� : ����� ȯ���Դϴ�. ������� Ȯ���� ' || round(v_prob, 2) * 100 || '%�Դϴ�.');

else
dbms_output.put_line('�ӽŷ����� ������ ��� : ����� ȯ�ڰ� �ƴմϴ�. ����� ȯ�ڰ� �ƴ� Ȯ���� ' || round(v_prob, 2) * 100 || '%�Դϴ�.');

end if;

end;
/
