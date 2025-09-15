-- find the employee whose salary > their dep_avg_salary

select * from myemp as e1 where salary > (select avg(salary) from myemp as e2 where e2.dep_id);

select * from myemp where salary > (select avg_sal from
	(select dep_id,avg(salary) as avg_sal from myemp group by dep_id) as temp
    where myemp.dep_id = temp.dep_id);