create table cancer
(발생연도 number(10),
성별 varchar2(20),
질병코드 varchar2(20),
암종 varchar2(50),
발생자수 number(10),
조발생률 number(10, 2),
연령표준화발생률 number(10, 2));

select * from cancer;


create table speech (speech_text varchar2(1000));

select * from speech;

select count(*) from speech;


create table speech2 (speech_text varchar2(1000));

select count(*) from speech2;


select regexp_substr('I never graduated from college', '[^ ]+', 1, 2) word from dual;


select regexp_substr(lower(speech_text), '[^ ]+', 1, a) word from speech2,
(select level a from dual connect by level <= 52);


select word, count(*) from (select regexp_substr(lower(speech_text), '[^ ]+', 1, a) word from speech2,
(select level a from dual connect by level <= 52))
where word is not null
group by word
order by count(*) desc;



create table positive(p_text varchar2(2000));
create table negative(n_text varchar2(2000)); 


create view speech_view as
select regexp_substr(lower(speech_text), '[^ ]+', 1, a) word from speech2,
(select level a from dual connect by level <= 52);


select count(word) as "긍정 단어" from speech_view
where lower(word) in (select lower(p_text) from positive);


select count(word) as "부정 단어" from speech_view
where lower(word) in (select lower(n_text) from negative);





