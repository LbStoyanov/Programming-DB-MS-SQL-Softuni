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

