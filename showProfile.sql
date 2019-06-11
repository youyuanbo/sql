# 查看开启状态
show variables like 'profiling';

# 设置开启profiling
set profiling = on;

use bigdata;

select * from emp;

show profiles ;

show profile cpu, block io for query 155;

show profile cpu ,block io for query 1;


use advance;
show tables ;

select * from table_emp emp left join table_dept dept on emp.deptId = dept.id;



select * from mylock;

UPDATE mylock SET name='c2' WHERE id = 3;
























































