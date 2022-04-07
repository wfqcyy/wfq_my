
===复合数据类型样例演示

//分别表示id, 名字，薪水，下属员工， 薪水扣除事项（公积金、医疗保险），地址（街道,城市,省份）
create table employee(
id string,	
name  string,
salary float,
subordinates array<string>,
deductions map<string,float>,
address struct<street:string,city:string,province:string>
)partitioned by (country string,state string) 
row format delimited fields terminated by ',' --列的分隔符
collection items terminated by '|'            --集合内元素的分隔符
map keys terminated by ':'                    --kv键值对直接的连接符
;


vim data.txt
1,zhangsan,30,P1|P2,P:100|M:100,s1|c1|p1
2,lisi,40,P3|P4,P:200|M:200,s2|c2|p2
3,wangwu,50,P1|P3,P:300|M:300,s3|c3|p3
4,mayun,60,P1,P:400|M:300,s4|c4|p4


load data local inpath '/data.txt' into table employee partition (country='china',state="s1");




//对分区字段country 建立索引

create index employee_index on table employee(country) as 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler' with deferred rebuild idxproperties ('creator'='me','created_at'='20190722')  in table employee_index_table partitioned by (country,name);






########################################## join操作 ###########################################
-----------------------------------------------------------------------------------------------
create table teacher
(
id string,
tname string
)row format delimited 
fields terminated by ',';

--teacher.txt 数据
1,吕布
2,关羽
3,刘备
4,赵云
5,曹操



create table course
(
cid string,
cname string,
id string
)row format delimited 
fields terminated by ',';

--course.txt 数据
11,语文,1
22,数学,2
33,英语,3
44,物理,4
55,大数据,6



-----------------------------1、inner join内连接----------------------------------------------------
select * from teacher t inner join course c  on t.id = c.id;

-----查询结果：
+-------+----------+--------+----------+-------+--+
| t.id  | t.tname  | c.cid  | c.cname  | c.id  |
+-------+----------+--------+----------+-------+--+
| 1     | 吕布       | 11     | 语文       | 1     |
| 2     | 关羽       | 22     | 数学       | 2     |
| 3     | 刘备       | 33     | 英语       | 3     |
| 4     | 赵云       | 44     | 物理       | 4     |
+-------+----------+--------+----------+-------+--+



-----------------------------2、left outer join 左外连接---------------------------------------------
select * from teacher t  left outer join course c  on t.id = c.id;
-----查询结果：
+-------+----------+--------+----------+-------+--+
| t.id  | t.tname  | c.cid  | c.cname  | c.id  |
+-------+----------+--------+----------+-------+--+
| 1     | 吕布       | 11     | 语文       | 1     |
| 2     | 关羽       | 22     | 数学       | 2     |
| 3     | 刘备       | 33     | 英语       | 3     |
| 4     | 赵云       | 44     | 物理       | 4     |
| 5     | 曹操       | NULL   | NULL       | NULL  |
+-------+----------+--------+----------+-------+--+


-----------------------------3、right outer join 左外连接---------------------------------------------
select * from teacher t  right outer join course c  on t.id = c.id;
-----查询结果：
+-------+----------+--------+----------+-------+--+
| t.id  | t.tname  | c.cid  | c.cname  | c.id  |
+-------+----------+--------+----------+-------+--+
| 1     | 吕布       | 11     | 语文       | 1     |
| 2     | 关羽       | 22     | 数学       | 2     |
| 3     | 刘备       | 33     | 英语       | 3     |
| 4     | 赵云       | 44     | 物理       | 4     |
| NULL  | NULL       | 55     | 大数据     | 6     |
+-------+----------+--------+----------+-------+--+


-----------------------------4、full outer join 左外连接---------------------------------------------
select * from teacher t  full outer join course c  on t.id = c.id;
-----查询结果：
+-------+----------+--------+----------+-------+--+
| t.id  | t.tname  | c.cid  | c.cname  | c.id  |
+-------+----------+--------+----------+-------+--+
| 1     | 吕布       | 11     | 语文       | 1     |
| 2     | 关羽       | 22     | 数学       | 2     |
| 3     | 刘备       | 33     | 英语       | 3     |
| 4     | 赵云       | 44     | 物理       | 4     |
| 5     | 曹操       | NULL   | NULL       | NULL  |
| NULL  | NULL       | 55     | 大数据     | 6     |
+-------+----------+--------+----------+-------+--+





############################################ order by 操作 #########################################
----------------------------------------------------------------------------------------------------
create table student
(
sid string,
tname string,
age int,
course string,
score Double
)row format delimited 
fields terminated by ',';


--student.txt 数据
1001,小明,20,语文,90
1001,小明,20,数学,95
1001,小明,20,英语,98
1001,小明,20,大数据,85
1002,小张,18,语文,92
1002,小张,18,数学,90
1002,小张,18,英语,85
1002,小张,18,大数据,96
1003,隔壁老王,16,语文,80
1003,隔壁老王,16,数学,85
1003,隔壁老王,16,英语,90
1003,隔壁老王,16,大数据,95


-----------------------------------查询学生的成绩，并按照分数降序排列-----------------------------------
select * from student s order by score desc ;

-----查询结果：
+--------+----------+--------+-----------+----------+--+
| s.sid  | s.tname  | s.age  | s.course  | s.score  |
+--------+----------+--------+-----------+----------+--+
| 1001   | 小明       | 20     | 英语        | 98.0     |
| 1002   | 小张       | 18     | 大数据      | 96.0     |
| 1003   | 隔壁老王   | 16     | 大数据      | 95.0     |
| 1001   | 小明       | 20     | 数学        | 95.0     |
| 1002   | 小张       | 18     | 语文        | 92.0     |
| 1003   | 隔壁老王   | 16     | 英语        | 90.0     |
| 1002   | 小张       | 18     | 数学        | 90.0     |
| 1001   | 小明       | 20     | 语文        | 90.0     |
| 1003   | 隔壁老王   | 16     | 数学        | 85.0     |
| 1002   | 小张       | 18     | 英语        | 85.0     |
| 1001   | 小明       | 20     | 大数据      | 85.0     |
| 1003   | 隔壁老王   | 16     | 语文        | 80.0     |
+--------+----------+--------+-----------+----------+--+


-----------------------------------查询学生的成绩，并按照学生分数的平均值降序排列-----------------------------------
select s.sid,s.tname, avg(score)  as score_avg  from student s  group by  s.sid,s.tname order by score_avg  desc;

-----查询结果：
+--------+----------+------------+--+
| s.sid  | s.tname  | score_avg  |
+--------+----------+------------+--+
| 1001   | 小明       | 92.0       |
| 1002   | 小张       | 90.75      |
| 1003   | 隔壁老王   | 87.5       |
+--------+----------+------------+--+



################################### 每个MapReduce内部排序（Sort By）局部排序 #######################################
--------------------------------------------------------------------------------------------------------------------
- sort by：每个reducer内部进行排序，对全局结果集来说不是排序。
  - 1、设置reduce个数
        set mapreduce.job.reduces=3;

  - 2、查看设置reduce个数
        set mapreduce.job.reduces;

  - 3、查询成绩按照成绩降序排列
        select * from student s sort by s.score;

  - 4、将查询结果导入到文件中（按照成绩降序排列）
        insert overwrite local directory '/home/hadoop/hivedata/sort' select * from student s sort by s.score;




################################### 分区排序（DISTRIBUTE BY） ######################################################
--------------------------------------------------------------------------------------------------------------------
--设置MR中reduce的个数
set mapreduce.job.reduces=3;
insert overwrite local directory '/home/hadoop/hivedata/distribute' select * from student distribute by sid sort by score;