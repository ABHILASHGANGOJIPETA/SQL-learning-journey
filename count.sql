select count(emp_id) from myemp;
select job_id, count(emp_id) from myemp where job_id = "pu_clerk" ;

select dep_id, count(emp_id) from myemp where dep_id in (50,80,30) group by dep_id having count(emp_id) > 40;

select job_id, count(emp_id) from myemp group by job_id having count(emp_id) > 5;

