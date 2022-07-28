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


