http://161.246.35.92:5560/isqlplus/login.uix
SQL_S1_26
CSKMITL_2565

DROP TABLE InventoryList;
DROP TABLE OrderList;
DROP TABLE Bill;
DROP TABLE Bookmark;
DROP TABLE Package;
DROP TABLE Prod_Lang;
DROP TABLE Language;
DROP TABLE Promotion;
DROP TABLE TagsIn;
DROP TABLE ProductTags;
DROP TABLE Product;
DROP TABLE Developer;
DROP TABLE Payment;
DROP TABLE Client;
DROP TABLE Library
DROP TABLE Promotion

SELECT * FROM TAB;
--
CREATE TABLE Client
(UserID CHAR(4) NOT NULL, 
FName VARCHAR(20) NOT NULL,
LName VARCHAR(20) NOT NULL,
Password VARCHAR(20) NOT NULL,
Email VARCHAR(30) NOT NULL UNIQUE,
Sex CHAR(1),
Age int,
Birthdate DATE,
Regisdate DATE,
PRIMARY KEY(UserID));

CREATE TABLE Payment
(CreditID CHAR(13) NOT NULL,
CreditTpye VARCHAR(12) NOT NULL,
CVV CHAR(3) NOT NULL,
MM CHAR(2) NOT NULL,
YYYY CHAR(4) NOT NULL,
UserID CHAR(4) NOT NULL,
PRIMARY KEY(CreditID),
FOREIGN KEY(UserID) REFERENCES Client(UserID));

CREATE TABLE Developer
(DevCode CHAR(16)  NOT NULL,
DevName CHAR(20)  NOT NULL,
PRIMARY KEY(DevCode));

CREATE TABLE Product
(ProductCode CHAR(16)  NOT NULL,
Title VARCHAR(30) NOT NULL,
Price float(5,2) NOT NULL,
Rate VARCHAR(4) ,
Rating float(2,2),
ReleaseDate DATE,
Recommend VARCHAR(100),
BaseGame CHAR(16),
DevCode CHAR(16),
PRIMARY KEY(ProductCode),
FOREIGN KEY(BaseGame) REFERENCES Product(ProductCode),
FOREIGN KEY(DevCode) REFERENCES Developer(DevCode));

CREATE TABLE ProductTags
(TagsCode CHAR(4) NOT NULL,
TagsName CHAR(20) NOT NULL,
PRIMARY KEY(TagsCode));

CREATE TABLE TagsIn
(TagsCode CHAR(4) NOT NULL,
ProductCode CHAR(16) NOT NULL,
PRIMARY KEY(TagsCode,ProductCode),
FOREIGN KEY(ProductCode) REFERENCES Product(ProductCode),
FOREIGN KEY(TagsCode) REFERENCES ProductTags(TagsCode));

CREATE TABLE Promotion
(Sequence CHAR(4) NOT NULL,
ProName VARCHAR(20),
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
DiscountPrice float NOT NULL,
ProductCode CHAR(16) NOT NULL,
PRIMARY KEY(Sequence,ProductCode),
FOREIGN KEY(ProductCode) REFERENCES Product(ProductCode));

CREATE TABLE Language
(LangCode CHAR(4) NOT NULL,
LangName CHAR(20) NOT NULL,
PRIMARY KEY(LangCode));

CREATE TABLE Prod_Lang
(ProductCode CHAR(16) NOT NULL,
LangCode CHAR(4) NOT NULL,
PRIMARY KEY(ProductCode,LangCode),
FOREIGN KEY(ProductCode) REFERENCES Product(ProductCode),
FOREIGN KEY(LangCode) REFERENCES Language(LangCode));

CREATE TABLE Package
(PackageID CHAR(16) NOT NULL,
ProductCode CHAR(16) NOT NULL,
Price float NOT NULL,
Title VARCHAR(30) NOT NULL,
PRIMARY KEY(PackageID,ProductCode),
FOREIGN KEY(ProductCode) REFERENCES Product(ProductCode));

CREATE TABLE Bookmark
(Sequence int NOT NULL,
UserID CHAR(4) NOT NULL,
ProductCode CHAR(16) NOT NULL,
PRIMARY KEY(Sequence,UserID),
FOREIGN KEY(UserID) REFERENCES Client(UserID),
FOREIGN KEY(ProductCode) REFERENCES Product(ProductCode));

CREATE TABLE Bill
(BillNo CHAR(10) NOT NULL,
PriceTotal float,  --0
PayDate DATE, 
UserID CHAR(4) NOT NULL,
CreditID CHAR(16) NOT NULL,
PRIMARY KEY(BillNo),
FOREIGN KEY(UserID) REFERENCES Client(UserID),
FOREIGN KEY(CreditID) REFERENCES Payment(CreditID));
--รวมราคา select แล้วตามด้วย sum 
-- SELECT UserID, SUM(PriceTotal) AS 'Total Price'
-- FROM Bill
-- GROUP BY UserID;


CREATE TABLE OrderList
(Sequence int NOT NULL,
BillNo CHAR(10) NOT NULL,
Price float, --0
ProductCode CHAR(16) NOT NULL,
PRIMARY KEY(Sequence,BillNo),
FOREIGN KEY(BillNo) REFERENCES Bill(BillNo),
FOREIGN KEY(ProductCode) REFERENCES Product(ProductCode));
--ยังไม่รวมราคา select ออกมาทีละตัว

CREATE TABLE InventoryList
(Sequence int NOT NULL,
UserID CHAR(4) NOT NULL,
ProductCode CHAR(16) NOT NULL,
BillNo CHAR(10) NOT NULL,
PRIMARY KEY(Sequence,UserID),
FOREIGN KEY(UserID) REFERENCES Client(UserID),
FOREIGN KEY(ProductCode) REFERENCES Product(ProductCode),
FOREIGN KEY(BillNo) REFERENCES Bill(BillNo));
