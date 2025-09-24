-- cursor

select * from products;
select * from orders;
-- <2000 - status as immediate req, -- 2000-5000 needed 5000 --> 5000 sufficent stock



-- enum data type, coalesce function
select * from names;

select coalesce(fn,mn,ln) as name from names;  -- first non null enteries 

-- enum    -- is a spl data type

create table t45 (sno tinyint, name varchar(10),gender enum("male","female","not_specified"));

insert into t45 values(1,"arun","male"),(2,"arun","female");

select * from t45;

insert into t45 (sno,name) values(3,"aswin");


