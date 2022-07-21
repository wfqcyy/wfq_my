# wfq_my

drop table if exists website_visit;

create table website_visit(
data_content varchar(100))
engine=innodb default charset=utf8;


> insert into website_visit(data_content) values('201812011241'),('201812022493'),('202112030482');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

> insert into website_visit(data_content) values('201912012317'),('201912032520'),('201912030412');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

> insert into website_visit(data_content) values('201812030484');
Query OK, 1 row affected (0.01 sec)

> insert into website_visit(data_content) values('202012011547'),('202012025847'),('202012030625');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0


create table visit
select 
	visit_year,
	max(visit_num)
from (select 
	*,
	substring(data_content,1,4) as visit_year,
	substring(data_content,-4,4) as visit_num
from 
	website_visit)a
group by 
	visit_year
order by visit_year

desc visit;
alter table visit change   `max(visit_num)` visit_num varchar(20);
alter table  visit modify visit_num int;




select
	`date`,
	 mall_gmv,
	 lag(mall_gmv,7) over(order by `date`)
from 
   gmv_info
   
   
   
   
select
	id,
	case 
		when  id='A' then '一级'
		when  id='B' then '二级'
		else '三级'
	end  as label 
from 
  case_when_test
  
  
  
  
selectcreate
	text_id,
	group_concat(text_content separator '&') as text_b
from 
   convert_table
 group by 
	text_id
 order by 
	text_id;



select
	`year`,
	 sum(case when quarter=1 then amount else 0 end) as 第一季度,
	 sum(case when quarter=2 then amount else 0 end) as 第二季度,
	 sum(case when quarter=3 then amount else 0 end) as 第三季度,
	 sum(case when quarter=4 then amount else 0 end) as 第四季度
from 
	purchase_quality
group by `year`



create table consumer_order(
	order_id varchar(8),
	money int(8))
engine=innodb 
default charset=utf8


insert into consumer_order(order_id,money) values('a001',2000),('a002',4000),('a003',6000),('a004',2000),('a005',4000),('a006',3000),('a007',2000),('a008',4000),('a009',5000);

select * from(select 
	order_id,
	diff,
	rank() over(order by diff) as num
from (select
			order_id,
			abs(20000-sum(money) over(order by order_id)) as diff
	
	  from 
			consumer_order)a )b where num=1




drop table if exists date_test;
create table date_test(
user_id varchar(8) primary key,
login_date date,
buy_date date)
engine=innodb default charset=utf8;




select 
	* 
from 
	date_test
where 
	datediff(buy_date,login_date) between 1 and 7;
	

select 
	* 
from 
	date_test
limit 5;


select 
	datediff(login_date,buy_date) 
from 
	date_test




insert into  express_cabinet(objection_location,is_express_cabinet)
values('/一号快递柜/','YES'),('/二号快递柜/','YES'),('/二号快递柜/快递A','NO'),('/一号快递柜/快递B','NO'),('/二号快递柜/快递C','NO'),('/三号快递柜/','YES'),('/二号快递柜/快递D','NO'),('/四号快递柜/','YES'),('/一号快递柜/快递E','NO'),('/四号快递柜/快递F','NO'),('/五号快递柜/','YES');



select
	distinct substring(objection_location,1,7) as busy_express_cabinet
from
	express_cabinet
where is_express_cabinet='NO'
order by busy_express_cabinet

-- 快递柜
select
	distinct a.objection_location
from
(select
	*
from 
express_cabinet
where is_express_cabinet='YES')a
inner join 
(select
	*
from 
express_cabinet
where is_express_cabinet='NO')b
on b.objection_location like concat(a.objection_location,'%')





-- app

select
	app_id,
	app_type,
	download,
	rank() over(order by download desc)num_rank
from
	app_download
	

select 
	app_type,
	count(*)
from (select
	app_id,
	app_type,
	download,
	rank() over(order by download desc)num_rank
from
	app_download)a
where a.num_rank between (select 
							 count(*)
                          from
							a )*0.1 and (select 
											count(*)
										 from a )*0.9;
group by 
	app_type


-- 学习表


select 
	user_id,
	study_date,
	weekofyear(study_date)week_num
from 
	active_learning
where study_date>='2021-04-01' and study_date<='2021-04-30'

-- insert into active_learning(user_id,study_date) values('u001','2021-04-01'),('u002','2021-04-01'),('u003','2021-04-03'),('u001','2021-04-06'),('u003','2021-04-07'),('u001','2021-04-12'),(u001','2021-04-13'),('u002','2021-04-14'),('u001','2021-04-23'),('u002','2021-04-24'),('u001','2021-04-26'),('u003','2021-04-27'),('u002','2021-04-30')


select 
	distinct user_id,week_num
from (select 
	user_id,
	study_date,
	weekofyear(study_date)week_num
from 
	active_learning
where study_date>='2021-04-01' and study_date<='2021-04-30')a
group by
	user_id
having count(*)=5;


-- 新增用户
select 
		* 
	from login_user
where
	is_registered=1;
	
	
select
	
explain
select
	a.`date`,
	count(user_id) as num
from view1 as a
where a.user_id in (select b.user_id from view1 as b where b.`date`>=a.`date`)
group by 
	a.`date`
	
	
create table group_test(
 user_id varchar(8),
 salary int)
 engine=innodb default charset=utf8;
 
 
insert into game_recharge(user_id,recharge_amount,recharge_date,game_category_1,game_category_2) values
    ('u001',100,'2021-03-01','A','A1'),
    ('u002',300,'2021-03-01','A','A2'),
    ('u003',150,'2021-03-01','B','B2'),
    ('u004',400,'2021-03-01','A','A2');
	


select 
	game_category_1,
	game_category_2,
	sum(recharge_amount)
from 
	game_recharge
group by 
	game_category_1,game_category_2
 

select 
	game_category_1,
	game_category_2,
	sum(recharge_amount) over(partition by game_category_1,game_category_2)
from 
	game_recharge
	

select 
	user_id,num
from
	in_test
where 
	(user_id,num) in 
					(select
						user_id,
						max(num)
					from 
						in_test
					group by 
						user_id)


select *
from consumer_order
where mail regexp '[a-zA-Z0-9]{1,}@[a-zA-Z0-9]{1,}\.com'




-- 1

select
	day_max,
	count(distinct user_id)
from(
select 
	user_id,
	max(number_day)day_max
from(
select
	user_id,
	login_date,
	count(*) as number_day
from 
(select 
	user_id,
	event_date,
	num,
	date_sub(event_date,interval num day) as login_date
from 
(select
	user_id,
	event_date,
	row_number() over(partition by user_id order by event_date) as num
from 
	events)a)b
	group by 
		user_id,
		login_date)e
group by 
    user_id)e
group by 
	day_max
order by	
	day_max


-- 2

select 
	third_step,
	second_step,
	first_step,
	count(distinct user_id)
from(
select
	user_id,
	event_time,
	substring_index(step,',',1) as third_step,
	substring_index(substring_index(substring_index(step,',',2),',',2),',',2) as second_step,
	substring_index(step,',',-1) as first_step
from (select	
	user_id,
	event_time,
	substring_index(replace(CONCAT_WS(',','None,None,None',event_time),',app_remove',''),',',-3)as step
from (select
	user_id,
	group_concat(event_name order by from_unixtime(event_timestamp)) as event_time
	
from 
	events
where 
	app_id='App2' 
group by 
	user_id)a
where find_in_set('app_remove',event_time))b)c

group by 
	third_step,second_step,first_step
	

-- 3

select
	*
from 
	events
where 
	app_id='APP2' and country_code='US' and event_date=' 2021-01-01' and event_name='first_open'
		
		
		
	
select
	day(event_date),
	count(distinct user_id)
from 
	events
where 
	app_id='APP2'  and event_date=' 2021-01-02' and event_name='user_engagement'
group by
	day(event_date)
		


		
select
	event_date,
	event_name,
	from_unixtime(event_timestamp),
	user_id,
	country_code
from 
	events 

left join(
	select
	event_date,
	event_name,
	from_unixtime(event_timestamp),
	user_id,
	country_code,
	app_id,
	(select
			count(*) 
	 from 
		events
	 where 
		app_id='APP2' and country_code='US' and event_date=' 2021-01-01')as num_ori
from 	
	events
)b
on e.user_id=b.user_id and b.date(from_unixtime(b.event_timestamp))-e.date(from_unixtime(e.event_timestamp))=1
	
	
	
	
select
	count(*)
from 
	events
where 
	app_id='APP2' and country_code='US' and event_date=' 2021-01-01'
	
-- [[[[	
with temp as(
select
	day(b.event_date)as d,
	count(distinct b.user_id) as num,
from 
(select
	a.event_date,
	a.user_id
from
	events
where
	app_id='APP2' and country_code='US' and event_date=' 2021-01-01' and event_name='first_open')a

left join 
	(select
	b.event_date,
	b.user_id
from
	events
where
	app_id='APP2' and event_date=' 2021-01-02' and event_name='user_engagement')b
on a.user_id=b.user_id and day(b.event_date)-day(a.event_date)=1
where b.user_id is not null
group by 
	day(b.event_date)

union

select
	day(b.event_date),
	count(distinct b.user_id)
from 
(select
	*
from
	events
where
	app_id='APP2' and country_code='US' and event_date=' 2021-01-01' and event_name='first_open')a

left join 
	(select
	*
from
	events
where
	app_id='APP2' and event_date=' 2021-01-03' and event_name='user_engagement')b
on a.user_id=b.user_id and day(b.event_date)-day(a.event_date)=2
where b.user_id is not null
group by 
	day(b.event_date)

union

select
	day(b.event_date),
	count(distinct b.user_id)
from 
(select
	*
from
	events
where
	app_id='APP2' and country_code='US' and event_date=' 2021-01-01' and event_name='first_open')a

left join 
	(select
	*
from
	events
where
	app_id='APP2' and event_date=' 2021-01-04' and event_name='user_engagement')b
on a.user_id=b.user_id and day(b.event_date)-day(a.event_date)=3
where b.user_id is not null
group by 
	day(b.event_date)

union

select
	day(b.event_date),
	count(distinct b.user_id)
from 
(select
	*
from
	events
where
	app_id='APP2' and country_code='US' and event_date=' 2021-01-01' and event_name='first_open')a

left join 
	(select
	*
from
	events
where
	app_id='APP2' and event_date=' 2021-01-05' and event_name='user_engagement')b
on a.user_id=b.user_id and day(b.event_date)-day(a.event_date)=4
where b.user_id is not null
group by 
	day(b.event_date)

union

select
	day(b.event_date),
	count(distinct b.user_id)
from 
(select
	*
from
	events
where
	app_id='APP2' and country_code='US' and event_date=' 2021-01-01' and event_name='first_open')a

left join 
	(select
	*
from
	events
where
	app_id='APP2' and event_date=' 2021-01-06' and event_name='user_engagement')b
on a.user_id=b.user_id and day(b.event_date)-day(a.event_date)=5
where b.user_id is not null
group by 
	day(b.event_date)

union

select
	day(b.event_date),
	count(distinct b.user_id)
from 
(select
	*
from
	events
where
	app_id='APP2' and country_code='US' and event_date=' 2021-01-01' and event_name='first_open')a

left join 
	(select
	*
from
	events
where
	app_id='APP2' and event_date=' 2021-01-07' and event_name='user_engagement')b
on a.user_id=b.user_id and day(b.event_date)-day(a.event_date)=6
where b.user_id is not null
group by 
	day(b.event_date))


select 
	temp.d,
	temp.num
from temp;





select 
	datediff(a.event_date,b.event_date)  as days,
	a.id_cnt/id_cnt_0 as user_rate
from 
	(
	select 
		event_date,
		count(distinct user_id) as id_cnt
	from events
	where app_id='APP2'
	group by event_date
) as a 
inner join 
	(
	select 
		event_date,
		count(distinct user_id) as id_cnt_0
	from events
	where app_id='APP2' and country_code='US' and event_date=' 2021-01-01'
	group by event_date
	) as b
on a.user_id=b.user_id



select
	days,
	round(user_rate,2)
from(select 
	datediff(a.event_date,b.event_date)  as days,
	a.id_cnt/id_cnt_0 as user_rate
from 
	(
	select 
		event_date,
		count(distinct user_id) as id_cnt
	from events
	where app_id='APP2' and event_name='user_engagement' and user_id in (select 
																			distinct user_id
																		from events
																		where app_id='APP2' and country_code='US' and event_date=' 2021-01-01' and event_name='first_open')
	group by
		event_date
) a
inner join 
	(
	select 
		event_date,
		count(distinct user_id) as id_cnt_0
	from events
	where app_id='APP2' and country_code='US' and event_date=' 2021-01-01' and event_name='first_open'
	group by event_date
	) as b)c
	
where days <> '0'












select
	user_id,
	max(date_sub(event_date,interval ranking day))as date_diff
from (select
	user_id,
	event_date,
	row_number() over(partition by user_id order by event_date) as ranking
from 
	events)a
group by
	user_id
 
select
	user_id,
	date_diff
from()b


select 
	day_num,
	count(distinct user_id)
from (select
	user_id,
	max(number_login) as day_num
from 

(select
	user_id,
	date_diff,
	count(*) as number_login
from(
select
	user_id,
	date_sub(a.event_date,interval a.ranking day)as date_diff
from (select
			user_id,
			event_date,
			row_number() over(partition by user_id order by event_date) as ranking
	  from 
			events)a
	)b
group by
	user_id,
	date_diff)c
group by 
	user_id)d
group by
	day_num







select
	f.user_id,
	f.follower_id,
	m.music_id
from 
	follow f
inner join
	music_likes m
on
	f.follower_id=m.user_id
where 
	f.user_id=1
	


select
	distinct m2.music_name
from 
	(select
	f.user_id,
	f.follower_id,
	m.music_id
from 
	follow f
inner join
	music_likes m
on
	f.follower_id=m.user_id 
where 
	f.user_id=1 and music_id not in (
			select
				distinct mm.music_id
			from 
				follow ff
			inner join music_likes mm
			on
				ff.user_id=mm.user_id
			where
				ff.user_id=1

		)
		)m1
inner join 
	music m2
on 
	m1.music_id=m2.id 
order by 
	m2.music_name








select
	distinct mm.music_id
from follow ff
inner join music_likes mm
on ff.user_id=mm.user_id
where ff.user_id=1







select
	T.goods_id,
from trans T
left join goods G
on T.goods_id =G.id
group by
	T.goods_id
having sum(`count`)>20 and weight<50





select 
	date(reg_time) dt,
	count(distinct user_info.user_id) 新增用户数,
	datediff(login_time,reg_time) 次日留存用户数,
	sum(datediff(login_time,reg_time)=3) 三日留存用户数,
	sum(datediff(login_time,reg_time)=7) 七日留存用户数
from user_info left join login_log on user_info.user_id=login_log.user_id
group by date(reg_time);
+------------+------------+----------------+----------------+----------------+------------+------------+------------+
| dt         | 新增用户数  | 次日留存用户数  | 三日留存用户数  | 七日留存用户数  | 次日留存率  | 三日留存率  | 七日留存率  |
+------------+------------+----------------+----------------+----------------+------------+------------+------------+
| 2020-01-01 |         10 |              8 |              6 |              3 |     0.8000 |     0.6000 |     0.3000 |
| 2020-01-02 |          6 |              4 |              3 |              2 |     0.6667 |     0.5000 |     0.3333 |
| 2020-01-03 |          4 |              3 |              2 |              1 |     0.7500 |     0.5000 |     0.2500 |
+------------+------------+----------------+----------------+----------------+------------+------------+------------+


select
	user_id,
	first_buy_date,
	second_buy_date,
	cnt
from(select 
	user_id,
	product_name,
	status,
	`date` as first_buy_date,
	lead(`date`,1)  over(partition by user_id ) as second_buy_date,
	ranking,
	max(ranking) over(partition  by user_id)as cnt
from 
	(select
	user_id,
	product_name,
	status,
	`date`,
	row_number()  over(partition by user_id order by `date`) as ranking
	
from 
	order_info
where 
	`date`>'2025-10-15'
  and status='completed'
  and product_name in ('Java','C++','Python')
  )b
)c
where 
	second_buy_date is not null
	and ranking<2
	


select
	user_id,
	product_name,
	status,
	`date`,
	row_number()  over(partition by user_id order by `date`) as ranking
from 
	order_info
where 
	`date`>'2025-10-15'
  and status='completed'
  and product_name in ('Java','C++','Python')


 def ReverseList(self, pHead):
        # write code here
        if pHead is None:
            return pHead
        last = None  #指向上一个节点
        while pHead:
            # 先用tmp保存pHead的下一个节点的信息，
            # 保证单链表不会因为失去pHead节点的next而就此断裂
            tmp = pHead.next
            # 保存完next，就可以让pHead的next指向last了
            pHead.next = last
            # 让last，pHead依次向后移动一个节点，继续下一次的指针反转
            last = pHead
            pHead = tmp
        return last
		
		
		
		
		
		
		

select
	m1.job,
	first_year_mon,
	first_year_cnt,
	second_year_mon,
	second_year_cnt
from 
(select
	job,
	first_year_mon,
	first_year_cnt
from(select
	job,
	dm as first_year_mon,
	sum(num) as first_year_cnt
from(select 
	job,
	date_format(`date`,'%Y-%m') as dm,
	`date`,
	num
from 
	resume_info
where 
	year(`date`)!='2027')a
group by 
	job,
	dm)b
where substring(first_year_mon,1,4)='2025')m1

inner join
(select
	job,
	second_year_mon,
	second_year_cnt
from(select
	job,
	dm as second_year_mon,
	sum(num) as second_year_cnt
from(select 
	job,
	date_format(`date`,'%Y-%m') as dm,
	`date`,
	num
from 
	resume_info
where 
	year(`date`)!='2027')a
group by 
	job,
	dm)b
where substring(second_year_mon,1,4)='2026')m2
on m1.job=m2.job and substring(second_year_mon,-1,1)=substring(first_year_mon,-1,1)
order by 
	first_year_mon desc,
	job desc



----------------------------------------------------
# num=input()
# num=num[::-1]
# s=[]
# for i in num:
#     if i not in s:
#         s.append(i)
# print(int(''.join(s)))



# a = input()[::-1]
# print(set(a))
# print(sorted(set(a),key=a.index))
# print("".join(sorted(set(a),key=a.index)))




# def get_stamp(num):
#     dic = {1: 1, 2: 2, 3: 3}
#     if num in dic.keys():
#         return dic[num]
#     else:
#         return get_stamp(num-1)+get_stamp(num-2)+get_stamp(num-3)
#
# print(get_stamp(7))

#250
# f=lambda x,n:x**n
# def main(factors,x):
#     sum=0
#     for i in range(len(factors))[::-1]:
#         sum+=factors[len(factors)-1-i]*f(x,i)
#     return sum
#
# print(main((3,0,1,2),3))


#251


# def GCU(m, n):
#     if not m:
#         return n
#     elif not n:
#         return m
#     elif m is n:
#         return m
#
#     if m > n:
#         gcd = n
#     else:
#         gcd = m
#
#     while m%gcd or n%gcd:
#         gcd -= 1
#
#     return gcd
# print(GCU(12,36))


#252


# def outer(a,b):
#     def inner(x):
#         return a*x+b
#     return inner
#
# def main(a,b,x):
#     return outer(a,b)(x)
#
# print(main(3,5,7))


#256

import zlib
import pickle
import hashlib

# def main(obj):
#     return  zlib.crc32(pickle.dumps(obj))
#
#
# print(main('董付国，Python小屋'))


# def main(obj):
#     return  hashlib.md5(pickle.dumps(obj)).hexdigest()
#
#
# print(main('董付国，Python小屋'))




def get_ser(s):
    lst=[]
    while True:
        try:
            num=s[0]
            l_temp=sorted(set(s[1:num+1]))
            lst+=l_temp
            s=s[num+1:]
        except Exception as e:
            return lst

a=input()




-----------------------------------------------------------------------------------
1.	请写 SQL 查出 （1）注册渠道 556 上各放款月份的放款件数和首期到期 0 天的件数逾期率。注：首期即 还款期数的第一期，0 天件数逾期率=逾期 1 天及以上的件数/所有到期件数
总体思路：1）筛选556渠道和首期用户并在repay表中标记是否首期逾期
          2）统计load表中放款字段放款月份
          3）根据月份分组并计算筛选
    select
   lt.transacted_at_month,
   sum(id_at_deadline='逾期')/count(*) as rate
from (select
	use_id,
	registered_from
from 
	user u
where registered_from=556)a
left join 
    (select
       load_id,
       user_id,
	   transacted_at,
	   month(transacted_at) as transacted_at_month
	from 
		loan)lt
on 
	a.use_id=lt.user_id
inner join
	(select
		load_id,
		term_no,
		if(repaid_at>dead_line,'逾期','未逾期') as id_at_deadline
	from 
		repay
	where 
		term_no=1)rt
on 
	lt.load_id=rt.load_id
group by 
	lt.transacted_at_month


2）现有如下表头的 Excel 文件 model3.xlsx，请用python/R读取excel 存入变量df中，对 loan_id 做 去重处理，并输出各放款月(transacted_at）各分期数〈term）的样本量分布。
import pandas as pd
#读取数据
df=pd,read_excel(‘./model3.xlsx’)
#根据loan_id字段去重
df.drop_duplicates(subset=['loan_id'],inplace=True)
 #将该列转换为datetime类型
df['transacted']=pd.to_datetime(df['transacted'])
#提取月份数据
df['month']=df['transacted'].dt.month
#分组统计数目并重命名
df.groupby(['month','term']).agg({'loan_id':'count'}).reset_index().rename(columns={'loan_id':'num'})

3）请用 python/R 在变量 df 中新增字段 A 和B，存入 content 中对应的 json 数据，并处理缺失值。
import numpy as np
import json

def get_content(df,col):
    #转换为字典
    df1=json.loads(df)
    #获取所需字段,如果该字段不存在用nan代替
    df1[col]=df1['data'].get(col,np.nan)
    #返回该字段
return df1[col]

#获取A字段中内容
df['A']=df['content'].apply(get_content,args=('A',))
#获取字段中内容
df['B']=df['content'].apply(get_content,args=('B',))

#在这里作为例子演示，用0填充缺失值，具体数值根据实际业务需求填充
df['A'].fillna(0,inplace=True)
df['B'].fillna(0,inplace=True)

4）变量df中transacted_at在18-05-01 至 18-07-01的样本为模型model3的测试集，请用python/R 筛选出测试集中9期产品(term=9)的样本，并画出模型 model3 在该样本上 ROC曲线和Lift Chart 提升图
ROC曲线
from sklearn.metrics import roc_curve, auc 

#将模型评分转换为list
y_score=data_term_9['model3'].tolist()
#计算fpr,tpr和threshold
fpr,tpr,threshold = roc_curve(y_test, y_score) 
#计算auc的值
roc_auc = auc(fpr,tpr) 
#绘制图形
plt.figure()
lw = 2
plt.figure(figsize=(10,10))
plt.plot(fpr, tpr, color='darkorange',
         lw=lw, label='ROC curve (area = %0.2f)' % roc_auc)
plt.plot([0, 1], [0, 1], color='navy', lw=lw, linestyle='--')
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver operating characteristic example')
plt.legend(loc="lower right")
plt.show()

lift-chart
#绘制lift-chart图表格
def lift_plot(predictions, labels, threshold_list, cut_point=100):
    #计算分母
    base = len([x for x in labels if x == 1]) / len(labels)
   
    #打包组合
    predictions_labels = list(zip(predictions, labels))
    #存储指标lift_value
    lift_values = []
    #阈值分割点的数量
    x_axis_range = np.linspace(0, 1, cut_point)
    #添加分割点
    x_axis_valid = []
    #遍历每个分割点
    for i in x_axis_range:
        #与分割点比较
        hit_data = [x[1] for x in predictions_labels if x[0] > i]
        # 避免为空
        if hit_data:  
            bad_hit = [x for x in hit_data if x == 1]
            #计算分子
            precision = len(bad_hit) / len(hit_data)
            #计算指标
            lift_value = precision / base
            #添加指标
            lift_values.append(lift_value)
            #添加分割点
            x_axis_valid.append(i)
    #绘制图形
    plt.plot(x_axis_valid, lift_values, color="blue")  # 提升线
    # base线
    plt.plot([0, 1], [1, 1], linestyle="-", color="darkorange", alpha=0.5, linewidth=2)  


lift_plot(y_score, y_test,threshold)


5) 以下是该现金分期产品的额度策略：分为初始额度和每次提额。 根据客户质量分为三组，初始额度由高至低为500元，400元，300元。 每次复贷提额策略分别为上一次额度乘以一个系数，再减去一个常量。然后四舍五入取整。 例：优质客户第一次借款，额度为500元，第二次借款时额度为 round(500 + (500*25% - 25))。 现有一客户额度是2006元，请用 求出其所在分组和提额次数（初始额度提额次数为0）

def func(start, percent, constant):
    global times
    if start > 2006:
        return
    elif start == 2006:
        return times
    else:
        times = times + 1
        start = round(start*(1+percent)-constant)
        return func(start, percent, constant)

parameters = ((500, 0.25, 25),
              (400, 0.2, 20),
              (300, 0.15, 15))
for para in parameters:
    times = 0
    result = func(*para)
    if result is not None:
        print(para, times)
 


A：两者都可用作分类任务
B：两者都属于分类算法
C：两者都需要预先定义超参数K
D：两者都有明显的前期训练过程

本题答案：A
解析：KNN与Kmeans都可以做分类任务
B选项KNN属于分类算法，Kmeans属于聚类算法，故排除
C选项Kmeans需要定义超参数K，可以通过交叉验证等方法进行选取，故排除
D选项KNN属于懒加载模型，它前期并没有明显的训练过程，Kmeans有明显的前期训练过程，故排除
def get_category():
    def func(start, percent, constant):
        if start > 2006:
            return
        elif start == 2006:
            return 0
        else:
            start = round(start*(1+percent)-constant)
            return func(start, percent, constant)

    parameters = ((500, 0.25, 25),
                  (400, 0.2, 20),
                  (300, 0.15, 15))
    for para in parameters:
        result = func(*para)
        if result is not None:
            print(*para)

get_category()




from collections import Counter
from collections import OrderedDict

class LeagueTable:
    def __init__(self,players):
        self.standings=OrderedDict([(player,Counter()) for player in players])

    def record_result(self,player,score):
        self.standings[player]['games_played']+=1
        self.standings[player]['score'] += score

    def player_rank(self):
        lst=sorted(self.standings.items(), key=lambda x: (x[0], -x[1]))
        return sorted(lst[:2],key=lambda x:list(self.standings.keys()).index(x[0]))[0][0]



if __name__ == '__main__':
    table=LeagueTable(['Mike','Chris','Arnold'])
    table.record_result('Mike',2)
    table.record_result('Mike',3)
    table.record_result('Arnold',5)
    table.record_result('Chris',5)
    # print(table.standings)
    print(table.player_rank())


# def func(total_money):
#     global start
#     global percent
#     global constant
#
#     if start > total_money:
#         return
#     elif start == total_money:
#         return constant
#     else:
#         start = round(start*(1+percent)-constant)
#         return func(total_money)
#
# parameters = ((500, 0.25, 25),
#               (400, 0.2, 20),
#               (300, 0.15, 15))
# for para in parameters:
#     start,percent,constant=para
#     result = func(2006)
#     if result is not None:
#         if result==25:
#             print('优质客户')
#         elif result==20:
#             print('中等客户')
#         else:
#             print('低质客户')



import string
letters=string.ascii_lowercase+string.ascii_uppercase
#获取辅音字母
fuyin_letter=set(letters)-{'A','E','I','O','U','a','e','i','o','u'}

s=list('udifkoca')
print(fuyin_letter)
print(letters)

start=0
end=len(s)-1
while start<=end:
    while start<=end and s[start] not in fuyin_letter:
        start+=1
    while start<=end and s[end] not in fuyin_letter:
        end-=1
    if start<=end:
        s[start],s[end]=s[end],s[start]
        start+=1
        end-=1
print(''.join(s))

#aaaa aaaa
#bbbb bbbb
#abefeco acefebo
#udifk123oca ucikfoda




#
# 代码中的类名、方法名、参数名已经指定，请勿修改，直接返回方法规定的值即可
#
# 
# @param total_money int整型 总额度
# @return string字符串



start = 0
percent = 0
constant = 0
class Solution:
    def get_money(self, total_money):
        global start
        global percent
        global constant
        
        while True:
            if start == total_money:
                return constant
            else:
                start = round(start*(1+percent)-constant)

    def get_rank(self, total_money: int) -> str:
        global start
        global percent
        global constant

        parameters = ((500, 0.25, 25), (400, 0.2, 20), (300, 0.15, 15))
        for para in parameters:
            start, percent, constant = para
            result = self.get_money(total_money*1.0)
            if result is not None:
                if result == 25:
                    print('优质客户')
                elif result == 20:
                    print('中等客户')
                else:
                    print('低质客户')



# from collections import defaultdict
# from collections import OrderedDict
# dic=defaultdict(list)
# lst=[1,2,3,2,1,5,4]
# 
# for k,va in[(value,index) for index,value in enumerate(lst)]:
#     dic[k].append(va)
# print(dic)
# 
# print([cnts[1] for value,cnts in filter(lambda x:len(x[1])>=2,dict(dic).items())])


#-----------------
# from collections import defaultdict
#
# dic=defaultdict(list)
# lst=[1,2,3,2,1,5,4]
#
# for k,va in[(value,index) for index,value in enumerate(lst)]:
#     dic[k].append(va)
# print(dic)
#
# print([cnts[1] for value,cnts in filter(lambda x:len(x[1])>=2,dict(dic).items())])


# from collections import defaultdict
#
# dics=defaultdict(list)
# lst=[(1,90),(1,93),(2,93),(2,99),(2,98),(2,97),(1,62),(1,56),(2,95),(1,61)]
#
# for index,value in lst:
#     dics[index].append(value)
#
# for key,value in dics.items():
#     dics[key]=sorted(value,reverse=True)[:3]
#
# answer = dict()
# for id, scores in dics.items():
#     answer[id] =round(sum(scores)/3,1)
# print(answer)

import re

s='abcd124fgg698djiw3986jhdg2567'
nums=re.findall('\d+',s)
print(nums)
nums_sort=sorted(nums,key=len,reverse=True)[0]
print(nums_sort,type(nums_sort))
print(int(''.join(sorted(map(str,nums_sort),reverse=True))))


print(sorted(['5','1','2']))

select
	sum(case when min_time>=interval_6_day then 1 else 0 end) as xjyh,
	sum(case when max_time>=interval_6_day and min_time<interval_6_day then 1 else 0 end) as zsyh,
	sum(case when max_time<interval_30_day then 1 else 0 end) as lsyh,
	sum(case when max_time<interval_6_day and min_time>= interval_30_day then 1 else 0 end) as csyh
from(select
	`uid`,
	(select date(max(out_time)) from tb_user_log) as max_time_all,
	(select date_sub((select date(max(out_time)) from tb_user_log),interval 5 day)) as interval_6_day,
	(select date_sub((select date(max(out_time)) from tb_user_log),interval 29 day)) as interval_30_day,
	 date(min(in_time))as min_time,
	 date(max(in_time))as max_time
from 
	tb_user_log
group by 
	`uid`)a
	

select *
from(
select
	"忠实用户",
	round(sum(case when max_time>=interval_6_day and min_time<interval_6_day then 1 else 0 end)/count(distinct `uid`) ,2)as rate
from(select
	`uid`,
	(select date(max(out_time)) from tb_user_log) as max_time_all,
	(select date(min(in_time)) from tb_user_log) as min_time_all,
	(select date_sub((select date(max(out_time)) from tb_user_log),interval 5 day)) as interval_6_day,
	(select date_sub((select date(max(out_time)) from tb_user_log),interval 29 day)) as interval_30_day,
	 date(min(in_time))as min_time,
	 date(max(in_time))as max_time
from 
	tb_user_log
group by 
	`uid`)a1

union all

select
	"新晋用户",
	round(sum(case when min_time>=interval_6_day then 1 else 0 end)/count(distinct `uid`),2) as rate
from(select
	`uid`,
	(select date(max(out_time)) from tb_user_log) as max_time_all,
	(select date(min(in_time)) from tb_user_log) as min_time_all,
	(select date_sub((select date(max(out_time)) from tb_user_log),interval 5 day)) as interval_6_day,
	(select date_sub((select date(max(out_time)) from tb_user_log),interval 29 day)) as interval_30_day,
	 date(min(in_time))as min_time,
	 date(max(in_time))as max_time
from 
	tb_user_log
group by 
	`uid`)a


union all
select
	"沉睡用户",
	round(sum(case when max_time<interval_6_day and min_time>=min_time_all  then 1 else 0 end)/count(distinct `uid`),2) as rate
from(select
	`uid`,
	(select date(max(out_time)) from tb_user_log) as max_time_all,
	(select date(min(in_time)) from tb_user_log) as min_time_all,
	(select date_sub((select date(max(out_time)) from tb_user_log),interval 5 day)) as interval_6_day,
	(select date_sub((select date(max(out_time)) from tb_user_log),interval 29 day)) as interval_30_day,
	 date(min(in_time))as min_time,
	 date(max(in_time))as max_time
from 
	tb_user_log
group by 
	`uid`)a3


union all

select
	"流失用户",
	round(sum(case when max_time<interval_30_day and min_time>=min_time_all then 1 else 0 end)/count(distinct `uid`),2) as rate
from(select
	`uid`,
	(select date(max(out_time)) from tb_user_log) as max_time_all,
	(select date(min(in_time)) from tb_user_log) as min_time_all,
	(select date_sub((select date(max(out_time)) from tb_user_log),interval 5 day)) as interval_6_day,
	(select date_sub((select date(max(out_time)) from tb_user_log),interval 29 day)) as interval_30_day,
	 date(min(in_time))as min_time,
	 date(max(in_time))as max_time
from 
	tb_user_log
group by 
	`uid`)a2
)c 
order by rate desc;
	
select 
	uid,
	in_time,
	out_time,
	ranking,
	date_sub(in_time,interval ranking day)
	sign_in
from(
select
	uid,
	date(in_time) in_time,
	date(out_time) out_time,
	rank() over(partition by uid order by date(in_time)) as ranking,
	sign_in
from 
	tb_user_log
where
	artical_id=0 and date(in_time)>='2021-07-01' and date(in_time)<'2021-11-01' and sign_in=1)a


	
select
	uid,
	sign_date,
	count(1) as sign_num
from(
select 
	uid,
	in_time,
	out_time,
	ranking,
	date_sub(in_time,interval ranking day) as sign_date,
	sign_in
from(
select
	uid,
	date(in_time) in_time,
	date(out_time) out_time,
	rank() over(partition by uid order by date(in_time)) as ranking,
	sign_in
from 
	tb_user_log
where
	artical_id=0 and date(in_time)>='2021-07-01' and date(in_time)<'2021-11-01' and sign_in=1)a)b
group by 
	uid,
	sign_date

	
select
	uid,
	sum(jifen_z+jifen_g)
from(
select
	uid,
	sign_date,
	floor(sign_num/7) *8+sign_num as jifen_z,
	case when mod(sign_num,7)=3 then 2 else 0 end as jifen_g
from(
select
	uid,
	sign_date,
	count(1) as sign_num
from(
select 
	uid,
	in_time,
	out_time,
	ranking,
	date_sub(in_time,interval ranking day) as sign_date,
	sign_in
from(
select
	uid,
	date(in_time) in_time,
	date(out_time) out_time,
	rank() over(partition by uid order by date(in_time)) as ranking,
	sign_in
from 
	tb_user_log
where
	artical_id=0 and date(in_time)>='2021-07-01' and date(in_time)<'2021-11-01' and sign_in=1)a)b
group by 
	uid,
	sign_date)c
	)d
group by 
	uid

import pandas as pd


def get_data(file_path):
    #读取文件
    data=pd.read_excel(file_path,skiprows=1,sheet_name='刷新记录')
    #筛选命中的单子
    data_mz=data[data['是否命中']=='是']
    #获取基线版本和F1name
    data_jxbb_dz=data_mz[['基线版本','F1name']].values.tolist()
    #输出结果
    print(data_jxbb_dz)
    #返回数据
    return data_jxbb_dz



# get_data('./北京产品稳定性Beta问题单2020年-ABYJC.xlsx')



def get_str(s):
    s1=['0' for i in range(len(s))]
    s_even=''.join(list(filter(lambda x:s.index(x)%2==0,s)))
    s_even=sorted(s_even)
    print(s_even)
    s_odd=''.join(list(filter(lambda x:s.index(x)%2==1,s)))
    s_odd = sorted(s_odd)
    print(s_odd)

    even_index=0
    odd_index=0
    for index,value  in enumerate(s):
        if index%2==0:
            s1[index]=s_even[even_index]
            even_index+=1
        else:
            s1[index]=s_odd[odd_index]
            odd_index+=1
    return ''.join(s1)

print(get_str("decfab"))


def get_transform_zf(s):
    for i in s:
        if i.isdigit():
            number_bin=bin(i)
            bin_temp='0'+number_bin.replace('0b','') if len(number_bin.replace('0b',''))<=4 else number_bin
            bin_rev=reversed(bin_temp)
            bin_num


import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import datetime
import pandas as pd
import requests
import json




date_now=datetime.datetime.now().strftime("%Y-%m-%d")
print(date_now)


def get_data(file_path):
    #读取文件
    data=pd.read_excel(file_path,skiprows=1,sheet_name='刷新记录')
    print(data.columns)
    #筛选命中的单子
    data_mz=data[((data['是否命中']=='是') & (data['录入日期']==date_now))]
    #获取基线版本和F1name
    data_jxbb_dz=data_mz[['基线版本','F1name']].values.tolist()
    #输出结果
    print(data_jxbb_dz)
    #返回数据
    return data_jxbb_dz

print(get_data('./北京产品稳定性Beta问题单2020年-ABYJC.xlsx'))


import requests
import json
import re


#读取cookies数据
with open('cookies.txt','r',encoding='utf8') as f:
    #存储为列表
    cookies_list=f.readlines()


#存储结果
result=''
#遍历每个cookie
for cookie_str in cookies_list:
    #加载cookie
    cookie_dict=json.loads(cookie_str)
    #构建会话
    session=requests.session()
    #加入到会话中
    session.cookies=requests.utils.cookiejar_from_dict(cookie_dict)
    #请求网址
    response=session.get('http://shanzhi.spbeen.com/login/')
    #输出响应内容
    #print(response,response.text)
    #存储结果
    result+=response.text

#输出登录结果，发现欢迎结果为4个，四个用户登录成功
print(re.findall('欢迎',result))

from selenium import webdriver
import time
import json


#用户名
users=[
    {'username':'test123456','password':'test123456'},
    {'username':'wfq123','password':'123'},
    {'username':'cauwfq','password':'cauwfq'},
    {'username':'cauwfq1234','password':'cauwfq1234'}
]


#登录网址
def login(username,password):
    #初始化url
    url='http://shanzhi.spbeen.com/login/'
    #初始化webdriver
    driver=webdriver.Chrome()
    #最大化窗口
    driver.maximize_window()
    #请求url
    driver.get(url)
    #用户名输入框
    username_input=driver.find_element_by_xpath('//*[@id="username"]')
    #发送用户名
    username_input.send_keys(username)
    time.sleep(1)
    #密码输入框
    password_input=driver.find_element_by_xpath('//*[@id="MemberPassword"]')
    #发送密码
    password_input.send_keys(password)
    time.sleep(1)
    #点击登录按钮
    driver.find_element_by_xpath('/html/body/div/div/div[2]/button').click()
    time.sleep(3)
    #获取cookies
    cookie_lists=driver.get_cookies()
    #获取cookie值
    cookie_dict={cookie['name']:cookie['value'] for cookie in cookie_lists}

    #写入文件
    with open('./cookies.txt','a+',encoding='utf8') as f:
        f.write(json.dumps(cookie_dict))
        f.write('\n')
    #退出浏览器
    driver.quit()


if __name__ == '__main__':
    for user in users:
        login(user['username'],user['password'])


# !/usr/bin/env python
# -*- coding: utf-8 -*-
# @Time : 2022/4/8 14:20
# @Author : zw0038142
# @File : selenium_set.py
# @Software: PyCharm

import pandas as pd
from selenium.webdriver import Chrome
from selenium.webdriver import ChromeOptions


options = ChromeOptions()
options.add_experimental_option('excludeSwitches', ['enable-automation'])
options.add_experimental_option('useAutomationExtension', False)
options.add_argument("--headless")  # => 为Chrome配置无头模式

Chrome_Driver = Chrome(options=options)
Chrome_Driver.maximize_window()

Chrome_Driver.execute_cdp_cmd("Page.addScriptToEvaluateOnNewDocument", {
  "source": """
    Object.defineProperty(navigator, 'webdriver', {
      get: () => undefined
    })
  """
})

df = pd.read_excel('./baseline_app_lianjie.xlsx')
print(df)
links = df['链接'].tolist()

dict = {}
for link in links:
    Chrome_Driver.get(link)
    Chrome_Driver.implicitly_wait(10)
    # content = Chrome_Driver.page_source
    # print(content)
    software = Chrome_Driver.find_element_by_xpath('//*[@id="appMain"]/div[2]/div[2]/div[1]/div[1]/div/p').text
    version = Chrome_Driver.find_element_by_xpath('//*[@id="andApp-baseInfo"]/div[2]/div[2]/div/ul/li[7]/p[2]').text
    print(software, version)

    dict[software] = version

# 创建df
res_data = pd.DataFrame({'版本': dict})
print(res_data)
res_data.to_excel('./res.xlsx', index=False)




#include<stdio.h>
#include<string.h>
#include<malloc.h>

typedef struct LNode{
	int data;
	struct LNode * next;
}LNode,*LinkList; 

LinkList List_HeadInsert(LinkList &L){
	LNode *s;
	int x;
	L=(LinkList) malloc(sizeof(LNode));
	L->next=NULL;
	
	scanf("%d",&x);
	while(x!=999){
		s=(LinkList)malloc(sizeof(LNode));
		s->data=x;
		s->next=L->next;
		L->next=s; 
		scanf("%d",&x);
	}
	return L;
}


LinkList List_TailInsert(LinkList &L){
	L=(LinkList)malloc(sizeof(LNode));
	L->next=NULL;
	int x;
	LNode *r=L;
	scanf("%d",&x);
	
	while(x!=999){
		LinkList s=(LinkList)malloc(sizeof(LNode));
		s->data=x;
		r->next=s;
		r=s;
		scanf("%d",&x);
	}
	r->next=NULL;
	return L;
}



//按序号查找节点 
LNode* GetElem(LinkList L,int i){
	int j=1;
	LNode* p=L->next;
	
	if(i==0) return L;
	if(i<1)  return NULL;
	while(p &&j<i){
		p=p->next;
		j++;
	}
	return p;
}


//按值查找节点 
LNode *LocationElem(LinkList L,int e){
	LNode *p=L->next;
	while(p!=NULL&&p->data!=e){
		p=p->next; 
	}
	return p;
	 
}

//输出链表每个节点 
void print_data(LinkList &L){
	LinkList p=L->next;
	while (p){
		printf("%d ",p->data);
		p=p->next;
	} 
}

void reverse_print_data(LinkList L){
	if(L->next!=NULL){
		reverse_print_data(L->next);
	}

	if(L!=NULL) printf("%d ",L->data);

} 

//删除最小值
LinkList Delete_min(LinkList &L){
	LNode *pre=L,*p=L->next;
	LNode *minpre=pre, *minp=p;
	while(p!=NULL){
		if(p->data<minp->data){
			minp=p;
			minpre=pre;
		}
		pre=p;
		p=p->next;
	}
	minpre->next=minp->next;
	free(minp);
	return L;
} 


//递归删除值为num节点 
void Del_x_num(LinkList &L,int num){
	LNode *p;
	if(L==NULL){
		return;
	}
	
	if(L->data==num){
		p=L;
		L=L->next;
		free(p);
		Del_x_num(L,num);
	}
	else{
		Del_x_num(L->next,num);
	}
} 



//删除值为num节点 
void Del_x(LinkList &L, int num){
	LinkList p=L->next;
	LinkList pre=L;
	LinkList q=NULL;
	while(p){
		if(p->data==num){
			q=p;
			p=p->next;
			free(q);
			pre->next=p;
		} 
		else{
			pre=p;
			p=p->next;
		}
	} 
}

LinkList reverse(LNode *p){
	if(p->next==NULL){
		return p;
	}
	
	LinkList temp=NULL;
	LinkList pre=NULL;
	
	while(p){
		temp=p->next;
		p->next=pre;
		pre=p;
		p=temp;
	}
	
	return pre;
} 

int main(){
	LinkList head=NULL;
	LinkList L_list=List_TailInsert(head);
	print_data(L_list);
	printf("\n");
////	reverse_print_data(L_list);
//	LinkList delte_after=Delete_min(L_list);
//	print_data(delte_after);
//	
//	
//	printf("============");
//	Del_x_num(L_list,2);
//	print_data(L_list);
//	
//	printf("\n");
//	printf("============");
//	Del_x(L_list,99);
//	print_data(L_list);
	
		
	printf("\n");
	printf("============");
	LinkList reverse_p=reverse(L_list);
	print_data(reverse_p);
	
	
	return 0;
} 


GS24180

import  pandas as pd
import re
import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import datetime
import pandas as pd
import requests
import json

df=pd.read_excel('./baseline_app_lianjie.xlsx')
print(df)


links=df['链接'].tolist()



headers={
'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.82 Safari/537.36',
'referer': 'https://www.qimai.cn/',
'cookie':'qm_check=SxJXQEUSChd2fHd1dRQQeV5EVVwcEHxZRlVVGGYREGV4dBB3QlRHWllaQxQOAwAQdFlCVVZDAXQIARROQ28FbwAQQEZoB28JHBR8A3QBAR0CBxsFAh4IAAQWCAcIAxkSHBdUWlVaWxYCEgAcABwAHAUbAhJE; PHPSESSID=a3lamhv7v7c84e5el4kb0ieook; tgw_l7_route=d09474674af82c17375cfcdd775c0c28; USERINFO=b%2BnLrXlvq6Gjly4qL3F3VBQIWi%2FwsJAwAvKs4MDmzWc%2FOhTH99WudyOhCv%2FRjk7vEh5Fr6SsqNUQjV1uqKJlcfV1FH%2BCvboXKS8F9qQ702f5nfFgbP1z95a41wBwDhsUUEw9cbYcrWT7iaIyyUvSmQylGZOSMNR1; AUTHKEY=KM9o8UW%2BbRDqZnApx%2BY92AIByCQ48PcHMW7TwpFR2rhGkOEmXvu9FapR%2B3XsShEo0dTmktqRnhnBHSSCXXmi6%2FEyCSxI36cAJosWd1QICYghELTA7dn6ng%3D%3D; aso_ucenter=1541HOSUS38cf0vS6RWkE71kLNcNSsl8NF36KL1PxZ5A%2BgtBoZ33mgzX93vi1wtS1g; synct=1649384903.709; syncd=-190'
}

url='https://api.qimai.cn/andapp/info'




for link in links:
    print(link)
    numbers=re.findall(r'\d+',link)
    print(numbers)
    params={
        'analysis':'ew5TCHYTH1FeVFFAExhXUBBZXFpwEwEDBAIFWgUGBVQKB3YTAQ==',
        'appid':numbers[0],
        'market':numbers[1]
    }
    res=requests.get(url=url,
                     headers=headers,
                     params=params
                     )
    print(res.status_code)
    print(json.loads(res.text)['appInfo']['app_name'],json.loads(res.text)['appInfo']['app_version'])
    time.sleep(60)








{% load staticfiles %}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>学生信息</title>
    <!-- 设置标题中的图标 -->
    <link type="image/x-icon" rel="icon" href="{% static 'images/ilync.ico' %}"/>
    <!-- 引入外部的CSS文件 -->
    <link type="text/css" rel="stylesheet" href="{% static 'css/bootstrap.min.css' %}">
    <link type="text/css" rel="stylesheet" href="{% static 'css/index.base.css' %}">
    <!-- 引入jquery文件 -->
    <script src="{% static 'js/jquery-3.4.1.min.js' %}"></script>

</head>
<body>
    <!-- 页面标题 -->
    <div class="header">
        <div class="header_center">
            <img src="{% static 'images/51kt.png' %}">
            <div>学生信息</div>
        </div>
    </div>

    <!-- 查询区域 -->
    <div class="query">
        <form action="" method="post">
            {% csrf_token %}
            <span>请输入查询条件：</span>
            <input type="text" name="txtquery" id="txtquery" value="{{ input_str }}">
            <input type="submit" class="btn" id="btnquery" value="查询">
            <input type="button" class="btn" id="btnadd" value="添加">
        </form>
    </div>

    <!-- 表单区域 -->
    <div class="formarea add" >
         <form action="/student/add/" method="post">
                 {% csrf_token %}
                 <div style="line-height: 40px;">学号：</div>
                 <div><input type="text" name="sno" class="form-control" style="width:120px;margin-right: 20px;"></div>
                 <div style="line-height: 40px;">姓名：</div>
                 <div><input type="text" name="name" class="form-control" style="width:200px;margin-right: 20px"></div>
                 <div style="line-height: 40px;">性别：</div>
                 <div>
                     <select name="gender" class="form-control" style="width:100px;margin-right: 20px" >
                         <option value="性别">性别</option>
                         <option value="男">男</option>
                         <option value="女">女</option>
                     </select>
                 </div>
                 <div style="line-height: 40px;">出生日期：</div>
                 <div><input type="text"  name="birthday" class="form-control" style="width:150px;margin-right: 20px"></div>
                 <div style="line-height: 40px;">手机号码：</div>
                 <div><input type="text" name="mobile" class="form-control" style="width:200px;margin-right: 20px"></div>
                 <div style="line-height: 40px; clear:both;margin-top:10px">邮箱：</div>
                 <div><input type="text"  name="email" class="form-control" style="width:300px;margin: 10px 20px 0 0"></div>
                 <div style="line-height: 40px;margin-top:10px">地址：</div>
                 <div><input type="text" name="address" class="form-control" style="width:400px; margin: 10px 20px 0 0"></div>
                 <div><input type="button" class="btn" id="add_cancel" value="取消" style="width:80px;height: 35px;margin: 10px 0 0 115px;color:white;background-color: #4cae4c"> </div>
                 <div><input type="submit" class="btn" id="add_commit" value="提交" style="width:80px;height: 35px;margin: 10px 0 0 10px;color:white;background-color: #4cae4c"> </div>
            </form>
    </div>

    <div class="formarea update" >
         <form action="/student/update/" method="post">
                 {% csrf_token %}
                 <div style="line-height: 40px;">学号：</div>
                 <div><input type="text" name="sno" readonly="readonly" class="form-control" style="width:120px;margin-right: 20px;"></div>
                 <div style="line-height: 40px;">姓名：</div>
                 <div><input type="text" name="name" class="form-control" style="width:200px;margin-right: 20px"></div>
                 <div style="line-height: 40px;">性别：</div>
                 <div>
                     <select name="gender" class="form-control" style="width:100px;margin-right: 20px" >
                         <option value="性别">性别</option>
                         <option value="男">男</option>
                         <option value="女">女</option>
                     </select>
                 </div>
                 <div style="line-height: 40px;">出生日期：</div>
                 <div><input type="text"  name="birthday" class="form-control" style="width:150px;margin-right: 20px"></div>
                 <div style="line-height: 40px;">手机号码：</div>
                 <div><input type="text" name="mobile" class="form-control" style="width:200px;margin-right: 20px"></div>
                 <div style="line-height: 40px; clear:both;margin-top:10px">邮箱：</div>
                 <div><input type="text"  name="email" class="form-control" style="width:300px;margin: 10px 20px 0 0"></div>
                 <div style="line-height: 40px;margin-top:10px">地址：</div>
                 <div><input type="text" name="address" class="form-control" style="width:400px; margin: 10px 20px 0 0"></div>
                 <div><input type="button" class="btn" id="update_cancel" value="取消" style="width:80px;height: 35px;margin: 10px 0 0 115px;color:white;background-color: #4cae4c"> </div>
                 <div><input type="submit" class="btn" id="update_commit" value="提交" style="width:80px;height: 35px;margin: 10px 0 0 10px;color:white;background-color: #4cae4c"> </div>
            </form>
    </div>
    <!-- 表格区域 -->
    <div class="content">
        <table class="table table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th>序号</th>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>出生日期</th>
                    <th>手机号码</th>
                    <th>邮箱地址</th>
                    <th>家庭住址</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
               <!-- 展示数据库中取到的学生信息
               [
               (95001,'张三'，‘女’，‘1900-10-10’， ‘13412344321’，‘zhang@163.com’,'上海'),
               (),
               ]
               -->
               {% for student in students %}
                    <tr>
                        <td>{{ forloop.counter }}</td><!-- 序号，从1开始计数 -->
                        <td>{{ student.0 }}</td> <!-- 学号 -->
                        <td>{{ student.1 }}</td> <!-- 姓名 -->
                        <td>{{ student.2 }}</td> <!-- 性别 -->
                        <td>{{ student.3|date:'Y-m-d' }}</td> <!-- 出生日期 -->
                        <td>{{ student.4 }}</td> <!-- 手机号码 -->
                        <td>{{ student.5 }}</td> <!-- 邮箱地址 -->
                        <td>{{ student.6 }}</td> <!-- 家庭住址 -->
                        <td>
                            <input type="button" value="修改" id="btnmodify" class="btn btn-sm " style="width:60px;background-color: navy;color:white;">
                            <input type="button" value="删除" id="btndelete" class="btn btn-sm " style="width:60px;background-color: navy;color:white;">
                        </td> <!-- 修改和删除的按钮 -->
                    </tr>
               {% endfor %}
            </tbody>
        </table>
    </div>

    <!-- 页脚区域 -->
    <div class="footer">
        版权所有 Steven Wang - 版本v1.0.0.1 - 2019/09/01
    </div>
</body>
</html>
<!-- 响应事件-->
<script>
    //入口函数
    $(document).ready(function () {

        //响应输入变化的事件===查询
        $('#txtquery').bind("input propertychange", function () {
            //1. 获取当前输入的值
            var input_str = $('#txtquery').val();
            //2. 实现查询：
            $('table tbody tr').hide().filter(':contains(' + input_str + ')').show();
        });

        //响应删除某一个学生信息
        $('table tbody tr').on('click', '#btndelete', function () {
            //获取学号和姓名
            var sno = $(this).parent().parent().children().eq(1).text();
            var name = $(this).parent().parent().children().eq(2).text();
            //提醒
            var result = confirm("是否确认要删除学生：【学号：" + sno + "  姓名：" + name + "】信息吗？");
            //根据用户选择的值来判断！
            if (result) {
                //转到后端！
                location.href = "student/delete/?sno=" + sno;
            }
        });

        //点击“添加”按钮，弹出添加的表单
        $('#btnadd').click(function () {
            //把添加的表单弹出
            $('.add').fadeIn();
        });
        //隐藏 添加表单的区域
        $('#add_cancel').click(function () {
            //把添加的表单隐藏
            $('.add').fadeOut();
        });
        //点击每一行的“修改”按钮，弹出添加的表单
        $('table tbody tr').on('click', '#btnmodify', function () {
            //把添加的表单弹出
            $('.update').fadeIn();
            //修改时填充数据
            $(".update input[name='sno']").val($(this).parent().parent().children().eq(1).text());
            $(".update input[name='name']").val($(this).parent().parent().children().eq(2).text());
            $(".update select[name='gender']").val($(this).parent().parent().children().eq(3).text());
            $(".update input[name='birthday']").val($(this).parent().parent().children().eq(4).text());
            $(".update input[name='mobile']").val($(this).parent().parent().children().eq(5).text());
            $(".update input[name='email']").val($(this).parent().parent().children().eq(6).text());
            $(".update input[name='address']").val($(this).parent().parent().children().eq(7).text());

        });
        //隐藏 添加表单的区域
        $('#update_cancel').click(function () {
            //把修改的表单隐藏
            $('.update').fadeOut();
        });

        //添加提交前的校验
        $('.add form').submit(function () {

            //校验学号：必须要是95开头的5位数字
            var sno = $(".add input[name='sno']").val().trim();
            if(sno.match(/^[9][5]\d{3}$/) == null){
                alert("输入的学号不符合要求！\n 学号的具体要求：必须要是95开头的5位数字！");
                return false
            }
            //校验姓名：必须要是2-5个汉字
            var name = $(".add input[name='name']").val().trim();
            if(name.match(/^[\u4e00-\u9fa5]{2,5}$/) == null){
                alert("输入的姓名不符合要求！\n 姓名的具体要求：必须要是2-5个汉字！");
                return false
            }
            //性别：只能填写男或者女
            var gender = $(".add select[name='gender']").val().trim();
            if(gender !="男" && gender !="女"){
                alert("选择的性别不符合要求！\n 性别的具体要求：只能是男或者女");
                return false
            }
            //出生日期： yyyy-mm-dd
            var brithday = $(".add input[name='birthday']").val().trim();
            if(brithday.match(/^\d{4}-\d{2}-\d{2}$/) == null){
                alert("输入的出生日期不符合要求！\n 出生日期的具体要求：必须要满足yyyy-mm-dd样式！");
                return false
            }
            //手机号码 -- 第1位1，第2位3589，其他的是数字
            var mobile = $(".add input[name='mobile']").val().trim();
            if(mobile.match(/^[1][35789]\d{9}$/) == null){
                alert("输入的手机号码不符合要求！\n 出生日期的具体要求：第1位1，第2位3589，其他的是数字！");
                return false
            }
            //邮箱地址--
            var email = $(".add input[name='email']").val().trim();
            if (email.match(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/)==null){
                alert("邮箱地址不符合要求！\n具体要求：邮箱地址不符合规范，必须包含.和@");
                return false;
            }
            //家庭住址--不能为空
            var address = $(".add input[name='address']").val().trim();
            if (address.length === 0){
                alert("家庭住址不能为空！");
                return false;
            }
            //最后！
            return true;
        });

        //修改提交前的校验
         $('.update form').submit(function () {

            //校验学号：必须要是95开头的5位数字
            var sno = $(".update input[name='sno']").val().trim();
            if(sno.match(/^[9][5]\d{3}$/) == null){
                alert("输入的学号不符合要求！\n 学号的具体要求：必须要是95开头的5位数字！");
                return false
            }
            //校验姓名：必须要是2-5个汉字
            var name = $(".update input[name='name']").val().trim();
            if(name.match(/^[\u4e00-\u9fa5]{2,5}$/) == null){
                alert("输入的姓名不符合要求！\n 姓名的具体要求：必须要是2-5个汉字！");
                return false
            }
            //性别：只能填写男或者女
            var gender = $(".update select[name='gender']").val().trim();
            if(gender !="男" && gender !="女"){
                alert("选择的性别不符合要求！\n 性别的具体要求：只能是男或者女");
                return false
            }
            //出生日期： yyyy-mm-dd
            var brithday = $(".update input[name='birthday']").val().trim();
            if(brithday.match(/^\d{4}-\d{2}-\d{2}$/) == null){
                alert("输入的出生日期不符合要求！\n 出生日期的具体要求：必须要满足yyyy-mm-dd样式！");
                return false
            }
            //手机号码 -- 第1位1，第2位3589，其他的是数字
            var mobile = $(".update input[name='mobile']").val().trim();
            if(mobile.match(/^[1][35789]\d{9}$/) == null){
                alert("输入的手机号码不符合要求！\n 出生日期的具体要求：第1位1，第2位3589，其他的是数字！");
                return false
            }
            //邮箱地址--
            var email = $(".update input[name='email']").val().trim();
            if (email.match(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/)==null){
                alert("邮箱地址不符合要求！\n具体要求：邮箱地址不符合规范，必须包含.和@");
                return false;
            }
            //家庭住址--不能为空
            var address = $(".update input[name='address']").val().trim();
            if (address.length === 0){
                alert("家庭住址不能为空！");
                return false;
            }
            //最后！
            return true;
        });

    });
</script>
