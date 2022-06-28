SELECT TOP (7) firstName,
               LastName,
               HireDate
FROM Employees
ORDER BY HireDate DESC;

-----21. Increase Salaries

DECLARE @EngineeringID INT;

DECLARE @ToolDesignID INT;

DECLARE @MarketingID INT;

DECLARE @InformationServicesID INT;

SELECT TOP (1) @EngineeringID = DepartmentID
FROM Departments
WHERE [Name] = 'Engineering';

SELECT TOP (1) @ToolDesignID = DepartmentID
FROM Departments
WHERE [Name] = 'Tool Design';

SELECT TOP (1) @MarketingID = DepartmentID
FROM Departments
WHERE [Name] = 'Marketing';

SELECT TOP (1) @InformationServicesID = DepartmentID
FROM Departments
WHERE [Name] = 'Information Services';

UPDATE Employees
  SET
      Salary *= 1.12
WHERE DepartmentID = @EngineeringID
      OR DepartmentID = @ToolDesignID
      OR DepartmentID = @MarketingID
      OR DepartmentID = @InformationServicesID;
	
SELECT Salary
FROM Employees;

-- 22. All Mountain Peaks

SELECT [PeakName]
FROM [Peaks]
ORDER BY [PeakName]

--23. Biggest Countries by Population

SELECT TOP (30) [CountryName],[Population] 
FROM [Countries]
WHERE
[ContinentCode] = 'EU'
ORDER BY
[Population] DESC

--24. Countries and Currency (Euro / Not Euro)

SELECT CountryName,
       CountryCode,
       CASE CurrencyCode
           WHEN 'EUR'
           THEN 'Euro'
           ELSE 'Not Euro'
       END AS 'Currency'
FROM Countries
ORDER BY CountryName;

--25. All Diablo Characters

SELECT
[Name]
FROM
[Characters]
ORDER BY
[Name]
