use advance;

DROP TABLE IF EXISTS tableA;

CREATE TABLE TableA(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    age INT,
    birth TIMESTAMP NOT NULL
)ENGINE = INNODB ;

INSERT INTO TableA(age, birth) VALUES (22, NOW());
INSERT INTO TableA(age, birth) VALUES (23, NOW());
INSERT INTO TableA(age, birth) VALUES (24, NOW());
INSERT INTO TableA(age, birth) VALUES (25, NOW());

CREATE INDEX idx_tableA_age_birth ON TableA(age, birth);

SELECT * FROM TableA;

SHOW INDEX FROM TableA;

# Using where; Using index
EXPLAIN SELECT * FROM TableA WHERE age > 20 ORDER BY age ;

# Using where; Using index
EXPLAIN SELECT * FROM TableA WHERE age > 20 ORDER BY age, birth;

# Using where; Using index; Using filesort
EXPLAIN SELECT * FROM TableA WHERE age > 20 ORDER BY birth;

# Using where; Using index; Using filesort
EXPLAIN SELECT * FROM TableA WHERE age > 20 ORDER BY birth, age;

# Using index; Using filesort
EXPLAIN SELECT * FROM TableA ORDER BY birth;

# Using where; Using index; Using filesort
EXPLAIN SELECT * FROM TableA WHERE birth > '2019-05-24 09:22:39' ORDER BY birth;

# Using where; Using index
EXPLAIN SELECT * FROM TableA WHERE birth > '2019-05-24 09:22:39' ORDER BY age;

# Using index; Using filesort
EXPLAIN SELECT * FROM TableA ORDER BY age ASC , birth DESC ;

# order by use ASC
#order by子句使用索引最左前列























































































































































































