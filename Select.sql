USE BakmiWM
GO

--1.	Display CustomerID, CustomerName, and Total Transaction (obtained from the total transaction and ended with ' purchase(s)') for each customer whose name contains 'e' and served by a staff whose name ends with 'n'.
		SELECT 
			mc.CustomerId,
			mc.[Name],
			[Total Transaction] = CAST( COUNT(hmt.HeaderMenuTransactionId) AS VARCHAR ) + ' purchase(s)'
		FROM
			MsCustomer mc
			JOIN HeaderMenuTransaction hmt
			ON hmt.CustomerId= mc.CustomerId
			JOIN MsStaff ms
			ON ms.StaffId = hmt.StaffId
		WHERE mc.[Name] LIKE '%e%' 
		AND
		ms.[Name] LIKE '%n'
		GROUP BY mc.CustomerId, mc.[Name]
--2.	Display SouvenirTransactionID, StaffID, CustomerID, and Total Price 
		--(obtained by adding 'Rp. ' in front of the sum of multiplication of the souvenir 
		--sell price and quantity) for each purchase which customer's name length is more than
		--10 and the souvenir sell price is greater than 35000.
		SELECT
			hst.SouvenirTransactionId,
			hst.StaffId,
			mc.CustomerId,
			[Total Price] = 'Rp. ' + CAST(SUM(mss.[Sell Price]*std.Quantity)AS VARCHAR)
		FROM
			HeaderSouvenirTransaction hst
			JOIN MsStaff ms ON ms.StaffId = hst.StaffId
			JOIN MsCustomer mc 
			ON mc.CustomerId = hst.CustomerId
			JOIN SouvenirTransactionDetail std
			ON std.SouvenirTransactionId = hst.SouvenirTransactionId
			JOIN MsSouvenir mss 
			ON std.SouvenirId  = mss.SouvenirId
		WHERE LEN(mc.[Name]) > 10 AND mss.[Sell Price] > 35000
		GROUP BY mc.CustomerId, hst.StaffId, hst.SouvenirTransactionId
--3.	Display MenuTransactionID, CustomerName, MenuTransactionDate (obtained from MenuTransactionDate with 'dd-mm-yyyy' format), Total Product (obtained from the number of products) and Total Quantity (obtained from the sum of all product's quantities) for every menu transaction which occurred at even day and the customer's name consists of at least 2 words	
		SELECT
			hmt.HeaderMenuTransactionId,
			mc.[Name],
			CONVERT(DATE, hmt.TransactionDate, 105)AS [MenuTransactionDate],
			COUNT(mtd.MenuId) AS [Total Product],
			[Total Quantity] = COUNT(mtd.Quantity) 
		FROM
			MsCustomer mc
			JOIN HeaderMenuTransaction hmt
			ON mc.CustomerId = hmt.CustomerId
			JOIN MenuTransactionDetail mtd
			ON hmt.HeaderMenuTransactionId = mtd.HeaderMenuTransactionId
			JOIN MsMenu mm
			ON mtd.MenuId = mm.MenuId
		WHERE DAY(hmt.TransactionDate)%2 = 0 AND mc.[Name] LIKE '% %'
		GROUP BY hmt.HeaderMenuTransactionId, mc.[Name], hmt.TransactionDate
--4.	Display SouvenirTransactionID, Staff First Name (obtained from the first name of the staff), Total Product (obtained from the count of product), and Total Quantity (obtained from the sum of quantity) for every souvenir transaction which staff's name consists of more than one word and staff's salary is more than 10000000

	SELECT
		hst.SouvenirTransactionId,
		[Staff First Name] = LEFT(ms.[Name], CASE WHEN charindex(' ', ms.[Name]) = 0 THEN 
		LEN(ms.[Name]) ELSE charindex(' ',ms.[Name]) - 1 END),
		[Total Product] = COUNT(std.SouvenirId),
		[Total Quantity] = COUNT(std.Quantity)
	FROM 
		HeaderSouvenirTransaction hst
		JOIN MsStaff ms 
		ON ms.StaffId = hst.StaffId
		JOIN SouvenirTransactionDetail std
		ON std.SouvenirTransactionId = hst.SouvenirTransactionId
	WHERE 
		ms.[Name] LIKE '% %'
		AND 
		ms.Salary > 10000000
	GROUP BY hst.SouvenirTransactionId, ms.[Name]
		

--5.	Display unique SouvenirTransactionID, StaffName, SouvenirTransactionDate (obtained from SouvenirTransactionDate with 'dd-mm-yyyy' format), Salary (obtained by adding ‘Rp. ’ in front of the StaffSalary) for every menu transaction which has a souvenir which buy price is more than 10000 and handled by a staff whose salary is more than average.
--(alias subquery)
SELECT DISTINCT 
	hst.SouvenirTransactionId,	
	ms.[Name],
	TransactionDate = CONVERT(DATE, hst.TransactionDate, 107)
FROM	
	HeaderSouvenirTransaction hst 
	JOIN MsStaff ms 
	ON ms.StaffId = hst.StaffId
	JOIN SouvenirTransactionDetail std
	ON std.SouvenirTransactionId = hst.SouvenirTransactionId
	JOIN MsSouvenir mss 
	ON mss.SouvenirId = std.SouvenirId,
	(
		SELECT average = AVG(ms.Salary) FROM MsStaff ms	
	) tabel
WHERE 
	ms.Salary > tabel.average 
	AND 
	mss.[Buy Price] > 10000


--6.	Display StaffName, MenuName, MenuTransactionDate (obtained from SouvenirTransactionDate with 'dd-mm-yyyy' format), Staff Local Phone (obtained by replacing StaffPhone first character into ‘+62’) for every menu transaction which is served by female staff and menu price is higher than the average sell price of all souvenirs.
--(alias subquery)

-- disini karena soalnya dia bilang menu transaction date tapi obtainednya dari souvenir transaction date? makanya saya asumsi menu transaction date didapatkan dari table header menu transaction punya date.
SELECT
	ms.[Name],
	mm.[Name],
	CONVERT(DATE,hmt.TransactionDate,105),
	[Staff Local Phone] = STUFF(ms.[Phone Number], 1,1,'+62')
FROM 
	MsStaff ms
	JOIN HeaderMenuTransaction hmt
	ON hmt.StaffId = ms.StaffId
	JOIN MenuTransactionDetail mtd
	ON mtd.HeaderMenuTransactionId = hmt.HeaderMenuTransactionId
	JOIN MsMenu mm
	ON mm.MenuId = mtd.MenuId,
	(SELECT average = AVG(MsSouvenir.[Sell Price]) FROM MsSouvenir) as x
WHERE ms.Gender = 'Female'  AND mm.Price > x.average

--7.	Display SouvenirTransactionID, Capitalized Customer Name (obtained from the uppercase of the customer's name), and Total Quantity (obtained from the sum of quantity purchased and ended with ' pc(s)') for every souvenir transaction which id number is odd and has total quantity purchased higher than the maximum quantity of all souvenir transaction.
--(alias subquery) 

SELECT
	hst.SouvenirTransactionId,
	[Capitalized Customer Name] = UPPER(mc.[Name]),
	[Total Quantity] = CAST (SUM(std.Quantity) AS VARCHAR) + ' pc(s)'
FROM
	HeaderSouvenirTransaction hst 
	JOIN MsCustomer mc ON mc.CustomerId = hst.CustomerId
	JOIN SouvenirTransactionDetail std ON std.SouvenirTransactionId = hst.SouvenirTransactionId,
	(
		SELECT
			MaxQty = MAX(Quantity)
		FROM
			SouvenirTransactionDetail
	) x
WHERE 
	CAST (RIGHT(hst.SouvenirTransactionId,3) AS INT)  % 2 != 0
GROUP BY hst.SouvenirTransactionId, mc.Name, x.MaxQty
HAVING SUM(std.Quantity) > x.MaxQty

--8.	Display Staff Number (obtained from replacing the 'SF' in StaffID with 'Staff '), StaffName, StaffPositionName, and Total Quantity (obtained from the sum of quantity purchased) for every menu transaction which total quantity is less than or equals to the minimum purchase quantity in every purchase that occurred between the 16th and 25th day of the month.
--(alias subquery)
SELECT
	[Staff Number] = REPLACE(ms.StaffId, 'SF', 'Staff '),
	ms.[Name],
	msp.[Name],
	[Total Quantity] = SUM (mtd.Quantity)
FROM 
	MsStaff ms JOIN HeaderMenuTransaction hmt
	ON ms.StaffId = hmt.StaffId
	JOIN MsStaffPosition msp ON ms.StaffPositionId = msp.StaffPositionId
	JOIN MenuTransactionDetail mtd ON mtd.HeaderMenuTransactionId = hmt.HeaderMenuTransactionId,
	(
		SELECT 
			minQty = MIN(Quantity)
		FROM 
			MenuTransactionDetail
	) x
WHERE 
	DAY(hmt.TransactionDate) BETWEEN 16 AND 25
GROUP BY ms.StaffId, ms.Name, msp.Name, x.minQty
HAVING SUM(mtd.Quantity) <= x.minQty

GO
--9.	Create a view named 'CustomerMenuPurchaseViewer' to display CustomerID, CustomerName, CustomerEmail, Maximum Quantity (obtained from the maximum quantity purchased), and Minimum Quantity (obtained from the minimum quantity purchased) for every customer whose id is even and the maximum quantity doesn't equal to its minimum quantity.
CREATE VIEW [CustomerMenuPurchaseViewer] 
AS
	SELECT
		mc.CustomerId,
		mc.[Name],
		mc.Email,
		[Maximum Quantity] = MAX (Quantity),
		[Minimum Quantity] = MIN (Quantity)
	FROM
		MsCustomer mc JOIN HeaderMenuTransaction hmt 
		ON mc.CustomerId = hmt.CustomerId
		JOIN MenuTransactionDetail mtd ON mtd.HeaderMenuTransactionId = hmt.HeaderMenuTransactionId 
	WHERE
		RIGHT(mc.CustomerId,3) % 2 = 0
	GROUP BY mc.CustomerId, mc.Name, mc.Email
	HAVING MAX(Quantity) != MIN(Quantity)
GO
--10.	Create a view named 'StaffSouvenirSellingViewer' to display StaffID, StaffName, StaffAddress, and Total Price (obtained by the sum of quantity purchased times souvenir sell price) for every staff whose address consists of at least 3 words and the minimum quantity purchased is more than 5.
CREATE VIEW StaffSouvenirSellingViewer 
AS
	SELECT
		ms.StaffId,
		ms.[Name],
		ms.[Address],
		[Total Price] = SUM(Quantity* mss.[Sell Price])
	FROM
		MsStaff ms JOIN HeaderSouvenirTransaction hst ON ms.StaffId = hst.StaffId
		JOIN SouvenirTransactionDetail std ON std.SouvenirTransactionId = hst.SouvenirTransactionId
		JOIN MsSouvenir mss ON mss.SouvenirId = std.SouvenirId
	WHERE 
		ms.[Address] LIKE '% % %'
	GROUP BY ms.StaffId , ms.[Name], ms.[Address]
	HAVING MIN(Quantity) > 5
	
