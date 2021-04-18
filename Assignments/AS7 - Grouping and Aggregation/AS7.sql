--Mojtaba Abbasszadeh - AS7

--0
Print '***Question 0 ***'
PRINT ''

SET ANSI_WARNINGS OFF;


--1
Print '***Question 1 ***'
PRINT ''

SELECT COUNT(*) AS 'Employees in the School of Business'
FROM Employee
WHERE schoolCode = 'BUS'


--2
Print '***Question 2 ***'
PRINT ''

SELECT number ,finalMark , firstName, lastName
FROM CourseStudent
JOIN CourseOffering ON CourseOffering.id = CourseStudent.CourseOfferingId
JOIN Person ON Person.number = CourseStudent.studentNumber
WHERE CourseOffering.courseNumber= 'PROG8080'
AND CourseOffering.sessionCode ='F09'
GROUP BY number, CourseStudent.finalMark , firstName, lastName
HAVING CourseStudent.finalMark > (SELECT  AVG(CourseStudent.finalMark) FROM CourseStudent)
ORDER BY lastName ASC


--3
Print '***Question 3 ***'
PRINT ''

SELECT CourseOffering.courseNumber AS 'Course',
MIN(finalMark) AS 'Lowest Mark',
ROUND(AVG (finalMark),0) AS 'Average Mark',
MAX(finalMark) AS 'Lowest Mark'
FROM CourseOffering
JOIN CourseStudent ON id = CourseOfferingId
WHERE sessionCode = 'F10'
GROUP BY CourseOffering.courseNumber


--4
Print '***Question 4 ***'
PRINT ''

SELECT DISTINCT Person.firstName, Person.lastName
FROM Audit
JOIN Person ON PERSON.number= Audit.studentNumber
GROUP BY amount, firstName, lastName
HAVING amount > (SELECT AVG(amount) FROM Audit)

--5
Print '***Question 5-a ***'
PRINT ''

SELECT employeeNumber , Person.firstName, Person.lastName,  COUNT(  employeeNumber)  AS 'Courses Taught'
FROM CourseOffering
INNER JOIN Employee ON employeeNumber = Employee.number
INNER JOIN Person ON employeeNumber = Person.number
INNER JOIN School ON School.code = Employee.schoolCode
WHERE School.name = 'Engineering and Information Technology'
AND CourseOffering.sessionCode LIKE  '%08' 
OR CourseOffering.sessionCode LIKE  '%09' 
GROUP BY employeeNumber ,Person.firstName, Person.lastName
ORDER BY lastName


Print '***Question 5-b ***'
PRINT ''

SELECT Employee.number , Person.firstName, Person.lastName,  COUNT(  employeeNumber)  AS 'Courses Taught'
FROM Employee
LEFT JOIN CourseOffering ON employeeNumber = Employee.number AND (sessionCode like '%09' OR sessionCode like '%08')
LEFT JOIN Person ON Person.number =employee.number
LEFT JOIN School ON School.code = Employee.schoolCode where School.name = 'Engineering and Information Technology'
GROUP BY Employee.number ,Person.firstName, Person.lastName
ORDER BY lastName

--6
Print '***Question 6 ***'
PRINT ''

Print  'The result shown in PDf which is wrong.'
SELECT acronym, NAME,
'$'+CONVERT(CHAR(10),CAST(SUM (ProgramFee.tuition * chargeIncidentalFee ) + SUM (ProgramFee.tuition * coopFeeMultiplier ) AS money),1) AS 'Total Fees'
FROM PROGRAM
JOIN ProgramFee ON Program.code = ProgramFee.code
WHERE name like'%coop%'
GROUP BY acronym, name
ORDER BY acronym

Print 'Actual solution to the question!!'
SELECT acronym, NAME,
'$'+CONVERT(CHAR(10),CAST(SUM (ProgramFee.internationalTuition * coopFeeMultiplier ) + SUM (ProgramFee.tuition * coopFeeMultiplier ) AS money),1) AS 'Total Fees'
FROM PROGRAM
JOIN ProgramFee ON Program.code = ProgramFee.code
WHERE name like'%coop%'
GROUP BY acronym, name
ORDER BY acronym


--7
Print '***Question 7 ***'
PRINT ''

SELECT studentNumber,firstName, lastName , 
'$'+CONVERT(CHAR(10),CAST(SUM (amount )  AS money),1) AS 'Fee Payment Total'
FROM  Payment 
INNER JOIN Person ON Person.number = Payment.studentNumber
GROUP BY Payment.studentNumber, firstName, lastName
HAVING SUM (amount)  > (SELECT AVG(amount) FROM Payment)* 3
order by lastName , firstName



--8
Print '***Question 8 ***'
PRINT ''

SET ANSI_WARNINGS ON;