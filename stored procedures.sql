-- stored procedures
use excelr_3;
create table emp_data (emp_data tinyint unsigned primary key,emp_name varchar(30), salary smallint unsigned not null);

select * from emp_data;


-- -----------------------------------------------------------------------
drop table b_d;
create table b_d (ac_no tinyint  unsigned, balance smallint unsigned);

insert into b_d values (101,20000),(102,5000),(103,1),(104,40000);

select * from b_d;

set sql_safe_updates = 0;

-- ------------------------------------------
select * from products;

select productline, count(pname) from products group by productline order by count(pname);

call new_procedure('trains',@count_prods);

select 1000 * @count_prods;