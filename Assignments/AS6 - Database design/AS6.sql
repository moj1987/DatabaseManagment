--Mojtaba Abbasszadeh - AS6
-- Everything is done in a database called SmallCompany
-- CREATE DATABASE SmallCompany

CREATE TABLE PartType 
(
	id int NOT NULL IDENTITY PRIMARY KEY,
	type nvarchar(50)
)
CREATE TABLE PartNumber
(
	id int NOT NULL IDENTITY PRIMARY KEY,
	description nvarchar(75),
	partyTypeID int REFERENCES PartType(id) ON DELETE CASCADE
)

CREATE TABLE Customer
(
	id int NOT NULL IDENTITY PRIMARY KEY,
	customerName nvarchar(50)
)

CREATE TABLE Plant
(
	id int NOT NULL IDENTITY PRIMARY KEY,
	city nvarchar(50)
)

CREATE TABLE Employee
(
	id int NOT NULL IDENTITY PRIMARY KEY,
	firstName nvarchar(50),
	lastName nvarchar(50),
	address nvarchar(175),
	telephone nchar(30),
	plantID int REFERENCES Plant(id) 
)

-- 1 
--Time is dependant on 3 elements 
-- BUT
-- we have repetitive data for the same 3 numbers. (crankshaft)(Frank)(Waterloo) has 40 and 45 mins

-- Consequently, we have to have ID and time in minutes for Time table. 
-- Had they been unique, no need to save time as number either.

-- 2
-- plant is unique for each employee 
-- so, no need to mention it in Time table. 

CREATE TABLE ProductionTime 
(
	id int NOT NULL IDENTITY PRIMARY KEY,
	partID int REFERENCES PartNumber(id),
	employeeID int REFERENCES Employee(id),
	timeNeeded int	
)

CREATE TABLE Production
(
	id int NOT NULL IDENTITY PRIMARY KEY,
	partNumberID int REFERENCES PartNumber(id) ON DELETE CASCADE, 
	cutomerID int REFERENCES Customer(id) ON DELETE CASCADE, 
	employeeID int REFERENCES Employee(id) ON DELETE CASCADE, 
	minutes int  
)

INSERT INTO PartType
(type)
VALUES
('crankShaft'),
('piston'),
('exhaust')

INSERT INTO PartNumber
(description, partyTypeID)
VALUES
('MOTO001',1),
('MOTO002',2),
('MOTO003',3),
('CAR001',2),
('CAR002',3),
('CAR003',1)

INSERT INTO Customer
(customerName)
VALUES
('Suzuki'),
('BMW')

INSERT INTO Plant
(city)
VALUES
('Guelph'),
('Waterloo')

INSERT INTO Employee
(firstName, lastName, address, telephone, plantID)
VALUES
('Joe', 'Joe','Kitchener', 5195195195 ,1 ),
('Frank', 'Joe','Kitchener', 5195195195 ,2),
('Mary', 'Joe','Kitchener', 5195195195 ,2),
('Gary', 'Joe','Kitchener', 5195195195 ,1),
('John', 'Joe','Kitchener', 5195195195 ,2)

INSERT INTO ProductionTime
(partID,employeeID,timeNeeded)
VALUES
(1,		 1,   		 45),
(1,		 2,   		 40),
(2,		 1,   		 20),
(4,		 3,   		 15),
(4,		 3,   		 20),
(2,		 3,   		 10),
(1,		 4,   		 65),
(5,	     4,   		 110),
(3,	     5,   		 45),
(6,		 5,   		 25),
(6,		 2,   		 45)


INSERT INTO Production
(partNumberID, cutomerID, employeeID )
VALUES
(1,				 1,			    1),
(1,				 1,			    2),
(2,				 1,			    1),
(4,				 1,			    3),
(4,				 2,			    3),
(2,				 2,			    3),
(1,				 2,			    4),
(5,				 2,			    4),
(3,				 1,			    5),
(6,				 1,			    5),
(6,				 2,			    2)

-- Temp table to create part number and part type
create table #PartText
(
	id int primary key not null identity,
	numberText varchar (75),
	typeText varchar (75)
)

insert into #PartText
select PartNumber.description, PartType.type
from PartNumber
join PartType
on PartNumber.partyTypeID=PartType.id

-- Temp table to create employee first name and plant
create table #NamePlant
(
	id int primary key not null identity,
	firstNameText varchar (75),
	plantText varchar (75)
)

insert into #NamePlant
select Employee.firstName , Plant.city
from Employee
join Plant
on Employee.plantID = Plant.id
SELECT * FROM #PartText
SELECT * FROM #NamePlant

-- Recreation of the given table. Just for checking and fun!
SELECT #PartText.numberText AS 'Part #',
		Customer.customerName AS 'Customer',	
		#PartText.typeText AS 'Part Type',
		#NamePlant.firstNameText AS 'Employee', 
		#NamePlant.plantText AS 'Plant', 
		ProductionTime.timeNeeded AS 'Time (min)'
INTO #allProduction
from Production
JOIN #PartText ON Production.partNumberID = #PartText.id
JOIN Customer ON Production.cutomerID = Customer.id
JOIN #NamePlant ON Production.employeeID = #NamePlant.id 
JOIN ProductionTime ON Production.id = ProductionTime.id;

-- Show the orginal table given in question
SELECT * FROM #allProduction

--6
Print '***Question 6-a ***'
PRINT ''

SELECT * 
FROM #allProduction
WHERE Customer = 'Suzuki'

Print '***Question 6-b ***'
PRINT ''

SELECT * 
FROM #allProduction
WHERE Plant = 'Waterloo'