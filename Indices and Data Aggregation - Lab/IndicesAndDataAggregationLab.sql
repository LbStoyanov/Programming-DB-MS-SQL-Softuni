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
	,MAX([MagicWandSize])
	
FROM [WizzardDeposits]
GROUP BY [DepositGroup]


--04. Smallest Deposit Group per Magic Wand Size

SELECT DepositGroup
FROM WizzardDeposits
GROUP BY [DepositGroup]
HAVING AVG(MagicWandSize) <
			(
			    SELECT AVG(MagicWandSize) FROM WizzardDeposits
			)



--05. Deposits Sum
