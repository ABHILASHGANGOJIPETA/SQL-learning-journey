-- case statements

use excelr_3;
-- select, update, group by, order by

select * from myemp;

-- 0-10000 - low, 10000-20000 - mediu,m, >20000 - high

select * ,
case when salary < 10000 then "low"
when salary between 10000 and 20000 then "medium"
else "high" end as status from myemp;

-- group by

select dep_id,count(emp_id) from myemp group by dep_id;

select case when salary <10000 then "low"
when salary between 10000 and 20000 then "medium"
else "high" end category,count(emp_id) as no_of_emp from myemp
group by category;

-- order by

select * from myemp order by case when job_id = "AD_PRES" then 1
when job_id = "AD_VP" then 2
when job_id = "IT_PROG" then 3
else 4 end;

select distinct(job_id) from myemp;

select *, 
case when salary <10000 then "low"
when salary between 10000 and 20000 then "medium"
else "high" end category
from myemp order by case when salary between 10000 and 20000 then 1
when salary <10000 then 2
else 3 end;

select *, 
case when salary <10000 then "low"
when salary between 10000 and 20000 then "medium"
else "high" end category
from myemp order by case when salary between 10000 and 20000 then 1
when salary <10000 then 2
else 3 end;



alter table myemp add column categoty varchar(20);

select * from myemp;

update myemp set
category = case when salary >20000 then "high" when salary between 10000 and 20000 then "mediun" else "low" end;

set sql_safe_updates = 0;



