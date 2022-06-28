--Problem 1.	One-To-One Relationship

CREATE TABLE [Persons](
		[PersonID]  INT PRIMARY KEY NOT NULL,
		[FirstName] NVARCHAR(50) NOT NULL,
		[Salary] FLOAT,
		[PassportID] INT NOT NULL
);		


--ALTER TABLE [Persons]
--ADD [PassportID] INT NOT NULL



CREATE TABLE [dbo].[Passports](
	[PassportID] [int] NOT NULL,
	[PassportNumber] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Passports] PRIMARY KEY CLUSTERED 
(
	[PassportID] ASC
)
)
CREATE TABLE [dbo].[Persons](
	[PersonID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
	[PassportID] [int] NOT NULL,
 CONSTRAINT [PK_Persons] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)
)

INSERT [dbo].[Passports] ([PassportID], [PassportNumber]) VALUES (101, N'N34FG21B')

INSERT [dbo].[Passports] ([PassportID], [PassportNumber]) VALUES (102, N'K65LO4R7')

INSERT [dbo].[Passports] ([PassportID], [PassportNumber]) VALUES (103, N'ZE657QP2')

INSERT [dbo].[Persons] ([PersonID], [FirstName], [Salary], [PassportID]) VALUES (1, N'Roberto     ', CAST(43300.00 AS Decimal(18, 2)), 102)

INSERT [dbo].[Persons] ([PersonID], [FirstName], [Salary], [PassportID]) VALUES (2, N'Tom', CAST(56100.00 AS Decimal(18, 2)), 103)

INSERT [dbo].[Persons] ([PersonID], [FirstName], [Salary], [PassportID]) VALUES (3, N'Yana', CAST(60200.00 AS Decimal(18, 2)), 101)

ALTER TABLE [dbo].[Persons]  WITH CHECK ADD  CONSTRAINT [FK_Persons_Passports] FOREIGN KEY([PassportID])
REFERENCES [dbo].[Passports] ([PassportID])

ALTER TABLE [dbo].[Persons] CHECK CONSTRAINT [FK_Persons_Passports]

