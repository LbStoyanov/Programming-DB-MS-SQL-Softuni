--01. Employees with Salary Above 35000

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

CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber  @minSalary DECIMAL(18, 4)
AS
BEGIN
	SELECT	
	   	  [FirstName]
		 ,[LastName] 
	FROM  [Employees]
	WHERE [Salary] >= @minSalary
END



--03. Town Names Starting With

		--Create a stored procedure usp_GetTownsStartingWith that accept string as parameter and returns all town names starting with that string. 

CREATE PROCEDURE usp_GetTownsStartingWith @townName NVARCHAR (50)
AS
BEGIN
	
	DECLARE @stringCount int = LEN(@townName)
	SELECT [Name] FROM [Towns]
	WHERE LEFT([Name],@stringCount) = @townName
END


--04. Employees from Town

  --Create a stored procedure usp_GetEmployeesFromTown that accepts town name as parameter and return the employees’ first and last name 
  --that live in the given town. 


CREATE PROCEDURE usp_GetEmployeesFromTown @townName VARCHAR (50)
AS
BEGIN
	SELECT
		e.[FirstName],
		e.[LastName]
	FROM [Employees] AS e
	LEFT JOIN [Addresses] AS a ON e.[AddressID] = a.[AddressID]
	LEFT JOIN [Towns] AS t ON a.[TownID] = t.[TownID]
	WHERE t.[Name] = @townName
	
END


--05. Salary Level Function

	--Create a function ufn_GetSalaryLevel(@salary DECIMAL(18,4)) that receives salary of an employee and returns the level of the salary.
	--•	If salary is < 30000 return "Low"
	--•	If salary is between 30000 and 50000 (inclusive) return "Average"
	--•	If salary is > 50000 return "High"


CREATE FUNCTION ufn_GetSalaryLevel (@salary DECIMAL(18 , 4))
RETURNS VARCHAR(7)
AS
BEGIN
	DECLARE @salaryLevel VARCHAR(7)

	IF @salary < 30000
	BEGIN
		SET @salaryLevel = 'Low'
	END
	ELSE IF @salary BETWEEN 30000 AND 50000
	BEGIN
		SET @salaryLevel = 'Average'
	END
	ELSE
	BEGIN
		SET @salaryLevel = 'High'
	END

	RETURN @salaryLevel
END


--06. Employees by Salary Level

