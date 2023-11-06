-- APRIORI 알고리즘을 이용하여 연관성 분석 수행하기
drop table market_table;

create table market_table
(cust_id number(10),
stock_code number(10),
stock_name varchar2(30),
quantity number(10),
stock_price number(10, 2),
buy_date date);


select * from market_table;


-- 연관성 분석을 위한 환경 구성 테이블 생성
drop table settings_association_rules;

create table settings_association_rules
as
select *
from table (dbms_data_mining.get_default_settings)
where setting_name like 'ASSO_%';

begin
update settings_association_rules
set setting_value = 3
where setting_name = dbms_data_mining.asso_max_rule_length;

update settings_association_rules
set setting_value = 0.03
where setting_name = dbms_data_mining.asso_min_support;

update settings_association_rules
set setting_value = 0.03
where setting_name = dbms_data_mining.asso_min_confidence;

insert into settings_association_rules
values(dbms_data_mining.odms_item_id_column_name, 'stock_code');

commit;

end;
/



-- 머신러닝 모델 생성
begin
dbms_data_mining.drop_model('md_assoc_analysis');
end;
/


create or replace view vw_market_table
as
select cust_id, stock_code
from market_table;


begin
dbms_data_mining.create_model(
model_name => 'md_assoc_analysis',
mining_function => dbms_data_mining.association,
data_table_name => 'vw_market_table',
case_id_column_name => 'cust_id',
target_column_name => null,
settings_table_name => 'settings_association_rules');
end;
/



-- 머신러닝 모델 확인
select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'MD_ASSOC_ANALYSIS';


-- 머신러닝 모델 구성 정보 확인
select setting_name, setting_value
from all_mining_model_settings
where model_name = 'MD_ASSOC_ANALYSIS';


-- 모델이 분석한 연관 분석 결과 확인
select a.attribute_subname as antecedent,
c.attribute_subname as consequent,
round(rule_support, 3) as support,
round(rule_confidence, 3) as confidence,
round(rule_lift, 3) as lift
from table(dbms_data_mining.get_association_rules('md_assoc_analysis', 10)) t,
table(t.consequent) c, table(t.antecedent) a
order by support desc, lift desc;



-- 아프리오리 알고리즘을 이용하여 온라인 쇼핑 구매자에게 구매하고자 하는 상품과 연관성이 있는 상품 추천하는 모델 생성하기
drop table online_retail;

create table online_retail
(invoiceno varchar2(100),
stockcode varchar2(100),
description varchar2(200),
quantity number(10, 2),
invoicedate date,
uniprice number(10, 2),
customerid number(10, 2),
country varchar2(100));


select * from online_retail;


-- 머신러닝 환경 설정

drop table settings_association_rules2;

create table settings_association_rules2
as
select *
from table(dbms_data_mining.get_default_settings)
where setting_name like 'ASSO_%';

begin
update settings_association_rules2 set setting_value = 3
where setting_name = dbms_data_mining.asso_max_rule_length;

update settings_association_rules2 set setting_value = 0.03
where setting_name = dbms_data_mining.asso_min_support;

update settings_association_rules2 set setting_value = 0.03
where setting_name = dbms_data_mining.asso_min_confidence;

insert into settings_association_rules2
values(dbms_data_mining.odms_item_id_column_name, 'invoiceno');

commit;
end;
/





begin
dbms_data_mining.drop_model('md_assoc_analysis2');
end;
/


create or replace view vw_online_retail
as select invoiceno, stockcode from online_retail;

begin
dbms_data_mining.create_model (
model_name => 'md_assoc_analysis2',
mining_function => dbms_data_mining.association,
data_table_name => 'vw_online_retail',
case_id_column_name => 'stockcode',
target_column_name => null,
settings_table_name => 'settings_association_rules2');
end;
/



select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'MD_ASSOC_ANALYSIS2';


SELECT SETTING_NAME, SETTING_VALUE
FROM ALL_MINING_MODEL_SETTINGS
WHERE MODEL_NAME = 'MD_ASSOC_ANALYSIS2';


-- 모델이 분석한 상품 간의 연관성 확인
SELECT A.ATTRIBUTE_SUBNAME AS ANTECEDENT, C.ATTRIBUTE_SUBNAME AS CONSEQUENT,
ROUND(RULE_SUPPORT, 3) AS SUPPORT, ROUND(RULE_CONFIDENCE, 3) AS CONFIDENCE,
ROUND(RULE_LIFT, 3) AS LIFT
FROM
TABLE(DBMS_DATA_MINING.GET_ASSOCIATION_RULES('MD_ASSOC_ANALYSIS2', 10)) T,
TABLE(T.CONSEQUENT) C, TABLE(T.ANTECEDENT) A
ORDER BY SUPPORT DESC, LIFT DESC;




-- K-means 알고리즘을 이용하여 토마토가 어느 클래스에 속하는지 분류해보기

-- 학습할 테이블 생성
drop table fruit;

create table fruit
(f_id number(10),
f_name varchar2(10),
sweet number(10),
crispy number(10),
f_class varchar2(10));

insert into fruit values(1, '사과', 10, 9, '과일');
insert into fruit values(2, '베이컨', 1, 4, '단백질');
insert into fruit values(3, '바나나', 10, 1, '과일');
insert into fruit values(4, '당근', 7, 10, '채소');
insert into fruit values(5, '샐러리', 3, 10, '채소');
insert into fruit values(6, '치즈', 1, 1, '단백질');
insert into fruit values(7, '토마토', 6, 7, null);

commit;



drop table settings_km1;

create table settings_km1
as
select *
from table (dbms_data_mining.get_default_settings)
where setting_name like '%GLM%';


begin
insert into settings_km1 values(dbms_data_mining.algo_name, 'ALGO_KMEANS');

insert into settings_km1 values(dbms_data_mining.prep_auto, 'ON');

insert into settings_km1 values(dbms_data_mining.clus_num_clusters, 3);

commit;

end;
/



-- 모델 생성


begin

dbms_data_mining.create_model(
model_name => 'md_km_model1',
mining_function => dbms_data_mining.clustering,
data_table_name => 'fruit',
case_id_column_name => 'f_id',
settings_table_name => 'settings_km1');
end;
/



drop table kmeans_result1;

begin
dbms_data_mining.apply 
(model_name => 'md_km_model1',
data_table_name => 'fruit',
case_id_column_name => 'f_id',
result_table_name => 'kmeans_result1');

end;
/


-- 2중 서브쿼리문....  이걸 직접 쓰라면 못쓸듯 
select t2.f_name, t2.f_class, t1.cluster_id, t1.probability, t2.sweet, t2.crispy
from (select f_id, cluster_id, probability from(select t.*,
max(probability) over (partition by f_id order by probability desc) maxp from kmeans_result1 t)
where maxp = probability) t1, fruit t2
where t1.f_id = t2.f_id
order by cluster_id;
-- 결과를 보면 토마토 cluster_id가 5로 k-means 머신러닝 모델이 과일로 분류한 것을 확인할 수 있음




-- K-means 이용하여 미국 시카고 지역의 순찰 지역의 범위 지정해보기

-- 머신러닝 모델이 학습할 테이블 생성
drop table chicago_crime;

create table chicago_crime
(c_id number(10),
case_number varchar2(10),
crime_date varchar2(40),
primary_type varchar2(40),
description varchar2(80),
location_description varchar2(50),
arrest_yn varchar2(10),
domestic varchar2(10),
fbi_code varchar2(10),
crime_year varchar2(10),
latitude number(20, 10),
longitude number(20, 10));

select * from chicago_crime;



-- 머신러닝 구성 정보 테이블 생성
drop table settings_km2;

create table settings_km2
as
select *
from table(dbms_data_mining.get_default_settings)
where setting_name like '%GLM%';

begin

insert into settings_km2 values(dbms_data_mining.algo_name, 'ALGO_KMEANS');

insert into settings_km2 values(dbms_data_mining.prep_auto, 'ON');

insert into settings_km2 values(dbms_data_mining.clus_num_clusters, 14);

commit;

end;
/



-- 모델 생성 
begin

dbms_data_mining.drop_model('md_glm_model2');
end;
/


drop table kmeans_result2;

create or replace view vw_chicago_crime
as
select c_id, latitude, longitude from chicago_crime;


begin

dbms_data_mining.create_model (
model_name => 'md_glm_model2',
mining_function => dbms_data_mining.clustering,
data_table_name => 'vw_chicago_crime',
case_id_column_name => 'c_id',
settings_table_name => 'settings_km2');
end;
/




begin
dbms_data_mining.apply (model_name => 'md_glm_model2',
data_table_name => 'vw_chicago_crime',
case_id_column_name => 'c_id',
result_table_name => 'kmeans_result2');

end;
/



-- 군집화 결과 확인
select t1.c_id, t1.cluster_id, t1.probability, t2.latitude, t2.longitude
from (select c_id, cluster_id, probability
from (select t.*, max(probability) over(partition by c_id order by probability desc) maxp from kmeans_result2 t)
where maxp = probability) t1, chicago_crime t2
where t1.c_id = t2.c_id
order by cluster_id;


-- 14개의 군집 번호와 군집 번호별 건수를 확인하기
select t1.cluster_id, count(*)
from (select c_id, cluster_id, probability
from (select t.*, max(probability) over(partition by c_id order by probability desc) maxp from kmeans_result2 t)
where maxp = probability) t1, chicago_crime t2
where t1.c_id = t2.c_id
group by t1.cluster_id;





/*---------------------------- 부록 ----------------------------- */
/*-------------------- Kaggle 상위권에 도전하기 ------------------- */
-- 타이타닉이라 생략



