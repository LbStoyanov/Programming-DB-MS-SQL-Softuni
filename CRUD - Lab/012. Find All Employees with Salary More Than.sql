﻿SELECT 
  [FirstName],
  [LastName],
  [Salary] 
  FROM SoftUni..Employees 
  WHERE [Salary] > 50000
  ORDER BY [Salary] DESC