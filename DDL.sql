USE MASTER
GO

DROP DATABASE IF EXISTS [BakmiWM]
GO

CREATE DATABASE [BakmiWM]
GO

USE [BakmiWM]
GO

CREATE TABLE MsStaffPosition(
	StaffPositionId CHAR(5) PRIMARY KEY CHECK (StaffPositionID LIKE 'SP[0-9][0-9][0-9]'),
	[Name]	VARCHAR(255) NOT NULL 
)

CREATE TABLE MsStaff (
	StaffId CHAR(5) PRIMARY KEY  CHECK (StaffId LIKE 'SF[0-9][0-9][0-9]'),
	StaffPositionId CHAR(5) FOREIGN KEY REFERENCES MsStaffPosition(StaffPositionId) ON DELETE CASCADE ON UPDATE CASCADE,
	[Name]	VARCHAR(255) NOT NULL,
	Gender VARCHAR(255) NOT NULL CHECK (Gender IN ('Male', 'Female')),
	DoB DATE NOT NULL CHECK (YEAR(DoB) < 2005),
	[Phone Number] CHAR(12) NOT NULL CHECK (ISNUMERIC([Phone Number]) = 1),
	Email VARCHAR(255) NOT NULL,
	[Address] VARCHAR(255) NOT NULL CHECK (LEN([Address]) > 15),
	Salary INT NOT NULL
)	

CREATE TABLE MsCustomer(
	CustomerId CHAR(5) PRIMARY KEY CHECK (CustomerId LIKE 'CU[0-9][0-9][0-9]'),
	[Name]	VARCHAR(255) NOT NULL,
	Gender VARCHAR(255) NOT NULL CHECK (Gender IN ('Male', 'Female')),
	DoB DATE NOT NULL,
	[Phone Number] CHAR(12) NOT NULL CHECK (ISNUMERIC([Phone Number]) = 1 ),
	Email VARCHAR(255) NOT NULL,
	[Address] VARCHAR(255) NOT NULL
)

CREATE TABLE MsMenuCategory(
	MenuCategoryId CHAR(5) PRIMARY KEY CHECK (MenuCategoryId LIKE 'MC[0-9][0-9][0-9]'),
	[Name] VARCHAR(255) NOT NULL
)

CREATE TABLE MsMenu(
	MenuId CHAR(5) PRIMARY KEY CHECK (MenuId LIKE 'ME[0-9][0-9][0-9]'),
	MenuCategoryId CHAR(5) FOREIGN KEY REFERENCES MsMenuCategory(MenuCategoryId) ON DELETE CASCADE ON UPDATE CASCADE,
	[Name] VARCHAR(255) NOT NULL,
	Price INT NOT NULL CHECK (Price BETWEEN 1000 AND 10000000)
)

CREATE TABLE MsSouvenir(
	SouvenirId CHAR(5) PRIMARY KEY CHECK (SouvenirId LIKE 'SO[0-9][0-9][0-9]'),
	[Name] VARCHAR(255) NOT NULL,
	[Buy Price] INT NOT NULL,
	[Sell Price] INT NOT NULL
)

CREATE TABLE HeaderMenuTransaction(
	HeaderMenuTransactionId CHAR(5) PRIMARY KEY CHECK (HeaderMenuTransactionId LIKE 'MT[0-9][0-9][0-9]'),
	StaffId CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffId) ON UPDATE CASCADE ON DELETE CASCADE,
	CustomerId CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerId) ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate DATE NOT NULL
)

CREATE TABLE MenuTransactionDetail(
	HeaderMenuTransactionId CHAR(5) FOREIGN KEY REFERENCES HeaderMenuTransaction(HeaderMenuTransactionId) ON UPDATE CASCADE ON DELETE CASCADE,
	MenuId CHAR(5) FOREIGN KEY REFERENCES MsMenu(MenuId) ON UPDATE CASCADE ON DELETE CASCADE, 
	Quantity INT NOT NULL,
	PRIMARY KEY (HeaderMenuTransactionId, MenuId)
)


CREATE TABLE HeaderSouvenirTransaction(
	SouvenirTransactionId CHAR(5) PRIMARY KEY CHECK (SouvenirTransactionId LIKE 'ST[0-9][0-9][0-9]'),
		StaffId CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffId) ON UPDATE CASCADE ON DELETE CASCADE,
	CustomerId CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerId) ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate DATE NOT NULL
)

CREATE TABLE SouvenirTransactionDetail(
	SouvenirTransactionId CHAR(5) FOREIGN KEY REFERENCES HeaderSouvenirTransaction(SouvenirTransactionId) ON UPDATE CASCADE ON DELETE CASCADE,
	SouvenirId CHAR(5) FOREIGN KEY REFERENCES MsSouvenir(SouvenirId) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (SouvenirId, SouvenirTransactionId),
	Quantity INT NOT NULL
)