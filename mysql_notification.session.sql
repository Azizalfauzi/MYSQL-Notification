SHOW DATABASES;
---
SHOW TABLES;
--- USER
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
SELECT *
FROM user;
---
DESCRIBE user;
--- NOTIFICATION
CREATE TABLE notification(
    id INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    user_id VARCHAR(100),
    PRIMARY KEY(id)
) Engine = InnoDb;
---
DESCRIBE notification;
---
ALTER TABLE notification
ADD CONSTRAINT fk_notification_user FOREIGN KEY (user_id) REFERENCES user(id);
---
INSERT INTO notification(title, detail, created_at, user_id)
VALUES (
        'Pesanan Anda',
        'Detail Pesanan Anda',
        CURRENT_TIMESTAMP(),
        "aziz"
    );
---
INSERT INTO notification(title, detail, created_at, user_id)
VALUES (
        'Contoh Promo',
        'Contoh Detail Promo',
        CURRENT_TIMESTAMP(),
        null
    );
---
INSERT INTO notification(title, detail, created_at, user_id)
VALUES (
        'Pembayaran anda',
        'Detail Pembayaran Anda',
        CURRENT_TIMESTAMP(),
        'alfa'
    );
---
SELECT *
FROM notification;
---
SELECT *
FROM notification
WHERE (
        user_id = 'aziz'
        OR user_id IS NULL
    )
ORDER BY created_at DESC;
---
SELECT *
FROM notification
WHERE (
        user_id = 'alfa'
        OR user_id IS NULL
    )
ORDER BY created_at DESC;
--- CATEGORY
CREATE TABLE category(
    id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY(id)
) Engine = InnoDb;
---
DESCRIBE category;
---
ALTER TABLE notification
ADD COLUMN category_id VARCHAR(100);
---
ALTER TABLE notification
ADD CONSTRAINT fk_notification_category FOREIGN KEY (category_id) REFERENCES category(id);
---
DESCRIBE notification;
---
SELECT *
FROM notification;
---
INSERT INTO category(id, name)
VALUES('INFO', 'Info');
INSERT INTO category(id, name)
VALUES('PROMO', 'Promo');
---
SELECT *
FROM category;
SELECT *
FROM notification;
---
UPDATE notification
SET category_id = 'INFO'
WHERE id = 3;
---
SELECT *
FROM notification
WHERE (
        user_id = 'alfa'
        OR user_id IS NULL
    )
ORDER BY created_at DESC;
---
SELECT *
FROM notification n
    JOIN category c ON (n.category_id = c.id)
WHERE (
        n.user_id = 'aziz'
        OR n.user_id IS NULL
    )
ORDER BY n.created_at DESC;
---
SELECT *
FROM notification n
    JOIN category c ON (n.category_id = c.id)
WHERE (
        n.user_id = 'alfa'
        OR n.user_id IS NULL
    )
ORDER BY n.created_at DESC;
---
SELECT *
FROM notification n
    JOIN category c ON (n.category_id = c.id)
WHERE (
        n.user_id = 'alfa'
        OR n.user_id IS NULL
    )
    AND c.id = 'INFO'
ORDER BY n.created_at DESC;
--- Read dan Unread
CREATE TABLE notification_read(
    id INT NOT NULL AUTO_INCREMENT,
    is_read BOOLEAN NOT NULL,
    notification_id INT NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    PRIMARY KEY(id)
) Engine = InnoDb;
---
DESCRIBE notification_read;
---
ALTER TABLE notification_read
ADD CONSTRAINT fk_notification_read_notification FOREIGN KEY (notification_id) REFERENCES notification(id);
---
ALTER TABLE notification_read
ADD CONSTRAINT fk_notification_read_user FOREIGN KEY (user_id) REFERENCES user(id);
---
SELECT *
FROM notification;
---
INSERT INTO notification_read (is_read, notification_id, user_id)
VALUES (TRUE, 2, 'aziz');
INSERT INTO notification_read (is_read, notification_id, user_id)
VALUES (TRUE, 3, 'alfa');
---
SELECT *
FROM notification_read;
---
SELECT *
FROM notification n
    JOIN category c ON (n.category_id = c.id)
    LEFT JOIN notification_read nr ON (nr.notification_id = n.id)
WHERE (
        n.user_id = 'aziz'
        OR n.user_id IS NULL
    )
    AND (
        nr.user_id = 'aziz'
        OR nr.user_id IS NULL
    )
ORDER BY n.created_at DESC;
--- 
INSERT INTO notification(title, detail, category_id, user_id, created_at)
VALUES (
        'Contoh Pesananan Test',
        'Detail Pesanan Test',
        'INFO',
        'aziz',
        CURRENT_TIMESTAMP()
    );
---
INSERT INTO notification(title, detail, category_id, user_id, created_at)
VALUES (
        'Contoh Promo Global',
        'Detail Promo Global',
        'PROMO',
        null,
        CURRENT_TIMESTAMP()
    );