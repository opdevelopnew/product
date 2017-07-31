drop database if exists product;

/*==============================================================*/
/* Database: product                                             */
/*==============================================================*/
create database product CHARACTER SET utf8;
USE product;

drop table if exists CUSTOMER_INFO;
drop table if exists DICT_INFO;
drop table if exists HARDWARE_INFO;
drop table if exists INVENTORY;
drop table if exists MAINTAIN_CUSTOMER;
drop table if exists MAINTAIN_FILE;
drop table if exists MAINTENANCE_INFO;
drop table if exists OPERATOR_INFO;
drop table if exists OPERATOR_LOG;
drop table if exists OPERATOR_PRIVILEGE_INFO;
drop table if exists ORDER_CUSTOMER;
drop table if exists ORDER_FILE;
drop table if exists ORDER_INFO;
drop table if exists ORDER_PRODUCT_INFO;
drop table if exists PRIVILEGE_INFO;
drop table if exists PRODUCTS_INFO;
drop table if exists PRODUCT_DETAIL_CUSTOMER;
drop table if exists PRODUCT_DETAIL_FILE;
drop table if exists PRODUCT_LIST;
drop table if exists PROJECT_INFO;
drop table if exists SALER_INFO;
drop table if exists SOFTWARE_INFO;
drop table if exists file_info;


create table CUSTOMER_INFO
(
   CUSTOMER_ID          int(8) not null,
   CUSTOMER_NAME        varchar(32),
   CUSTOMER_SEX         varchar(8),
   CUSTOMER_UNIT        varchar(8),
   CUSTOMER_PHONE       varchar(32),
   CUSTOMER_ADDRESS     varchar(64),
   UNIT                 varchar(64),
   qq                   varchar(32),
   Email                varchar(32),
   Landlise             varchar(32),
   INTRODUCER           varchar(32),
   primary key (CUSTOMER_ID)
);

create table DICT_INFO
(
   HEAD_ID              varchar(32) not null comment '数据字典标识',
   VALUE                varchar(32) not null comment '数据项标识',
   NAME                 varchar(128) not null comment '数据项描述',
   STATUS               varchar(2) not null comment '状态',
   primary key (HEAD_ID, VALUE),
   key Index_ConstID (HEAD_ID)
);

create table HARDWARE_INFO
(
   HARDWARE_ID          int(8) not null auto_increment comment '硬件信息主键',
   HARDWARE_TYPE        varchar(32) comment '硬件名',
   HARDWARE_NAME        varchar(32) comment '硬件名',
   MODEL_NUMBER         varchar(32) comment '型号',
   SIZE                 int(64),
   CAPACITY             int(8),
   HARDWARE_DESC        varchar(256) default NULL comment '描述',
   SUPPLIER             varchar(32) comment '供应商',
   primary key (HARDWARE_ID)
);

create table INVENTORY
(
   INVENTORY_ID         int(8) not null comment '库存主键',
   HARDWARE_ID          int(8) comment '硬件信息主键',
   ID                   int(8) comment '产品主键',
   SERIES_NUMBER        varchar(32) not null comment '硬件序列号',
   MODER_NUMBER         varchar(64) not null comment '型号',
   ADD_TIME             datetime comment '入库时间',
   STATUS               int(2) comment '库存状态',
   RES_OFFICER          varchar(16) default NULL comment '库存负责人',
   INSERT_TIME          datetime comment '插入时间',
   REMARK               longblob,
   EUQIPMENT_USE        varchar(32),
   primary key (INVENTORY_ID)
);

create table MAINTAIN_CUSTOMER
(
   CUSTOMER_ID          int(8) not null,
   MAINTENANCE_ID       int(8) not null comment '维护记录主键',
   primary key (MAINTENANCE_ID, CUSTOMER_ID)
);

create table MAINTAIN_FILE
(
   FILE_ID              int(8) not null,
   MAINTENANCE_ID       int(8) not null comment '维护记录主键',
   primary key (FILE_ID, MAINTENANCE_ID)
);

create table MAINTENANCE_INFO
(
   MAINTENANCE_ID       int(8) not null comment '维护记录主键',
   PRODUCT_LIST_ID      int(8) comment '产品主键',
   USER                 varchar(16) not null comment '维护人',
   TIME                 datetime comment '维护时间',
   REASON               longtext comment '维护原因',
   DETAIL               longtext comment '维护内容',
   PROBLEM              longtext comment '遗留问题',
   INSERT_TIME          datetime comment '插入时间',
   FLIE_EXPLAIN         varchar(256) comment '附件说明',
   TPYE                 varchar(64),
   primary key (MAINTENANCE_ID)
);

create table OPERATOR_INFO
(
   OPERATOR_ID          int(8) not null comment '主键',
   OPERATOR_NAME        varchar(32) not null comment '操作员姓名',
   PASSWORD             varchar(64) comment '登录密码',
   MANAGER_TYPE         int(2) not null comment '管理员类型',
   STATUS               int(2) not null comment '管理员状态',
   CERT                 longtext default null comment '证书',
   CERT_SN              varchar(32) comment '证书序列号',
   CERT_DN              varchar(128) comment '证书DN项',
   VALID_TIME           datetime comment '失效时间',
   INSERT_TIME          datetime comment '添加时间',
   TELEPHONE            varchar(32) comment '联系电话',
   EMAIL                varchar(64) comment '邮箱',
   OPER_STATUS          int(2),
   primary key (OPERATOR_ID)
);

create table OPERATOR_LOG
(
   LOG_ID               int(8) not null comment '主键',
   OPERATOR_ID          int(8) not null comment '操作员主键',
   OP_TYPE              int(2) comment '操作类型',
   OP_RESULT            int(2) not null comment '操作结果',
   OP_OBJECT            varchar(32) not null comment '操作对象',
   MSG                  varchar(512) comment '描述信息',
   OP_TIME              datetime comment '操作时间',
   SIGN_DATA            varchar(512) comment '签名值',
   AUDIT_STATUS         int(2) comment '审计状态',
   AUDIT_OP_ID          int(8) comment '审计员主键',
   AUDIT_TIME           datetime comment '审计时间',
   primary key (LOG_ID)
);

create table OPERATOR_PRIVILEGE_INFO
(
   OPERATOR_ID          int(8) not null comment '管理员ID',
   PRIVILEGE_ID         int(8) not null comment '权限ID',
   primary key (OPERATOR_ID, PRIVILEGE_ID)
);

create table ORDER_CUSTOMER
(
   CUSTOMER_ID          int(8) not null,
   ORDER_ID             int(8) not null comment '订单主键',
   primary key (CUSTOMER_ID, ORDER_ID)
);

create table ORDER_FILE
(
   ORDER_ID             int(8) not null comment '订单主键',
   FILE_ID              int(8) not null,
   primary key (ORDER_ID, FILE_ID)
);

create table ORDER_INFO
(
   ORDER_ID             int(8) not null comment '订单主键',
   SALER_ID             int(8),
   PROJECT_ID           int(8) comment '主键',
   ORDER_NO             varchar(32) not null comment '订单号',
   CARGORECEIPT         varchar(32),
   ORDER_TIME           datetime default NULL comment '订单时间',
   ARRIVE_TIME          datetime comment '到货时间',
   STATUS               int(2) comment '订单状态',
   INSERT_TIME          datetime comment '插入时间',
   DELIVERY_TIME        datetime,
   ADDRESS              varchar(32),
   REMARK               varchar(256),
   primary key (ORDER_ID)
);

create table ORDER_PRODUCT_INFO
(
   ORDER_PRODUCT_ID     int not null,
   ORDER_ID             int(8) comment '订单主键',
   PRODUCT_ID           int(8) comment '产品主键',
   PRODUCT_NUM          int,
   primary key (ORDER_PRODUCT_ID)
);

create table PRIVILEGE_INFO
(
   PRIVILEGE_ID         int(8) not null comment '主键',
   PRIVILEGE_NAME       varchar(64) not null comment '权限名称',
   PARENT_ID            int(8) default NULL comment '上级权限ID',
   PRIVILEGE_PATH       varchar(128) default null comment '权限路径',
   PRIVILEGE_DESC       varchar(128) default null comment '描述',
   PRIVILEGE_LEVEL      int(2) default NULL comment '权限级别',
   PRIVILEGE_ORDER      int(2) not null comment '权限排序',
   STATUS               int(2) not null comment '状态',
   INSERT_TIME          datetime not null comment '添加时间',
   PRIVILEGE_TYPE        int(2) DEFAULT NULL COMMENT '分类标识，2是操作员权限',
   primary key (PRIVILEGE_ID)
);

create table PRODUCTS_INFO
(
   PRODUCT_ID           int(8) not null comment '产品主键',
   SERIES_NUMBER        varchar(32) not null comment '硬件序列号',
   PRODUCT_NAME         varchar(32),
   VERSION              varchar(32) not null comment '型号',
   STATUS               int(2) not null comment '状态',
   remark               varchar(128),
   TYPE                 varchar(64),
   SOFTWARE_VERSION     varchar(64),
   CHASSIS              varchar(64),
   ENCRYPTION_CARD      varchar(64),
   TIME_SOURCE          varchar(64),
   primary key (PRODUCT_ID)
);

create table PRODUCT_DETAIL_CUSTOMER
(
   CUSTOMER_ID          int(8) not null,
   PRODUCT_LIST_ID      int(8) not null comment '产品主键',
   primary key (CUSTOMER_ID, PRODUCT_LIST_ID)
);

create table PRODUCT_DETAIL_FILE
(
   FILE_ID              int(8) not null,
   PRODUCT_LIST_ID      int(8) not null comment '产品主键',
   primary key (FILE_ID, PRODUCT_LIST_ID)
);

create table PRODUCT_LIST
(
   PRODUCT_LIST_ID      int(8) not null comment '产品主键',
   ORDER_PRODUCT_ID     int,
   remark               varchar(128),
   PRE_IP               varchar(32),
   SYSTEM               varchar(64),
   SYSTEM_PW            varchar(32),
   License_Valid_period varchar(32),
   License              longtext,
   EQUIPMENT_MAC        varchar(32),
   PORT                 varchar(32),
   IP                   varchar(32),
   CABINET              varchar(32),
   CERT                 varchar(32),
   MAIN_MATCH_ENGINE    varchar(8),
   ACTUALIZE_TEXT       longtext,
   ACTUALIZE_TIME       datetime,
   imgAdd               varchar(32),
   ENCRYPTION_CARD_ID   int,
   TIMESOURCE_ID        int,
   primary key (PRODUCT_LIST_ID)
);

create table PROJECT_INFO
(
   PROJECT_ID           int(8) not null comment '主键',
   PROJECT_NAME         varchar(32) not null comment '项目名称',
   START_TIME           datetime comment '合同开始时间',
   END_TIME             datetime comment '合同结束时间',
   INSERT_TIME          datetime comment '插入时间',
   primary key (PROJECT_ID)
);

create table SALER_INFO
(
   SALER_ID             int(8) not null,
   SALER_NAME           varchar(32),
   SALER_SEX            varchar(8),
   SALER_AGE            int(8),
   SALER_PHONE          varchar(32),
   SALER_ADDRESS        varchar(64),
   UNIT                 varchar(64),
   primary key (SALER_ID)
);

create table SOFTWARE_INFO
(
   SOFTWARE_ID          int(8) not null comment '软件信息主键',
   SOFTWARE_NAME        varchar(32) not null comment '软件名称',
   SOFTWARE_VERSION     varchar(512) comment '软件版本',
   SOFTWARE_DESC        varchar(80) comment '描述',
   SUPPLIER             varchar(256) default NULL comment '供应商',
   FILE_ADDRESS         varchar(128),
   DEPLOYMENT_ADDRESS   varchar(128),
   SOURCE_ADDRESS       varchar(128),
   FILE                 longtext,
   ENVIRONMENTAL_ADDRESS varchar(256),
   STATUS               varchar(128),
   primary key (SOFTWARE_ID)
);

create table file_info
(
   FILE_ID              int(8) not null,
   FILE_NAMES           varchar(64),
   FILE_TIME            datetime,
   FILE_PATH            varchar(128),
   FILE_EXPLAIN         varchar(256),
   FILE_TYPE            varchar(64),
   primary key (FILE_ID)
);

alter table INVENTORY add constraint FK_Reference_11 foreign key (HARDWARE_ID)
      references HARDWARE_INFO (HARDWARE_ID) on delete restrict on update restrict;

alter table INVENTORY add constraint FK_Reference_25 foreign key (ID)
      references PRODUCT_LIST (PRODUCT_LIST_ID) on delete restrict on update restrict;

alter table MAINTAIN_CUSTOMER add constraint FK_Reference_23 foreign key (CUSTOMER_ID)
      references CUSTOMER_INFO (CUSTOMER_ID) on delete restrict on update restrict;

alter table MAINTAIN_CUSTOMER add constraint FK_Reference_34 foreign key (MAINTENANCE_ID)
      references MAINTENANCE_INFO (MAINTENANCE_ID) on delete restrict on update restrict;

alter table MAINTAIN_FILE add constraint FK_Reference_32 foreign key (FILE_ID)
      references file_info (FILE_ID) on delete restrict on update restrict;

alter table MAINTAIN_FILE add constraint FK_Reference_33 foreign key (MAINTENANCE_ID)
      references MAINTENANCE_INFO (MAINTENANCE_ID) on delete restrict on update restrict;

alter table MAINTENANCE_INFO add constraint FK_Reference_26 foreign key (PRODUCT_LIST_ID)
      references PRODUCT_LIST (PRODUCT_LIST_ID) on delete restrict on update restrict;

alter table OPERATOR_PRIVILEGE_INFO add constraint FK_Reference_13 foreign key (PRIVILEGE_ID)
      references PRIVILEGE_INFO (PRIVILEGE_ID) on delete restrict on update restrict;

alter table OPERATOR_PRIVILEGE_INFO add constraint FK_Reference_14 foreign key (OPERATOR_ID)
      references OPERATOR_INFO (OPERATOR_ID) on delete restrict on update restrict;

alter table ORDER_CUSTOMER add constraint FK_Reference_24 foreign key (CUSTOMER_ID)
      references CUSTOMER_INFO (CUSTOMER_ID) on delete restrict on update restrict;

alter table ORDER_CUSTOMER add constraint FK_Reference_28 foreign key (ORDER_ID)
      references ORDER_INFO (ORDER_ID) on delete restrict on update restrict;

alter table ORDER_FILE add constraint FK_Reference_35 foreign key (ORDER_ID)
      references ORDER_INFO (ORDER_ID) on delete restrict on update restrict;

alter table ORDER_FILE add constraint FK_Reference_36 foreign key (FILE_ID)
      references file_info (FILE_ID) on delete restrict on update restrict;

alter table ORDER_INFO add constraint FK_Reference_6 foreign key (SALER_ID)
      references SALER_INFO (SALER_ID) on delete restrict on update restrict;

alter table ORDER_INFO add constraint FK_Reference_7 foreign key (PROJECT_ID)
      references PROJECT_INFO (PROJECT_ID) on delete restrict on update restrict;

alter table ORDER_PRODUCT_INFO add constraint FK_Reference_18 foreign key (ORDER_ID)
      references ORDER_INFO (ORDER_ID) on delete restrict on update restrict;

alter table ORDER_PRODUCT_INFO add constraint FK_Reference_19 foreign key (PRODUCT_ID)
      references PRODUCTS_INFO (PRODUCT_ID) on delete restrict on update restrict;

alter table PRODUCT_DETAIL_CUSTOMER add constraint FK_Reference_30 foreign key (PRODUCT_LIST_ID)
      references PRODUCT_LIST (PRODUCT_LIST_ID) on delete restrict on update restrict;

alter table PRODUCT_DETAIL_CUSTOMER add constraint FK_Reference_31 foreign key (CUSTOMER_ID)
      references CUSTOMER_INFO (CUSTOMER_ID) on delete restrict on update restrict;

alter table PRODUCT_DETAIL_FILE add constraint FK_Reference_27 foreign key (PRODUCT_LIST_ID)
      references PRODUCT_LIST (PRODUCT_LIST_ID) on delete restrict on update restrict;

alter table PRODUCT_DETAIL_FILE add constraint FK_Reference_29 foreign key (FILE_ID)
      references file_info (FILE_ID) on delete restrict on update restrict;

alter table PRODUCT_LIST add constraint FK_Reference_16 foreign key (ORDER_PRODUCT_ID)
      references ORDER_PRODUCT_INFO (ORDER_PRODUCT_ID) on delete restrict on update restrict;
