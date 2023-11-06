drop table emp145;

create table emp145
( num  number(10),
 fruit   varchar2(10) );

insert into emp145 values (1, '사과');
insert into emp145 values (2, '바나나');
insert into emp145 values (3, '오렌지');
commit;

select * from emp145;