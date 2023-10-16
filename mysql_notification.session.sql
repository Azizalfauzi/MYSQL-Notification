SHOW DATABASES;
---
SHOW TABLES;
---
CREATE TABLE user (
    id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) Engine = InnoDb;
---
INSERT INTO user(id, name)
VALUES('aziz', 'Aziz Alfa');
INSERT INTO user(id, name)
VALUES('alfa', 'Alfa Aziz');
---
SELECT * FROM user;
---
DESCRIBE user;