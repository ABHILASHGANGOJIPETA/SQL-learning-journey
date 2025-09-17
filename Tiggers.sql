-- Tiggers

-- before insert
use excelr_3;
create table emp_whrs (emp_id tinyint unsigned, w_hrs tinyint unsigned, ot_hrs tinyint unsigned);

describe emp_whrs;

insert into emp_whrs (emp_id,w_hrs) values (101,7),(102,9),(103,15);
select * from emp_whrs;


-- after insert

create table main_student (sid tinyint unsigned, sname varchar(10), cname varchar(10));

create table DA (sid tinyint unsigned, sname varchar(10), cname varchar(10));

create table ds (sid tinyint unsigned, sname varchar(10), cname varchar(10));

create table FSD (sid tinyint unsigned, sname varchar(10), cname varchar(10));


insert into main_student values (101, "swetha", "ds");

select * from main_student;
select * from da;

-- before update

create table mobiles (mid tinyint, price smallint);

insert into mobiles values (101, 14000),(102,25000),(103,20000),(104,30000);

select * from mobiles;
set sql_safe_update = 0;
update mobiles set price = price + 21000 where mid = l04;

-- after update
select * from books;

ALTER TABLE Books
ADD tot_qty INT DEFAULT 0;

update books set tot_qty = tot_qty + 30 where bookid = 4;

select * from book_sales;

-- before delete

select * from myemp;
create table backup (empid tinyint, first_name varchar(30));

ALTER TABLE backup ADD column lwd datetime;
select * from backup;






