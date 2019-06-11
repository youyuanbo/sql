# 查看是否开启慢查询日志记录
show variables like '%slow_query_log%';

# 设置开启慢查询日志记录(当前有效)
 set global slow_query_log = 1;

# 更改配置文件，永久有效
# slow_query_log=1
# slow_query_log_file=D:/Program Files/mysql-5.7.24-winx64/data/slow.log

# 查看慢查询记录日志的阈值
show variables like 'long_query_time';

# 设置慢查询日志记录的阈值（当前有效）
set global long_query_time = 1;

# 设置慢查询日志记录的阈值（更改配置文件，永久有效）
# long_query_time =1
# log_output=FILE

# Test
select sleep(2);


# slow_query_log analytics tool


