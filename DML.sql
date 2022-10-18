USE [BakmiWM]
GO

INSERT INTO MsSouvenir VALUES
('SO001','Key Chain',3000,6000),
('SO002','Candle',12000,20000),
('SO003','Artificial Flower',5000,12000),
('SO004','Bookmark',2500,5000),
('SO005','Post Card',3000,5000),
('SO006','Miniature',15000,28000),
('SO007','Mug',12000,25000),
('SO008','Stacking Dolls',33000,60000),
('SO009','Statues',8000,1600),
('SO010','Refrigerator Magnet',4000,9000)


INSERT INTO MsMenuCategory VALUES
('MC001','Food'),
('MC002','Dessert'),
('MC003','Beverage'),
('MC004','Topping')

INSERT INTO MsMenu VALUES
('ME001','MC001','Bakmi Sayur',25000),
('ME002','MC001','Bakmi Ayam',30000),
('ME003','MC001','Bakmi Ayam Pangsit',39000),
('ME004','MC001','Bakmi Ayam Baso Sapi',39000),
('ME005','MC002','Ice Cream Coklat',18000),
('ME006','MC002','Ice Cream Vanilla',18000),
('ME007','MC003','Ice Lemon Tea',14000),
('ME008','MC003','Mineral Water',8000),
('ME009','MC004','Extra Ayam',15000),
('ME010','MC004','Jamur',19000)

INSERT INTO MsStaffPosition VALUES
('SP001', 'Chairman'),
('SP002', 'Director'),
('SP003', 'Assistant Manager'),
('SP004', 'Secretary'),
('SP005', 'Treasurer'),
('SP006', 'Accountant'),
('SP007', 'Cashier'),
('SP008', 'Chef'),
('SP009', 'Waiter'),
('SP010', 'Dishwasher')

INSERT INTO MsStaff VALUES
('SF001','SP001','Harry Potter','Male','1998-10-22','081312121313','harry.potter@gmail.com','60 East Graandrose St. Bartlett',12000000),
('SF002','SP002','Edward Cullen','Male','1990-01-12','081412121919','edward.culle@gmail.com','71 Meadow Street Starkville',10000000),
('SF003','SP003','Emma Watson','Female','2000-10-10','085334349898','emma.watson@gmail.com','52 Beechwood Holland',7800000),
('SF004','SP004','Kristen Stewart','Female','2001-01-14','085272725757','kristen.ste@gmail.com','92 Coraopolis Glen Burnie',7000000),
('SF005','SP005','Robbert Pattinson','Male','1999-12-07','085590904234','rob.pattinson@gmail.com','8 Spring Valley Deerfield',5600000),
('SF006','SP006','Winter','Female','1996-05-23','089818786554','dem.lov@gmail.com','53 Iroquois Drive Galloway',5600000),
('SF007','SP007','Caroline','Female','1997-08-18','095668171616','caroline001@gmail.com','22 West Queen Eve',5500000),
('SF008','SP008','Taylor Lautner','Male','1992-04-11','081278786565','taylor.laut@gmail.com','22 Jennings Lane Armstrong ',5600000),
('SF009','SP009','Alexa Heaton','Female','2003-01-19','091234569898','alexa.heaton@gmail.com','155 Hilltop Pine Street',20000000),
('SF010','SP010','Xavier','Male','2004-05-06','081978786534','xavier003@gmail.com','2 Brewery North Inverness',3000000)


INSERT INTO MsCustomer VALUES
('CU001','Felix','Male','1990-10-12','081298984848','felix002@gmail.com','507 Penn Road'),
('CU002','Jennie','Female','1999-09-19','098837378899','jennie01@gmail.com','37 Canterbury Street'),
('CU003','Lalisa Manoban','Female','1997-08-28','081722338877','lalisa.manoban@gmail.com','4th Dr.
Smyrna'),
('CU004','Kim Namjoon','Male','1998-01-24','081122334455','kim,namjoon@gmail.com','55 Bridge Street
Pataskala'),
('CU005','Kim Jongdae','Male','1992-04-19','081233887766','kim.jongdae@gmail.com','90 E. Pulaski Street
Bellmore'),
('CU006','Park Jimin','Male','1994-12-02','089988667755','park.jimin@gmail.com','1 San Juan Road'),
('CU007','Irene','Female','1999-05-22','087812127667','irenee02@gmail.com','48 East Drive
Maplewood'),
('CU008','Wendy','Female','1993-12-19','089912128969','wendyy001@gmail.com','23 Lexington Ave.
Fayetteville'),
('CU009','Kwon Jiyong','Male','1988-08-18','098878789898','kwon.jiyong@gmail.com','2 Mayfield St.
Clarksburg'),
('CU010','Taeyeon','Female','1992-08-01','081767677667','taeyeon002@gmail.com','763 Lafayette')

INSERT INTO HeaderMenuTransaction VALUES
('MT001','SF008','CU010','2020-01-22'),
('MT002','SF004','CU008','2020-01-23'),
('MT003','SF005','CU005','2020-01-25'),
('MT004','SF006','CU006','2020-01-27'),
('MT005','SF004','CU001','2020-01-27'),
('MT006','SF005','CU002','2020-01-29'),
('MT007','SF010','CU003','2020-02-02'),
('MT008','SF002','CU007','2020-02-03'),
('MT009','SF009','CU005','2020-02-04'),
('MT010','SF009','CU004','2020-02-05'),
('MT011','SF005','CU006','2020-02-06'),
('MT012','SF010','CU009','2020-02-08'),
('MT013','SF007','CU002','2020-02-10'),
('MT014','SF008','CU002','2020-02-11'),
('MT015','SF006','CU001','2020-02-15')

INSERT INTO MenuTransactionDetail VALUES
('MT001','ME003',2),
('MT002','ME004',2),
('MT003','ME002',6),
('MT004','ME001',5),
('MT005','ME004',2),
('MT006','ME001',1),
('MT007','ME006',3),
('MT008','ME010',2),
('MT009','ME008',2),
('MT010','ME009',1),
('MT011','ME007',1),
('MT012','ME005',4),
('MT013','ME005',2),
('MT014','ME002',5),
('MT015','ME001',1),
('MT011','ME010',3),
('MT012','ME008',2),
('MT013','ME007',1),
('MT014','ME007',2),
('MT002','ME006',5),
('MT011','ME001',4),
('MT002','ME003',3),
('MT003','ME003',1),
('MT004','ME007',2),
('MT005','ME010',6)

INSERT INTO HeaderSouvenirTransaction VALUES
('ST001','SF007','CU001','2020-01-21'),
('ST002','SF007','CU002','2020-01-22'),
('ST003','SF003','CU004','2020-01-25'),
('ST004','SF004','CU005','2020-01-26'),
('ST005','SF005','CU008','2020-02-01'),
('ST006','SF009','CU001','2020-02-08'),
('ST007','SF010','CU010','2020-02-10'),
('ST008','SF002','CU004','2020-02-11'),
('ST009','SF008','CU003','2020-02-14'),
('ST010','SF009','CU009','2020-02-15'),
('ST011','SF006','CU008','2020-02-16'),
('ST012','SF009','CU009','2020-02-18'),
('ST013','SF010','CU006','2020-02-20'),
('ST014','SF008','CU008','2020-03-01'),
('ST015','SF005','CU003','2020-03-05')

INSERT INTO SouvenirTransactionDetail VALUES
('ST004','SO001',12),
('ST002','SO005',9),
('ST003','SO002',2),
('ST010','SO008',3),
('ST008','SO006',2),
('ST007','SO005',1),
('ST002','SO006',5),
('ST002','SO010',7),
('ST001','SO005',2),
('ST011','SO003',10),
('ST015','SO003',8),
('ST014','SO004',4),
('ST013','SO007',2),
('ST012','SO009',8),
('ST011','SO010',11),
('ST010','SO010',3),
('ST009','SO001',20),
('ST008','SO002',12),
('ST007','SO009',4),
('ST006','SO002',1),
('ST005','SO001',14),
('ST004','SO006',2),
('ST003','SO005',9),
('ST002','SO004',7),
('ST001','SO010',6)