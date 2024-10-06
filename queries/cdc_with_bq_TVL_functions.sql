CREATE TABLE mytestingenv-355509.delete_me.my_cdc_tbl (
  id INT64,
  name STRING,
  ts timestamp default CURRENT_TIMESTAMP()
)
OPTIONS (
  enable_change_history = TRUE
);

-- 
insert into mytestingenv-355509.delete_me.my_cdc_tbl (id, name) values (1, 'name1');
insert into mytestingenv-355509.delete_me.my_cdc_tbl (id, name) values (2, 'name2');
insert into mytestingenv-355509.delete_me.my_cdc_tbl (id, name) values (3, 'name3');
delete from mytestingenv-355509.delete_me.my_cdc_tbl where id = 2;
update mytestingenv-355509.delete_me.my_cdc_tbl set name = 'name3_updated' where id = 3;

--- all inserted records
SELECT
  id, name,
  _CHANGE_TYPE AS change_type,
  _CHANGE_TIMESTAMP AS change_time
FROM
 APPENDS(TABLE delete_me.my_cdc_tbl, NULL, NULL);

--- all insert, delete, update records
 SELECT
  id, name,
  _CHANGE_TYPE AS change_type,
  _CHANGE_TIMESTAMP AS change_time
FROM
 changes(TABLE delete_me.my_cdc_tbl, NULL, TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 601 SECOND))
 order by change_time desc;
 
 