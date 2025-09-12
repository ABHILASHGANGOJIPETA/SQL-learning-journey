-- subquery : query inside the query
-- first name of top salaried person

select first_name from myemp where salary = (select max(salary) from myemp);

select first_name from myemp where salary = 25000;

select max(salary) from myemp;

update myemp set salary = 25000 where emp_id = 102;

select * from myemp;

-- name of 2nd higest salaried person in myemp

set sql_safe_updates =  0;


select first_name from myemp where salary = (select max(salary) from myemp where salary < (select max(salary) from myemp));

select first_name from myemp where salary = (select max(salary) from myemp where salary < 25000);

select first_name from myemp where salary = 17000;


-- find the 10th highest person
select first_name from
(select * , dense_rank() over (order by salary desc) as dr from myemp) as temp where dr = 1;

-- find the employees whose salary is < avg(salary)

SELECT *
FROM myemp
WHERE salary < (SELECT AVG(salary) FROM myemp);

select avg(salary) from myemp;

select *,(select avg(salary) from myemp) as avg_sal from myemp where salary < (select avg(salary) from myemp);

-- find the combinations  of meals and drinks where total price > 40 rupess

select * from meals;

SELECT * FROM MEALS CROSS JOIN 

SELECT * FROM 
(SELECT MEALNAME,DRINKNAME,M.RATE + D.RATE AS TOTAL_PRICE





-- FIND THE MOVIES WHERE ACTOR DEATAILS ARE NOT GIVEN

SELECT * FROM MOVIES;
SELECT * FROM MEMBERS;

SELECT TITLE FROM
(SELECT * FROM MOVIES LEFT JOIN MEMBERS ON MOVIES.ID = MEMBERS.MOVIEID) AS T1 WHERE MEMID IS NULL;



-- FIND THE EMPLOYEES WHOSE SALARY IS > THEIR MANAGER SALARY;

SELECT * FROM MYEMP;

SELECT E.EMP_ID AS EMPLOYEE_ID, E.FIRST_NAME AS EMPLOYEENAME, E.SALARY AS EMP_SALARY,
M.FIRST_NAME AS MANAGER_NAME,
M.SALARY AS MANAGER_SALARY FROM MYEMP AS E LEFT JOIN MYEMP AS M ON E.MGR_ID = 
