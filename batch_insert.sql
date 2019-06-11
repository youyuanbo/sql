DROP DATABASE IF EXISTS bigData;

CREATE DATABASE bigData;

USE bigData;

DROP TABLE IF EXISTS dept;

CREATE TABLE dept(
    id      INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    deptno  MEDIUMINT UNSIGNED NOT NULL DEFAULT 0,
    dname   VARCHAR(20) NOT NULL DEFAULT '',
    loc     VARCHAR(13) NOT NULL DEFAULT ''
)ENGINE = INNODB DEFAULT CHARSET=utf8;

desc dept;

DROP TABLE IF EXISTS emp;

CREATE TABLE emp(
    id      INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    empno   MEDIUMINT UNSIGNED NOT NULL DEFAULT 0,
    ename   VARCHAR(20) NOT NULL DEFAULT '',
    job     VARCHAR(9)  NOT NULL DEFAULT '',
    mgr     MEDIUMINT UNSIGNED NOT NULL default 0,
    hiredate DATE NOT NULL,
    sal     DECIMAL(7,2) NOT NULL,
    comm    DECIMAL(7,2) NOT NULL,
    deptno  MEDIUMINT UNSIGNED NOT NULL DEFAULT 0
)ENGINE = INNODB DEFAULT CHARSET = utf8;


desc emp;

# 开启二进制日志文件记录
show variables like 'log_bin_trust_function_creators';

set global log_bin_trust_function_creators=1;

# Change the configuration file
# log_bin_trust_function_creators=1

select now() from dual;

# create function
# generate a random string
DELIMITER $$
CREATE FUNCTION rand_string(n INT) RETURNS VARCHAR(255)
BEGIN
    DECLARE char_str VARCHAR(100) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    DECLARE return_str VARCHAR(255) DEFAULT '';
    DECLARE i INT DEFAULT 0;
    WHILE i < n DO
        SET return_str = CONCAT(return_str, SUBSTRING(char_str, FLOOR(1+RAND()*52),1));
        SET i = i + 1;
    END WHILE ;
    RETURN return_str;
END $$

drop function rand_string;


# generate a random empno
DELIMITER $$
CREATE FUNCTION random_num() RETURNS INT(5)
BEGIN
    DECLARE i INT DEFAULT 0;
    SET i = FLOOR(100 + RAND()*10);
    RETURN i;
END $$

# insert into emp

DELIMITER $$
CREATE PROCEDURE insert_emp(IN START INT(10), IN max_num INT(10))
BEGIN
    DECLARE i INT DEFAULT 0;
    SET autocommit = 0;
    REPEAT
        SET i = i + 1;
        INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUE ((START + i), rand_string(6), 'SALESMAN', 001, NOW(),15, 25, 1);
        UNTIL i = max_num
    END REPEAT ;
    COMMIT ;
end $$

# insert into dept
DELIMITER $$
CREATE PROCEDURE insert_dept(IN START INT(10), IN max_num INT(10))
BEGIN
    DECLARE i INT DEFAULT 0;
    SET autocommit = 0;
    REPEAT
        SET i = i + 1;
        INSERT INTO dept(deptno, dname, loc) VALUES ((START + i), rand_string(10), rand_string(8));
        UNTIL i = max_num
    END REPEAT ;
    COMMIT ;
end $$


DELIMITER ;
CALL insert_dept(100,10);

CALL insert_dept(100001, 500000);

CALL insert_emp(10001, 50000);

select *
from dept;

show variables like 'profiling';







