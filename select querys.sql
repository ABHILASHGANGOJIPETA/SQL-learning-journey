-- select

select * from myemp;

select emp_id, first_name, salary from myemp;

select emp_id, 
concat(first_name," ",last_name) as employee_name,
email as email_id,
hire_date as joining_id,
dep_id as department_id
from myemp;

alter table myemp add column full_name varchar(40);

update myemp set full_name = concat(first_name," ", last_name);

select emp_id, salary, dep_id from myemp where dep_id = 50;

-- write a query to print dep_id = 50,60,70 emps whose salary is > 5000;

SELECT * from myemp WHERE dep_id in (50, 60, 70) and salary >5000 order by salary desc;

-- write a query to print only dep_50 in order of experience/hire_date


select * from myemp WHERE dep_id = 50 ORDER BY hire_date;

select * from myemp where hire_date = (select min(hire_date));

-- write a query to print name of the top salaried person in the entire data set

SELECT full_name FROM myemp ORDER BY salary DESC LIMIT 1;  -- limit the no of rows that are printed

SELECT full_name FROM myemp ORDER BY salary DESC LIMIT 1 OFFSET 1;  -- offset will skip the no of rows

-- group by
use excelr_3;
select avg(salary) from myemp;

select dep_id,avg(salary) from myemp group by dep_id;

-- print dep_id, count of emp from myemp for dep - 10,30,50,70,90,110 in dec order of emp_count

SELECT dep_id, COUNT(emp_id) -- 4
FROM myemp -- 1
WHERE dep_id IN (10, 30, 50, 70, 90, 110) -- 2
GROUP BY dep_id -- 3
having count(emp_id) > 30 -- 5
ORDER BY count(emp_id) DESC; -- 6

-- print dep_id and avg(salary) where avg is > 5000

SELECT dep_id, AVG(salary)
FROM myemp
GROUP BY dep_id
HAVING AVG(salary) > 5000;


-- from (pick the table)
-- join (pick the multiple tables joined for analysis)

-- where (filters and calculates the aggregates)
-- group by (groups and calculates the aggregates)
-- having (filter the grouped result)

-- select
-- order by
-- offset
-- limit


