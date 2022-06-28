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

--