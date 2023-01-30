--1. Records’ Count
--Import the database and send the total count of records from the one and only table to Mr. Bodrog. Make sure nothing got lost.

SELECT COUNT(*) 
     FROM dbo.WizzardDeposits


--02. Longest Magic Wand

--Select the size of the longest magic wand. Rename the new column appropriately.

SELECT MAX([MagicWandSize]) AS LongestMagicWand
     FROM [WizzardDeposits] 


--03. Longest Magic Wand per Deposit Groups
    --For wizards in each deposit group show the longest magic wand. Rename the new column appropriately.

SELECT 	
	[DepositGroup]
	,MAX([MagicWandSize]) AS [LongestMagicWand]
	
FROM [WizzardDeposits]
GROUP BY [DepositGroup]


--04. Smallest Deposit Group per Magic Wand Size

SELECT [DepositGroup]
 FROM [WizzardDeposits]
 GROUP BY [DepositGroup]
 HAVING AVG([MagicWandSize]) = (
    SELECT TOP (1) AVG([MagicWandSize])
    FROM [WizzardDeposits]
    GROUP BY [DepositGroup]
    ORDER BY AVG([MagicWandSize])
 );


--05. Deposits Sum

SELECT DISTINCT
	[DepositGroup]
	,SUM([DepositAmount]) AS TotalSum
FROM [WizzardDeposits]
GROUP BY [DepositGroup]


--06. Deposits Sum for Ollivander Family

SELECT DISTINCT
	[DepositGroup]
	,SUM([DepositAmount]) AS TotalSum
FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]


--07. Deposits Filter

SELECT
	[DepositGroup],
	SUM([DepositAmount]) AS [TotalSum]
FROM [WizzardDeposits]
WHERE [MagicWandCreator] = 'Ollivander family'
GROUP BY [DepositGroup]
HAVING SUM([DepositAmount]) < 150000
ORDER BY [TotalSum] DESC


--08. Deposit Charge

	--Create a query that selects:
		--•	Deposit group  
		--•	Magic wand creator
		--•	Minimum deposit charge for each group 
		--Select the data in ascending ordered by MagicWandCreator and DepositGroup.

SELECT
	 [DepositGroup]
	,[MagicWandCreator]
	,MIN([DepositCharge]) AS MinDepositCharge

FROM [WizzardDeposits]
GROUP BY 
		  [DepositGroup]
		 ,[MagicWandCreator]
ORDER BY 
		  [MagicWandCreator]
		 ,[DepositGroup]

--09. Age Group

SELECT 
	[AgeGroup]
	,COUNT([Id]) AS [WizzardCount]
	
FROM 
(
	SELECT
		*,
		CASE
			WHEN [Age] BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN [Age] BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN [Age] BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN [Age] BETWEEN 30 AND 40 THEN '[31-40]'
			WHEN [Age] BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN [Age] BETWEEN 51 AND 60 THEN '[51-60]'
			ELSE '[61+]'
		END AS [AgeGroup]
	FROM [WizzardDeposits]
) AS [AgeGroupQuerie]
GROUP BY [AgeGroup]


--10. First Letter
  --Create a query that returns all unique wizard first letters of their first names only if they have deposit of type Troll Chest.
  --Order them alphabetically. Use GROUP BY for uniqueness.

SELECT 
	LEFT([FirstName],1) AS [FirstLetter]
	
		 FROM [WizzardDeposits]
		WHERE [DepositGroup] = 'Troll Chest'
	GROUP BY LEFT([FirstName],1)
	ORDER BY [FirstLetter]


--11. Average Interest
	--Mr. Bodrog is highly interested in profitability. He wants to know the average interest of all deposit groups split by 
	--whether the deposit has expired or not. But that’s not all. He wants you to select deposits with start date after 
	--01/01/1985. Order the data descending by Deposit Group and ascending by Expiration Flag.


SELECT
	[DepositGroup],
	[IsDepositExpired],
	AVG([DepositInterest]) AS AverageInterest
FROM [WizzardDeposits]
WHERE [DepositStartDate] > '1.1.1985'
GROUP BY [DepositGroup]
		 ,[IsDepositExpired]	
ORDER BY 
		 [DepositGroup] DESC
		,[IsDepositExpired] 
	
--12. Rich Wizard, Poor Wizard

	--Mr. Bodrog definitely likes his werewolves more than you. This is your last chance to survive! Give him some data to 
	--play his favorite game Rich Wizard, Poor Wizard. The rules are simple: You compare the deposits of every wizard with 
	--the wizard after him. If a wizard is the last one in the database, simply ignore it. In the end you have to sum the 
	--difference between the deposits.
	--At the end your query should return a single value: the SUM of all differences.


SELECT
	SUM([Difference]) AS [SumDifference]
FROM (
		SELECT
			[FirstName] AS [Host Wizard]
			,[DepositAmount] AS [Host Wizard Deposit]
			,LEAD([FirstName]) OVER(ORDER BY [Id]) AS [Guest Wizard]
			,LEAD([DepositAmount]) OVER(ORDER BY [Id]) AS [Guest Wizard Deposit]
			,[DepositAmount] - LEAD([DepositAmount]) OVER(ORDER BY [Id]) AS [Difference]
		FROM [WizzardDeposits]
	) AS [DifferenceSubqueary]



--13. Departments Total Salaries


--18*

SELECT DISTINCT DepartmentId, Salary AS ThirdHighestSalary 
FROM 
(
	SELECT DepartmentId, Salary,
	DENSE_RANK() OVER(PARTITION BY DepartmentId ORDER BY Salary DESC) 
	AS SalaryRank
	FROM Employees
) AS SalaryRankQuery
WHERE SalaryRank = 3

--19

SELECT FirstName, LastName, DepartmentID, Salary
FROM Employees AS eMain
WHERE Salary > 
(
	SELECT  AVG(Salary) AS AverageSalary
	FROM Employees
	AS eSub
	WHERE DepartmentID = 7
	GROUP BY DepartmentID
) AS


