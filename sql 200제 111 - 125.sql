with loop_table as (select level as num from dual connect by level <= 9)
select '2' || 'x' || num || ' = ' || 2 * num as "2��"
from loop_table;


select level as num from dual
connect by level <= 9;


with loop_table as (select level as num from dual connect by level <= 9),
gugu_table as (select level + 1 as gugu from dual connect by level <=8)
select to_char(a.num) || 'X' || to_char(b.gugu) || ' = ' || to_char(b.gugu * a.num) as ������
from loop_table a, gugu_table b;



with loop_table as (select level as num from dual connect by level <= 8)
select lpad('��', num, '��') as star from loop_table;

select lpad('��', 10, '��') as star from dual;


with loop_table as (select level as num from dual connect by level <= 8)
select lpad(' ', 10-num, ' ') || lpad('��', num, '��') as "Triangle" from loop_table;




undefine ����1
undefine ����2

with loop_table as (select level as num from dual connect by level <= &����1)
select lpad(' ', &����2-num, ' ') || lpad('��', num, '��') as "Triangle" from loop_table;



undefine p_num
ACCEPT p_num prompt '���� �Է� : '

select lpad(' ', &p_num-level, ' ') || rpad('��', level, '��') as star from dual
connect by level < &p_num+1
union all
select lpad(' ', level, ' ') || rpad('��', (&p_num)-level, '��') as star from dual
connect by level < &p_num+1;



undefine p_n1
undefine p_n2
accept p_n1 prompt '���� ���ڸ� �Է��ϼ���~';
accept p_n2 prompt '���� ���ڸ� �Է��ϼ���~';

with loop_table as (select level as num from dual connect by level <=&p_n2)
select lpad('��', &p_n1, '��') as star from loop_table;



undefine p_n
accept p_n prompt '���ڿ� ���� �� �Է� : ~';

select sum(level) as �հ� from dual connect by level <= &p_n;



undefine p_n
accept p_n prompt '���ڿ� ���� �� �Է� : '

select round(exp(sum(ln(level)))) �� from dual
connect by level <= &p_n;



undefine n
accept n prompt '���ڿ� ���� �� �Է� : ';

select listagg(level, ', ') as ¦�� from dual
where mod(level, 2) = 0
connect by level <= &n;



undefine p_n
accept p_n prompt '���ڿ� ���� �� �Է� : ';

with loop_table as (select level as num from dual connect by level <= &p_n)

select l1.num as �Ҽ� from loop_table l1, loop_table l2
where mod(l1.num, l2.num) = 0
group by l1.num
having count(l1.num) = 2;



with loop_table as (select level as num from dual connect by level <= 10)
select l1.num, count(l1.num) from loop_table l1, loop_table l2
where mod(l1.num, l2.num) = 0
group by l1.num;




accept p_n1 prompt 'ù ��° ���ڸ� �Է��ϼ���.';
accept p_n2 prompt '�� ��° ���ڸ� �Է��ϼ���.';

with num_d as (select &p_n1 as num1, &p_n2 as num2 from dual)
select max(level) as "�ִ� �����" from num_d
where mod(num1, level) = 0 and mod(num2, level) = 0
connect by level <= num2;



accept p_n1 prompt 'ù ��° ���ڸ� �Է��ϼ���. ';
accept p_n2 prompt '�� ��° ���ڸ� �Է��ϼ���. ';

with num_d as (select &p_n1 as num1, &p_n2 as num2 from dual)
select num1, num2, (num1/max(level))*(num2/max(level))*max(level) as "�ּ� �����"
from num_d
where mod(num1, level) = 0 and mod(num2, level) = 0
connect by level <=  num2;



accept num1 prompt '�غ��� ���̸� �Է��ϼ��� ~ '
accept num2 prompt '������ ���̸� �Է��ϼ��� ~ '
accept num3 prompt '������ ���̸� �Է��ϼ��� ~ '

select case when
    (power(&num1, 2) + power(&num2, 2))  = power(&num3, 2)
    then '�����ﰢ���� �½��ϴ�'
    else '�����ﰢ���� �ƴմϴ�' end as "��Ÿ����� ����"
from dual;



select sum(case when (power(num1, 2) + power(num2, 2)) <= 1 then 1 else 0 end) / 100000 * 4 as ������
from( select dbms_random.value(0,1) as num1, dbms_random.value(0,1) as num2
        from dual connect by level < 100000);
        
        

with loop_table as (select level as num from dual connect by level <= 1000000)
select result from (select num, power((1+ 1/num), num) as result from loop_table)
where num = 1000000;


        