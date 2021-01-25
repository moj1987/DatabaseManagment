--Mojtaba Abbasszadeh
--1
Print '***Question 1 ***'
PRINT ''

SELECT * 
FROM dbo.AcademicStatus

--2
Print '***Question 2 ***'
PRINT ''

SELECT number, AcademicStatusCode 
FROM dbo.Student
WHERE academicStatusCode = 'D' 
ORDER BY number DESC 

--3
Print '***Question 3 ***'
PRINT ''

SELECT number, AcademicStatusCode 
FROM dbo.Student
WHERE academicStatusCode = 'D' OR academicStatusCode='S' 
ORDER BY number ASC

--4
Print '***Question 4 ***'
PRINT ''

SELECT number, AcademicStatusCode 
FROM dbo.Student
WHERE NOT academicStatusCode = 'N' 
ORDER BY number

--5
Print '***Question 5 ***'
PRINT ''

SELECT number, AcademicStatusCode 
FROM dbo.Student
WHERE  academicStatusCode != 'N' 
ORDER BY number


--6
-- The question is wrong because there are no "countires" in the table. 
Print '***Question 6 ***'
PRINT ''

SELECT DISTINCT countryCode 
FROM dbo.Person

--7
Print '***Question 7 ***'
PRINT ''

SELECT   item AS "Incidental Fee Item", 
		 amountPerSemester AS  "Current fee",
		 amountPerSemester*1.1 AS "Increased Fee"
FROM dbo.incidentalfee

--8
Print '***Question 8 ***'
PRINT ''

SELECT * 
FROM dbo.CourseStudent
WHERE finalMark <55  
AND  finalMark > 0 

--9
Print '***Question 9 ***'
PRINT ''

SELECT number 
FROM dbo.Room
WHERE capacity >= 40  
AND  isLab = 1 
AND memory = '4GB' 
AND campusCode='D'

--10
Print '***Question 10 ***'
PRINT ''

SELECT * 
FROM dbo.Employee
WHERE schoolCode='TAP'  
AND  campusCode IN('D','G','W') 