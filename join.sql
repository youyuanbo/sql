use advance;

DROP TABLE if exists table_dept;
# 创建tabele_dept表
CREATE TABLE table_dept(
    id  INT(11) NOT NULL AUTO_INCREMENT,
    deptName  VARCHAR(30) DEFAULT NULL,
    locAdd  VARCHAR(40) DEFAULT NULL,
    PRIMARY KEY (id)
)ENGINE = INNODB AUTO_INCREMENT=1 DEFAULT CHARSET = utf8;

#创建table_emp

DROP TABLE IF EXISTS table_emp;
CREATE TABLE table_emp(
    id  INT(11) NOT NULL AUTO_INCREMENT,
    name  VARCHAR(20) DEFAULT NULL,
    deptId  INT(11) DEFAULT NULL,
    PRIMARY KEY (id)
#     CONSTRAINT foreign key (deptId) references table_dept(id)
)ENGINE = INNODB AUTO_INCREMENT=1 DEFAULT CHARSET = utf8;

#插入数据
INSERT INTO table_dept(deptName, locAdd) VALUES ('RD', 11);
INSERT INTO table_dept(deptName, locAdd) VALUES ('HR', 12);
INSERT INTO table_dept(deptName, locAdd) VALUES ('MK', 13);
INSERT INTO table_dept(deptName, locAdd) VALUES ('MIS',14);
INSERT INTO table_dept(deptName, locAdd) VALUES ('FD', 15);

INSERT INTO table_emp(name, deptId) VALUES ('z3',1);
INSERT INTO table_emp(name, deptId) VALUES ('z4',1);
INSERT INTO table_emp(name, deptId) VALUES ('z5',1);

INSERT INTO table_emp(name, deptId) VALUES ('w5',2);
INSERT INTO table_emp(name, deptId) VALUES ('w6',3);

INSERT INTO table_emp(name, deptId) VALUES ('s7',3);

INSERT INTO table_emp(name, deptId) VALUES ('s8',4);

INSERT INTO table_emp(name, deptId) VALUES ('s9', 51);

# select
select * from table_emp;
select * from table_dept;


# inner join
SELECT * FROM table_emp INNER JOIN table_dept ON table_emp.deptId = table_dept.id;

# left join
SELECT * FROM table_emp emp LEFT JOIN table_dept dept ON emp.deptId = dept.id;

# right join
SELECT * FROM table_emp emp RIGHT JOIN table_dept dept ON emp.deptId = dept.id;

# left out join
# 显示左表的独有
SELECT * FROM table_emp emp LEFT JOIN table_dept dept ON emp.deptId = dept.id WHERE dept.id IS NULL;

# right out join
# 显示右表的独有
SELECT * FROM table_emp emp RIGHT JOIN table_dept dept ON emp.deptId = dept.id WHERE emp.deptId IS NULL;

# full join

SELECT * FROM table_emp emp LEFT JOIN table_dept dept ON emp.deptId = dept.id
UNION
SELECT * FROM table_emp emp RIGHT JOIN table_dept dept ON emp.deptId = dept.id;

#
# 显示左表与右表的独有部分
SELECT * FROM table_emp emp LEFT JOIN table_dept dept ON emp.deptId = dept.id WHERE dept.id IS NULL
UNION
SELECT * FROM table_emp emp RIGHT JOIN table_dept dept ON emp.deptId = dept.id WHERE emp.deptId IS NULL;
