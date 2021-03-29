--Mojtaba Abbasszadeh - AS3

--1
Print '***Question 1 ***'
PRINT ''

SELECT Course.number, Course.name 
FROM dbo.Course 
WHERE Course.number IN (SELECT CoursePrerequisiteAnd.prerequisiteNumber
			FROM CoursePrerequisiteAnd
			WHERE courseNumber ='COMP2280')
ORDER BY Course.number


--2
Print '***Question 2 ***'
PRINT ''

SELECT Person.number, Person.firstName, Person.lastName, schoolCode, Employee.extension 
FROM dbo.Person
JOIN dbo.Employee
ON Person.number = Employee.number
WHERE Person.lastName LIKE 'W%'
ORDER BY number

--3
Print '***Question 3 ***'
PRINT ''

SELECT DISTINCT Person.number, firstName, lastName, city
FROM dbo.Person
LEFT OUTER JOIN dbo.Student
ON Person.number = Student.number
WHERE Student.number IS NULL
ORDER BY lastName

--4
Print '***Question 4 ***'
PRINT ''

SELECT Software.product , uniqueId
FROM Software
WHERE uniqueId IN ( SELECT softwareUniqueId
					FROM LabSoftware
					WHERE roomId IN ( SELECT id 
									  FROM ROOM 
									  WHERE number = '2A205'))
ORDER BY product

--5
Print '***Question 5 ***'
PRINT ''

SELECT CourseOffering.sessionCode, CourseOffering.courseNumber, Person.firstName, Person.lastName, Employee.extension
FROM CourseOffering
JOIN Person ON employeeNumber = number
JOIN Employee ON Person.number = Employee.number
WHERE sessionCode = 'F10'
ORDER BY courseNumber

--6
Print '***Question 6 ***'
PRINT ''

SELECT lastName, firstName, collegeEmail, personalEmail, StudentOffence.notes
FROM Person
JOIN StudentOffence 
ON Person.number = StudentOffence.studentNumber
WHERE EXISTS (SELECT * 
			  FROM StudentOffence)
ORDER BY studentNumber


--7
Print '***Question 7 ***'
PRINT ''

SELECT e1.number "Employee", e1.reportsTo "Empoyee Reports To", e2.reportsTo "Supervisor reports To"
FROM Employee "e1"
LEFT OUTER JOIN Employee "e2"
ON e1.reportsTo=e2.number
ORDER BY e1.number

--8
Print '***Question 8 ***'
PRINT ''

SELECT LOWER(LEFT(firstName, 1)) + LOWER(LEFT(lastName, 7)) "User ID", lastName, schoolCode, extension
FROM dbo.Person
JOIN Employee ON Person.number = Employee.number
AND CHARINDEX('K', lastName ) = 1
ORDER BY [User ID]

--9
Print '***Question 9 ***'
PRINT ''

SELECT DISTINCT number, hours, credits, name
FROM Course
LEFT OUTER JOIN CourseOffering
ON Course.number = CourseOffering.courseNumber
WHERE  CHARINDEX('Programming', name) > 0
AND CourseOffering.id is NULL
ORDER BY number

SELECT *
FROM Employee	
SELECT *
FROM Person
