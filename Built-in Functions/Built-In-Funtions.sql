﻿--01. Find Names of All Employees by First Name

SELECT FirstName,LastName
FROM Employees
WHERE FirstName LIKE 'Sa%'--Starts With
--Another solution: WHERE LEFT(FirstName, 2) = 'Sa'


--02. Find Names of All Employees by Last Name

SELECT FirstName,LastName
FROM Employees
WHERE LastName LIKE '%ei%' --Contains
--Another solution: WHERE CHARINDEX('ei',LastName) > 0

--03. Find First Name of All Employess

SELECT FirstName
FROM Employees
WHERE DepartmentID IN(3,10) 
		AND (SELECT YEAR(HireDate)) >= 1995
			AND(SELECT YEAR(HireDate)) <= 2005
--Another solution: AND YEAR(HireDate) BETWEEN 1995 AND 2005

--04. Find All Employees Except Engineers

SELECT FirstName,LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'
--Another Solution:WHERE CHARINDEX('engineer', JobTitle) = 0

--05. Find Towns with Name Length

SELECT [Name]
FROM Towns
WHERE LEN(Name) IN (5,6)
ORDER BY [Name]

--06. Find Towns Starting With

SELECT [TownID],[Name]
FROM Towns
WHERE LEFT(Name,1) IN ('M','K','B','E')
--WHERE Name LIKE '[MKBE]%'
ORDER BY [Name]

--07. Find Towns Not Starting With

SELECT [TownID],[Name]
FROM Towns
WHERE [Name] NOT LIKE 'R%' AND [Name] NOT LIKE 'B%' AND [Name] NOT LIKE 'D%'
ORDER BY [Name]

 --08. Create View Employees Hired After

--CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees
WHERE (SELECT YEAR(HireDate)) > 2000

--09. Length of Last Name

SELECT FirstName,LastName
FROM Employees
WHERE LEN([LastName]) = 5

--10. Rank Employees by Salary

SELECT 
	 [EmployeeID]
	,[FirstName]
	,[LastName]
	,[Salary] 
	,DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY EmployeeID)   AS Rank 

FROM [Employees]

WHERE [Salary] BETWEEN 10000 AND 50000 ORDER BY [Salary] DESC

--11. Find All Employees with Rank 2

SELECT * FROM (
		SELECT 
	 [EmployeeID]
	,[FirstName]
	,[LastName]
	,[Salary] 
	,DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY EmployeeID)   AS Rank
	FROM [Employees]
	WHERE [Salary] BETWEEN 10000 AND 50000) AS MyTable

WHERE [Rank] = 2
ORDER BY [Salary] DESC


--12. Countries Holding 'A'

SELECT 
	 [CountryName]
	,[IsoCode] AS [ISO Code]

FROM [Countries]

WHERE [CountryName] LIKE '%a%a%a%'
ORDER BY [IsoCode]

--13. Mix of Peak and River Names

--SELECT Peaks.PeakName,
--       Rivers.RiverName,
--       LOWER(CONCAT(LEFT(Peaks.PeakName, LEN(Peaks.PeakName)-1), Rivers.RiverName)) AS Mix
--FROM Peaks
--     JOIN Rivers ON RIGHT(Peaks.PeakName, 1) = LEFT(Rivers.RiverName, 1)
--ORDER BY Mix;

SELECT  p.[PeakName],
		r.[RiverName],
		LOWER(CONCAT(LEFT(p.[PeakName], LEN(p.PeakName) - 1), r.[RiverName])) AS [Mix]
	FROM [Peaks]  AS p,
		 [Rivers] AS r
WHERE LOWER(RIGHT(p.PeakName,1)) = LOWER(LEFT(r.RiverName,1))
ORDER BY [Mix]


--14. Games From 2011 and 2012 Year

SELECT TOP(50) 
		[Name],
		FORMAT([Start], 'yyyy-MM-dd') AS [Start]
		--Another format solution
		--FORMAT(CAST([Start] AS DATE),'yyyy-MM-dd') AS [Start]
		 

FROM [Games]

WHERE YEAR([Start]) IN(2011,2012)
ORDER BY [Start],[Name]



--15. User Email Providers

SELECT	 [Username]
		,RIGHT(Email, LEN(Email)-CHARINDEX('@', Email)) AS [Email Provider]
FROM [Users]
ORDER BY [Email Provider] ASC,[Username]

--16. Get Users with IPAddress Like Pattern

SELECT   [Username]
    	,[IpAddress]  AS [IP Address]	 
FROM [Users]
WHERE [IpAddress] LIKE '___.1_%._%.___'
ORDER BY [Username]

--17. Show All Games with Duration

SELECT  [Name]
	AS	[Game],
		CASE
			WHEN DATEPART(HOUR, [Start]) >= 0 AND DATEPART(HOUR, [Start]) < 12 THEN  'Morning'
			WHEN DATEPART(HOUR, [Start]) >= 12 AND DATEPART(HOUR, [Start]) < 18 THEN  'Afternoon'
			ELSE 'Evening'
		END AS [Part of the Day],
		CASE	
			WHEN [Duration] <= 3 THEN 'Extra Short'
			WHEN [Duration] BETWEEN 4 AND 6 THEN 'Short'
			WHEN [Duration] > 6 THEN 'Long'
			ELSE 'Extra Long'
	    END AS [Duration]
	   
FROM [Games]
ORDER BY [Game],[Duration],[Part of the Day]

--18. Orders Table

SELECT ProductName, OrderDate, 
    DATEADD(DAY,3,OrderDate) AS [Pay Due],
    DATEADD(MONTH,1,OrderDate) AS [Deliver Due]
    FROM Orders

