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

		