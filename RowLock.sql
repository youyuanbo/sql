USE advance;

DROP TABLE IF EXISTS test_innodb_lock;

CREATE TABLE test_innodb_lock(
    a INT(11),
    b VARCHAR(16)
)ENGINE = INNODB ;

INSERT INTO test_innodb_lock(a, b) VALUES (1, 'b1');
INSERT INTO test_innodb_lock(a, b) VALUES (1, 'b2');
INSERT INTO test_innodb_lock(a, b) VALUES (3, '3');
INSERT INTO test_innodb_lock(a, b) VALUES (4, '4000');
INSERT INTO test_innodb_lock(a, b) VALUES (5, '5000');
INSERT INTO test_innodb_lock(a, b) VALUES (6, '6000');
INSERT INTO test_innodb_lock(a, b) VALUES (7, '7000');
INSERT INTO test_innodb_lock(a, b) VALUES (8, '8000');
INSERT INTO test_innodb_lock(a, b) VALUES (9, '9000');

CREATE INDEX test_innodb_a_ind ON test_innodb_lock(a);

CREATE INDEX test_innodb_b_ind ON test_innodb_lock(b);

select * from test_innodb_lock;

SET autocommit = 0;


begin ;

select * from test_innodb_lock where a = 8 for update ;

update test_innodb_lock set b = '8002' where a = 8;

select * from test_innodb_lock;

commit ;








