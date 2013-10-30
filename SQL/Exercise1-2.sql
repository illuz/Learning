-- Exercise2
-- (1)
CREATE DATABASE SaleManager;


CREATE TABLE Product
(
	Pno CHAR(8) PRIMARY KEY,
	Pname CHAR(8),
	Pclass CHAR(6),
	Pprice NUMERIC(6,2)
);


CREATE TABLE Member
(
	Mno CHAR(12) PRIMARY KEY,
	Mname CHAR(8),
	Mclass CHAR(1),
	TEL CHAR(11),
	Createdate DATETIME,
	Maddr CHAR(20)
);


CREATE TABLE Employee
(
	Eno CHAR(11) PRIMARY KEY,
	Ename CHAR(8),
	Ejob CHAR(10),
	Epsw VARCHAR(12)
);


CREATE TABLE Sale
(
	Sno CHAR(15) PRIMARY KEY,
	Eno CHAR(11),
	Mno CHAR(12),
	SaleDate DATETIME,
	Ssum NUMERIC(6,2)
);


CREATE TABLE SaleDetail
(
	Sno CHAR(15),
	Pno CHAR(8),
	QTY INT,
	Discount NUMERIC(3,2)
);


SELECT * FROM Product;

-- (3)

ALTER TABLE Product
	ALTER COLUMN Pname CHAR(8) NOT NULL
ALTER TABLE Product
	ALTER COLUMN Pclass CHAR(6) NOT NULL
ALTER TABLE Product
	ALTER COLUMN Pprice NUMERIC(6, 2) NOT NULL

ALTER TABLE Member
	ALTER COLUMN Mname CHAR(8) NOT NULL
ALTER TABLE Member
	ALTER COLUMN Mclass CHAR(1) NOT NULL

ALTER TABLE Employee
	ALTER COLUMN Ename CHAR(8) NOT NULL
	
	
ALTER TABLE SaleDetail
	ALTER COLUMN Pno CHAR(8) NOT NULL
ALTER TABLE SaleDetail
	ALTER COLUMN QTY INT NOT NULL

