set serveroutput on
set verify off

accept p_chills prompt '������ �ֽ��ϱ�(Y/N)? '
accept p_runny_nose prompt '�๰�� �ֽ��ϱ�(Y/N)? '
accept p_headache prompt '������ �ֽ��ϱ�?(STRONG/MILD/NO)? '
accept p_fever prompt '���� �ֽ��ϱ�(Y/N)? '

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
dbms_output.put_line('�ӽŷ����� ������ ��� : �����Դϴ�. ������ Ȯ���� ' || round(v_prob, 2) * 100 || '%�Դϴ�');

else
dbms_output.put_line('�ӽŷ����� ������ ��� : ������ �ƴմϴ�. ������ �ƴ� Ȯ���� ' || round(v_prob, 2) * 100 || '%�Դϴ�.');

end if;

end;
/

