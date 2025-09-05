-- joins (pick the multiple tables joined for analysis)

-- type of joins
-- left, right, inner join, full outer join. cross join, self join

-- cross join --> which dosn't required any common columns 

select * from meals;
select * from drinks;

select * from meals cross join drinks;

select meals.mealname, 
drinks.drinkname, 
meals.rate+drinks.rate as total_bill
from meals cross join drinks;

select mealname,
drinkname,
m.rate+d.rate as total_bill
from meals as m cross join drinks as d;

--

select * from movies;
select * from members;

select * from movies left join members on movies.id = members.movieid;

-- left join

select id as movie_id,
title as movie_title,
category,
ifnull(memid,"--") as actor_id,
ifnull(concat(first_name," ",last_name),"--") as actor_name from
movies left join members on movies.id = members.movieid;

-- right join

select ifnull(id,"") as movie_id,
ifnull(title,"") as movie_title,
ifnull(category,"") as Category,
memid  as actor_id,
concat(first_name," ",last_name) as actor_name 
from movies RIGHT JOIN members ON movies.id = members.movieid;


-- inner join

-- select * from movies inner join members on movies.id = members.movieid

select * from myemp;

select e.emp_id as employee_id,
e.full_name as employee_name,e.salary as emp_salary,
e.mgr_id as manager_id,
m.full_name as manager_name,m.salary as manager_salary
from myemp as e inner join myemp as m on e.mgr_id = m.emp_id;


