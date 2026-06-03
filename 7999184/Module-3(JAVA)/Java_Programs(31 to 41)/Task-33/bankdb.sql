CREATE DATABASE bankdb;

USE bankdb;

CREATE TABLE accounts (
    id INT PRIMARY KEY,
    balance DOUBLE
);

INSERT INTO accounts VALUES (1,1000);
INSERT INTO accounts VALUES (2,1000);