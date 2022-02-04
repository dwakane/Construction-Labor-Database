DROP DATABASE IF EXISTS payroll;
CREATE DATABASE payroll;
USE payroll;
DROP TABLE IF EXISTS employee, job, wage, hours;

CREATE TABLE wage
	(trade		varchar(255),
    city		varchar(255),
    state		char(2),
    effective	date,
    stwages		decimal(5,2),
    stbenifits	decimal(5,2),
    otwages		decimal(5,2),
    otbenefits	decimal(5,2),
    PRIMARY KEY (trade, city, state, effective));
    

CREATE TABLE employee
	(eID		char(3) PRIMARY KEY,
    lastname	varchar(255),
    firstname	varchar(255),
    trade		varchar(255), 
    CONSTRAINT FOREIGN KEY (trade) REFERENCES wage(trade));
    
CREATE TABLE job
	(pID		char(4) PRIMARY KEY,
    owner		varchar(255),
    city		varchar(255) REFERENCES wage(city),
    state		char(2) REFERENCES wage(state));
       
CREATE TABLE hours
	(pID		char(4),
    date		date,
    eID			char(3),
    sthours		decimal(4,2),
    othours		decimal(4,2),
    PRIMARY KEY (pID, date, eID),
    CONSTRAINT FOREIGN KEY (pID) REFERENCES job(pID),
    CONSTRAINT FOREIGN KEY (eID) REFERENCES employee(eID));
