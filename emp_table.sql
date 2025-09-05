use excelr;

create table emp(emp_id tinyint primary key,
emp_name varchar(20) not null,
email varchar(40) unique key,
salary smallint unsigned);

insert into emp values(101,"Abhi","abhi@gmail.com",30000),(102,"arun","arun@gmail.com",7000);

insert into emp(emp_id,emp_name,salry) values (104,"Adarsh",10000);
select * from emp;

show tables;

select * from myemp;

update myemp set commission_pct = 0.10;

update myemp set commission_pct = 0.15 where emp_id = 100;  -- where clause will filter the rows

set sql_safe_updates = 0;  -- Inturn off the safe update mode and allow to run update and delete queries

-- update for 100,110,115

update myemp set salary = salary + 5000 where emp_id = 100 or emp_id = 110 or emp_id = 115;

update my_emp set salary = salary + 5000 where emp_id in (110,100,115); -- membership operator

update myemp set salary = salary + 5000 where emp_id not in (110,100,115); -- membership operator

-- write an uptade query to set cmsn_pct = 0.2 for people from It_prog job_id and salary >5000

update myemp set commission_pct = 0.2 where job_id = "it_prog" and salary >5000; -- logical operator

-- update cmsn pct = 0 for 10, 20, 30, 40

update myemp set commission_pct = 0.0 where dep_id between 10 and 40; -- math operators

update myemp set commission_pct = 0.0 where dep_id not between 50 and 110; -- math operators

update myemp set salary = 25000 where emp_id = 100;  -- math operators

update myemp set salary = 25000 where emp_id != 100;  -- math operators

update myemp set salary = 25000 where emp_id < 100;  -- math operators

update myemp set salary = 25000 where emp_id > 100;  -- math operators

update myemp set salary = 25000 where emp_id >= 100;  -- math operators

update myemp set salary = 25000 where emp_id <= 100;  -- math operators

-- 