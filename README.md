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
