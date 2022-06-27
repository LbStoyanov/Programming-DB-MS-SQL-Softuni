CREATE VIEW [dbo].[V_EmployeeNameJobTitle]
AS
SELECT 
CONCAT(FirstName, ' ',ISNULL(MiddleName, ''), LastName) AS [Full Name], 

JobTitle AS [Job Title]
FROM 
dbo.Employees
GO