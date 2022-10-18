USE BakmiWMfe
GO

--d.	Create query using DML syntax to simulate the transactions process for menu and souvenir transactions.
--Note: DML syntax to fill database and DML syntax to simulate the transactions process should be a different query.


-- query to stimulate menu transaction by a staff named taeyeon and customer named taylor launtner
INSERT INTO HeaderMenuTransaction VALUES ('MT016','SF008','CU010','2020-05-12')
INSERT INTO MenuTransactionDetail VALUES
('MT016','ME003',2),
('MT016','ME001',5),
('MT016','ME004',2),
('MT016','ME001',1),
('MT016','ME006',3),
('MT016','ME010',2),
('MT016','ME008',2)



-- query to stimulate menu transaction by staff named caroline and customer named felix
INSERT INTO HeaderSouvenirTransaction VALUES ('ST016','SF007','CU001','2020-03-15')
INSERT INTO SouvenirTransactionDetail VALUES
('ST016','SO001',4),
('ST016','SO005',21),
('ST016','SO002',32),
('ST016','SO008',2),
('ST016','SO006',5),
('ST016','SO005',9)