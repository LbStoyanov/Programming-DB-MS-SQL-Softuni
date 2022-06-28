--Problem 1.	One-To-One Relationship

CREATE TABLE [Persons](
		[PersonID]  INT PRIMARY KEY NOT NULL,
		[FirstName] NVARCHAR(50) NOT NULL,
		[Salary] FLOAT,
		[PassportID] INT NOT NULL
);		


--ALTER TABLE [Persons]
--ADD [PassportID] INT NOT NULL


CREATE TABLE[Passport](
		[PassportID] INT FOREIGN KEY REFERENCES Persons(PersonID),
		[PassportNumber] NVARCHAR(20)

);

INSERT INTO [Persons] 
VALUES(1, 'Roberto', 43300.00, 102)