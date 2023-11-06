set serveroutput on
set verify off

accept p_cement prompt '�ø�Ʈ�� �ѷ��� �Է��ϼ���. ���� : kg (���� 0 ~ 540)'
accept p_slag prompt '������ �ø�Ʈ�� �ѷ��� �Է��ϼ���. ���� : kg (���� 0 ~ 360)'
accept p_ash prompt 'ȸ���� �ѷ��� �Է��ϼ���. ���� : kg (���� : 0 ~ 195)'
accept p_water prompt '���� �ѷ��� �Է��ϼ���. ���� : kg (���� : 0 ~ 137)'
accept p_superplastic prompt '���� �������� �ѷ��� �Է��ϼ���. ���� : kg (���� : 0 ~ 32)'
accept p_coarseagg prompt '���� �ڰ��� �ѷ��� �Է��մϴ�. ���� : kg (���� : 0 ~ 1125)'
accept p_fineagg prompt '�� �ڰ��� �ѷ��� �Է��մϴ�. ���� : kg (���� : 0 ~ 594)'
accept p_age prompt '���� �Ⱓ�� �Է��մϴ�. ���� : day (���� : 0 ~ 365)'


declare
v_pred varchar2(20);

begin
with test_data as (select '&p_cement' CEMENT,
'&p_slag' SLAG,
'&p_ash' ASH,
'&p_water' WATER,
'&p_superplastic' SUPERPLASTIC,
'&p_coarseagg' COARSEAGG,
'&p_fineagg' FINEAGG,
'&p_age' AGE
from dual)


select prediction (md_glm_model using *) into v_pred
from test_data;

dbms_output.put_line('�ӽŷ��� ������ ��ũ��Ʈ ������ ' || round(v_pred, 2) || '�Դϴ�. �׽�Ʈ �������� �ִ� ������ 82.6�Դϴ�.');

end;
/
