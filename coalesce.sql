-- coalesce function

use excelr_3;

select * from  names;
select * from employees;

select coalesce(fn,mn,ln) as name from names;