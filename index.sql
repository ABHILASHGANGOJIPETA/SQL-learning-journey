-- indexes

use excelr_3;

describe authors;
show indexes from authors;

create index name_idx on authors(name);  -- creating a non_unique_index

show indexes from myemp;

create unique index eml_idx on myemp(email);    -- creating a unique_index

alter table myemp drop index eml_idx;

