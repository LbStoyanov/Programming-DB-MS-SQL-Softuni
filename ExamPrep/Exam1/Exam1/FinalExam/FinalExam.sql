CREATE APPLICATION ROLE [FinalExam]
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
SET PlayersMax = PlayersMax + 1
WHERE PlayersMin = 2 AND PlayersMax = 2

UPDATE Boardgames
SET [Name] = CONCAT( [Name] ,'V2')
WHERE YearPublished >= 2020


-- 04. Delete

DELETE CreatorsBoardgames WHERE BoardgameId IN (SELECT Id FROM Boardgames WHERE PublisherId IN(SELECT ID FROM Publishers 
WHERE AddressId IN (SELECT Id FROM Addresses WHERE Town IS NOT NULL AND Town LIKE 'L%')))
DELETE Boardgames 
WHERE PublisherId in (SELECT ID FROM Publishers 
WHERE AddressId IN (SELECT Id FROM Addresses WHERE Town IS NOT NULL AND Town LIKE 'L%'))
DELETE Publishers WHERE AddressId IN(SELECT ID FROM Addresses WHERE Town IS NOT NULL AND Town LIKE 'L%')
DELETE FROM Addresses WHERE Town IS NOT NULL AND Town LIKE 'L%'

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

SELECT Rating.FullName, Rating.Email, MAX(Rating) AS Rating
FROM (
	SELECT CONCAT(c.FirstName, ' ', c.LastName) AS FullName, c.Email AS Email, bg.Rating AS Rating
	FROM Creators AS c
	INNER JOIN CreatorsBoardgames AS cb ON c.Id = cb.CreatorId
	LEFT JOIN Boardgames AS bg ON cb.BoardgameId = bg.Id
	WHERE c.Email LIKE '%.com'
	GROUP BY c.FirstName,c.LastName,c.Email,bg.Rating

) AS Rating
GROUP BY Rating.FullName,Rating.Email
ORDER BY FullName

--10. Creators by Rating

SELECT c.LastName,CEILING(AVG(bg.Rating)) AS AverageRating ,p.[Name] AS PublisherName 
FROM Creators AS c
INNER JOIN CreatorsBoardgames AS cb ON c.Id = cb.CreatorId
LEFT JOIN Boardgames AS bg ON cb.BoardgameId = bg.Id
LEFT JOIN Publishers AS p ON bg.PublisherId = p.Id
WHERE p.[Name] = 'Stonemaier Games'
GROUP BY bg.Rating,c.LastName, p.[Name]
ORDER BY AVG(bg.Rating) DESC
--11. Creator with Boardgames
CREATE FUNCTION udf_CreatorWithBoardgames(@name VARCHAR(30)) 
RETURNS INT
AS
BEGIN
	DECLARE @TotalBoardGamesNumber INT;

    SELECT 
	@TotalBoardGamesNumber =  COUNT(bg.Id)
	FROM Creators AS c
	LEFT JOIN CreatorsBoardgames AS cb ON c.Id = cb.CreatorId
	LEFT JOIN Boardgames AS bg ON cb.BoardgameId = bg.Id
	WHERE c.FirstName = @name
	GROUP BY C.Id;
RETURN @TotalBoardGamesNumber
END;

--12. Search for Boardgame with Specific Category

CREATE PROCEDURE usp_SearchByCategory(@category VARCHAR(50)) 
AS
BEGIN
						    SELECT  bg.[Name] AS [Name], 
									bg.YearPublished AS YearPublished,
									bg.Rating AS Rating,
									c.[Name] AS CategoryName,
									p.[Name] AS PublisherName,
									CONCAT(pr.PlayersMin, ' ', 'people') AS MinPlayers,
									CONCAT(pr.PlayersMax, ' ', 'people') AS MaxPlayers
								
							FROM Boardgames AS bg
							LEFT JOIN Categories AS c ON bg.CategoryId = c.Id
							LEFT JOIN Publishers AS p ON bg.PublisherId = p.Id
							LEFT JOIN PlayersRanges AS  pr ON bg.PlayersRangeId = pr.Id
							WHERE c.[Name] = @category
							ORDER BY p.[Name],bg.YearPublished DESC

END