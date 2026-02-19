CREATE DATABASE college;
DROP DATABASE sakila;
DROP DATABASE world;

USE college;
CREATE TABLE student (
	rostudentll INT,
    name VARCHAR(30),
    age  INT
);

INSERT INTO student
VALUES
(101,"ADAM",45),
(102,"EVE",35);

SELECT * FROM student;
DROP DATABASE IF EXISTS COLLEGE;

CREATE DATABASE IF NOT EXISTS instagram;
SHOW DATABASES;


CREATE DATABASE IF NOT EXISTS DON;
USE DON;
drop table user;
CREATE TABLE user (
	ID INT,
    name VARCHAR(30) NOT NULL,
    email VARCHAR(50) UNIQUE,
    following INT DEFAULT 0 ,
    followers INT DEFAULT 0,
    age INT,
    CONSTRAINT CHECK (age >13),
    PRIMARY KEY (ID)
);

INSERT INTO user
(id,age,name,email,followers,following)
VALUES
(1,14,"adam","adam@gmail.com",123,145),
(2,15,"oggy","oggy@gmail.com",234,567),
(3,23,"bob","bob@gmail.com",332,345);

INSERT INTO user
(id,age,name,email,followers,following)
VALUES
(4,17,"om","om@gmail.com",625,488),
(5,19,"pinky","pinky@gmail.com",789,897),
(6,28,"ash","ash@gmail.com",3328,3475);

SELECT id, name, email FROM user;

SELECT * FROM user;

SELECT DISTINCT age FROM user;

SELECT * FROM user WHERE followers > 200;
SELECT * FROM user WHERE age+1 = 18;

SELECT * FROM user WHERE age>15 AND followers > 200;
SELECT * FROM user WHERE age BETWEEN 15 AND 24;

SELECT * FROM user WHERE email IN ("bob@gmail.com","prash@gmail.com","oggy@gmail.com");
SELECT * FROM user WHERE email NOT IN ("bob@gmail.com","prash@gmail.com","oggy@gmail.com");

SELECT * FROM user WHERE email IN ("bob@gmail.com","prash@gmail.com","oggy@gmail.com")
LIMIT 2 ;

SELECT name,age,followers FROM user ORDER BY followers ASC;
SELECT name,age,followers FROM user ORDER BY followers DESC;

SELECT MAX(followers)FROM user;
SELECT COUNT(age) FROM user WHERE age>18;
SELECT AVG(age) FROM user;
SELECT SUM(followers) FROM user;

SELECT age, COUNT(id) FROM user GROUP BY age;
SELECT age, MAX(followers) FROM user GROUP BY age;

SELECT age, MAX(followers) FROM user GROUP BY age HAVING MAX(followers)>200 ORDER BY age DESC;




CREATE TABLE post(
	id INT,
    content VARCHAR(100),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES user(ID)
);

UPDATE  USER SET followers = 600 WHERE age > 17;

SET SQL_SAFE_UPDATES = 0;



DELETE FROM user WHERE age=17;

ALTER TABLE user ADD COLUMN city VARCHAR(25) DEFAULT "Delhi";
ALTER TABLE user DROP COLUMN age;
ALTER TABLE user RENAME TO instauser;

ALTER TABLE instauser CHANGE COLUMN followers subs INT DEFAULT 0;
ALTER TABLE instauser MODIFY subs INT DEFAULT 5;

DROP TABLE post;
TRUNCATE TABLE instauser;
DROP TABLE instauser;

SELECT * FROM instauser;




CREATE DATABASE IF NOT EXISTS college;

USE college;

CREATE TABLE teacher (
	id INT,
    name VARCHAR(30),
    sub VARCHAR(15),
    salary INT,
    PRIMARY KEY (id)
);

INSERT INTO teacher
(id, name, sub, salary)
VALUES
(23, "ajay", "math", 50000),
(47, "bharat", "english", 60000),
(18, "chetan", "chemistry", 45000),
(9, "divya", "physics", 75000);



SELECT * FROM teacher WHERE salary >55000;
ALTER TABLE teacher CHANGE COLUMN salary ctc VARCHAR(30);

UPDATE teacher SET ctc = ctc + ctc * 0.25;
SELECT * FROM teacher;

ALTER TABLE teacher ADD COLUMN city VARCHAR(30) DEFAULT "MUMBAI";

ALTER TABLE teacher DROP COLUMN city;







