
CREATE DATABASE IF NOT EXISTS QuanLySinhVien
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE QuanLySinhVien;

CREATE TABLE IF NOT EXISTS Class (
    ClassID INT PRIMARY KEY AUTO_INCREMENT,
    ClassName VARCHAR(255) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);

CREATE TABLE IF NOT EXISTS Student (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassId INT NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

CREATE TABLE IF NOT EXISTS Subject (
    SubID INT PRIMARY KEY AUTO_INCREMENT,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT DEFAULT 1 CHECK (Credit >= 1),
    Status BIT DEFAULT 1
);

CREATE TABLE IF NOT EXISTS Mark (
    MarkID INT PRIMARY KEY AUTO_INCREMENT,
    SubId INT NOT NULL,
    StudentId INT NOT NULL,
    Mark FLOAT DEFAULT 0 CHECK (Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId, ExamTimes),
    FOREIGN KEY (SubId) REFERENCES Subject (SubID),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentID)
);

INSERT INTO Class (ClassID, ClassName, StartDate, Status)
VALUES 
    (1, 'A1', '2008-12-20', 1),
    (2, 'A2', '2008-12-22', 1),
    (3, 'B3', CURRENT_DATE, 0);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES 
    ('Hung', 'Ha Noi', '0912113113', 1, 1),
    ('Hoa', 'Hai phong', NULL, 1, 1),
    ('Manh', 'HCM', '0123123123', 0, 2);

INSERT INTO Subject (SubID, SubName, Credit, Status)
VALUES 
    (1, 'CF', 5, 1),
    (2, 'C', 6, 1),
    (3, 'HDJ', 5, 1),
    (4, 'RDBMS', 10, 1);

INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES 
    (1, 1, 8, 1),
    (1, 2, 10, 2),
    (2, 1, 12, 1);


SELECT *
FROM Student;

SELECT *
FROM Student
WHERE Status = true;

SELECT *
FROM Subject
WHERE Credit < 10;

SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student S 
JOIN Class C ON S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';

SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S 
JOIN Mark M ON S.StudentId = M.StudentId 
JOIN Subject Sub ON M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';