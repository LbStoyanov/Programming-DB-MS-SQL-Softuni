﻿CREATE APPLICATION ROLE [FinalExam]
	WITH PASSWORD = 'htwqPdqpeubQt7|eqiyqJcsDmsFT7_&#$!~<,mUelguuicXa'

--01.DDL

CREATE DATABASE Boardgames

CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL 
);

CREATE TABLE Addresses
(
	Id INT PRIMARY KEY IDENTITY,
	StreetName VARCHAR(100) NOT NULL,
	StreetNumber INT NOT NULL,
	Town VARCHAR(30) NOT NULL,
	Country VARCHAR(50) NOT NULL,
	ZIP INT NOT NULL
);

CREATE TABLE Publishers
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) UNIQUE NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses (Id) NOT NULL,
	Website VARCHAR(40),
	Phone VARCHAR(20),
);

CREATE TABLE PlayersRanges
(
	Id INT PRIMARY KEY IDENTITY,
	PlayersMin INT  NOT NULL,
	PlayersMax INT  NOT NULL,
);

CREATE TABLE Boardgames
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) NOT NULL,
	YearPublished INT NOT NULL,
	Rating DECIMAL(18,2) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories (Id) NOT NULL,
	PublisherId INT FOREIGN KEY REFERENCES Publishers (Id) NOT NULL,
	PlayersRangeId INT FOREIGN KEY REFERENCES PlayersRanges (Id) NOT NULL
);

CREATE TABLE Creators
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL
);

CREATE TABLE CreatorsBoardgames
(
	CreatorId INT FOREIGN KEY REFERENCES Creators (Id) NOT NULL,
	BoardgameId INT FOREIGN KEY REFERENCES Boardgames (Id) NOT NULL,
	PRIMARY KEY (CreatorId, BoardgameId)
);

--Task 02.-INSERT

INSERT INTO Boardgames ([Name], YearPublished, Rating, CategoryId, PublisherId, PlayersRangeId)
VALUES
('Deep Blue', 2019, 5.67, 1, 15, 7),
('Paris', 2016, 9.78, 7, 1, 5),
('Catan: Starfarers', 2021, 9.87, 7, 13, 6),
('Bleeding Kansas', 2020, 3.25, 3, 7, 4),
('One Small Step', 2019, 5.75, 5, 9, 2)


INSERT INTO Publishers ([Name], AddressId, Website, Phone)
VALUES
('Agman Games', 5, 'www.agmangames.com', '+16546135542'),
('Amethyst Games', 7, 'www.amethystgames.com', '+15558889992'),
('BattleBooks', 13, 'www.battlebooks.com', '+12345678907')

-- 03. Update

UPDATE PlayersRanges
SET PlayersMax = (SELECT Id FROM PlayersRanges WHERE PlayersMin = 2 AND PlayersMax = 2) + 1;

UPDATE Boardgames
SET [Name] = CONCAT( (SELECT TOP 1 [Name] FROM Boardgames WHERE YearPublished >= 2020) ,'v2')


-- 04. Delete

DELETE FROM Addresses WHERE Town LIKE 'L%'

--05. Boardgames by Year of Publication
SELECT   [Name]
		,Rating
FROM Boardgames
ORDER BY YearPublished,[Name] DESC

--06. Boardgames by Category

SELECT bg.Id,bg.[Name], bg.YearPublished,c.[Name]
FROM Boardgames AS bg
LEFT JOIN Categories AS c ON bg.CategoryId = c.Id
WHERE c.[Name] = 'Strategy Games' OR c.[Name] = 'Wargames'
ORDER BY bg.YearPublished DESC

--07. Creators without Boardgames

SELECT Id, CONCAT(c.FirstName, ' ', c.LastName) AS CreatorName, c.Email
FROM Creators AS c
LEFT JOIN CreatorsBoardgames AS cb ON c.Id = cb.CreatorId
WHERE cb.BoardgameId IS NULL
ORDER BY CreatorName

--08. First 5 Boardgames
SELECT TOP(5) BG.[Name], bg.Rating, c.[Name]
FROM Boardgames AS bg
LEFT JOIN PlayersRanges AS pr ON bg.PlayersRangeId = pr.Id
LEFT JOIN Categories AS c ON bg.CategoryId = c.Id
WHERE bg.Rating > 7 AND bg.[Name] LIKE '%a%' OR bg.Rating > 7.50 AND pr.PlayersMin = 2 AND pr.PlayersMax = 5
ORDER BY bg.[Name], bg.Rating DESC

--09. Creators with Emails
