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
SELECT *
FROM user;
---
DESCRIBE user;
---
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