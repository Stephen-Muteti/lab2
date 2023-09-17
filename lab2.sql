-- Question 1: SECTION 3

-- Drop any existence of the HorseRacing_tllos1 database
DROP DATABASE IF EXISTS HorseRacing_tllos1;

-- Creating database
CREATE DATABASE IF NOT EXISTS HorseRacing_tllos1;

-- Using the database in the subsequent queries
USE HorseRacing_tllos1;

-- Creating tables

-- Person table
CREATE TABLE Person (
    pId VARCHAR(3),
    PName VARCHAR(20) NOT NULL,
    pPhone VARCHAR(10),
    pAddress VARCHAR(40),
    CONSTRAINT Person_pId_pk PRIMARY KEY (pId)
);

-- RaceHorse table
CREATE TABLE RaceHorse (
    regNum VARCHAR(3) PRIMARY KEY,
    hName VARCHAR(20) NOT NULL,
    gender VARCHAR(6),
    type VARCHAR(13),
    purchaseDate VARCHAR(10),
    purchasePrice VARCHAR(10),
    trainedBy VARCHAR(3),
    FOREIGN KEY (trainedBy) REFERENCES Person (pId)
);

-- Entry table
CREATE TABLE Entry (
    sId VARCHAR(3),
    rNumber INT(4),
    gate INT(2),
    finalPos INT(2),
    jockey VARCHAR(3),
    horse VARCHAR(3),
    PRIMARY KEY (sId, rNumber, gate),
    FOREIGN KEY (jockey) REFERENCES Person (pId),
    FOREIGN KEY (horse) REFERENCES RaceHorse (regNum)
);

-- Populating tables

INSERT INTO Person VALUES ('p01', 'Bob Jones', '8069927001', '401 Oak Street, Lubbock, TX 11122'); 
INSERT INTO Person VALUES ('p02', 'Sally Smith', '8069927002', '200 Pine Street, Abilene, TX 22211'); 
INSERT INTO Person VALUES ('p03', 'Rick Robins', '8069927003', '301 Elm Street, 
Amarillo, TX 33321'); 
INSERT INTO Person VALUES ('p04', 'Jack Anders', '8069927004', '100 5th Street, Guthrie, TX 55533'); 
INSERT INTO Person VALUES ('p05', 'Sue Stegen', '8069927005', '506 Cedar Street, Bastrop, TX 77789'); 
INSERT INTO Person VALUES ('p06', 'Joe Koblinski', '8069927006', '600 6th Street, Austin, TX 99988'); 
INSERT INTO Person VALUES ('p07', 'Mary Cane', '8069927007', '722 1st Street, Houston, TX 12345'); 
 
INSERT INTO RaceHorse VALUES ('r01', 'Lucky',     'male',   'thoroughbred',   
'02/02/2015', 30000, 'p01'); 
INSERT INTO RaceHorse VALUES ('r02', 'Fast',      'female', 'thoroughbred',   
'02/01/2015', 20000, 'p02'); 
INSERT INTO RaceHorse VALUES ('r03', 'UnLucky',   'male', 'quarter horse', 
'02/07/2015', 25000,  'p02'); 
INSERT INTO RaceHorse VALUES ('r04', 'Slow',      'female', 'quarter horse', 
'02/08/2015', 40000,  'p01'); 
INSERT INTO RaceHorse VALUES ('r05', 'Legend',   'male',   'thoroughbred',   '02/04/2015', 15000, 'p07'); 
INSERT INTO RaceHorse VALUES ('r12', 'Lufast',    'female', 'thoroughbred',   
'02/09/2015', 50000, 'p07'); 
INSERT INTO RaceHorse VALUES ('r34', 'Unslow',    'male',   'quarter horse', '02/10/2015', 30000,  'p01'); 
 
INSERT INTO Entry VALUES ('s01', 1, 1, 4, 'p01', 'r01'); 
INSERT INTO Entry VALUES ('s01', 1, 2, 3, 'p02', 'r02'); 
INSERT INTO Entry VALUES ('s01', 1, 3, 2, 'p03', 'r03'); 
INSERT INTO Entry VALUES ('s01', 1, 4, 1, 'p04', 'r04'); 
INSERT INTO Entry VALUES ('s01', 2, 1, 3, 'p05', 'r05'); 
INSERT INTO Entry VALUES ('s01', 2, 2, 2, 'p06', 'r12'); 
INSERT INTO Entry VALUES ('s01', 2, 3, 1, 'p07', 'r34'); 
INSERT INTO Entry VALUES ('s02', 1, 1, 1, 'p07', 'r01'); 
INSERT INTO Entry VALUES ('s02', 1, 2, 4, 'p06', 'r12'); 
INSERT INTO Entry VALUES ('s02', 1, 3, 3, 'p05', 'r34'); 
INSERT INTO Entry VALUES ('s02', 1, 4, 2, 'p04', 'r04'); 
INSERT INTO Entry VALUES ('s02', 2, 1, 1, 'p03', 'r05'); 
INSERT INTO Entry VALUES ('s02', 2, 2, 2, 'p02', 'r02'); 
INSERT INTO Entry VALUES ('s02', 2, 3, 3, 'p01', 'r03');

-- (i) What are the name and telephone number of the person who trained Lucky?
SELECT P.pName, P.pPhone
FROM RaceHorse R
JOIN Person P ON R.trainedBy = P.pId
WHERE R.hName = 'Lucky';

-- (ii) What was Lucky’s final position in a given race?
SELECT E.sId, E.rNumber, E.finalPos
FROM RaceHorse R
JOIN Entry E ON R.regNum = E.horse
WHERE R.hName = 'Lucky';

-- (iii) What are the name and address of the jockey who rode the winning horse in a particular race?
SELECT E.sId, E.rNumber, P.pName, P.pAddress
FROM Person P
JOIN Entry E ON E.jockey = P.pId
WHERE E.finalPos = 1;

-- Question 2: EXERCISE 5

-- Drop any existence of the WorkerProjects database
DROP DATABASE IF EXISTS WorkerProjects;

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS WorkerProjects;

-- Use the newly created database
USE WorkerProjects;

-- Create the Worker table
CREATE TABLE IF NOT EXISTS Worker (
    empId INT PRIMARY KEY,
    lastName VARCHAR(20) NOT NULL,
    firstName VARCHAR(15) NOT NULL,
    deptName VARCHAR(15),
    birthDate DATE,
    hireDate DATE,
    salary DECIMAL(8,2)
);

-- Create the Dept table
CREATE TABLE IF NOT EXISTS Dept (
    deptName VARCHAR(15) PRIMARY KEY,
    mgrId INT,
    CONSTRAINT Dept_mgrid_fk FOREIGN KEY (mgrId) REFERENCES Worker (empId) ON DELETE SET NULL
);

-- Create the Project table
CREATE TABLE IF NOT EXISTS Project (
    projNo INT PRIMARY KEY,
    projName VARCHAR(20),
    projMgrId INT,
    budget DECIMAL(8,2),
    startDate DATE,
    expectedDurationWeeks INT,
    CONSTRAINT Project_projMgrId_fk FOREIGN KEY (projMgrId) REFERENCES Worker (empId) ON DELETE SET NULL
);

-- Create the Assign table
CREATE TABLE IF NOT EXISTS Assign (
    projNo INT,
    empId INT,
    hoursAssigned INT,
    rating INT,
    CONSTRAINT Assign_projNo_empId_pk PRIMARY KEY (projNo, empId),
    CONSTRAINT Assign_projNo_fk FOREIGN KEY (projNo) REFERENCES Project (projNo) ON DELETE CASCADE,
    CONSTRAINT Assign_empid_fk FOREIGN KEY(empId) REFERENCES Worker (empId) ON DELETE CASCADE
);

-- Insert data into the Dept table
INSERT INTO Dept VALUES ('Accounting', NULL);
INSERT INTO Dept VALUES ('Research', NULL);

-- Insert data into the Worker table
INSERT INTO Worker VALUES (101, 'Smith', 'Tom', 'Accounting', '1970-02-01', '1993-06-06', 50000.00);
INSERT INTO Worker VALUES (103, 'Jones', 'Mary', 'Accounting', '1975-06-15', '2005-09-20', 48000.00);
INSERT INTO Worker VALUES (105, 'Burns', 'Jane', 'Accounting', '1980-09-21', '2000-06-12', 39000.00);
INSERT INTO Worker VALUES (110, 'Burns', 'Michael', 'Research', '1977-04-05', '2010-09-10', 70000.00);
INSERT INTO Worker VALUES (115, 'Chin', 'Amanda', 'Research', '1980-09-22', '2014-06-19', 60000.00);

-- Update Dept with manager IDs
UPDATE Dept SET mgrId = 101 WHERE deptName = 'Accounting';
UPDATE Dept SET mgrId = 110 WHERE deptName = 'Research';

-- Insert data into the Project table
INSERT INTO Project VALUES (1001, 'Jupiter', 101, 300000.00, '2014-02-01', 50);
INSERT INTO Project VALUES (1005, 'Saturn', 101, 400000.00, '2014-06-01', 35);
INSERT INTO Project VALUES (1019, 'Mercury', 110, 350000.00, '2014-02-15', 40);
INSERT INTO Project VALUES (1025, 'Neptune', 110, 600000.00, '2015-02-01', 45);
INSERT INTO Project VALUES (1030, 'Pluto', 110, 380000.00, '2014-09-15', 50);

-- Insert data into the Assign table
INSERT INTO Assign VALUES (1001, 101, 30, NULL);
INSERT INTO Assign VALUES (1001, 103, 20, 5);
INSERT INTO Assign VALUES (1005, 103, 20, NULL);
INSERT INTO Assign VALUES (1001, 105, 30, NULL);
INSERT INTO Assign VALUES (1001, 115, 20, 4);
INSERT INTO Assign VALUES (1019, 110, 20, 5);
INSERT INTO Assign VALUES (1019, 115, 10, 4);
INSERT INTO Assign VALUES (1025, 110, 10, NULL);
INSERT INTO Assign VALUES (1030, 110, 10, NULL);

-- (i) Get the names of all workers in the Accounting department
SELECT lastName, firstName
FROM Worker
WHERE deptName = 'Accounting';

-- (ii) Get the name of the employee in the Research department who has the lowest salary
SELECT lastName, firstName
FROM Worker
WHERE deptName = 'Research'
ORDER BY salary
LIMIT 1;

-- (iii) Get an alphabetical list of names and corresponding ratings of all workers on any project which is managed by Michael Burns
SELECT W.lastName, W.firstName, A.rating
FROM Worker W
INNER JOIN Assign A ON W.empId = A.empId
INNER JOIN Project P ON A.projNo = P.projNo
WHERE P.projMgrId = 110
ORDER BY W.lastName, W.firstName;

-- (iv) Change the hours that employee 110 is assigned to project 1019 from 20 to 10
UPDATE Assign
SET hoursAssigned = 10
WHERE empId = 110 AND projNo = 1019;

-- (v) For each project, list the project number and how many workers are assigned to it
SELECT P.projNo, COUNT(A.empId) AS numWorkers
FROM Project P
LEFT JOIN Assign A ON P.projNo = A.projNo
GROUP BY P.projNo;