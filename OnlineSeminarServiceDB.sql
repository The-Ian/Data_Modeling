USE master;
if (select count(*) 
    from sys.databases where name = 'OnlineSeminarService') > 0
BEGIN
	DROP DATABASE OnlineSeminarService;
END

Create Database OnlineSeminarService;
GO
Print 'OnlineSeminarService Database Created'

Use OnlineSeminarService


GO
Create TABLE SubscriptionPricing 
(
	SubscriptionPricingID Int NOT NULL Identity(1,1),
	SubscriptionType Varchar(50) NOT NULL,
	Amount Decimal(5,2) NOT NULL,

  CONSTRAINT pk_SubscriptionPricing PRIMARY KEY(SubscriptionPricingID) 

)

Print 'SubscriptionPricing Table Created'

Insert Into SubscriptionPricing
		(SubscriptionType, Amount)
Values
		('2 Year Plan',189),
		('1 Year Plan', 99),
		('Quarterly', 27),
		('Monthly', 9.99),
		('Special', 0.00)
/* 
The Special plan is the free membership.
*/


Print 'SubscriptionPricing Data Inserted'

GO
CREATE TABLE Members 
(
	MemberID Int NOT NULL Identity(1,1),
	MemberNumber Varchar(10) Not Null,
	FirstName varchar(50) NOT NULL,
	MiddleName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Birthday date NOT NULL,
	Gender varchar(2) NOT NULL,
	JoinDate date NOT NULL,
	Current_Member Bit NOT NULL,
	SubscriptionPricingID Int NOT NULL
	

  CONSTRAINT pk_Members PRIMARY KEY(MemberID), 
  CONSTRAINT fk_SubscriptionPricing Foreign KEY(SubscriptionPricingID) References SubscriptionPricing(SubscriptionPricingID)

)

Print 'Members Table Created'

Insert Into Members
		(MemberNumber, FirstName, MiddleName, LastName, Birthday, Gender, JoinDate, Current_Member, SubscriptionPricingID)
Values	
		('M001', 'Otis', 'Brooke', 'Fallon', '6/29/1971', 'M', '4/7/2017', 1, 4),
		('M002', 'Katee', 'Virgie', 'Gepp', '4/3/1972', 'F', '11/29/2017', 1, 4),
		('M003', 'Lilla', 'Charmion', 'Eatttok', '12/13/1975', 'F', '2/26/2017', 1, 3),
		('M004', 'Ddene', 'Shelba', 'Clapperton', '2/19/1997', 'F', '11/5/2017', 1, 3),
		('M005', 'Audrye', 'Agathe', 'Dawks', '2/7/1989', 'F', '1/15/2016', 1, 4),
		('M006', 'Fredi', 'Melisandra', 'Burgyn', '5/31/1956', 'F', '3/13/2017', 1, 2),
		('M007', 'Dimitri', 'Francisco', 'Bellino', '10/12/1976', 'M', '8/9/2017', 1, 4),
		('M008', 'Enrico', 'Cleve', 'Seeney', '2/29/1988', 'M', '9/9/2016', 1, 2),
		('M009', 'Marylinda', 'Jenine', 'O''Siaghail', '2/6/1965', 'F', '11/21/2016', 0, 2),
		('M0010', 'Luce', 'Codi', 'Kovalski', '3/31/1978', 'M', '12/22/2017', 1, 4),
		('M0011', 'Claiborn', 'Shadow', 'Baldinotti', '12/26/1991', 'M', '3/19/2017', 1, 4),
		('M0012', 'Isabelle', 'Betty', 'Glossop', '2/17/1965', 'F', '4/25/2016', 1, 3),
		('M0013', 'Davina', 'Lira', 'Wither', '12/16/1957', 'F', '3/21/2016', 1, 2),
		('M0014', 'Panchito', 'Hashim', 'De Gregorio', '10/14/1964', 'M', '1/27/2017', 1, 4),
		('M0015', 'Rowen', 'Arvin', 'Birdfield', '1/9/1983', 'M', '10/6/2017', 0, 4)

Print 'Members Data Inserted'

GO
Create Table Passwords
(
MemberID Int Not Null,
LoginName Nvarchar(75) Not Null,
[Password] Varchar(60) Not Null,
ModifiedDate Date Not Null Default(Getdate()),

Constraint pk_MemID Primary Key (MemberID),
Constraint fk_Member Foreign Key (MemberID) References Members(MemberID)
)

Print 'Passwords Table Created'




GO
CREATE TABLE TransactionTypeLookup 
(
	TransactionTypeID integer NOT NULL Identity(1,1),
	Name varchar(50) NOT NULL,

  CONSTRAINT pk_TransactionType PRIMARY KEY(TransactionTypeID) 

)

Print 'TransactionTypeLookup Table Created'

Insert Into TransactionTypeLookup
		(Name)
Values
		('Credit Card')

Print 'TransactionTypeLookup Data Inserted'

GO
CREATE TABLE Transactions 
(
	TransactionID integer NOT NULL Identity(1,1),
	MemberID Int Not Null,
	TransactionDate date NOT NULL,
	Amount decimal(5,2) NOT NULL,
	Result varchar(25) NOT NULL,
	TransactionType integer NOT NULL,

  CONSTRAINT pk_Transactions PRIMARY KEY (TransactionID),
  CONSTRAINT fk_TransactionType Foreign KEY(TransactionType) References TransactionTypeLookup(TransactionTypeID),
  CONSTRAINT fk_MBRID Foreign KEY(MemberID) References Members(MemberID)
 )

 Print 'Transactions Table Created'

Insert Into Transactions
		(MemberID, TransactionDate, Amount, Result, TransactionType)
Values	

(5,	'1/15/2016', '9.99', 'Approved',1),
(5,	'2/15/2016', '9.99', 'Approved',1),
(5,	'3/15/2016', '9.99', 'Approved',1),
(13,'3/21/2016', '99', 'Approved',1),
(5,	'4/15/2016', '9.99', 'Approved',1),
(13,'4/21/2016', '99', 'Approved',1),
(12,'4/25/2016', '27', 'Approved',1),
(5,	'5/15/2016', '9.99', 'Approved',1),
(5,	'6/15/2016', '9.99', 'Approved',1),
(5,	'7/15/2016', '9.99', 'Approved',1),
(12,'7/25/2016', '27', 'Approved',1),
(5,	'7/25/2016', '9.99', 'Approved',1),
(8,	'9/9/2016', '99', 'Approved',1),
(5,	'9/15/2016', '9.99', 'Approved',1),
(5,	'10/15/2016', '9.99', 'Approved',1),
(12,'10/25/2016', '27', 'Approved',1),
(5,	'11/15/2016', '9.99', 'Approved',1),
(9,	'11/21/2016', '99', 'Approved',1),
(5,	'12/15/2016', '9.99', 'Approved',1),
(5,	'1/15/2017', '9.99', 'Approved',1),
(12,'1/25/2017', '27', 'Approved',1),
(14,'1/27/2017', '9.99', 'Approved',1),
(5,	'2/15/2017', '9.99', 'Approved',1),
(3,	'2/26/2017', '27', 'Approved',1),
(14,'2/27/2017', '9.99', 'Approved',1),
(6,	'3/13/2017', '99', 'Approved',1),
(5,	'3/15/2017', '9.99', 'Approved',1),
(11,'3/19/2017', '9.99', 'Approved',1),
(14,'3/27/2017', '9.99', 'Approved',1),
(1,	'4/7/2017', '9.99', 'Approved',1),
(5,	'4/15/2017', '9.99', 'Approved',1),
(11,'4/19/2017', '9.99', 'Approved',1),
(12,'4/25/2017', '27', 'Approved',1),
(14,'4/27/2017', '9.99', 'Approved',1),
(1,	'5/7/2017', '9.99', 'Approved',1),
(5,	'5/15/2017', '9.99', 'Approved',1),
(11,'5/19/2017', '9.99', 'Approved',1),
(3,	'5/26/2017', '27', 'Approved',1),
(14,'5/27/2017', '9.99', 'Approved',1),
(1,	'6/7/2017', '9.99', 'Declined',1),
(1,	'6/8/2017', '9.99', 'Approved',1),
(5,	'6/15/2017', '9.99', 'Approved',1),
(11,'6/19/2017', '9.99', 'Approved',1),
(14,'6/27/2017', '9.99', 'Approved',1),
(1,	'7/7/2017', '9.99', 'Approved',1),
(5,	'7/15/2017', '9.99', 'Approved',1),
(11,'7/19/2017', '9.99', 'Declined',1),
(11,'7/20/2017', '9.99', 'Approved',1),
(12,'7/25/2017', '27', 'Approved',1),
(14,'7/27/2017', '9.99', 'Approved',1),
(1,	'8/7/2017', '9.99', 'Approved',1),
(7,	'8/9/2017', '9.99', 'Approved',1),
(5,	'8/15/2017', '9.99', 'Approved',1),
(11,'8/19/2017', '9.99', 'Approved',1),
(3,	'8/26/2017', '27', 'Approved',1),
(14,'8/27/2017', '9.99', 'Approved',1),
(1,	'9/7/2017', '9.99', 'Approved',1),
(7,	'9/9/2017', '9.99', 'Approved',1),
(8,	'9/9/2017', '99', 'Approved',1),
(5,	'9/15/2017', '9.99', 'Approved',1),
(11,'9/19/2017', '9.99', 'Approved',1),
(14,'9/27/2017', '9.99', 'Approved',1),
(15,'10/6/2017', '9.99', 'Invalid Card',1),
(1,	'10/7/2017', '9.99', 'Approved',1),
(7,	'10/9/2017', '9.99', 'Approved',1),
(5,	'10/15/2017', '9.99', 'Approved',1),
(11,'10/19/2017', '9.99', 'Approved',1),
(12,'10/25/2017', '27', 'Approved',1),
(14,'10/27/2017', '9.99', 'Approved',1),
(4,	'11/5/2017', '27', 'Approved',1),
(1,	'11/7/2017', '9.99', 'Approved',1),
(7,	'11/9/2017', '9.99', 'Approved',1),
(5,	'11/15/2017', '9.99', 'Approved',1),
(11,'11/19/2017', '9.99', 'Approved',1),
(3,	'11/26/2017', '27', 'Declined',1),
(3,	'11/27/2017', '27', 'Approved',1),
(14,'11/27/2017', '9.99', 'Approved',1),
(2,	'11/29/2017', '9.99', 'Approved',1),
(1,	'12/7/2017', '9.99', 'Approved',1),
(7,	'12/9/2017', '9.99', 'Approved',1),
(5,	'12/15/2017', '9.99', 'Approved',1),
(11,'12/19/2017', '9.99', 'Approved',1),
(10,'12/22/2017', '9.99', 'Approved',1),
(14,'12/27/2017', '9.99', 'Approved',1),
(2,	'12/29/2017', '9.99', 'Approved',1),
(1,	'1/7/2018', '9.99', 'Approved',1),
(7,	'1/9/2018', '9.99', 'Approved',1),
(5,	'1/15/2018', '9.99', 'Approved',1),
(11,'1/19/2018', '9.99', 'Approved',1),
(10,'1/22/2018', '9.99', 'Approved',1),
(12,'1/25/2018', '27', 'Approved',1),
(14,'1/27/2018', '9.99', 'Approved',1)

Print 'Transactions Data Inserted'

GO
CREATE TABLE CreditCard 
(
	CreditCardID integer NOT NULL Identity(1,1),
	CardType varchar(50) NOT NULL,
	CardNumber varchar(50) NOT NULL,
	CardExp Date NOT NULL,
	TransactionType integer NOT NULL,
	MemberID Int NOT NULL,
	

  CONSTRAINT pk_CreditCard PRIMARY KEY(CreditCardID),
  CONSTRAINT fk_TransactionID Foreign KEY(TransactionType) References TransactionTypeLookup(TransactionTypeID),
  CONSTRAINT fk_MID Foreign KEY(MemberID) References Members(MemberID)
 )

Print 'CreditCard Table Created'

Insert Into CreditCard
		(CardType, CardNumber, CardExp, TransactionType, MemberID)
Values
		('AmericanExpress', '337941553240515', '9/30/19', 1, 1),
		('Visa', '4041372553875903', '1/31/20', 1, 2),
		('Visa', '4041593962566', '3/31/19', 1, 3),
		('JCB', '3559478087149594', '4/30/19', 1, 4),
		('JCB', '3571066026049076', '7/31/18', 1, 5),
		('Diners-Club-Carte-Blanche', '30423652701879', '5/31/19', 1, 6),
		('JCB', '3532950215393858', '2/28/19', 1, 7),
		('JCB', '3569709859937370', '3/31/19', 1, 8),
		('JCB', '3529188090740670', '5/31/19', 1, 9),
		('JCB', '3530142576111598', '11/30/19', 1, 10),
		('Mastercard', '5108756299877313', '7/31/18', 1, 11),
		('JCB', '3543168150106220', '6/30/18', 1, 12),
		('JCB', '3559166521684728', '10/31/19', 1, 13),
		('Diners-Club-Carte-Blanche', '30414677064054', '6/30/18', 1, 14),
		('JCB', '3542828093985763', '3/31/20', 1, 15)

Print 'CreditCard Data Inserted'

GO
CREATE TABLE MemberDetails 
(
	MemberDetailsID Int NOT NULL Identity(1,1),
	Phone varchar(15) NOT NULL,
	Email varchar(50) NOT NULL,
	[Address] varchar(50) NOT NULL,
	BillAddress varchar(50),
	City varchar(50) NOT NULL,
	[State] varchar(50) NOT NULL,
	ZIP Varchar(15) Not Null,
	Notes varchar(255) NOT NULL,
	MemberID Int NOT NULL,
	

  CONSTRAINT pk_MemberDetails PRIMARY KEY(MemberDetailsID),
  CONSTRAINT fk_MembersID Foreign KEY(MemberID) References Members(MemberID)

)

Print 'MemberDetails Table Created'

Insert Into MemberDetails
		(Phone, Email, [Address], BillAddress, City, [State], ZIP, Notes, MemberID)
Values
		('818-873-3863', 'bfallon0@artisteer.com', '020 New Castle Way', Null, 'Port Washington', 'New York', '11054', 'blsnvkdvkmfnd', 1),
		('503-689-8066', 'vgepp1@nih.gov', '8 Corry Parkway', 'P.O. Box 7088', 'Newton', 'Massachusetts', '2458', 'mnjbvkbvhm', 2),
		('210-426-7426', 'ceatttok2@google.com.br', '39426 Stone Corner Drive', Null, 'Peoria', 'Illinois', '61605', 'mnjbvkbvhm', 3),
		('716-674-1640', 'sclapperton3@mapquest.com', '921 Granby Junction', Null, 'Oklahoma City', 'Oklahoma', '73173', 'mnjbvkbvhm', 4),
		('305-415-9419', 'adawks4@mlb.com', '77 Butternut Parkway', Null, 'Saint Paul', 'Minnesota', '55146', 'mnjbvkbvhm', 5),
		('214-650-9837', 'mburgyn5@cbslocal.com', '821 Ilene Drive', Null, 'Odessa', 'Texas', '79764', 'mnjbvkbvhm', 6),
		('937-971-1026', 'fbellino6@devhub.com', '1110 Johnson Court', Null, 'Rochester', 'New York', '14624', 'mnjbvkbvhm', 7),
		('407-445-6895', 'cseeney7@macromedia.com', '6 Canary Hill', 'P.O. Box 255', 'Tallahassee', 'Florida', '32309', 'mnjbvkbvhm', 8),
		('206-484-6850', 'josiaghail8@tuttocitta.it', '9 Buhler Lane', Null, 'Bismark', 'North Dakota', '58505', 'mnjbvkbvhm', 9),
		('253-159-6773', 'ckovalski9@facebook.com', '99 Northwestern Pass', Null, 'Midland', 'Texas', '79710', 'mnjbvkbvhm', 10),
		('253-141-4314', 'sbaldinottia@discuz.net', '69 Spenser Hill', Null, 'Provo', 'Utah', '84605', 'mnjbvkbvhm', 11),
		('412-646-5145', 'bglossopb@msu.edu', '3234 Kings Court', 'P.O. Box 1233', 'Tacoma', 'Washington', '98424', 'mnjbvkbvhm', 12),
		('404-495-3676', 'lwitherc@smugmug.com', '3 Lakewood Gardens Circle', Null, 'Columbia', 'South Carolina', '29225', 'mnjbvkbvhm', 13),
		('484-717-6750', 'hdegregoriod@a8.net', '198 Muir Parkway', Null, 'Fairfax', 'Virginia', '22036', 'mnjbvkbvhm', 14),
		('915-299-3451', 'abirdfielde@over-blog.com', '258 Jenna Drive', Null, 'Pensacola', 'Florida', '32520', 'mnjbvkbvhm', 15)

Print 'MemberDetails Data Inserted'

GO
CREATE TABLE MemberInterests 
(
	MemberInterestsID integer NOT NULL Identity(1,1),
	MemberDetailsID integer NOT NULL,
	Interests varchar(250) NOT NULL,

  CONSTRAINT pk_MemberInterests PRIMARY KEY(MemberInterestsID),
  CONSTRAINT fk_MemberDetailID Foreign KEY(MemberDetailsID) References MemberDetails(MemberDetailsID)
)

Print 'MemberInterests Table Created'

Insert Into MemberInterests
		(MemberDetailsID, Interests)
Values
		(1, 'Acting, Video Games and Crossword Puzzles'),
		(2, 'Calligraphy'),
		(3, 'Movies, Restaurants and Woodworking'),	
		(4, 'Juggling and Quilting'),
		(5, 'Electronics'),
		(6, 'Sewing, Cooking and Movies'),
		(7, 'Botany	and Skating'),
		(8, 'Dancing, Coffee and Foreign Languages'),
		(9, 'Fashion'),
		(10, 'Woodworking'),
		(11, 'Homebrewing, Geneology, Movies and Scrapbooking'),
		(12, 'Surfing and Amateur Radio'),
		(13, 'Computers'),
		(14, 'Writing and Singing'),
		(15, 'Reading and Pottery')

Print 'MemberInterests Data Inserted'	

GO
CREATE TABLE [Events] 
(
	EventsID integer NOT NULL Identity(1,1),
	Speaker varchar(75) NOT NULL,
	EventName varchar(255) NOT NULL,
	EventDate date NOT NULL,

  CONSTRAINT pk_Events PRIMARY KEY(EventsID) 

)

Print 'Events Table Created'

Insert Into [Events]
		(Speaker, EventName, EventDate)
Values
		('Tiffany Watt Smith', '"The History of Human Emotions"', '1/12/2017'),
		('Simon Sinek', '"How Great Leaders Inspire Action"', '2/22/2017'),
		('Dan Pink', '"The Puzzle of Motivation"', '3/5/2017'),
		('Elizabeth Gilbert', '"Your Elusive Creative Genius"', '4/16/2017'),
		('Andrew Comeau', '"Why are Programmers So Smart?"', '5/1/2017')

Print 'Events Data Inserted'

GO
CREATE TABLE MemberEvents 
(
	MemberEventsID Int NOT NULL Identity(1,1),
	MemberID Int NOT NULL,
	EventsID Int NOT NULL,
	Attended Bit NOT NULL,

  CONSTRAINT pk_MemberEvents PRIMARY KEY([MemberEventsID]),
  CONSTRAINT fk_MemID Foreign KEY(MemberID) References Members(MemberID),
  CONSTRAINT fk_EventsID Foreign KEY(EventsID) References [Events](EventsID)
)

Print 'MemberEvents Table Created'

Insert Into MemberEvents
		(MemberID, EventsID, Attended)
Values
		(1, 1, 0),
		(1, 2, 0),
		(1, 3, 1),
		(1, 4, 1),
		(1, 5, 1),
		(2, 1, 1),
		(2, 2, 0),
		(2, 3, 1),
		(2, 4, 1),
		(2, 5, 0),
		(3, 1, 1),
		(3, 2, 1),
		(3, 3, 1),
		(3, 4, 0),
		(3, 5, 1),
		(4, 1, 1),
		(4, 2, 1),
		(4, 3, 1),
		(4, 4, 1),
		(4, 5, 1),
		(5, 1, 1),
		(5, 2, 1),
		(5, 3, 1),
		(5, 4, 1),
		(5, 5, 0),
		(6, 1, 1),
		(6, 2, 0),
		(6, 3, 1),
		(6, 4, 1),
		(6, 5, 0),
		(7, 1, 0),
		(7, 2, 1),
		(7, 3, 1),
		(7, 4, 1),
		(7, 5, 0),
		(8, 1, 1),
		(8, 2, 1),
		(8, 3, 1),
		(8, 4, 1),
		(8, 5, 0),
		(9, 1, 0),
		(9, 2, 1),
		(9, 3, 1),
		(9, 4, 1),
		(9, 5, 0),
		(10, 1, 1),
		(10, 2, 1),
		(10, 3, 0),
		(10, 4, 0),
		(10, 5, 0),
		(11, 1, 1),
		(11, 2, 1),
		(11, 3, 0),
		(11, 4, 0),
		(11, 5, 0),
		(12, 1, 1),
		(12, 2, 0),
		(12, 3, 1),
		(12, 4, 1),
		(12, 5, 1),
		(13, 1, 1),
		(13, 2, 1),
		(13, 3, 0),
		(13, 4, 0),
		(13, 5, 1),
		(14, 1, 0),
		(14, 2, 1),
		(14, 3, 1),
		(14, 4, 1),
		(14, 5, 0),
		(15, 1, 1),
		(15, 2, 1),
		(15, 3, 1),
		(15, 4, 1),
		(15, 5, 0)

Print 'MemberEvents Data Inserted'





--								Challenge 1
Go
Create View vCurrentContactList
As
Select Concat(Firstname, ' ', MiddleName, ' ', LastName) Member, [Address], Phone, Email
From Members M
Inner Join MemberDetails MD
On M.MemberID = MD.MemberID
Where Current_Member = 1

/* 
This View allows us to see all current members and their contact details.
*/

--	Select * From vCurrentContactList

--								Challenge 2
Go
Create View vEmailList
As
Select Concat(Firstname, ' ', MiddleName, ' ', LastName) 'Member', Email
From Members M
Inner Join MemberDetails MD
On M.MemberID = MD.MemberID

/*
This View allows us to see all member email accounts.
*/

--	Select * From vEmailList

--								Challenge 3
Go
Create View vMemberBirthday
As
Select Concat(FirstName, ' ', LastName) 'Member', Birthday From Members Where DateName(Month,Birthday)  = DateName(Month,Getdate())

/*
This View allows us to see all members who are celebrating 
their birthday in the current month.
*/


-- Select * From vMemberBirthday
Go 
------------------------------------------------------------

--								Challenge 4
--Select Max(TransactionDate) 'Transaction Date', M.MemberID, Max(T.Amount) 'Amount'
--From Transactions T
--Inner Join Members M
--On M.MemberID = T.MemberID
--Inner Join SubscriptionPricing SP
--On SP.SubscriptionPricingID = M.SubscriptionPricingID
--Where SP.SubscriptionPricingID = 4 And M.Current_Member = 1 and (DateAdd(Month,1, T.TransactionDate) <= Getdate())
--Group By M.MemberID 

Go
Create Proc  spMemberTransactionBilling
As
Begin Transaction
Insert into Transactions
		(MemberID, TransactionDate, Amount, Result, TransactionType)
Select Max(M.MemberID), Dateadd(Month,1,Max(JoinDate)) , Max(T.Amount) 'Amount', 'Approved', 1
From Transactions T
Inner Join Members M
On M.MemberID = T.MemberID
Inner Join SubscriptionPricing SP
On SP.SubscriptionPricingID = M.SubscriptionPricingID
Where SP.SubscriptionPricingID = 4 And M.Current_Member = 1 and (DateAdd(Month,1, JoinDate) < Getdate())

Insert into Transactions
		(MemberID, TransactionDate, Amount, Result, TransactionType)
Select  Max(M.MemberID), Dateadd(Month,3,Max(JoinDate)) , Max(T.Amount) 'Amount', 'Approved', 1
From Transactions T
Inner Join Members M
On M.MemberID = T.MemberID
Inner Join SubscriptionPricing SP
On SP.SubscriptionPricingID = M.SubscriptionPricingID
Where SP.SubscriptionPricingID = 3 And M.Current_Member = 1 and (DateAdd(Month,3, JoinDate) < Getdate())

Insert into Transactions
		(MemberID, TransactionDate, Amount, Result, TransactionType)
Select Max(M.MemberID), Dateadd(Year,1,Max(JoinDate)) , Max(T.Amount) 'Amount', 'Approved', 1
From Transactions T
Inner Join Members M
On M.MemberID = T.MemberID
Inner Join SubscriptionPricing SP
On SP.SubscriptionPricingID = M.SubscriptionPricingID
Where SP.SubscriptionPricingID = 2 And M.Current_Member = 1 and (DateAdd(Year,1, JoinDate) < Getdate())

Insert into Transactions
		(MemberID, TransactionDate, Amount, Result, TransactionType)

Select Max(M.MemberID), Dateadd(Year,2,Max(JoinDate)) , Max(T.Amount) 'Amount', 'Approved', 1
From Transactions T
Inner Join Members M
On M.MemberID = T.MemberID
Inner Join SubscriptionPricing SP
On SP.SubscriptionPricingID = M.SubscriptionPricingID
Where SP.SubscriptionPricingID = 1 And M.Current_Member = 1 and (DateAdd(Year,2, JoinDate) < Getdate())
Commit Transaction
--Select * From Transactions
--Exec spMemberTransactionBilling
----------------------------------------------------------------

--								Challenge 5
Go
Create Proc spCreditCardExpDate
As
Select * From CreditCard Where CardExp <= Getdate()

/* This procedure will get all the cards that are expired.
*/

--Exec spCreditCardExpDate
/* This exec doesn't pull anything because no cards are expired yet.
*/

--								Challenge 6
Go
Create Proc spMemberIncome
(
@StartDate Date,
@EndDate Date
)
As
Select sum(amount) 'Income', Datename(MM,(Max(TransactionDate))) 'Month'
From Transactions 
Where TransactionDate between @StartDate and @EndDate
Group By Month(TransactionDate)

/* 
This procedure pulls the amount of money this service gets per month 
between the dates you input.
*/

--Exec spMemberIncome '1/1/16', '1/1/18'

--								Challenge 7
Go
Create Proc spNewMemberSignUps
(
@StartDate Date,
@EndDate Date
)
As
Select Count(MemberID) 'Member Sign Ups', DateName(MM,(Max(JoinDate))) 'Month'
From Members 
Where JoinDate between @StartDate and @EndDate
Group By Month(JoinDate)

/* 
This procedure pulls the number of member sign ups per month 
between the dates you input.
*/

--Exec spNewMemberSignUps '1/1/17', '1/1/18'

--								Challenge 8
Go
Create Proc spEventAttendance
(
@StartDate Date,
@EndDate Date
)
As
Select Count(M.MemberID) [Member Attendance], EventName 
From Members M 
Inner Join MemberEvents ME
On M.MemberID = ME.MemberID
Inner Join [Events] E
On E.EventsID = ME.EventsID
Where Attended = 1 And EventDate Between @StartDate and @EndDate
Group By EventName

/* 
This procedure pulls the number of members that attended each event 
between the dates you input.
*/

--Exec spEventAttendance'1/1/17','5/4/17'

--								Challenge 9
-- Procedure For Making Logins
Go
Create Proc spAddLogin
	@MemberID Int,
    @LoginName VARCHAR(75), 
    @Password VARCHAR(60), 
    @ResponseMessage VARCHAR(250) OUTPUT

As
Begin
	
	Begin Try
		Insert Into Passwords 
				(MemberID, LoginName, [Password])
		Values
				(@MemberID, @LoginName, HASHBYTES('MD5', @Password))
		Set @ResponseMessage = 'Success'

	End Try
	Begin Catch
		Set @ResponseMessage = ERROR_MESSAGE()
	End Catch
End

Go
--Executing Procedure
--Declare @ResponseMessage VARCHAR(250)
--Exec	spAddLogin @MemberID = 1, @LoginName = 'bfallon0@artisteer.com', 
--		@Password = 'Yes', @ResponseMessage = @ResponseMessage Output
--Select @ResponseMessage As '@ResponseMessage'
--Select * From Passwords

-- Making the Login test
Go
Create PROCEDURE spLoginTest
    @LoginName VARCHAR(75),
    @Password VARCHAR(60),
    @responseMessage NVARCHAR(250)='' OUTPUT
AS
BEGIN


    DECLARE @memberID INT

    IF EXISTS (SELECT TOP 1 MemberID FROM Passwords WHERE LoginName = @LoginName)
    BEGIN
        SET @memberID =(SELECT MemberID FROM Passwords WHERE LoginName = @LoginName AND [Password] = HASHBYTES('MD5', @Password))

       IF(@memberID IS NULL)
           SET @ResponseMessage='Incorrect password'
       ELSE 
           SET @ResponseMessage='User successfully logged in'
    END
    ELSE
       SET @ResponseMessage='Invalid login'

END
--Actual Password Test
Go
--DECLARE	@responseMessage nvarchar(250)
--EXEC	spLoginTest
--		@LoginName = 'bfallon0@artisteer.com',
--		@Password = 'Aye',
--		@responseMessage = @ResponseMessage OUTPUT

--SELECT	@ResponseMessage as '@ResponseMessage'

-- Password Change Procedure
Go
Create Proc spPasswordChange
			@MemberID Int,
			@NewPassword Varchar(60),
			@ResponseMessage VARCHAR(250) OUTPUT
As
Begin
	Update Passwords
	Set [Password] = Hashbytes('MD5',@NewPassword), ModifiedDate = Getdate()
	Where MemberID = @MemberID

	If (Select [Password] From Passwords Where MemberID = @MemberID) <> @NewPassword 
	Begin
	Set @ResponseMessage = 'Password Successfully Changed'
	End
End

-- Testing Password Change
Go
--Declare @ResponseMessage VARCHAR(250)
--Exec spPasswordChange 1,'Aye' ,@ResponseMessage Output
--Select @ResponseMessage As '@ResponseMessage'