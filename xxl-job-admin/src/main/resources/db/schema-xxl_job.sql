DROP TABLE IF EXISTS xxl_job_qrtz_trigger_info;
DROP TABLE IF EXISTS xxl_job_qrtz_trigger_log;
DROP TABLE IF EXISTS xxl_job_qrtz_trigger_logglue;
DROP TABLE IF EXISTS xxl_job_qrtz_trigger_registry;
DROP TABLE IF EXISTS xxl_job_qrtz_trigger_group;

DROP INDEX IF EXISTS I_trigger_time;
DROP INDEX IF EXISTS I_handle_code;

DROP SEQUENCE IF EXISTS seq_xxl_job_qrtz_trigger_info;
DROP SEQUENCE IF EXISTS seq_xxl_job_qrtz_trigger_log;
DROP SEQUENCE IF EXISTS seq_xxl_job_qrtz_trigger_logglue;
DROP SEQUENCE IF EXISTS seq_xxl_job_qrtz_trigger_registry;
DROP SEQUENCE IF EXISTS seq_xxl_job_qrtz_trigger_group;

CREATE TABLE XXL_JOB_QRTZ_TRIGGER_INFO (
  id int8 NOT NULL,
  job_group int8 NOT NULL,
  job_cron varchar(128) NOT NULL,
  job_desc varchar(255) NOT NULL,
  add_time timestamp without time zone DEFAULT NULL,
  update_time timestamp without time zone DEFAULT NULL,
  author varchar(64) DEFAULT NULL,
  alarm_email varchar(255) DEFAULT NULL,
  executor_route_strategy varchar(50) DEFAULT NULL,
  executor_handler varchar(255) DEFAULT NULL,
  executor_param varchar(512) DEFAULT NULL,
  executor_block_strategy varchar(50) DEFAULT NULL,
  executor_timeout int8 NOT NULL DEFAULT '0',
  executor_fail_retry_count int8 NOT NULL DEFAULT '0',
  glue_type varchar(50) NOT NULL,
  glue_source text,
  glue_remark varchar(128) DEFAULT NULL,
  glue_updatetime timestamp without time zone DEFAULT NULL,
  child_jobid varchar(255) DEFAULT NULL,
  PRIMARY KEY (id)
);

COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.job_group IS '执行器主键ID';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.job_cron IS '任务执行CRON';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.author IS '作者';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.alarm_email IS '报警邮件';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.executor_route_strategy IS '执行器路由策略';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.executor_handler IS '执行器任务handler';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.executor_param IS '执行器任务参数';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.executor_block_strategy IS '阻塞处理策略';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.executor_timeout IS '任务执行超时时间，单位秒';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.executor_fail_retry_count IS '失败重试次数';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.glue_type IS 'GLUE类型';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.glue_source IS 'GLUE源代码';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.glue_remark IS 'GLUE备注';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.glue_updatetime IS 'GLUE更新时间';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_INFO.child_jobid IS '子任务ID，多个逗号分隔';

CREATE TABLE XXL_JOB_QRTZ_TRIGGER_LOG (
  id int8 NOT NULL,
  job_group int8 NOT NULL,
  job_id int8 NOT NULL,
  executor_address varchar(255) DEFAULT NULL,
  executor_handler varchar(255) DEFAULT NULL,
  executor_param varchar(512) DEFAULT NULL,
  executor_sharding_param varchar(20) DEFAULT NULL,
  executor_fail_retry_count int8 NOT NULL DEFAULT '0',
  trigger_time timestamp without time zone DEFAULT NULL,
  trigger_code int8 NOT NULL,
  trigger_msg text,
  handle_time timestamp without time zone DEFAULT NULL,
  handle_code int8 NOT NULL,
  handle_msg text,
  alarm_status int4 NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
);

COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.job_group IS '执行器主键ID';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.job_id IS '任务，主键ID';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.executor_address IS '执行器地址，本次执行的地址';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.executor_handler IS '执行器任务handler';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.executor_param IS '执行器任务参数';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.executor_sharding_param IS '执行器任务分片参数，格式如 1/2';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.executor_fail_retry_count IS '失败重试次数';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.trigger_time IS '调度-时间';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.trigger_code IS '调度-结果';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.trigger_msg IS '调度-日志';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.handle_time IS '执行-时间';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.handle_code IS '执行-状态';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.handle_msg IS '执行-日志';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOG.alarm_status IS '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';

CREATE TABLE XXL_JOB_QRTZ_TRIGGER_LOGGLUE (
  id int8 NOT NULL,
  job_id int8 NOT NULL,
  glue_type varchar(50) DEFAULT NULL,
  glue_source text,
  glue_remark varchar(128) NOT NULL,
  add_time timestamp without time zone DEFAULT NULL,
  update_time timestamp without time zone DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOGGLUE.job_id IS '任务，主键ID';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOGGLUE.glue_type IS 'GLUE类型';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOGGLUE.glue_source IS 'GLUE源代码';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_LOGGLUE.glue_remark IS 'GLUE备注';


CREATE TABLE XXL_JOB_QRTZ_TRIGGER_REGISTRY (
  id int8 NOT NULL,
  registry_group varchar(255) NOT NULL,
  registry_key varchar(255) NOT NULL,
  registry_value varchar(255) NOT NULL,
  update_time timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);

CREATE TABLE XXL_JOB_QRTZ_TRIGGER_GROUP (
  id int8 NOT NULL,
  app_name varchar(64) NOT NULL,
  title varchar(12) NOT NULL,
  "order" int4 NOT NULL DEFAULT '0',
  address_type int4 NOT NULL DEFAULT '0',
  address_list varchar(512) DEFAULT NULL,
  PRIMARY KEY (id)
);
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_GROUP.app_name IS '执行器AppName';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_GROUP.title IS '执行器名称';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_GROUP.order IS '排序';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_GROUP.address_type IS '执行器地址类型：0=自动注册、1=手动录入';
COMMENT ON COLUMN XXL_JOB_QRTZ_TRIGGER_GROUP.address_list IS '执行器地址列表，多地址逗号分隔';

CREATE INDEX I_trigger_time
  ON XXL_JOB_QRTZ_TRIGGER_LOG (trigger_time);
CREATE INDEX I_handle_code
  ON XXL_JOB_QRTZ_TRIGGER_LOG (handle_code);

CREATE SEQUENCE seq_xxl_job_qrtz_trigger_info
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
CREATE SEQUENCE seq_xxl_job_qrtz_trigger_log
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
CREATE SEQUENCE seq_xxl_job_qrtz_trigger_logglue
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
CREATE SEQUENCE seq_xxl_job_qrtz_trigger_registry
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
CREATE SEQUENCE seq_xxl_job_qrtz_trigger_group
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;

commit;

