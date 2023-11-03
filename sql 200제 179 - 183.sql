-- Train 데이터 생성
drop table navie_flu_train;

create table navie_flu_train
(patient_id number(10),
chills varchar2(2),
runny_nose varchar(2),
headache varchar2(10),
fever varchar2(2),
flu varchar2(2));

insert into navie_flu_train values(1, 'Y', 'N', 'MILD', 'Y', 'N');
insert into navie_flu_train values(2, 'Y', 'Y', 'NO', 'N', 'Y');
insert into navie_flu_train values(3, 'Y', 'N', 'STRONG', 'Y', 'Y');
insert into navie_flu_train values(4, 'N', 'Y', 'MILD', 'Y', 'Y');
insert into navie_flu_train values(5, 'N', 'N', 'NO', 'N', 'N');
insert into navie_flu_train values(6, 'N', 'Y', 'STRONG', 'Y', 'Y');
insert into navie_flu_train values(7, 'N', 'Y', 'STRONG', 'N', 'N');
insert into navie_flu_train values(8, 'Y', 'Y', 'MILD', 'Y', 'Y');

select * from navie_flu_train;

commit;

--Test 데이터 생성

drop table navie_flu_test;

create table navie_flu_test
(patient_id number(10),
chills varchar2(2),
runny_nose varchar2(2),
headache varchar2(10),
fever varchar2(2),
flu varchar2(2));

insert into navie_flu_test values(9, 'Y', 'N', 'MILD', 'N', NULL);

select * from navie_flu_test;

commit;

-- 머신러닝 모델 환경 설정 테이블 생성

drop table settings_glm;

create table settings_glm --머신러닝 환경 구성에 필요한 정보를 저장하기 위한 테이블 생성 
as -- 데이터를 저장하기 위한 기본적인 구조만 생성
select * from table (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
where setting_name like '%GLM%';

begin
insert into settings_glm values(DBMS_DATA_MINING.ALGO_NAME, 'ALGO_NAIVE_BAYES'); 
-- 나이브 베이즈 알고리즘인 ALGO_NAIVE_BAYES으로 입력함
insert into settings_glm values(DBMS_DATA_MINING.PREP_AUTO, 'ON');
-- 나이브 베이즈 모델이 좋은 성능을 보이려면 모델을 위한 여러 가지 환경 설정 값들이 자동으로 최적화되어 세팅될 수 있도록 PREP_AUTO를 ON으로 입력

commit;
end;
/
-- 나이브 베이즈 알고리즘을 사용함을 지정하는 머신러닝 환경 설정 코드



--머신러닝 모델 생성
BEGIN 
DBMS_DATA_MINING.DROP_MODEL('MD_CLASSIFICATION_MODEL');
end;
/

begin
dbms_data_mining.create_model( --create_model 프로시저 실행
model_name => 'MD_CLASSIFICATION_MODEL', -- 이름 설정
mining_function => dbms_data_mining.classification, --분류가 목표이므로 classification으로 설정
data_table_name => 'navie_flu_train',
case_id_column_name => 'patient_id',
target_column_name => 'flu', --타켓 컬럼 설정
settings_table_name => 'settings_glm');
end;
/


--머신러닝 모델일 잘 생성되었는지 확인
select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'MD_CLASSIFICATION_MODEL'; --대소문자 구분해야 함

--나이브 베이즈 머신러닝 모델이 테스트 데이터에 대해 예측한 값을 확인

select T.*, prediction (MD_CLASSIFICATION_MODEL using *) 예측값
from navie_flu_test T;
-- 나이브 베이즈 모델은 테스트 환자를 독감이 아닌 환자(N)으로 예측


-- 위에 예제에 답변하는 PL/SQL 프로그래밍 실습
set serveroutput on
set verify off

accept p_chills prompt '오한이 있습니까(Y/N)? '
accept p_runny_nose prompt '콧물이 있습니까(Y/N)? '
accept p_headache prompt '두통이 있습니까?(STRONG/MILD/NO)? '
accept p_fever prompt '열이 있습니까(Y/N)? '

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
dbms_output.put_line('머신러닝이 예측한 결과 : 독감입니다. 독감일 확률은 ' || round(v_prob, 2) * 100 || '%입니다');

else
dbms_output.put_line('머신러닝이 예측한 결과 : 독감이 아닙니다. 독감이 아닐 확률은 ' || round(v_prob, 2) * 100 || '%입니다.');

end if;

end;
/



-- 머신러닝 패키지를 이용하여 정상 버섯과 독버섯을 분류해보기


create table mushrooms
(id number(10),
type varchar2(10),
cap_shape varchar2(10),
cap_surface varchar2(10),
cap_color varchar2(10),
bruises varchar2(10),
odor varchar2(10),
gill_attachment varchar2(10),
gill_spacing varchar2(10),
gill_size varchar2(10),
gill_color varchar2(10),
stalk_shape varchar2(10),
stalk_root varchar2(10),
stalk_surface_above_ring varchar2(10),
stalk_surface_below_ring varchar2(10),
stalk_color_above_ring varchar2(10),
stalk_color_below_ring varchar2(10),
veil_type varchar2(10),
veil_color varchar2(10),
ring_number varchar2(10),
ring_type varchar2(10),
spore_print_color varchar2(10),
population varchar2(10),
habitat varchar2(10));



select * from mushrooms;


-- 데이터 분할
drop table mushrooms_training;

create table mushrooms_training
as
select * from mushrooms
where ID < 7312;

drop table mushrooms_test;

create table mushrooms_test
as
select * from mushrooms
where ID >= 7312;


-- 머신러닝 모델 환경 설정 테이블 생성
drop table settings_glm;

create table settings_glm --데이터의 기본적인 구조만 생성
as -- 나이브 베이즈 머신러닝 환경 구성에 필요한 정보를 저장하기 위한 테이블 생성 
select * 
from table (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
where setting_name like '%GLM%';


begin
insert into settings_glm
values (DBMS_DATA_MINING.ALGO_NAME, 'ALGO_NAIVE_BAYES');

insert into settings_glm values (DBMS_DATA_MINING.PREP_AUTO, 'ON');

commit;
end;
/


-- 머신러닝 모델 생성
begin
dbms_data_mining.drop_model('md_classification_model');
end;
/

begin
dbms_data_mining.create_model(
model_name => 'md_classification_model',
mining_function => dbms_data_mining.classification,
data_table_name => 'mushrooms',
case_id_column_name => 'id',
target_column_name => 'type',
settings_table_name => 'settings_glm');
end;
/



-- 요상하게 model_name은 꼭 대문자로 써줘야 함. 소문자로 쓰면 안됨
select model_name, algorithm, creation_date, mining_function
from all_mining_models
where model_name = 'MD_CLASSIFICATION_MODEL';


select setting_name, setting_value
from all_mining_model_settings
where model_name = 'MD_CLASSIFICATION_MODEL';


-- 테스트 데이터 예측값 확인
select id, cap_shape, cap_surface, cap_color, bruises, odor, type 실제값, 
prediction(md_classification_model using *) 예측값
from mushrooms_test T
where id in (7620, 7621, 7622, 7623);


-- 나이브 베이즈 머신러닝 모델 정확도 확인
select sum(decode(p.model_predict_response, i.type, 1, 0)) / count(*) 정확도
from (select id, prediction(md_classification_model using * ) model_predict_response
from mushrooms_test T) p, mushrooms i
where p.id = i.id;




-- 의사 결정 트리로 퇴사할 것으로 예측되는 직원 예측하기

drop table hr_data;

create table hr_data
(emp_id number,
satisfaction_level number,
last_evaluation number,
number_project number,
average_montly_hours number,
time_spend_company number,
work_accident number,
left number,
promotion_last_5years number,
sales varchar2 (20),
salary varchar2 (20));


select * from hr_data;


-- 훈련 데이터와 테스트 데이터로 분리
drop table hr_data_main;

create table hr_data_main
as
select *
from hr_data;

drop table hr_data_training;

create table hr_data_training
as
select *
from hr_data_main
where emp_id < 10500;

drop table hr_data_test;

create table hr_data_test
as
select * 
from hr_data_main
where emp_id >= 10500;





-- 머신러닝 모델의 환경 설정을 위한 정보가 들어 있는 테이블 생성

drop table dtsettings;

create table dtsettings
as
select * 
from table (dbms_data_mining.get_default_settings)
where setting_name like '%GLM%';


begin
insert into dtsettings -- ALGO_NAME의 값을 ALGO_DECISION_TREE로 입력하여 의사결정 트리 머신러닝 모델을 사용하겠다고 설정
values('ALGO_NAME', 'ALGO_DECISION_TREE');

--의사결정 트리 모델의 핵심 엔진을 엔트로피 설정하기 위해 DBMS_DATA_MINING.TREE_IMPURITY_METRIC 파라미터 값을 TREE_IMPURITY_ENTROPY로 설정
insert into dtsettings
values(DBMS_DATA_MINING.TREE_IMPURITY_METRIC, 'TREE_IMPURITY_ENTROPY');

commit;
end;
/



-- 모델 생성

begin
dbms_data_mining.drop_model('dt_model');
end;
/


begin
dbms_data_mining.create_model (
model_name => 'dt_model',
mining_function => dbms_data_mining.classification,
data_table_name => 'hr_data_training',
case_id_column_name => 'emp_id',
target_column_name => 'left',
settings_table_name => 'dtsettings');
end;
/


select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'DT_MODEL'; -- 꼭 대문자로 해야 함. 이유는 알 수 없음


select setting_name, setting_value
from all_mining_model_settings
where model_name = 'DT_MODEL';


-- 실제 예측값과 예측 확률을 출력
select emp_id, t.left 실제값, prediction (dt_model using * ) 예측값,
prediction_probability (dt_model using * ) "모델이 예측한 확률"
from hr_data_test t;


-- 머신러닝 모델 성능 확인
drop table hr_data_test_matrix_2;

create or replace view view_hr_data_test
as
select emp_id, prediction(dt_model using *) predicted_value,
prediction_probability(dt_model using * ) probability
from hr_data_test;

set serveroutput on

declare
v_accuracy number;

begin
dbms_data_mining.compute_confusion_matrix (
accuracy => v_accuracy,
apply_result_table_name => 'VIEW_HR_DATA_TEST',
target_table_name => 'HR_DATA_TEST',
case_id_column_name => 'emp_id',
target_column_name => 'left',
confusion_matrix_table_name => 'hr_data_test_matrix_2',
score_column_name => 'predicted_value',
score_criterion_column_name => 'probability',
cost_matrix_table_name => NULL,
apply_result_schema_name => NULL,
target_schema_name => NULL,
cost_matrix_schema_name => NULL,
SCORE_CRITERION_TYPE       => 'PROBABILITY'); -- 어이없음 왜 대문자로 해야 인식되는거?

dbms_output.put_line('**** MODEL ACCURACY ****: ' || round(v_accuracy, 4));
end;
/



-- 의사 결정 트리를 이용하여 머신러닝 성능 높이기

-- 의사결정 모델의 환경 구성 테이블 재구성하여 생성
drop table dtsettings2;

create table dtsettings2
as
select *
from table (dbms_data_mining.get_default_settings)
where setting_name like '%GLM%';

begin
insert into dtsettings2
values('ALGO_NAME', 'ALGO_DECISION_TREE');

insert into dtsettings2
values(DBMS_DATA_MINING.TREE_IMPURITY_METRIC, 'TREE_IMPURITY_ENTROPY');

insert into dtsettings2
values(DBMS_DATA_MINING.CLAS_MAX_SUP_BINS, 10000);

insert into dtsettings2
values(DBMS_DATA_MINING.TREE_TERM_MAX_DEPTH, 20);

commit;
end;
/


-- 모델 생성
begin
dbms_data_mining.drop_model('dt_model2');
end;
/


BEGIN
   DBMS_DATA_MINING.CREATE_MODEL (
      MODEL_NAME            => 'DT_MODEL2',
      MINING_FUNCTION       => DBMS_DATA_MINING.CLASSIFICATION,
      DATA_TABLE_NAME       => 'HR_DATA_TRAINING',
      CASE_ID_COLUMN_NAME   => 'EMP_ID',
      TARGET_COLUMN_NAME    => 'LEFT',
      SETTINGS_TABLE_NAME   => 'DTSETTINGS2');
END;
/




select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'DT_MODEL2';


-- 머신러닝 성능 확인
drop table hr_data_test_matrix_2;

create or replace view view_hr_data_test2
as
select emp_id, prediction(dt_model2 using * ) predicted_value,
prediction_probability(dt_model2 using * ) probability from hr_data_test;


declare
v_accuracy number;

begin
   DBMS_DATA_MINING.COMPUTE_CONFUSION_MATRIX (
      ACCURACY           => V_ACCURACY,
      APPLY_RESULT_TABLE_NAME => 'VIEW_HR_DATA_TEST2',
      TARGET_TABLE_NAME       => 'HR_DATA_TEST',
      CASE_ID_COLUMN_NAME     => 'EMP_ID',
      TARGET_COLUMN_NAME      => 'LEFT',
      CONFUSION_MATRIX_TABLE_NAME => 'HR_DATA_TEST_MATRIX_2',
      SCORE_COLUMN_NAME       => 'PREDICTED_VALUE',
      SCORE_CRITERION_COLUMN_NAME => 'PROBABILITY',
      COST_MATRIX_TABLE_NAME      => NULL,
      APPLY_RESULT_SCHEMA_NAME    => NULL,
      TARGET_SCHEMA_NAME       => NULL,
      COST_MATRIX_SCHEMA_NAME    => NULL,
      SCORE_CRITERION_TYPE       => 'PROBABILITY');

dbms_output.put_line('**** MODEL ACCURACY **** : ' || round(v_accuracy, 4));
end;
/
