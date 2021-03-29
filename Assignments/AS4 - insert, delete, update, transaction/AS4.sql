--Mojtaba Abbasszadeh - AS4

--1
Print '***Question 1 ***'
PRINT ''

DELETE FROM Person
WHERE firstName ='Indu'
AND  lastName = 'Taneja'

DELETE FROM Course
WHERE number ='BUS1070'

DELETE FROM Course
WHERE number ='LIBS1010'

--2
Print '***Question 2 ***'
PRINT ''

select * from Program
select * from Course
select * from ProgramCourse

SELECT number, hours, credits, name
From Course
WHERE number IN (SELECT courseNumber
				 FROM ProgramCourse  
				 WHERE  programCode IN (SELECT code 
										FROM Program
										WHERE acronym = 'ITID')
				AND semester='1')
				------------- ONLY ONE LITERAL!!!!!!!-----
ORDER BY number

--3
Print '***Question 3 ***'
PRINT ''
select * from Person
select * from Payment
select * from PaymentMethod

			--------- individual payment?

SELECT number, firstName, lastName 
FROM Person
WHERE number IN ( SELECT studentNumber 
				  FROM Payment
				  WHERE paymentMethodId NOT IN( SELECT id 
											  FROM PaymentMethod 
											  WHERE explanation ='American Express')
					AND amount > 1000)
ORDER BY lastName

--4
Print '***Question 4 ***'
PRINT ''
select * from Person
select * from Student
select * from StudentProgram
select * from Program
select * from Credential

SELECT firstName, lastName 
FROM Person
WHERE number IN ( SELECT number
					FROM Student
					WHERE isInternational = 1
					-- LEADS TO POST GRAD CERT?????
					--- WHO ARE ENROLLED ?????
					AND number IN  ( SELECT studentNumber
									FROM StudentProgram
									WHERE programCode IN (SELECT code
															FROM Program
															WHERE credentialCode IN (SELECT code
																					FROM Credential
																					WHERE CHARINDEX('GRADUATE', name)>0 )) ))
ORDER BY lastName

--5
Print '***Question 5 ***'
PRINT ''

INSERT INTO Person
(number, lastName, firstName, street, city, provinceCode, countryCode, postalCode, mainPhone, alternatePhone, collegeEmail, personalEmail, birthdate)
VALUES
(7424476, 'TANEJA', 'INDU', 'FLAT NO. 100 TRIVENI APARTMENTS PITAM PURA', 'NEW DELHI', NULL, 'IND', 110034, 6610242, 94324060195, 'iteneja@conestogac.on.ca', 'iteneja@bsnl.co.in', 'October 7 1989'   )

SELECT *
FROM Person
WHERE firstName = 'indu'

--6
Print '***Question 6 ***'
PRINT ''

INSERT INTO Student
(number, isInternational,academicStatusCode,financialStatusCode,sequentialNumber,balance, localStreet,		localCity, localProvinceCode, localCountryCode, localPostalCode, localPhone)
VALUES
(7424476, 1,			 'N',				'D',				 0,				1130,	 '442 GIBSON ST N', 'Kitchener', 'ON',				 'CAN',				'N2M 4T4' ,  2261472985 )

SELECT number, isInternational, academicStatusCode, financialStatusCode, sequentialNumber, balance
FROM Student
WHERE number IN (SELECT number
				FROM Person
				WHERE firstName = 'INDU'
				AND lastName = 'TANEJA')

SELECT localStreet
FROM Student
WHERE number IN (SELECT number
				FROM Person
				WHERE firstName = 'INDU'
				AND lastName = 'TANEJA')

SELECT localCity, localPostalCode
FROM Student
WHERE number IN (SELECT number
				FROM Person
				WHERE firstName = 'INDU'
				AND lastName = 'TANEJA')

--7
Print '***Question 7 ***'
PRINT ''

SELECT code
FROM Program
WHERE acronym = 'CAD'

INSERT INTO StudentProgram
(studentNumber, programCode, semester, programStatusCode)
VALUES
(7424476, '0066C',1,'A')

SELECT studentNumber, programCode, semester, programStatusCode
FROM StudentProgram
WHERE studentNumber IN (SELECT number
						FROM Person
						WHERE firstName = 'INDU'
						AND lastName = 'TANEJA')

--8
Print '***Question 8 ***'
PRINT ''

SELECT id
FROM CourseOffering
WHERE sessionCode = 'F14'
AND courseNumber = 'PROG8080'

INSERT INTO CourseStudent
(CourseOfferingId,studentNumber)
VALUES
(64, 7424476 )

SELECT *
FROM CourseStudent
WHERE studentNumber IN (SELECT number
						FROM Person
						WHERE firstName = 'INDU'
						AND lastName = 'TANEJA')

--9
Print '***Question 9 ***'
PRINT ''

INSERT INTO Course
(number, hours, credits, name, frenchName)
VALUES
('LIBS1010', 45, 3, 'Critical Thinking Skills', 'Pensée Critique')

SELECT *
FROM Course
WHERE  number = 'LIBS1010'

--10
Print '***Question 10 ***'
PRINT ''

INSERT INTO Course
VALUES
('BUS1070', 45, 3, 'Introduction To Human Relations', 'Introduction aux relations humaines')

SELECT *
FROM Course
WHERE  number = 'BUS1070'

--11
Print '***Question 11 ***'
PRINT ''

SELECT id 
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee'

UPDATE IncidentalFee
SET amountPerSemester = 100
WHERE id = 5
AND  item = 'Technology Enhancement Fee'

BEGIN TRANSACTION
UPDATE IncidentalFee
SET amountPerSemester = 150
WHERE id = 5
AND  item = 'Technology Enhancement Fee'
ROLLBACK

SELECT * 
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee'

--12
Print '***Question 12 ***'
PRINT ''

BEGIN TRANSACTION
UPDATE IncidentalFee
SET amountPerSemester = 200
WHERE id = 5
AND  item = 'Technology Enhancement Fee'
COMMIT

SELECT * 
FROM IncidentalFee
WHERE item = 'Technology Enhancement Fee'