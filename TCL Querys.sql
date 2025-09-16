-- tcl Querys
start transaction;
select * from myemp;

insert into myemp 
values( 225, "arun","prakash","arun@xyz.com","1997-10-01","trainer",3000,0.10,100,10,"arun Prakash","low");

select * from myemp;

commit;

start transaction;
update myemp set salary = 5000 where emp_id = 225;
rollback;

-- savepoint
create table t11 (sno tinyint unsigned,name varchar(10));
select * from t11;

start transaction;
insert into t11 values (1,"a"), (2, "b"), (3,"c");
savepoint spl;
insert into t11 values (5,"e"), (4, "d"), (6,"");
savepoint sp2;
update t11 set name = "xyz" where sno in (5,6);
savepoint sp3;
delete from t11 where sno = 3;
rollback to sp3;
rollback to spl;
commit;

-- autoincrement applied on primary key columns only

create table t20 (sno tinyint primary key auto_increment,sname varchar(10));

insert into t20 (sname) values ("arun"),("aruna"),("lakshya"),("lakshith");

select * from t20;

alter table t20 auto_increment 50;

delete from t20; -- 54 no memory refresh
truncate t20; -- 1 memory refreshed



