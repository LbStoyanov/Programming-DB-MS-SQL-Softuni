--Problem 1.	One-To-One Relationship

CREATE TABLE [Persons](
		[PersonID]  INT PRIMARY KEY NOT NULL,
		[FirstName] NVARCHAR(50) NOT NULL,
		[Salary] FLOAT,
		[PassportID] INT NOT NULL
);		


--ALTER TABLE [Persons]
--ADD [PassportID] INT NOT NULL



CREATE TABLE [dbo].[Passports](
	[PassportID] [int] NOT NULL,
	[PassportNumber] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Passports] PRIMARY KEY CLUSTERED 
(
	[PassportID] ASC
)
)
CREATE TABLE [dbo].[Persons](
	[PersonID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
	[PassportID] [int] NOT NULL,
 CONSTRAINT [PK_Persons] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)
)

INSERT [dbo].[Passports] ([PassportID], [PassportNumber]) VALUES (101, N'N34FG21B')

INSERT [dbo].[Passports] ([PassportID], [PassportNumber]) VALUES (102, N'K65LO4R7')

INSERT [dbo].[Passports] ([PassportID], [PassportNumber]) VALUES (103, N'ZE657QP2')

INSERT [dbo].[Persons] ([PersonID], [FirstName], [Salary], [PassportID]) VALUES (1, N'Roberto     ', CAST(43300.00 AS Decimal(18, 2)), 102)

INSERT [dbo].[Persons] ([PersonID], [FirstName], [Salary], [PassportID]) VALUES (2, N'Tom', CAST(56100.00 AS Decimal(18, 2)), 103)

INSERT [dbo].[Persons] ([PersonID], [FirstName], [Salary], [PassportID]) VALUES (3, N'Yana', CAST(60200.00 AS Decimal(18, 2)), 101)

ALTER TABLE [dbo].[Persons]  WITH CHECK ADD  CONSTRAINT [FK_Persons_Passports] FOREIGN KEY([PassportID])
REFERENCES [dbo].[Passports] ([PassportID])

ALTER TABLE [dbo].[Persons] CHECK CONSTRAINT [FK_Persons_Passports]

--02. One-To-Many Relationship


CREATE TABLE [dbo].[Manufacturers](
	[ManufacturerID] [int] NOT NULL,
	[Name] [nchar](20) NOT NULL,
	[EstablishedOn] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Manufacturers] PRIMARY KEY CLUSTERED 
(
	[ManufacturerID] ASC
)
)

CREATE TABLE [dbo].[Models](
	[ModelID] [int] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[ManufacturerID] [int] NOT NULL,
 CONSTRAINT [PK_Models] PRIMARY KEY CLUSTERED 
(
	[ModelID] ASC
)
)

INSERT [Manufacturers] ([ManufacturerID], [Name], [EstablishedOn]) VALUES (1, N'BMW ', CAST(N'1916-03-07T00:00:00.0000000' AS DateTime2))

INSERT [Manufacturers] ([ManufacturerID], [Name], [EstablishedOn]) VALUES (2, N'Tesla ', CAST(N'2003-01-01T00:00:00.0000000' AS DateTime2))

INSERT [Manufacturers] ([ManufacturerID], [Name], [EstablishedOn]) VALUES (3, N'Lada ', CAST(N'1966-05-01T00:00:00.0000000' AS DateTime2))

INSERT [Models] ([ModelID], [Name], [ManufacturerID]) VALUES (101, N'X1', 1)

INSERT [Models] ([ModelID], [Name], [ManufacturerID]) VALUES (102, N'i6', 1)

INSERT [Models] ([ModelID], [Name], [ManufacturerID]) VALUES (103, N'Model S', 2)

INSERT [Models] ([ModelID], [Name], [ManufacturerID]) VALUES (104, N'Model X', 2)

INSERT [Models] ([ModelID], [Name], [ManufacturerID]) VALUES (105, N'Model 3', 2)

INSERT [Models] ([ModelID], [Name], [ManufacturerID]) VALUES (106, N'Nova', 3)

ALTER TABLE [dbo].[Models]  WITH CHECK ADD  CONSTRAINT [FK_Models_Manufacturer] FOREIGN KEY([ManufacturerID])
REFERENCES [dbo].[Manufacturers] ([ManufacturerID])

ALTER TABLE [dbo].[Models] CHECK CONSTRAINT [FK_Models_Manufacturer]

--Many-To-Many Relationships

CREATE TABLE Students(
StudentID INT PRIMARY KEY,
Name NVARCHAR(50)
)
 
CREATE TABLE Exams(
ExamID INT PRIMARY KEY,
Name NVARCHAR(255)
)
 
CREATE TABLE StudentsExams(
StudentID INT,
ExamID INT,
CONSTRAINT PK_StudentID_ExamID PRIMARY KEY(StudentID, ExamID),
CONSTRAINT FK_StudentsExams_Students FOREIGN KEY(StudentID) REFERENCES Students(StudentID),
CONSTRAINT FK_StudentsExams_ExamID FOREIGN KEY(ExamID) REFERENCES Exams(ExamID)
)
 
INSERT INTO Students VALUES
    (1, 'Mila'),
    (2, 'Toni'),
    (3, 'Ron')
 
INSERT INTO Exams VALUES
    (101, 'SpringMVC'),
    (102, 'Neo4j'),
    (103, 'Oracle 11g')
 
INSERT INTO StudentsExams VALUES
  (1, 101), 
  (1, 102), 
  (2, 101), 
  (3, 103), 
  (2, 102), 
  (2, 103)

