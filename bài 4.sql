USE USERS;
DROP TABLE IF EXISTS UserTable;

CREATE TABLE UserTable (
	id_user INT PRIMARY KEY,
	phone_number VARCHAR(10) UNIQUE NOT NULL,
    user_name varchar(50) NOT NULL
);