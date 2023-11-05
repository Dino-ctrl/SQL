-- 서포트 벡터 머신 알고리즘을 이용하여 종양 예측하기

-- 유방암 데이터를 저장할 테이블 생성
drop table wisc_bc_data;

create table wisc_bc_data
(id number(10),
diagnosis varchar2(5),
radius_mean number(10, 7),
texture_mean number(20, 7),
perimeter_mean number(20, 7),
area_mean number(20, 7),
smoothness_mean number(20, 7),
compactness_mean number(20, 7),
concavity_mean number(20, 7),
points_mean number(20, 7),
symmetry_mean number(20, 7),
dimension_mean number(20, 7),
radius_se number(20, 7),
texture_se number(20, 7),
perimeter_se number(20, 7),
area_se number(20, 7),
smoothness_se number(20, 7),
compactness_se number(20, 7),
concavity_se number(20, 7),
points_se number(20, 7),
symmetry_se number(20, 7),
dimension_se number(20, 7),
radius_worst number(20, 7),
texture_worst number(20, 7),
perimeter_worst number(20, 7),
area_worst number(20, 7),
smoothness_worst number(20, 7),
compactness_worst number(20, 7),
concavity_worst number(20, 7),
points_worst number(20, 7),
symmetry_worst number(20, 7),
dimension_worst number(20, 7));


select * from wisc_bc_data;


-- 유방암 데이터 훈련 데이터와 테스트 데이터로 분리
drop table wisc_bc_data_training;

create table wisc_bc_data_training
as
select *
from wisc_bc_data
where rownum < 501;

drop table wisc_bc_data_test;

create table wisc_bc_data_test
as
select * from wisc_bc_data
minus
select * from wisc_bc_data_training;


-- 머신러닝 모델 구성 정보 테이블 생성
drop table dtsettings;

create table dtsettings
as
select *
from table (dbms_data_mining.get_default_settings)
where setting_name like '%GLM%';

begin
insert into dtsettings values(dbms_data_mining.algo_name, 'ALGO_SUPPORT_VECTOR_MACHINES');
insert into dtsettings values(dbms_data_mining.prep_auto, 'ON');
insert into dtsettings values(dbms_data_mining.svms_kernel_function, 'SVMS_GAUSSIAN');

commit;
end;
/


-- 서포트 벡터 머신 모델 생성
begin
dbms_data_mining.drop_model('wc_model');
end;
/

begin
dbms_data_mining.create_model (
model_name => 'wc_model',
mining_function => dbms_data_mining.classification,
data_table_name => 'wisc_bc_data_training',
case_id_column_name => 'id',
target_column_name => 'diagnosis',
settings_table_name => 'dtsettings');
end;
/


select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'WC_MODEL';


-- 머신러닝 모델의 구성 정보 확인
select setting_name, setting_value
from all_mining_model_settings
where model_name = 'WC_MODEL';



-- 모델의 성능 정보 확인
drop table wc_data_test_matrix;

create or replace view view_wisc_bc_data_test
as
select id, diagnosis, prediction(wc_model using *) predicted_value,
prediction_probability(wc_model using *) probability
from wisc_bc_data_test;


-- 예측결과 확인
select id "환자 번호", diagnosis 실제값, predicted_value 예측값, probability "예측 확률"
from view_wisc_bc_data_test
where id in(87930, 91858, 92751, 842517, 845636);


-- 서포트 벡터 머신 모델 성능 확인
set serveroutput on

declare
v_accuracy number;

begin
dbms_data_mining.compute_confusion_matrix (
accuracy => v_accuracy, -- 정확도 저장할 변수 v_accuracy로 지정
apply_result_table_name => 'view_wisc_bc_data_test', -- 매개변수의 값으로 모델이 예측한 값과 예측 확률 데이터를 볼 수 있는 view 지정
target_table_name => 'wisc_bc_data_test',
case_id_column_name => 'id',
target_column_name => 'diagnosis',
confusion_matrix_table_name => 'wc_data_test_matrix',
score_column_name => 'predicted_value', -- 예측값 들어있는 컬럼 지정
score_criterion_column_name => 'PROBABILITY', -- 테스트 데이터 예측 값의 예측 확률이 들어 있는 컬럼 지정
cost_matrix_table_name => null,
apply_result_schema_name => null,
target_schema_name => null,
cost_matrix_schema_name => null,
score_criterion_type => 'PROBABILITY'); -- 정확도 기준 정하는 컬럼 지정

dbms_output.put_line('**** MODEL ACCURACY **** : ' || round(v_accuracy, 4)); --정확도 출력

end;
/


-- 서포트 벡터 머신 커널(엔진) 변경하기
-- 서포트 벡터 머신 모델 구성 정보 재구성


drop table dtsettings;

create table dtsettings (
setting_name varchar2(200),
setting_value varchar2(200));

begin

insert into dtsettings values(dbms_data_mining.algo_name, 'ALGO_SUPPORT_VECTOR_MACHINES');
insert into dtsettings values(dbms_data_mining.prep_auto, 'ON');
-- 서포트 벡터 머신 모델을 SVMS_LINEAR로 설정 
insert into dtsettings values(dbms_data_mining.svms_kernel_function, 'SVMS_LINEAR');

commit;
end;
/


-- 모델 생성

begin
dbms_data_mining.drop_model('wc_model');
end;
/


begin
dbms_data_mining.create_model (
model_name => 'wc_model',
mining_function => dbms_data_mining.classification,
data_table_name => 'wisc_bc_data_training',
case_id_column_name => 'id',
target_column_name => 'diagnosis',
settings_table_name => 'dtsettings');
end;
/



select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'WC_MODEL';



-- 생성된 모델의 구성 정보를 확인
select setting_name, setting_value
from all_mining_model_settings
where model_name ='WC_MODEL';



drop table wc_data_test_matrix;


create or replace view view_wisc_bc_data_test
as
select id, prediction(wc_model using *) predicted_value,
prediction_probability(wc_model using *) probability
from wisc_bc_data_test;

set serveroutput on

declare
v_accuracy number;

begin
dbms_data_mining.compute_confusion_matrix (
accuracy => v_accuracy,
apply_result_table_name => 'view_wisc_bc_data_test',
target_table_name => 'wisc_bc_data_test',
case_id_column_name => 'id',
target_column_name => 'diagnosis',
confusion_matrix_table_name => 'wc_data_test_matrix',
score_column_name => 'predicted_value',
score_criterion_column_name => 'PROBABILITY',
cost_matrix_table_name => NULL,
apply_result_schema_name => NULL,
target_schema_name => NULL,
cost_matrix_schema_name => NULL,
score_criterion_type => 'PROBABILITY');

dbms_output.put_line('**** MODEL ACCURACY **** : ' || round(v_accuracy, 4));
end;
/




-- 과목 점수를 통하여 어느 과목이 학교 입학에 영향을 주는지 회귀분석하기

-- 학생점수 테이블 생성
drop table student_score;

create table student_score
(st_id number(10),
academic number(20, 8),
sports number(30, 10),
music number(30, 10),
acceptance number(30, 10));

select * from student_score;



-- 훈련 데이터와 테스트 데이터로 분리

drop table student_score_training;

create table student_score_training
as
select *
from student_score
where st_id < 181;


drop table student_score_test;

create table student_score_test
as
select * 
from student_score
where st_id >= 181;



-- 머신러닝 모델 구성 테이블 생성
drop table settings_reg1;

create table settings_reg1
as
select *
from table (dbms_data_mining.get_default_settings)
where setting_name like '%GLM%';

begin

insert into settings_reg1 values(dbms_data_mining.algo_name, 'ALGO_GENERALIZED_LINEAR_MODEL');

insert into settings_reg1 values(dbms_data_mining.prep_scale_2dnum, 'prep_scale_range');

commit;

end;
/


-- 회귀 모델 생성

begin
dbms_data_mining.drop_model('md_reg_model1');
end;
/

begin
dbms_data_mining.create_model (
model_name => 'md_reg_model1',
mining_function => dbms_data_mining.regression,
data_table_name => 'student_score_training',
case_id_column_name => 'st_id',
target_column_name => 'acceptance',
settings_table_name => 'settings_reg1');

end;
/


select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'MD_REG_MODEL1';



SELECT SETTING_NAME, SETTING_VALUE
FROM ALL_MINING_MODEL_SETTINGS
WHERE MODEL_NAME = 'MD_REG_MODEL1';



-- 테스트 데이터에 대해 회귀분석 모델이 예측한 예측 점수 확인
SELECT ST_ID "학생 번호", ACADEMIC "학과 점수", ROUND(MUSIC, 2) "음악 점수",
SPORTS "체육 점수", ROUND(ACCEPTANCE, 2) AS "실제 점수",
ROUND(MODEL_PREDICT_RESPONSE, 2) AS "예측 점수"
FROM
(SELECT T.*, PREDICTION(MD_REG_MODEL1 USING *) MODEL_PREDICT_RESPONSE
FROM STUDENT_SCORE_TEST T);


--결정계수 확인
SELECT * FROM TABLE(DBMS_DATA_MINING.GET_MODEL_DETAILS_GLOBAL(MODEL_NAME => 'MD_REG_MODEL1'))
WHERE GLOBAL_DETAIL_NAME IN('R_SQ', 'ADJUSTED_R_SQUARE');


-- 입학점수에 영향력 준 변수가 무엇인지 확인
SELECT ATTRIBUTE_NAME, COEFFICIENT
FROM
TABLE (DBMS_DATA_MINING.GET_MODEL_DETAILS_GLM ('MD_REG_MODEL1'));



-- 미국 국민들의 의료비 지출에 영향력을 크게 미치는 요소가 무엇인지 회귀분석으로 알아보기

-- 의료비 데이터 테이블 생성

DROP TABLE INSURANCE;

CREATE TABLE INSURANCE
(ID NUMBER(10),
AGE NUMBER(3),
SEX VARCHAR2(10),
BMI NUMBER(10, 2),
CHILDREN NUMBER(2),
SMOKER VARCHAR2(10),
REGION VARCHAR2(20),
EXPENSES NUMBER(10, 2));

SELECT * FROM INSURANCE;

-- 훈련데이터와 테스트 데이터로 분리

DROP TABLE INSURANCE_TRAINING;

CREATE TABLE INSURANCE_TRAINING
AS
SELECT * FROM INSURANCE
WHERE ID < 1114;

DROP TABLE INSURANCE_TEST;

CREATE TABLE INSURANCE_TEST
AS
SELECT * FROM INSURANCE
WHERE ID >= 1114;


-- 머신러닝 모델의 환경 구성 테이블 생성
DROP TABLE SETTINGS_REG2;

CREATE TABLE SETTINGS_REG2
AS
SELECT * 
FROM TABLE (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
WHERE SETTING_NAME LIKE '%GLM%';

BEGIN
INSERT INTO SETTINGS_REG2 
VALUES (DBMS_DATA_MINING.ALGO_NAME, 'ALGO_GENERALIZED_LINEAR_MODEL');

INSERT INTO SETTINGS_REG2 
VALUES (DBMS_DATA_MINING.PREP_AUTO, 'ON');

COMMIT;

END;
/


-- 모델 생성

BEGIN
  DBMS_DATA_MINING.DROP_MODEL('MD_REG_MODEL2');
END;
/

BEGIN 

   DBMS_DATA_MINING.CREATE_MODEL(
      MODEL_NAME            => 'MD_REG_MODEL2',
      MINING_FUNCTION       => DBMS_DATA_MINING.REGRESSION,
      DATA_TABLE_NAME       => 'INSURANCE_TRAINING',
      CASE_ID_COLUMN_NAME   => 'ID',
      TARGET_COLUMN_NAME    => 'EXPENSES',
      SETTINGS_TABLE_NAME   => 'SETTINGS_REG2');
END;
/

-- 생성된 머신러닝 모델 확인
select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'MD_REG_MODEL2';


SELECT SETTING_NAME, SETTING_VALUE
FROM ALL_MINING_MODEL_SETTINGS
WHERE MODEL_NAME ='MD_REG_MODEL2';


-- 회귀분석 모델의 회귀계수 확인
SELECT ATTRIBUTE_NAME, ATTRIBUTE_VALUE, ROUND(COEFFICIENT)
FROM TABLE (DBMS_DATA_MINING.GET_MODEL_DETAILS_GLM ('MD_REG_MODEL2'));


-- 예측값 확인
SELECT ID, AGE, SEX, EXPENSES,
ROUND(PREDICTION(MD_REG_MODEL2 USING *), 2) MODEL_PREDICT_RESPONSE
FROM INSURANCE_TEST T;


-- 결정계수 값 확인
SELECT GLOBAL_DETAIL_NAME, ROUND(GLOBAL_DETAIL_VALUE, 3)
FROM
TABLE(DBMS_DATA_MINING.GET_MODEL_DETAILS_GLOBAL(MODEL_NAME => 'MD_REG_MODEL2'))
WHERE GLOBAL_DETAIL_NAME IN ('R_SQ', 'ADJUSTED_R_SQUARE');


-- 비만인 사람이 흡연까지 하게 되면 의료비가 더 증가되는지 미국 국민 데이터를 회귀분석 하여 알아보기

-- 학습 테이블에 파생변수 컬럼 추가
alter table insurance drop column bmi30;

alter table insurance add bmi30 number(10);

update insurance i
set bmi30 = (select case when bmi >= 30 and smoker = 'yes' then 1 else 0 end 
from insurance s where s.rowid = i.rowid);

commit;

select * from insurance;


-- 훈련 데이터와 테스트 데이터를 9:1로 분리

drop table insurance_training;

create table insurance_training
as
select *
from insurance
where id < 1114;

drop table insurance_test;

create table insurance_test
as
select *
from insurance
where id >= 1114;


-- 머신러닝 모델 생성
begin
dbms_data_mining.drop_model('md_reg_model3');
end;
/


begin
dbms_data_mining.create_model(
model_name => 'md_reg_model3',
mining_function => dbms_data_mining.regression,
data_table_name => 'insurance_training',
case_id_column_name => 'id',
target_column_name => 'expenses',
settings_table_name => 'settings_reg2');
end;
/


-- 생성된 모델 확인
select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'MD_REG_MODEL3';


-- 회귀 모수 확인
select attribute_name, attribute_value, round(coefficient)
from table (dbms_data_mining.get_model_details_glm ('MD_REG_MODEL3'));


-- 결정계수 확인
SELECT GLOBAL_DETAIL_NAME, ROUND(GLOBAL_DETAIL_VALUE, 3)
FROM TABLE(DBMS_DATA_MINING.GET_MODEL_DETAILS_GLOBAL(MODEL_NAME => 'MD_REG_MODEL3'))
WHERE GLOBAL_DETAIL_NAME IN ('R_SQ', 'ADJUSTED_R_SQUARE');



-- 미국 국민 의료비 데이터를 회귀분석하여 나이가 들수록 의료비가 증가하는지 알아보기

-- 기존 나이의 제곱값인 새로운 파생변수 추가
alter table insurance drop column age2;

alter table insurance add age2 number(10);

update insurance set age2 = age * age;

commit;



drop table insurance_training;

create table insurance_training
as
select *
from insurance
where id < 1114;


drop table insurance_test;

create table insurance_test
as
select *
from insurance
where id >= 1114;



-- 모델 생성
begin
dbms_data_mining.drop_model('md_reg_model4');
end;
/


begin
dbms_data_mining.create_model(
model_name => 'md_reg_model4',
mining_function => dbms_data_mining.regression,
data_table_name => 'insurance_training',
case_id_column_name => 'id',
target_column_name => 'expenses',
settings_table_name => 'settings_reg2');
end;
/


-- 모델 생성 확인
select model_name, algorithm, creation_date, mining_function
from all_mining_models
where model_name = 'MD_REG_MODEL4';



-- 회귀 계수 확인
select attribute_name, attribute_value, round(coefficient)
from
table (dbms_data_mining.get_model_details_glm ('MD_REG_MODEL4'));


-- 결정계수 확인
select global_detail_name, round(global_detail_value, 3)
from
table (dbms_data_mining.get_model_details_global(model_name => 'MD_REG_MODEL4'))
where global_detail_name in ('R_SQ', 'ADJUSTED_R_SQUARE');