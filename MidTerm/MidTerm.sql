--Mojtaba Abbasszadeh - Midterm

--1
Print '***Question 1 ***'
PRINT ''

--a)
SELECT PaymentMethod.explanation
FROM PaymentMethod
JOIN Payment
ON PaymentMethod.id = Payment.paymentMethodId
JOIN Person 
ON Person.number = Payment.studentNumber
WHERE Person.firstName = 'DOROTHEA'
AND Person.lastName = 'BRENGELMAN'

--b)
SELECT Payment.transactionDate
FROM Payment
JOIN Person 
ON Person.number = Payment.studentNumber
WHERE Person.firstName = 'DOROTHEA'
AND Person.lastName = 'BRENGELMAN'

--c)
SELECT Student.isInternational
FROM Student
JOIN Person 
ON Person.number = Student.number
WHERE Person.firstName = 'DOROTHEA'
AND Person.lastName = 'BRENGELMAN'

--d)
SELECT Payment.invoiceNumber
FROM Payment
JOIN Person 
ON Person.number = Payment.studentNumber
WHERE Person.firstName = 'DOROTHEA'
AND Person.lastName = 'BRENGELMAN'

--e)
SELECT firstName, lastName, Student.number, Payment.amount, Payment.transactionDate, Student.isInternational
FROM Person 
JOIN Student
ON Person.number = Student.number
JOIN Payment
ON Person.number = Payment.studentNumber
WHERE Person.firstName = 'DOROTHEA'
AND Person.lastName = 'BRENGELMAN'

--2
Print '***Question 2 ***'
PRINT ''

--a)
SELECT PaymentMethod.explanation
FROM PaymentMethod
WHERE id IN (SELECT paymentMethodId
						FROM Payment
						WHERE studentNumber IN ( SELECT number 
												FROM Person
												WHERE firstName = 'DOROTHEA'
												AND Person.lastName = 'BRENGELMAN'))

--b)
SELECT Payment.transactionDate
FROM Payment
WHERE studentNumber IN (SELECT number
						FROM Person
						WHERE firstName = 'DOROTHEA'
						AND Person.lastName = 'BRENGELMAN')

--c)
SELECT isInternational
FROM Student
WHERE number IN (SELECT number
				 FROM Person
				 WHERE firstName = 'DOROTHEA'
				 AND Person.lastName = 'BRENGELMAN')

--d)
SELECT invoiceNumber
FROM Payment
WHERE studentNumber IN (SELECT number
						 FROM Person
						 WHERE firstName = 'DOROTHEA'
						AND Person.lastName = 'BRENGELMAN')

--e)
SELECT firstname,
lastname,
number,
(SELECT amount FROM payment WHERE studentNumber = ( SELECT number FROM person WHERE firstName = 'DOROTHEA'))AS amount,
(SELECT transactionDate FROM payment WHERE studentNumber = ( SELECT number FROM person WHERE firstName = 'DOROTHEA')) AS date,
(SELECT isInternational FROM Student WHERE number IN (SELECT number FROM Person WHERE firstName = 'DOROTHEA' AND Person.lastName = 'BRENGELMAN')) AS isInternational
FROM person
WHERE firstName = 'DOROTHEA'
AND lastname = 'BRENGELMAN';

--3
Print '***Question 3 ***'
PRINT ''

SELECT TOP 5 number, name
FROM Course
WHERE number IN (SELECT courseNumber
				FROM CourseOffering 
				WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering))
--a)
SELECT prerequisiteNumber
FROM CoursePrerequisiteAnd
WHERE  courseNumber IN (SELECT TOP 5 number
					FROM Course
					WHERE number IN (SELECT courseNumber
					FROM CourseOffering 
					WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering)))

--b)
SELECT COUNT(*)
FROM Student
WHERE isInternational = 1
AND number IN (SELECT studentNumber
		FROM CourseStudent
		WHERE CourseOfferingId IN (SELECT TOP 5 id
						FROM CourseOffering
						WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering)))
--c)
SELECT credits
FROM Course
WHERE number IN (SELECT TOP 5 courseNumber
				FROM CourseOffering 
				WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering))

--d)
SELECT DISTINCT roomId 
FROM ClassSchedule 
WHERE CourseOfferingId IN (SELECT TOP 5 id
						   FROM CourseOffering
						   WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering))

--e)
SELECT courseNumber, 
(SELECT name FROM course WHERE number IN (SELECT TOP 5 courseNumber
	FROM CourseOffering WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering))) as courseEnglishName,
(SELECT prerequisiteNumber FROM CoursePrerequisiteAnd WHERE courseNumber IN (SELECT TOP 5 courseNumber
	FROM CourseOffering WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering))) as prerequisiteNumber,
(SELECT dayCode FROM ClassSchedule WHERE CourseOfferingId IN (SELECT TOP 5 id
	FROM CourseOffering WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering))) as courseDay,
(SELECT time FROM ClassSchedule WHERE CourseOfferingId IN (SELECT TOP 5 id
	FROM CourseOffering WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering))) as courseTime,
(SELECT firstName FROM Person WHERE number IN (SELECT studentNumber 
	FROM CourseStudent WHERE CourseOfferingId IN (SELECT TOP 5 id 
		FROM CourseOffering WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering)))) as firstName,
(SELECT lastName FROM Person WHERE number IN (SELECT studentNumber 
	FROM CourseStudent WHERE CourseOfferingId IN (SELECT TOP 5 id 
		FROM CourseOffering WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering)))) as lastName
FROM CourseOffering
WHERE courseNumber IN (SELECT TOP 5 courseNumber
	FROM CourseOffering WHERE enrollment = (SELECT MAX(enrollment) FROM CourseOffering))


--4
Print '***Question 4 ***'
PRINT ''
SELECT COUNT(*) FROM Program WHERE  CHARINDEX ('C', name) = 1

--a)
SELECT COUNT(*) 
FROM ProgramCourse 
WHERE programCode IN (SELECT code FROM Program WHERE CHARINDEX ('C', name) = 1)

--b)
-- Semester 5 is selected. 

--c)
SELECT ProgramFee.tuition, ProgramFee.internationalTuition
FROM ProgramFee
JOIN Program 
ON Program.code = ProgramFee.code
WHERE ProgramFee.semester = 5
AND CHARINDEX('C', name) = 1;

--d)
SELECT DISTINCT Program.name, Program.code, ProgramFee.tuition, ProgramFee.internationalTuition
FROM ProgramFee
JOIN Program 
ON Program.code = ProgramFee.code

--5
Print '***Question 5 ***'
PRINT ''

--a)
INSERT INTO StudentOffence
(studentNumber,penaltyCode, date, notes)
VALUES
(8846289, 'A', GETDATE(), (SELECT explanation FROM Penalty WHERE code='A') ),
(8858763,'A',GETDATE(),(SELECT explanation FROM Penalty WHERE code='A')),
(8862666,'C',GETDATE(),(SELECT explanation FROM Penalty WHERE code='C')),
(8614315,'D',GETDATE(),(SELECT explanation FROM Penalty WHERE code='D')),
(8761314,'B',GETDATE(),(SELECT explanation FROM Penalty WHERE code='B'))

-- I wanted to add a column for student names in StudentOffence table and add their names. 

ALTER TABLE StudentOffence 
ADD StudentName varchar(255)

select *
from student

INSERT INTO StudentOffence
(studentNumber,penaltyCode, date, notes, StudentName)
VALUES
(8846289, 'A', GETDATE(), (SELECT explanation FROM Penalty WHERE code='A'), (SELECT name from ) ),
(8858763,'A',GETDATE(),(SELECT explanation FROM Penalty WHERE code='A')),
(8862666,'C',GETDATE(),(SELECT explanation FROM Penalty WHERE code='C')),
(8614315,'D',GETDATE(),(SELECT explanation FROM Penalty WHERE code='D')),
(8761314,'B',GETDATE(),(SELECT explanation FROM Penalty WHERE code='B'))