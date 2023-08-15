with loop_table as (select level as num from dual connect by level <= 9)
select '2' || 'x' || num || ' = ' || 2 * num as "2단"
from loop_table;


select level as num from dual
connect by level <= 9;


with loop_table as (select level as num from dual connect by level <= 9),
gugu_table as (select level + 1 as gugu from dual connect by level <=8)
select to_char(a.num) || 'X' || to_char(b.gugu) || ' = ' || to_char(b.gugu * a.num) as 구구단
from loop_table a, gugu_table b;



with loop_table as (select level as num from dual connect by level <= 8)
select lpad('★', num, '★') as star from loop_table;

select lpad('★', 10, '★') as star from dual;


with loop_table as (select level as num from dual connect by level <= 8)
select lpad(' ', 10-num, ' ') || lpad('★', num, '★') as "Triangle" from loop_table;




undefine 숫자1
undefine 숫자2

with loop_table as (select level as num from dual connect by level <= &숫자1)
select lpad(' ', &숫자2-num, ' ') || lpad('★', num, '★') as "Triangle" from loop_table;



undefine p_num
ACCEPT p_num prompt '숫자 입력 : '

select lpad(' ', &p_num-level, ' ') || rpad('★', level, '★') as star from dual
connect by level < &p_num+1
union all
select lpad(' ', level, ' ') || rpad('★', (&p_num)-level, '★') as star from dual
connect by level < &p_num+1;



undefine p_n1
undefine p_n2
accept p_n1 prompt '가로 숫자를 입력하세요~';
accept p_n2 prompt '세로 숫자를 입력하세요~';

with loop_table as (select level as num from dual connect by level <=&p_n2)
select lpad('★', &p_n1, '★') as star from loop_table;



undefine p_n
accept p_n prompt '숫자에 대한 값 입력 : ~';

select sum(level) as 합계 from dual connect by level <= &p_n;



undefine p_n
accept p_n prompt '숫자에 대한 값 입력 : '

select round(exp(sum(ln(level)))) 곱 from dual
connect by level <= &p_n;



undefine n
accept n prompt '숫자에 대한 값 입력 : ';

select listagg(level, ', ') as 짝수 from dual
where mod(level, 2) = 0
connect by level <= &n;



undefine p_n
accept p_n prompt '숫자에 대한 값 입력 : ';

with loop_table as (select level as num from dual connect by level <= &p_n)

select l1.num as 소수 from loop_table l1, loop_table l2
where mod(l1.num, l2.num) = 0
group by l1.num
having count(l1.num) = 2;



with loop_table as (select level as num from dual connect by level <= 10)
select l1.num, count(l1.num) from loop_table l1, loop_table l2
where mod(l1.num, l2.num) = 0
group by l1.num;




accept p_n1 prompt '첫 번째 숫자를 입력하세요.';
accept p_n2 prompt '두 번째 숫자를 입력하세요.';

with num_d as (select &p_n1 as num1, &p_n2 as num2 from dual)
select max(level) as "최대 공약수" from num_d
where mod(num1, level) = 0 and mod(num2, level) = 0
connect by level <= num2;



accept p_n1 prompt '첫 번째 숫자를 입력하세요. ';
accept p_n2 prompt '두 번째 숫자를 입력하세요. ';

with num_d as (select &p_n1 as num1, &p_n2 as num2 from dual)
select num1, num2, (num1/max(level))*(num2/max(level))*max(level) as "최소 공배수"
from num_d
where mod(num1, level) = 0 and mod(num2, level) = 0
connect by level <=  num2;



accept num1 prompt '밑변의 길이를 입력하세요 ~ '
accept num2 prompt '높이의 길이를 입력하세요 ~ '
accept num3 prompt '빗변의 길이를 입력하세요 ~ '

select case when
    (power(&num1, 2) + power(&num2, 2))  = power(&num3, 2)
    then '직각삼각형이 맞습니다'
    else '직각삼각형이 아닙니다' end as "피타고라스의 정리"
from dual;



select sum(case when (power(num1, 2) + power(num2, 2)) <= 1 then 1 else 0 end) / 100000 * 4 as 원주율
from( select dbms_random.value(0,1) as num1, dbms_random.value(0,1) as num2
        from dual connect by level < 100000);
        
        

with loop_table as (select level as num from dual connect by level <= 1000000)
select result from (select num, power((1+ 1/num), num) as result from loop_table)
where num = 1000000;


        