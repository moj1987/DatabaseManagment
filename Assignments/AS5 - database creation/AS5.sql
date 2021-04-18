--Mojtaba Abbasszadeh - AS5
--1
Print '***Question 1 ***'
PRINT ''
CREATE DATABASE CollegeDB;

--2
Print '***Question 2 ***'
PRINT ''

CREATE TABLE Student
(
	id int NOT NULL PRIMARY KEY  IDENTITY(100000,1) ,
	firstName VARCHAR(30),
	lastName VARCHAR(30),
);

--3
Print '***Question 3 ***'
PRINT ''

CREATE TABLE Address  
(
	id int IDENTITY,
	studentID int FOREIGN KEY REFERENCES Student(id) ON DELETE CASCADE,
	street VARCHAR(25),
	city VARCHAR(25),
	post_code VARCHAR(8),
	phone_number VARCHAR(15),
	email VARCHAR(50)
);

--4
Print '***Question 4 ***'
PRINT ''

CREATE TABLE Course
(
	id int  NOT NULL IDENTITY,
	name VARCHAR(50),
	courseCode int PRIMARY KEY,
	description VARCHAR(255),
);

--5
Print '***Question 5 ***'
PRINT ''

CREATE TABLE Semester
(
	id CHAR(3) NOT NULL 
	CONSTRAINT id_pk PRIMARY KEY
	CHECK(id Like '[A-Z][0-9][0-9]' ),

	description VARCHAR(25),
);

--6
Print '***Question 6 ***'
PRINT ''

CREATE TABLE StudentCourse
(
	studentID int NOT NULL
	FOREIGN KEY REFERENCES dbo.Student(id),
	
	courseID int NOT NULL
	FOREIGN KEY REFERENCES dbo.Course(courseCode), 

	semesterID CHAR(3) NOT NULL
	FOREIGN KEY REFERENCES Semester(id),
	
	mark FLOAT(24) DEFAULT  0
	CHECK (mark between 0 and 100),

	PRIMARY KEY (studentID, courseID, semesterID)
);

--7
Print '***Question 7 ***'
PRINT ''

INSERT INTO Student
(firstName, lastName)
VALUES
('Carey', 'Mahoney'),
('Moses', 'Hightower'),
('Debbie', 'Callahan');

--8
Print '***Question 8 ***'
PRINT ''

INSERT INTO Address
(studentID,												street,					city,		post_code, phone_number,	 email)
VALUES 
((select id from Student where firstName = 'Carey' ), '2336 Bolevard Cremazie', 'Quebex', 'G1R 1B8','418-528-2338', '1y02cq9oj23@temporary-mail.net'),

((select id from Student where firstName = 'Moses' ), '68 Yonge Street', 'Toronto', 'M4W 1J7','416-278-1458', 'n2mdr80x1l@temporary-mail.net'),

((select id from Student where firstName = 'Debbie' ), '2262 Algonquin Blvd', 'Timmins', 'P4N 1C3','705-360-3260', '71ubqzoec89@temporary-mail.net');


--9
Print '***Question 9 ***'
PRINT ''

INSERT INTO Course
(name, courseCode, description)
VALUES
('Database Managment',8080,'This course teaches the knowledge and skills needed to use relational databases to persist application data. '),
('Software Development Techniques',8010,'Students use an object-oriented language to develop software solutions to solve business problems.'),
('Web Foundations',8540,'In order to promote market appeal and a strong user experience, websites and web applications require user-friendly and appealing front ends.'),
('Conestoga 101',101,'This self-directed course focuses on introducing new students to the supports, services, and opportunities available at Conestoga College. ');

--10
Print '***Question 10 ***'
PRINT ''
INSERT INTO Semester
(id, description)
VALUES
('F15', 'Fall 2015'),
('W16', 'Winter 2016'),
('S16', 'Summer 2016');

select * from Semester
--11
Print '***Question 11 ***'
PRINT ''

INSERT INTO StudentCourse
(studentID, courseID, semesterID)
VALUES 
((SELECT id FROM STUDENT WHERE firstName = 'Carey'), (SELECT courseCode FROM Course WHERE id =1),(SELECT id FROM Semester WHERE description = 'Fall 2015')),
((SELECT id FROM STUDENT WHERE firstName = 'Carey'), (SELECT courseCode FROM Course WHERE id =2),(SELECT id FROM Semester WHERE description = 'Fall 2015')),
((SELECT id FROM STUDENT WHERE firstName = 'Moses'), (SELECT courseCode FROM Course WHERE id =3),(SELECT id FROM Semester WHERE description = 'Fall 2015')),
((SELECT id FROM STUDENT WHERE firstName = 'Moses'), (SELECT courseCode FROM Course WHERE id =4),(SELECT id FROM Semester WHERE description = 'Fall 2015')),
((SELECT id FROM STUDENT WHERE firstName = 'Debbie'), (SELECT courseCode FROM Course WHERE id =1),(SELECT id FROM Semester WHERE description = 'Fall 2015')),
((SELECT id FROM STUDENT WHERE firstName = 'Debbie') , (SELECT courseCode FROM Course WHERE id =3),(SELECT id FROM Semester WHERE description = 'Fall 2015'));

--12
Print '***Question 12 ***'
PRINT ''

UPDATE StudentCourse
SET mark = 96
WHERE studentID = 100000
AND courseID = 8080;

UPDATE StudentCourse
SET mark = 81.67
WHERE studentID = 100000
AND courseID = 8010;

--13
Print '***Question 13 ***'
PRINT ''

DELETE FROM StudentCourse
WHERE studentID = (SELECT ID
				   FROM  Student
				   WHERE firstName = 'Debbie' 
				   AND lastName= 'Callahan')

DELETE FROM Student
WHERE lastName= 'Callahan'
AND firstName = 'Debbie'
