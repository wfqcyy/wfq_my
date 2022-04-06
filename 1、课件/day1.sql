潘老师 , 科研猫
hive hbase 
推荐系统, 机器学习

8个编程步骤

-- Hive是基于Hadoop的一个数据仓库工具
    -- 可以将结构化的数据文件映射为一张数据库表，并提供类SQL查询功能。
    -- 其本质是将SQL转换为MapReduce的任务进行运算，底层由HDFS来提供数据的存储支持
    -- hive可以理解为一个将SQL转换为MapReduce任务的工具，甚至更进一步可以说hive就是一个MapReduce的客户端


-- 数仓相关的实战 (游戏数仓的项目)

-- 数据仓库的三个特征
    -- 面向主题
    -- 继承性
    -- 非易失性
    -- 时变性

-- 数据仓库(OLAP)和数据库(OLTP)的区别
    -- OLTP: MySQL, SQLServer, DB2
    -- 数据库是面向事务的设计，数据仓库是面向主题设计的, 数据库一般存储业务数据，数据仓库存储的一般是历史数据
    -- 数据库是面向事务的设计, 数据仓库是面向主题设计的
    -- 数据仓库是为分析数据而设计, 数据库是为捕获数据而设计

    -- 分析: 描述性分析, 挖掘性分析, 预测性分析
    -- 数据仓库在设计是有意引入冗余，依照分析需求，分析维度、分析指标进行设计。


hive不是数据仓库
hive是一个操作数据仓库的工具

-- 数据仓库分层 (三层)
    -- 源数据层(ODS), 对接外部的数据源, 存储原始的数据, 不做任何数据处理
    -- 数据仓库层(DW), 数据清洗, 转换, 加载将源数据处理成为一致的, 准确的, 干净的数据
    -- 数据应用层(APP), 数据战术, 数据报表, 商业BI, 数据分析/挖掘, 即席查询

-- Hive的优点
    -- 操作接口采用类SQL语法，提供快速开发的能力（简单、容易上手）
    -- 避免了去写MapReduce，减少开发人员的学习成本
    -- Hive支持用户自定义函数，用户可以根据自己的需求来实现自己的函数

-- Hive缺点
    -- 查询延迟很严重
    -- 转换为mr, 需要进行任务划分, 然后再向集群申请资源
    -- hive不支持事物

hive 不需要再每个节点进行安装
因为hive会讲sql转换为mapreduce任务, 再将任务提交到集群运行

-- hive三种连接方式
    -- 用户接口, 直接hive shell命令
    -- JDBC/ODBC java访问hive   启动一个thift服务 beeline客户端连接
    -- WebUI, 浏览器访问Hive  HUE (写SQL编辑方便, 有提示)  提供录播视频

-- 元数据
    -- mysql管理元数据, 当操作hive(创建库、表), 会自动将库、表的元数据信息保存到hive中
    -- 默认使用的derby, 但是它有缺陷, 在课程当中使用mysql作为hive的元数据管理数据库


-- Hive使用
    -- 前提: 启动hadoop, 启动mysql
        -- 启动hadoop: hadoop.sh start (自定义脚本)
        -- 启动mysql: service mysqld start

    -- 启动hiveserver2
        -- hiveserver2 或者 hive --service hiveserver2

    -- 通过beeline连接
        beeline --color=true

    -- 输入连接地址
        !connect jdbc:hive2://node03:10000
    -- 输入用户名: hadoop 密码:123456

    --退出
        -- 快捷键: ctrl+d 或者 exit; 命令退出;


-- 在Linux下执行hive命令
    hive -e "show databases"

-- 在Linux下批量执行sql脚本
    hive -f /kkb/install/demo.sql


-- hive数据类型 和 mysql基本一致, 具体参考菜鸟教程中sql使用文档

-- 复合类型, 重点了解复合类型创建表的语法, 以及查询上的基本使用
    -- array
    -- map
    -- struct


-- Hive 数据定义语言 DDL(Data Definition Language) 操作
-- 数据库相关操作
    -- 创建数据库
    create database db_hive;
    create database if not exists db_hive;
    -- 数据库在HDFS上的默认存储路径是/user/hive/warehouse/数据库名.db

    -- 显示所有的数据库
    show databases;
    show databases like 'db_hive*';

    -- 显示数据库详细信息
    desc database extended db_hive;

    -- 切换数据库
    use db_hive;

    -- 删除为空的数据库
    drop database db_hive;

    -- 如果数据库中存在表, 需要强制删除
    drop database db_hive cascade;

-- 数据表相关操作
CREATE [EXTERNAL] TABLE [IF NOT EXISTS] table_name 
[(col_name data_type [COMMENT col_comment], ...)] 
[COMMENT table_comment] 
[PARTITIONED BY (col_name data_type [COMMENT col_comment], ...)] 分区
[CLUSTERED BY (col_name, col_name, ...) 分桶
[SORTED BY (col_name [ASC|DESC], ...)] INTO num_buckets BUCKETS] 
[ROW FORMAT row_format]  row format delimited fields terminated by “分隔符”
[STORED AS file_format] 
[LOCATION hdfs_path]

-- 创建内部表
create table stu(id int, name string);
-- 插入数据
insert into stu(id,name) values(1,"zhangsan");
insert into stu(id,name) values(2,"lisi");
-- 实际开发很少使用, 1: 效率低, 2: hive的数据都是来源于外部 不会自己创建数据
-- 基础查询
select * from students;

MANAGED_TABLE   --> 内部表

-- 通过查询结果建表
create table if not exists myhive.stu1 as select id, name from stu;

-- like建表法
create table if not exists myhive.stu2 like stu;  -- 仅复制表的结构, 不会复制数据

-- 查询标的类型
desc formatted myhive.stu;


-- 创建内部表, 并且制定字段之间分隔符, 指定文件存储格式, 以及数据存储位置
create table if not exists myhive.stu3(id int, name string)
row format delimited fields terminated by '\t' 
stored as textfile 
location '/user/stu3';

-- 创建外部表
create external table myhive.teacher (t_id string, t_name string) 
row format delimited fields terminated by '\t';

-- 从本地路径加载数据到表中
load data local inpath '/kkb/install/hivedatas/teacher.csv' into table myhive.teacher;
-- 从hdfs上加载数据到表中
load data inpath '/kkb/hdfsload/hivedatas' overwrite into table myhive.teacher;



-- 分区表
-- 创建只有一个分区的表
create table score(s_id string, c_id string, s_score int) partitioned by (month string) row format delimited fields terminated by '\t';
-- 加载数据
load data local inpath '/kkb/install/hivedatas/score.csv' into table score partition (month='201806');


-- 创建有多个分区的表
create table score2 (s_id string,c_id string, s_score int) partitioned by (year string, month string, day string) row format delimited fields terminated by '\t';
-- 加载数据
load data local inpath '/kkb/install/hivedatas/score.csv' into table score2 partition(year='2018', month='06', day='01');
-- 查看分区
show  partitions  score;

-- 添加一个分区
alter table score add partition(month='201805');

-- 同时添加多个分区
alter table score add partition(month='201804') partition(month = '201803');

-- 删除分区
alter table score drop partition(month = '201806');

-- 作业

- 需求描述：

  - 现在有一个文件score.csv文件，里面有三个字段，分别是s_id string, c_id string, s_score int
  - 字段都是使用 \t进行分割
  - 存放在集群的这个目录下/scoredatas/day=20180607，这个文件每天都会生成，存放到对应的日期文件夹下面去
  - 文件别人也需要公用，不能移动
  - 请创建hive对应的表，并将数据加载到表中，进行数据统计分析，且删除表之后，数据不能删除

- 需求实现:

- 数据准备:

- node03执行以下命令，将数据上传到hdfs上面去

将我们的score.csv上传到node03服务器的/kkb/install/hivedatas目录下，然后将score.csv文件上传到HDFS的/scoredatas/day=20180607目录上



-- hive的底层执行引擎有3种
    -- mapreduce(默认)
    -- tez（支持DAG作业的计算框架）mr1-->mr2 -->mr3
    -- spark（基于内存的分布式计算框架）