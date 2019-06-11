USE advance;

# create index
# create [unique] index indexName on tableName(columnName(length));
# alter tableName add [unique] index [indexName] on tableName(columnName(length));

# delete index
# drop index [indexName] on tableName;

# show index
# show index from tableName;

CREATE TABLE t1(
    id  INT(11) auto_increment,
    other_col   varchar(10) DEFAULT NULL,
    primary key (id)
)ENGINE = INNODB auto_increment = 1 DEFAULT CHARSET = utf8;

CREATE TABLE t2(
    id  INT(11) auto_increment,
    other_col   varchar(10) DEFAULT NULL,
    primary key (id)
)ENGINE = INNODB auto_increment = 1 DEFAULT CHARSET = utf8;

CREATE TABLE t3(
    id  INT(11) auto_increment,
    other_col   varchar(10) DEFAULT NULL,
    primary key (id)
)ENGINE = INNODB auto_increment = 1 DEFAULT CHARSET = utf8;

INSERT INTO t3() VALUES ();



explain select t2.*
from t1, t2, t3
where t1.id = t2.id and t1.id = t3.id and t1.other_col = '';

explain select t2.*
from t2
where t2.id = (
    select t1.id
    from t1
    where t1.id=(
        select t3.id
        from t3
        where t3.other_col=''
        )
    );

explain select t2.*
from (
     select t3.id
    from t3
    where t3.other_col = '') s1, t2
    where s1.id = t2.id;

explain SELECT * FROM table_emp emp LEFT JOIN table_dept dept ON emp.deptId = dept.id
UNION
SELECT * FROM table_emp emp RIGHT JOIN table_dept dept ON emp.deptId = dept.id;

#type的类型，从好到差
# system const  eq_ref ref range index all

explain select * from t1 where id = 1;

# const
explain select id from (select * from t1 where id = 1) d1;

alter table t1 add (name varchar(10) default null);

# eq_ref
explain select * from t1, t2 where t1.id = t2.id;

INSERT INTO t1(name) VALUES ('t1');
INSERT INTO t1(advance.t1.name) VALUES ('t1');
INSERT INTO t1(advance.t1.name) VALUES ('t1');

alter table t1 add index idx_t1_name (name);
create index idx_t1_name on t1(name);

# ref
explain select * from t1 where t1.name = 't1';

# range
explain select * from t1 where id between 1 and 10;
explain select * from t1 where id >= 1 and id <= 10;

# index
explain select t1.name from t1;

alter table t1 add (address varchar(10) default null);

INSERT INTO t1(advance.t1.address) VALUES ('a1');
INSERT INTO t1(advance.t1.address) VALUES ('a4');
INSERT INTO t1(advance.t1.address) VALUES ('a3');
INSERT INTO t1(advance.t1.address) VALUES ('a2');

create index idx_t1_name_address on t1(name, address);

explain select t1.address, t1.name, t2.id from t1, t2;

explain select name from t1;
explain select name from t1 where t1.name = 'z1' and t1.address = 'a1';
explain select address, name from t1;

INSERT INTO t2(address) VALUES ('a1');
INSERT INTO t2(address) VALUES ('a2');
INSERT INTO t2(address) VALUES ('a3');
INSERT INTO t2(address) VALUES ('a4');

alter table t2 add (address varchar(10) default null);
create index idx_t2_address on t2(address);
explain select t1.address from t1, t2 where t1.address = t2.address and t1.address = 'a1';

# explain select * from table_emp\G

explain select t1.address from t1 where t1.address = 'a1' order by  t1.address;
show index from t1;
drop index idx_t1_name_address on t1;

create index idx_t1_address on t1(address);
create index idx_t1_name on t1(name);

create index idx_t1_name_address on t1(name, address);

explain select name, address from t1;


# 实践 单表查询优化
DROP TABLE IF EXISTS article;

CREATE TABLE article(
    id INT(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    author_id INT(10) UNSIGNED NOT NULL,
    category_id INT(10) UNSIGNED NOT NULL,
    views INT(10) UNSIGNED NOT NULL,
    comments INT(10) UNSIGNED NOT NULL ,
    title varchar(255) NOT NULL ,
    context TEXT NOT NULL
);

INSERT INTO article(author_id, category_id, views, comments, title, context) VALUES (1,1,1,1,'1','1');

INSERT INTO article(author_id, category_id, views, comments, title, context) VALUES (2,2,2,2,'2','2'),(1,1,3,3,'3','3');

select * from article;

select id, author_id from article where category_id = 1 and comments > 1 order by views desc limit 1;
# explain select id, author_id from article where category_id = 1 and comments = 1 order by views desc limit 1;

# 建立包含三个字段的复合索引
alter table article add index idx_article_ccv (category_id, comments, views);
explain select id, author_id from article where category_id = 1 and comments > 1 order by views desc limit 1;
drop index idx_article_ccv on article;
# 由于在where中出现了范围查询，范围后面的查询，索引失效


# 建立包含两个字段的复合索引
alter table article add index idx_article_cv (category_id, views);
explain select id, author_id from article where category_id = 1 and comments > 1 order by views desc limit 1;




# 双表查询优化
DROP TABLE IF EXISTS class;

CREATE TABLE class(
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    card INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS book;

CREATE TABLE book(
    bookId INT(10) NOT NULL AUTO_INCREMENT,
    card INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (bookId)
);

INSERT INTO class(card) VALUES (FLOOR(1+(RAND()*20)));
INSERT INTO class(card) VALUES (FLOOR(1+(RAND()*20)));
INSERT INTO class(card) VALUES (FLOOR(1+(RAND()*20)));
INSERT INTO class(card) VALUES (FLOOR(1+(RAND()*20)));
INSERT INTO class(card) VALUES (FLOOR(1+(RAND()*20)));
INSERT INTO class(card) VALUES (FLOOR(1+(RAND()*20)));
INSERT INTO class(card) VALUES (FLOOR(1+(RAND()*20)));
INSERT INTO class(card) VALUES (FLOOR(1+(RAND()*20)));
INSERT INTO class(card) VALUES (FLOOR(1+(RAND()*20)));
INSERT INTO class(card) VALUES (FLOOR(1+(RAND()*20)));




INSERT INTO book(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO book(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO book(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO book(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO book(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO book(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO book(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO book(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO book(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO book(card) VALUES (FLOOR(1+RAND()*20));


# No index
select * from book inner join class on book.card = class.card;
explain select * from book inner join class on book.card = class.card;

# left join
select * from class left join book on class.card = book.card;
explain select * from class left join book on class.card = book.card;

# add index in left table

drop index idx_class_card on class;

create index idx_class_card on class(card);

# add index in right table
drop index idx_book_card on book;

create index idx_book_card on book(card);

show index from book;

# There is a index which name is idx_book_card in book table;
explain select * from class left join book on class.card = book.card;

# There is a index which name is idx_class_card in class table;
explain select * from class left join book on class.card = book.card;

# Conclusion：If the query uses left join, then add the index in right table;

explain select * from class right join book on class.card = book.card;

explain select * from book left join class on class.card = book.card;


# Three table

CREATE TABLE phone(
    phonId INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    card INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (phonId)
)ENGINE = INNODB ;

INSERT INTO phone(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO phone(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO phone(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO phone(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO phone(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO phone(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO phone(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO phone(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO phone(card) VALUES (FLOOR(1+RAND()*20));
INSERT INTO phone(card) VALUES (FLOOR(1+RAND()*20));

select * from class left join book on class.card = book.card left join phone on book.card = phone.card;

create index idx_book_card on book(card);
create index idx_phone_card on phone(card);
explain select * from class left join book on class.card = book.card left join phone on book.card = phone.card;


# 索引失效

CREATE TABLE staff(
    id  INT PRIMARY KEY AUTO_INCREMENT,
    name    varchar(24) NOT NULL DEFAULT '' COMMENT 'name',
    age INT NOT NULL DEFAULT 0 COMMENT 'age',
    position    VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'position',
    add_time    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'add_time'
)CHARSET=utf8 COMMENT 'staff record';

INSERT INTO staff(name, age, position, add_time) VALUES ('z3',22,'manager', NOW());
INSERT INTO staff(name, age, position, add_time) VALUES ('July', 33,'developer',NOW());
INSERT INTO staff(name, age, position, add_time) VALUES ('august',44, 'developer', NOW());


select * from staff;

alter table staff add index idx_staff_name_age_pos(name, age, position);

# 全表匹配
explain select * from staff where name = 'august';

explain select * from staff where name = 'august' and age = 44;

explain select * from staff where name = 'august' and age = 44 and position = 'developer';

# 最左原则
explain select * from staff where name = 'august';

explain select * from staff where name = 'august' and age = 44;

explain select * from staff where name = 'august' and position = 'developer';
# 违背最左原则，索引失效
explain select * from staff where age = 44 and position = 'developer';
# 违背最左原则，索引失效
explain select * from staff where position = 'developer';
# 违背最左原则，中间字段丢失，只能部分使用索引
explain select * from staff where name = 'august' and position = 'developer';

# 不在索引列上做任何操作
explain select * from staff where name = 'July';
# 索引失效，因为在索引列上使用了函数
explain select * from staff where left(name, 4) = 'July';

# 范围右边的索引会失效
explain select * from staff where name = 'august' and age > 22 and position = 'developer';

explain select * from staff where name = 'august' and age = 22 and position = 'developer';


# 减少使用select*
explain select * from staff where name = 'august' and age = 44 and position = 'developer';

explain select name, age, position from staff where name = 'august' and age = 22 and position = 'developer';


# 是用不等于时，会导致索引失效和全表扫描
explain select * from staff where name = 'august' and age != 44;


# 使用了is null或is not null 也会导致索引失效

explain select * from staff where name is NULL;

explain select * from staff where name is NOT NULL;

# 查询中使用了like语句，并且以“%”开头，会导致索引失效，变为全表扫描
explain select * from staff where name like '%augu';
# 如果“%”在右边，则可以使用索引
explain select * from staff where name like 'augu%';
# 如果like语句中需要使用两个“%”，则可以使用覆盖索引
explain select name, age from staff where name like '%ul%';

# 字符串不加单引号，索引会失效
# 理论应该失效，实际未失效
explain select name from staff where name = 777;

# 使用or连接时，索引会失效
# 理论应该失效,实际未失效
explain select name from staff where name = 'august' or name = 'z3';

