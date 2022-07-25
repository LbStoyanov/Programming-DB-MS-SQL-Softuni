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
	e.EmployeeID,
	e.FirstName,	
	CASE
        WHEN DATEPART(YEAR,p.StartDate) = 2005 then 'NULL'
        else p.Name
        end as ProjectName
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