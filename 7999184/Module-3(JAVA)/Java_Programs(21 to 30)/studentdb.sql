-- Creating Database for task-30 in java
CREATE DATABASE studentdb;

-- Using Db
USE studentdb;

-- Creating Table
CREATE TABLE students (
    id INT,
    name VARCHAR(50)
);

-- Inserting Data into created Table
INSERT INTO students VALUES (10094,'Shishu');
INSERT INTO students VALUES (10095,'Soni');
INSERT INTO students VALUES (10096,'Naini');

-- Verifying Data
SELECT * FROM students;

-- To execute the ql in vs code i did it via connecting my vs to sql for that i used something like:
-- mysql -u root -p
-- then use your sql root password.