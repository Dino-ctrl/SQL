drop table emp145;

create table emp145
( num  number(10),
 fruit   varchar2(10) );

insert into emp145 values (1, '���');
insert into emp145 values (2, '�ٳ���');
insert into emp145 values (3, '������');
commit;

select * from emp145;