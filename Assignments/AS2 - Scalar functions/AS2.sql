--Mojtaba Abbasszadeh - AS2

--1
Print '***Question 1 ***'
PRINT ''

SELECT DISTINCT LEN(firstName)  "First Name Length"
FROM dbo.Person
ORDER BY [First Name Length] DESC

--2
Print '***Question 2 ***'
PRINT ''

SELECT firstName,
LEFT(firstName,1) "First Initial",
LOWER(LEFT(firstName,1)) "Lower First Initial"
FROM dbo.Person
WHERE CHARINDEX('P', lastName)=1
ORDER BY firstName ASC

--3
Print '***Question 3 ***'
PRINT ''

SELECT lastName,
SUBSTRING(lastName,1,7) "First Seven",
LOWER(SUBSTRING(lastName,1,7)) "Lower First Seven"
FROM dbo.Person
WHERE CHARINDEX('P', lastName)=1
ORDER BY firstName ASC

--4
Print '***Question 4 ***'
PRINT ''

SELECT LOWER(LEFT(firstName,1))+LOWER(LEFT(lastName,7)) "User Id" 
FROM dbo.Person 
WHERE CHARINDEX('P', lastName)=1 
ORDER BY [User Id] ASC

--5
Print '***Question 5 ***'
PRINT ''

SELECT number "Course Code", name "Course Name" 
FROM dbo.Course
WHERE CHARINDEX('Database',name)>0

--6
Print '***Question 6 ***'
PRINT ''

SELECT CONVERT(CHAR(10), GETDATE(),102) AS "Today",
CONVERT(CHAR(10),DATEADD(day,30, GETDATE()),102) AS "30 Days",
CONVERT(CHAR(10),DATEADD(day,60, GETDATE()),102) AS "60 Days",
CONVERT(CHAR(10),DATEADD(day,90, GETDATE()),102) AS "90 Days",
CONVERT(CHAR(10),DATEADD(day,120, GETDATE()),102) AS "120 Days"

--7
Print '***Question 7 ***'
PRINT ''

--a)
Print '***7-a ***'

SELECT 'Employee Number: '+Person.number,
'Year: ' + CONVERT (varchar , DATEPART (YYYY,birthdate) ),
'Month: ' + CONVERT (varchar , DATEPART (MM,birthdate) ),
'Day: ' + CONVERT (varchar , DATEPART (DD,birthdate) )
FROM dbo.person 
JOIN dbo.employee 
ON Person.number = Employee.number 
ORDER BY birthdate

--b)
Print '***7-b ***'
SELECT 'Employee Number: '+Person.number,
'Year: ' + CONVERT (varchar , YEAR (birthdate) ),
'Month: ' + CONVERT (varchar , MONTH (birthdate) ),
'Day: ' + CONVERT (varchar , DAY (birthdate) )
FROM dbo.person 
JOIN dbo.employee 
ON Person.number = Employee.number 
ORDER BY birthdate


