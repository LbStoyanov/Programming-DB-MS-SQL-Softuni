﻿--01. Employees with Salary Above 35000

		--Create stored procedure usp_GetEmployeesSalaryAbove35000 that returns all employees’ first and last names for whose 
		--salary is above 35000. 


CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT	
	   	  [FirstName]
		 ,[LastName] 
	FROM  [Employees]
	WHERE [Salary] > 35000
END
--EXEC usp_GetEmployeesSalaryAbove35000

--02. Employees with Salary Above Number

	--Create a stored procedure usp_GetEmployeesSalaryAboveNumber that accept a number (of type DECIMAL(18,4)) as 
	--parameter and returns all employees’ first and last names whose salary is above or equal to the given number. 

--CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber  @minSalary DECIMAL(18, 4)
--AS
--BEGIN
--	SELECT	
--	   	  [FirstName]
--		 ,[LastName] 
--	FROM  [Employees]
--	WHERE [Salary] >= @minSalary
--END



--03. Town Names Starting With

		--Create a stored procedure usp_GetTownsStartingWith that accept string as parameter and returns all town names starting with that string. 

--CREATE PROCEDURE usp_GetTownsStartingWith @townName NVARCHAR (50)
--AS
--BEGIN
	
--	DECLARE @stringCount int = LEN(@townName)
--	SELECT [Name] FROM [Towns]
--	WHERE LEFT([Name],@stringCount) = @townName
--END


--04. Employees from Town

  --Create a stored procedure usp_GetEmployeesFromTown that accepts town name as parameter and return the employees’ first and last name 
  --that live in the given town. 


--CREATE PROCEDURE usp_GetEmployeesFromTown @townName VARCHAR (50)
--AS
--BEGIN
--	SELECT
--		e.[FirstName],
--		e.[LastName]
--	FROM [Employees] AS e
--	LEFT JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
--	LEFT JOIN [Towns] AS t ON a.[TownID] = t.[TownID]
--	WHERE t.[Name] = @townName
	
--END


--05. Salary Level Function

	--Create a function ufn_GetSalaryLevel(@salary DECIMAL(18,4)) that receives salary of an employee and returns the level of the salary.
	--•	If salary is < 30000 return "Low"
	--•	If salary is between 30000 and 50000 (inclusive) return "Average"
	--•	If salary is > 50000 return "High"


--CREATE FUNCTION ufn_GetSalaryLevel (@salary DECIMAL(18 , 4))
--RETURNS VARCHAR(7)
--AS
--BEGIN
--	DECLARE @salaryLevel VARCHAR(7)

--	IF @salary < 30000
--	BEGIN
--		SET @salaryLevel = 'Low'
--	END
--	ELSE IF @salary BETWEEN 30000 AND 50000
--	BEGIN
--		SET @salaryLevel = 'Average'
--	END
--	ELSE
--	BEGIN
--		SET @salaryLevel = 'High'
--	END

--	RETURN @salaryLevel
--END


--06. Employees by Salary Level

	--Create a stored procedure usp_EmployeesBySalaryLevel that receive as parameter level of salary 
	--(low, average, or high) and print the names of all employees that have 
	--given level of salary. You should use the function - "dbo.ufn_GetSalaryLevel(@Salary) ",
	--which was part of the previous task, inside your "CREATE PROCEDURE …" query.
	

--CREATE PROCEDURE usp_EmployeesBySalaryLevel @salaryLevel VARCHAR(7)
--AS
--BEGIN
--	SELECT
--		[FirstName],
--		[LastName]
--	FROM [Employees] AS e
--	WHERE dbo.ufn_GetSalaryLevel(e.[Salary]) = @salaryLevel

--END

--07. Define Function

	--Define a function ufn_IsWordComprised(@setOfLetters, @word) 
	--that returns true or false depending on that if the word is comprised of the given set of letters. 

--CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR (50), @word VARCHAR (50)) 
--RETURNS BIT
--AS
--BEGIN
--     DECLARE @index INT = 1
--     DECLARE @length INT = LEN(@word)
--     DECLARE @letter CHAR(1)

--     WHILE (@index <= @length)
--     BEGIN
--          SET @letter = SUBSTRING(@word, @index, 1)
--          IF (CHARINDEX(@letter, @setOfLetters) > 0)
--             SET @index = @index + 1
--          ELSE
--             RETURN 0
--     END
--     RETURN 1
--END 


--08.Delete Employees and Departments

	--Create a procedure with the name usp_DeleteEmployeesFromDepartment (@departmentId INT) which deletes all Employees from a given 
	--department. Delete these departments from the Departments table too. 
	--Finally, SELECT the number of employees from the given department. If the delete statements are correct the select query should return 0.
	--After completing that exercise restore your database to revert all changes.
	
--	CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT) 
--AS
--BEGIN
--	DELETE FROM [EmployeesProjects]
--	WHERE [EmployeeID] IN (
--								SELECT [EmployeeID]
--								FROM [Employees]
--								WHERE [DepartmentID] = @departmentId
--						  )	

--	UPDATE [Employees]
--	SET [ManagerID] = NULL
--	WHERE [ManagerID] IN (
--								SELECT [EmployeeID]
--								FROM [Employees]
--								WHERE [DepartmentID] = @departmentId
--						 )	

--	ALTER TABLE [Departments]
--	ALTER COLUMN [ManagerID] INT
	
--	UPDATE [Departments]
--	SET [ManagerID] = NULL
--	WHERE [ManagerID] IN (
--								SELECT [EmployeeID]
--								FROM [Employees]
--								WHERE [DepartmentID] = @departmentId
--						 )

--	DELETE FROM [Employees]
--	WHERE [DepartmentID] = @departmentId

--	DELETE FROM [Departments]
--	WHERE[DepartmentID] = @departmentId

--	SELECT
--		COUNT(*)
--	FROM [Employees]
--	WHERE [DepartmentID] = @departmentId
--END

--13. *Cash in User Games Odd Rows

	--Create a function ufn_CashInUsersGames that sums the cash of odd rows. 
	--Rows must be ordered by cash in descending order.
	--The function should take a game name as a parameter and return the result as a table. 
	--Submit only your function in.


--CREATE FUNCTION ufn_CashInUsersGames (@gameName VARCHAR(50))
--RETURNS TABLE
--AS
--RETURN SELECT(

--	SELECT 
--		SUM([Cash]) AS [SumCahs] 
--	FROM (
--				SELECT
--					g.[Name],
--					ug.[Cash],
--					ROW_NUMBER() OVER(PARTITION BY g.[Name] ORDER BY ug.[Cash] DESC) AS [RowNumber]
--				FROM [UsersGames] AS ug
--				INNER JOIN [Games] AS g ON ug.[GameId] = g.[id]
--				WHERE g.[Name] = @gameName
--		 ) AS [RowNumberSubQuery]
--WHERE [RowNumber] % 2 <> 0	
--			) AS [SumCash]
