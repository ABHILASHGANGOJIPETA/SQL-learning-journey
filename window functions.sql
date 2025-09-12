-- window functions

select * , rank() over (order by salary desc) as r from myemp;

select * , dense_rank() over (order by salary desc) as dr from myemp;

select * , dense_rank() over (partition by dep_id order by salary desc) as dr from myemp;

-- write a wuery to get experience wise dense_rank in each dept

select * , dense_rank() over (partition by dep_id order by hire_date) as dr from myemp;

select * , row_number() over () as rn from myemp;

create table sales_data (year year, sales smallint unsigned);

insert into sales_data values  (2014,200), (2015,500), (2016,650), (2017,680);

select * from sales_data;

select * ,lag(sales) over () as PY_Sales from sales_data;

-- (cy-py)/py
use excelr_3;
select year,
sales as cy_sales,	-- cy = current year sales
lag(sales) over () as PY_sales,
concat(round(((sales - lag(sales) over())*100) / lag(sales) over()),"%") as yoy from sales_data;

-- rank(),denser_rank(),row_number(),

select emp_id,salary,dep_id,hire_date,first_value(salary) over (partition by dep_id order by hire_date rows between unbounded preceding and unbounded following) as exp_salary from myemp; 

select *,first_value(salary) over(order by salary desc) as highest_sal from myemp;
select *,last_value(salary) over(order by salary desc rows between unbounded preceding and unbounded following) as least_sal from myemp;

select *,nth_value(salary,2) over(order by salary desc) as nth_sal from myemp;


select * from sales_data;

-- moving/rolling calculation  
select *,avg(sales) over(rows between 2 preceding and current row) as 3_yrs_rolling_avg from sales_data;
