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

