--01. Find Names of All Employees by First Name

SELECT FirstName,LastName
FROM Employees
WHERE FirstName LIKE 'Sa%'--Starts With

--02. Find Names of All Employees by Last Name

SELECT FirstName,LastName
FROM Employees
WHERE LastName LIKE '%ei%' --Contains

--03. Find First Names of All Employess

