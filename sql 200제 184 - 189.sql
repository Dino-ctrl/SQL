-- 랜덤 포레스트로 머신러닝 환경 설정
drop table dtsettings3;

create table dtsettings3
as
select * 
from table (dbms_data_mining.get_default_settings)
where setting_name like '%GLM%';

begin 
insert into dtsettings3 values(dbms_data_mining.algo_name, 'ALGO_RANDOM_FOREST');

insert into dtsettings3 values(dbms_data_mining.prep_auto, 'ON');

commit;
end;
/


begin
dbms_data_mining.drop_model('dt_model3');
end;
/


begin
dbms_data_mining.create_model (
model_name => 'dt_model3',
mining_function => dbms_data_mining.classification,
data_table_name => 'hr_data_training',
case_id_column_name => 'emp_id',
target_column_name => 'left',
settings_table_name => 'dtsettings3');
end;
/


select model_name, algorithm, mining_function
from all_mining_models
where model_name = 'DT_MODEL3';


-- 머신러닝 모델 환경 설정 값 확인
select setting_name, setting_value
from all_mining_model_settings
where model_name = 'DT_MODEL3';



-- 실제값, 예측값, 예측 확률 출력
select emp_id, t.left 실제값, prediction (dt_model3 using *) 예측값,
round(prediction_probability (dt_model3 using * ), 2) "예측한 확률"
from hr_data_test t
where rownum < 10;



-- 머신러닝 모델 성능 확인
drop table hr_data_test_matrix_3;

create or replace view view_hr_data_test3
as
select emp_id, prediction(dt_model3 using *) predicted_value, 
prediction_probability(dt_model3 using *) probability
from hr_data_test;

set serveroutput on

declare
v_accuracy number;

begin
dbms_data_mining.compute_confusion_matrix (
accuracy => v_accuracy,
apply_result_table_name => 'view_hr_data_test3',
target_table_name => 'hr_data_test',
case_id_column_name => 'emp_id',
target_column_name => 'left',
confusion_matrix_table_name => 'hr_data_test_matrix_3',
score_column_name => 'predicted_value',
score_criterion_column_name => 'PROBABILITY',
cost_matrix_table_name => null,
apply_result_schema_name => null,
target_schema_name => null,
cost_matrix_schema_name => null,
score_criterion_type => 'PROBABILITY');

dbms_output.put_line('**** MODEL ACCURACY **** : ' || round(v_accuracy, 4));
end;
/


-- 위의 예제 성능 높이기

-- 머신러닝 환경 재구성
drop table dtsettings4;

create table dtsettings4
as
select * 
from table (dbms_data_mining.get_default_settings)
where setting_name like '%GLM%';

begin
insert into dtsettings4 values(dbms_data_mining.algo_name, 'ALGO_RANDOM_FOREST');
insert into dtsettings4 values(dbms_data_mining.prep_auto, 'ON');
insert into dtsettings4 values(dbms_data_mining.clas_max_sup_bins, 254);

commit;
end;
/

begin
dbms_data_mining.drop_model('dt_model4');
end;
/

begin
dbms_data_mining.create_model (
model_name => 'dt_model4',
mining_function => dbms_data_mining.classification,
data_table_name => 'hr_data_training',
case_id_column_name => 'emp_id',
target_column_name => 'left',
settings_table_name => 'dtsettings4');
end;
/


-- 모델 생성 확인
select * from all_mining_models
where model_name = 'DT_MODEL4';


select setting_name, setting_value
from all_mining_model_settings
where model_name = 'DT_MODEL4';



-- 모델 성능 확인
drop table hr_data_test_matrix_4;

create or replace view view_hr_data_test4
as
select emp_id, prediction(dt_model4 using *) predicted_value,
prediction_probability(dt_model4 using *) probability
from hr_data_test;

declare
v_accuracy number;
begin
dbms_data_mining.compute_confusion_matrix(
accuracy => v_accuracy,
apply_result_table_name => 'view_hr_data_test4',
target_table_name => 'hr_data_test',
case_id_column_name => 'emp_id',
target_column_name => 'left',
confusion_matrix_table_name => 'hr_data_test_matrix_4',
score_column_name => 'predicted_value',
score_criterion_column_name => 'PROBABILITY',
cost_matrix_table_name => null,
apply_result_schema_name => null,
target_schema_name => null,
cost_matrix_schema_name => null,
score_criterion_type => 'PROBABILITY');

dbms_output.put_line('**** MODEL ACCURACY **** : ' || round(v_accuracy, 4));
end;
/




-- 콘크리트 강도를 높이기 위한 재료 조합을 신경망으로 예측해보기

--머신러닝 모델을 훈련시킬 데이터 만들기
drop table concrete;

create table concrete
(c_id number(10),
cement number(20, 4),
slag number(20, 4),
ash number(20, 4),
water number(20, 4),
superplastic number(20, 4),
coarseagg number(20, 4),
fineagg number(20, 4),
age number(20, 4),
strength number(20, 4));

select * from concrete;

-- 훈련 데이터와 테스트 데이터를 9로 1로 분리

drop table concrete_train;


create table concrete_train
as
select * from concrete
where c_id < 931;

drop table cocncrete_test;

create table concrete_test
as select * from concrete
where c_id >= 931;


-- 환경 설정 테이블 생성 
drop table settings_glm;

create table settings_glm
as
select *
from table (dbms_data_mining.get_default_settings)
where setting_name like '%GLM%';

begin

insert into settings_glm(setting_name, setting_value) values (dbms_data_mining.algo_name, dbms_data_mining.algo_neural_network);

insert into settings_glm(setting_name, setting_value) values (dbms_data_mining.prep_auto, dbms_data_mining.prep_auto_on);

end;
/


-- 머신러닝 모델 생성
begin
dbms_data_mining.drop_model('md_glm_model');
end;
/

begin
dbms_data_mining.create_model (
model_name => 'md_glm_model',
mining_function => dbms_data_mining.regression,
data_table_name => 'concrete_train',
case_id_column_name => 'c_id',
target_column_name => 'strength',
settings_table_name => 'settings_glm');
end;
/


select model_name, algorithm, mining_function
from all_mining_models
where model_name ='MD_GLM_MODEL ';


-- 인공 신경망의 환경 구성 정보 확인
select setting_name, setting_value
from all_mining_model_settings
where model_name = 'MD_GLM_MODEL'
and setting_name = 'NNET_HIDDEN_LAYERS';


-- 예측 결과 확인
select c_id, strength 실제값, round(prediction(md_glm_model using * ), 2) 예측값
from concrete_test;

-- 상관관계 확인
select round(corr(predicted_value, strength), 2) 상관관계
from (
select c_id, prediction(md_glm_model using *) predicted_value, prediction_probability(md_glm_model using *) prob, strength
from concrete_test);


drop table settings_glm;

create table settings_glm
as
select *
from table (dbms_data_mining.get_default_settings)
where setting_name like '%GLM%';

begin
insert into settings_glm(setting_name, setting_value)
values(dbms_data_mining.algo_name, dbms_data_mining.ALGO_NEURAL_NETWORK);

insert into settings_glm(setting_name, setting_value)
values(dbms_data_mining.prep_auto, dbms_data_mining.prep_auto_on);

insert into settings_glm (setting_name, setting_value) 
values(dbms_data_mining.nnet_nodes_per_layer, '100, 100');

end;
/




begin
dbms_data_mining.drop_model('md_glm_model');
end;
/

begin
dbms_data_mining.create_model(model_name => 'md_glm_model',
mining_function => DBMS_DATA_MINING.REGRESSION,
data_table_name => 'concrete_train',
case_id_column_name => 'c_id',
target_column_name => 'strength',
settings_table_name => 'settings_glm');

end;
/


-- 인공신경망의 환경 구성 정보 확인
select setting_name, setting_value
from all_mining_model_settings
where model_name = 'MD_GLM_MODEL'
and setting_name in ('NNET_HIDDEN_LAYERS', 'NNET_NODES_PER_LAYER');


-- 예측결과 확인
select c_id, strength 실제값, round(prediction(md_glm_model using *), 2) 예측값
from concrete_test;


select round(corr(predicted_value, strength), 2) 상관관계
from (
select c_id, prediction(md_glm_model using *) predicted_value, 
prediction_probability(md_glm_model using *) prob,
strength
from concrete_test);

