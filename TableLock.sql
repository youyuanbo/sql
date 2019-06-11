USE advance;

DROP TABLE IF EXISTS mylock;

CREATE TABLE mylock(
    id  INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(20)
)ENGINE = INNODB ;

INSERT INTO mylock(name) VALUES ('a');
INSERT INTO mylock(name) VALUES ('b');
INSERT INTO mylock(name) VALUES ('c');
INSERT INTO mylock(name) VALUES ('d');
INSERT INTO mylock(name) VALUES ('e');


SELECT * FROM mylock;

USE advance;

# add lock
LOCK TABLES mylock read ;

LOCK TABLES book WRITE ;

# unlock table
UNLOCK TABLES ;


# show lock
SHOW OPEN TABLES ;

# after add read lock, can not update

UPDATE mylock SET name='a2' WHERE id = 1;

SELECT * FROM book;

LOCK TABLES mylock WRITE ;

SELECT * from mylock;
select * from book;

UPDATE mylock SET name='b2' WHERE id = 2;

UNLOCK TABLES ;


SHOW STATUS  LIKE 'table%';

show variables like 'tx_isolation';








































