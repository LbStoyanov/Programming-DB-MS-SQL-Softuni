CREATE DATABASE Minions

USE [Minions]

CREATE TABLE Minions(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(100),
	Age INT
)

--ALTER TABLE Minions
--ALTER COLUMN Id INT NOT NULL

--ADD CONSTRAINT PK_Id PRIMARY KEY (Id)
	

CREATE TABLE Towns(
	 Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(100),
)

--04. Insert Records in Both Tables

INSERT INTO [Towns] ([Id], [Name]) VALUES
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna')

INSERT INTO [Minions]([Id], [Name], [Age], [TownId]) VALUES
(1,'Kevin', 22,1),
(2,'Bob', 15,3),
(3,'Steward',NULL,2)

--07. Create Table People

CREATE TABLE People
(
 [Id] INT PRIMARY KEY Identity,
 [Name] NVARCHAR(200) NOT NULL,
 [Picture] VARBINARY(MAX),
 [Height] DECIMAL(5,2),
 [Weight] DECIMAL(5,2),
 [Gender] char(1) Not null CHECK(Gender='m' OR Gender='f'),
 Birthdate DATE Not Null,
 Biography NVARCHAR(MAX)
)
INSERT INTO People(Name,Picture,Height,Weight,Gender,Birthdate,Biography) Values
('Stela',Null,1.65,44.55,'f','2000-09-22',Null),
('Ivan',Null,2.15,95.55,'m','1989-11-02',Null),
('Qvor',Null,1.55,33.00,'m','2010-04-11',Null),
('Karolina',Null,2.15,55.55,'f','2001-11-11',Null),
('Pesho',Null,1.85,90.00,'m','1983-07-22',Null)

--08. Create Table Users

CREATE TABLE [Users](
	[Id] BIGINT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY(MAX),
	CHECK (DATALENGTH ([ProfilePicture]) <= 900000),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT NOT NULL
)


INSERT INTO [Users]([Username],[Password],[ProfilePicture],[LastLoginTime],[IsDeleted]) VALUES
('Mitko', 'dasaznai123456', null, '2015-11-08', 'true'),
('Ditko', 'dasaznai1234567', null, '2015-09-08', 'false'),
('Kalitko', 'dasaznai12345678', null, '2015-12-08', 'true'),
('Margaritko', 'dasaznai1234567891', null, '2015-12-08', 'true'),
('Pitko', 'dasaznai1234', null, '2015-12-08', 'false')

--13. Movies Database

CREATE TABLE Directors
(
    Id int IDENTITY ,
    DirectorName nvarchar(50) NOT NULL,
    Notes nvarchar(MAX)
)

CREATE TABLE Genres
(
    Id int IDENTITY,
    GenereName nvarchar(50) NOT NULL,
    Notes nvarchar(MAX)
)

CREATE TABLE Categories 
(
    Id int IDENTITY,
    CategoryName nvarchar(50) NOT NULL,
    Notes nvarchar(MAX)
)

CREATE TABLE Movies
(
    Id int IDENTITY,
    Title nvarchar(50),
    DirectorId int,
    CopyrightYear  int,
    Length int,
    GenreId int,
    CatgoryId int,
    Rating int, 
    Notes nvarchar(MAX)
)

ALTER TABLE Directors
ADD CONSTRAINT PK_Id
PRIMARY KEY (Id)

ALTER TABLE Genres
ADD CONSTRAINT PK_Genres
PRIMARY KEY (Id)

ALTER TABLE Categories
ADD CONSTRAINT PK_Categories
PRIMARY KEY (Id)

ALTER TABLE Movies
ADD CONSTRAINT PK_Movies
PRIMARY KEY (Id)

INSERT INTO Directors(DirectorName,Notes)
VALUES ('Pesho', 'Пешо е добър служител'), 
('Mitko','Митко е най-добрия'),
('Калин', 'Отличникът'),
('Калина', 'Тя просто е перфектна'),
('Явор', 'Връзкар')

INSERT INTO Genres (GenereName, Notes)
VALUES ('Asen', 'klklkl'),
('Kaloqn', ' lrlllll'),
('Simeon', 'Aheloi'),
('Boris', 'Покръстителят'),
('Крум', 'Крумовите закони')

INSERT INTO Categories (CategoryName,Notes)
VALUES ('HISTORY', 'Отличен филм'),
('Action', 'Oscar'),
('History','lklllllk'),
('drama', 'lkooooopo' ),
('Triller', 'llkllkklk')

INSERT INTO Movies (Title,DirectorId,CopyrightYear,Length,GenreId,CatgoryId,Rating,Notes)
VALUES(' King' ,5,1999,78,1,5,10,'otlichen'),
('RRIRIR',4,2000,90,2,4,9,'otlichen'),
('plpppo',3,1980,100,3,3,5,'otlichen'),
('kkiklo',2,1890,20,4,2,10,'iopkll'),
('ukukkk',1,1990,120,5,1,10,'plpppp')

