--Joins

SELECT TOP(50)
	e.FirstName,
	e.LastName,
	t.[Name] AS Town,
	a.AddressText

FROM [Employees] AS e
INNER JOIN [Addresses] AS a ON e.AddressID = a.AddressID
INNER JOIN [Towns] AS t ON a.TownID = t.TownID
ORDER BY e.FirstName, e.LastName

--1.	Employee Address
	--Create a query that selects:
		--EmployeeId
		--JobTitle
		--AddressId
		--AddressText
		--Return the first 5 rows sorted by AddressId in ascending order.
SELECT TOP(5)
	e.EmployeeID,
	e.JobTitle,
	a.AddressID,
	a.AddressText

FROM [Employees] AS e
JOIN [Addresses] AS a ON e.AddressID = a.AddressID
ORDER BY a.AddressID

--02. Addresses with Towns

	--Write a query that selects:
		--•	FirstName
		--•	LastName
		--•	Town
		--•	AddressText
		--Sorted by FirstName in ascending order then by LastName. Select first 50 employees.

SELECT TOP(50)
	e.FirstName,
	e.LastName,
	t.[Name],
	a.AddressText

FROM [Employees] AS e
JOIN [Addresses] AS a ON e.AddressID = a.AddressID
JOIN [Towns] AS t ON t.TownID = a.TownID
ORDER BY e.FirstName, e.LastName


--03. Sales Employees

	--Create a query that selects:
		--•	EmployeeID
		--•	FirstName
		--•	LastName
		--•	DepartmentName
	--Sorted by EmployeeID in ascending order. Select only employees from "Sales" department.

SELECT TOP(50)
	e.EmployeeID,
	e.FirstName,
	e.LastName,
	d.[Name] AS DepartmentName
	

FROM [Employees] AS e
JOIN [Departments] AS d ON e.DepartmentID = d.DepartmentID
WHERE d.[Name] = 'Sales'

ORDER BY e.EmployeeID


--04. Employee Departments
	
	--Create a query that selects:
		--•	EmployeeID
		--•	FirstName
		--•	Salary
		--•	DepartmentName
	--Filter only employees with salary higher than 15000. Return the first 5 rows sorted by DepartmentID in ascending order.


SELECT TOP(5)
	e.EmployeeID,
	e.FirstName,
	e.Salary,
	d.[Name] AS DepartmentName
	

FROM [Employees] AS e
JOIN [Departments] AS d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000

ORDER BY d.DepartmentID


--05. Employees Without Projects

		--Create a query that selects:
		--•	EmployeeID
		--•	FirstName
		--Filter only employees without a project. Return the first 3 rows sorted by EmployeeID in ascending order.

SELECT TOP(3)
	e.EmployeeID,
	e.FirstName
	
FROM [Employees] AS e
LEFT JOIN [EmployeesProjects] AS d ON e.EmployeeID = d.EmployeeID
WHERE  d.ProjectID IS NULL

ORDER BY e.EmployeeID



--06. Employees Hired After

		--•	FirstName
		--•	LastName
		--•	HireDate
		--•	DeptName
	--Filter only employees hired after 1.1.1999 and are from either "Sales" or "Finance" departments, sorted by HireDate (ascending).

SELECT 
	e.FirstName,
	e.LastName,
	e.HireDate,
	d.[Name] AS DeptName
	
	
FROM [Employees] AS e
LEFT JOIN [Departments] AS d ON e.DepartmentID = d.DepartmentID
WHERE  e.HireDate > '1999.1.1' AND d.[Name] IN('Sales','Finance')

ORDER BY e.HireDate

--07. Employees With Project

		--Create a query that selects:
		--•	EmployeeID
		--•	FirstName
		--•	ProjectName
		--Filter only employees with a project which has started after 13.08.2002 and it is still ongoing (no end date). 
		--Return the first 5 rows sorted by EmployeeID in ascending order.


SELECT TOP(5)
	e.EmployeeID,
	e.FirstName,
	P.[Name]
	
FROM [Employees] AS e
INNER JOIN [EmployeesProjects] AS ep ON e.EmployeeID = ep.EmployeeID
INNER JOIN [Projects] AS p ON p.ProjectID = ep.ProjectID
WHERE p.StartDate > '2002.08.13' AND p.EndDate IS NULL 

ORDER BY e.EmployeeID


--08. Employee 24

		--Create a query that selects:
		--•	EmployeeID
		--•	FirstName
		--•	ProjectName
		--Filter all the projects of employee with Id 24. If the project has started during or after 2005 the returned value should be NULL.

	
SELECT
	e.[EmployeeID],
	e.[FirstName],	
	CASE
        WHEN DATEPART(YEAR,p.StartDate) >= 2005 THEN NULL
        ELSE p.[Name]
        END AS [ProjectName]
FROM [Employees] AS e
INNER JOIN [EmployeesProjects] AS ep ON e.EmployeeID = ep.EmployeeID
INNER JOIN [Projects] AS p ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24

ORDER BY e.EmployeeID
	

--09. Employee Manager

		--Create a query that selects:
		--•	EmployeeID
		--•	FirstName
		--•	ManagerID
		--•	ManagerName

		--Filter all employees with a manager who has ID equals to 3 or 7. Return all the rows, sorted by EmployeeID in ascending order.


SELECT
	e.EmployeeID,
	e.FirstName,	
	mn.EmployeeID AS ManagerID,
	mn.FirstName AS ManagerName
	
FROM [Employees] AS e

INNER JOIN [Employees] AS mn ON mn.EmployeeID = e.ManagerID
WHERE e.ManagerID IN(3,7)

ORDER BY e.EmployeeID


--10. Employees Summary

		--Create a query that selects:
		--•	EmployeeID
		--•	EmployeeName
		--•	ManagerName
		--•	DepartmentName
	--Show first 50 employees with their managers and the departments they are in (show the departments of the employees).
	--Order by EmployeeID.

SELECT TOP (50)
	e.EmployeeID,
	CONCAT(e.FirstName,' ',e.LastName) AS EmployeeName, 		
	CONCAT(mn.FirstName, ' ',mn.LastName) AS ManagerName,
	d.[Name] AS DepartmentName
	
	
FROM [Employees] AS e

LEFT JOIN [Employees] AS mn ON mn.EmployeeID = e.ManagerID
LEFT JOIN [Departments] AS d ON e.DepartmentID = d.DepartmentID
WHERE e.ManagerID IS NOT NULL

ORDER BY e.EmployeeID


--11. Min Average Salary

		--Create a query that returns the value of the lowest average salary of all departments.

SELECT MIN(AVG) AS [MinAverageSalary]
FROM (
       SELECT AVG([Salary]) AS [avg]
       FROM Employees
       GROUP BY DepartmentID
     ) AS AverageSalary


--12. Highest Peaks in Bulgaria

		--Create a query that selects:
			--•	CountryCode
			--•	MountainRange
			--•	PeakName
			--•	Elevation
		--Filter all peaks in Bulgaria with elevation over 2835. Return all the rows sorted by elevation in descending order.


SELECT
	mc.[CountryCode]
	,m.[MountainRange]
	,p.[PeakName]
	,p.[Elevation]
FROM [Peaks] AS p
LEFT JOIN [Mountains] AS m ON p.[MountainId] = m.[Id]
INNER JOIN [MountainsCountries] AS mc ON mc.[MountainId] = p.[MountainId]
WHERE mc.CountryCode = 'BG' AND p.[Elevation] > 2835 
ORDER BY p.[Elevation] DESC


--13. Count Mountain Ranges
		
		--Create a query that selects:
			--•	CountryCode
			--•	MountainRanges
			--Filter the count of the mountain ranges in the United States, Russia and Bulgaria.

SELECT
	mc.[CountryCode]
	,COUNT(m.[MountainRange])
	
FROM [Mountains] AS m
LEFT JOIN [MountainsCountries] AS mc ON m.[Id] = mc.[MountainId]
WHERE mc.CountryCode IN ('US','BG','RU')
GROUP BY mc.[CountryCode]


--14. Countries With or Without Rivers

	--Create a query that selects:
		--•	CountryName
		--•	RiverName
	--Find the first 5 countries with or without rivers in Africa. Sort them by CountryName in ascending order.


SELECT TOP(5)
	c.[CountryName]
	,r.[RiverName]
	
FROM [Countries] AS c
LEFT JOIN [CountriesRivers] AS cr ON c.[CountryCode] = cr.[CountryCode]
LEFT JOIN [Rivers] AS r ON r.[Id] = cr.[RiverId]
WHERE c.[ContinentCode] = 'AF'
ORDER BY c.[CountryName]


--15. Continents and Currencies


		--Create a query that selects:
			--•	ContinentCode
			--•	CurrencyCode
			--•	CurrencyUsage
		--Find all continents and their most used currency. Filter any currency that is used in only one country. Sort your results by ContinentCode.


SELECT 
	rankedCurrencies.ContinentCode
	, rankedCurrencies.CurrencyCode
	, rankedCurrencies.Count
FROM (
		SELECT c.ContinentCode,
			c.CurrencyCode, COUNT(c.CurrencyCode) AS [Count]
			, DENSE_RANK() OVER (PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS [rank] 
		FROM Countries AS c
		GROUP BY c.ContinentCode, c.CurrencyCode) AS rankedCurrencies
WHERE rankedCurrencies.rank = 1 and rankedCurrencies.Count > 1


--16. Countries Without any Mountains

	--Create all the count of all countries, which don’t have a mountain.

--17. Highest Peak and Longest River by Country

	--For each country, find the elevation of the highest peak and the length of the longest river, 
	--sorted by the highest peak elevation (from highest to lowest), 
	--then by the longest river length (from longest to smallest), then by country name (alphabetically). 
	--Display NULL when no data is available in some of the columns. Limit only the first 5 rows.


SELECT TOP(5)
	c.[CountryName]
	,MAX(p.[Elevation]) AS [HighestPeakElevation]
	,MAX(r.[Length]) AS [LongestRiverLength]
FROM [Countries] AS c
LEFT JOIN [MountainsCountries] AS mc ON c.[CountryCode] = mc.[CountryCode]
LEFT JOIN [Mountains] AS m ON m.[Id] = mc.[MountainId]
LEFT JOIN [Peaks] AS p ON p.[MountainId] = m.[Id]
LEFT JOIN [CountriesRivers] AS cr ON c.[CountryCode] = cr.[CountryCode]
LEFT JOIN [Rivers] AS r ON r.[Id] = cr.[RiverId]
GROUP BY c.[CountryName]
ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, [CountryName]