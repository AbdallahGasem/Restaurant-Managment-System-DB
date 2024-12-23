CREATE DATABASE Resturant_Managment_System;

CREATE TABLE [User] (

[User_Id] INT PRIMARY KEY,
First_Name VARCHAR(15) NOT NULL,
Last_Name VARCHAR(15) NOT NULL,
Phone VARCHAR(15) NOT NULL,
Email VARCHAR(50) ,
Signner INT FOREIGN KEY REFERENCES [User]([User_Id]) ,
updator INT FOREIGN KEY REFERENCES [User]([User_Id]),
[Role] VARCHAR(20) NOT NULL, 

);


CREATE TABLE [Table] (

Table_Id INT PRIMARY KEY , 
[User_Id] INT FOREIGN KEY REFERENCES [User]([User_Id]),
Capacity INT NOT NULL,
[Status] VARCHAR(30) NOT NULL, 

);

CREATE TABLE Customer(

[User_Id] INT PRIMARY KEY,
Table_Id INT FOREIGN KEY REFERENCES [Table]([Table_Id]),
CONSTRAINT Child1_link FOREIGN KEY([User_Id]) REFERENCES [User]([User_Id]),

);


CREATE TABLE Admin_Manager (

[User_Id] INT PRIMARY KEY,
Salary FLOAT NOT NULL,
CONSTRAINT Child2_link FOREIGN KEY([User_Id]) REFERENCES [User]([User_Id]),

);

CREATE TABLE Waiter(

[User_Id] INT PRIMARY KEY,
Hourly_Paid FLOAT NOT NULL,
CONSTRAINT Child3_link FOREIGN KEY([User_Id]) REFERENCES [User]([User_Id]),

);


CREATE TABLE Accept_Reject_Reservation(

[User_Id] INT,
Table_Id INT,
PRIMARY KEY([User_Id] , Table_Id),
CONSTRAINT Accept_Rej_Res_userfk FOREIGN KEY([User_Id]) REFERENCES Admin_Manager([User_Id]),
CONSTRAINT Accept_Rej_Res_tablefk FOREIGN KEY(Table_Id) REFERENCES [Table](Table_Id),

);


CREATE TABLE Menu_Item(

Item_Id INT PRIMARY KEY,
Item_Name VARCHAR(50) NOT NULL,
[Description] VARCHAR(MAX) NOT Null, 
Price FLOAT NOT NULL,
[User_Id] INT FOREIGN KEY REFERENCES Admin_Manager([User_Id]),

);


CREATE TABLE [Order] (

Order_Id INT PRIMARY KEY,
Customer_Id INT FOREIGN KEY REFERENCES Customer([User_Id]),
Menu_Item_Id INT FOREIGN KEY REFERENCES Menu_Item(Item_Id),
[Date] Date ,
[Status] VARCHAR(50),

);


CREATE TABLE Order_Item(

Order_Item_Id INT,
Order_Id INT FOREIGN KEY REFERENCES [Order](Order_Id),
Quantity INT NOT NULL,
Menu_Item_Id INT FOREIGN KEY REFERENCES Menu_Item(Item_Id),
PRIMARY KEY(Order_Item_Id , Order_Id),

);


CREATE TABLE Order_Placment(
C_User_Id INT FOREIGN KEY REFERENCES Customer([User_Id]),
Waiter_Id INT FOREIGN KEY REFERENCES Waiter([User_Id]),
Order_Id INT FOREIGN KEY REFERENCES [Order](Order_Id),
Primary Key (C_User_Id , Waiter_Id , Order_Id),

);

-- Order Has item gonna be a 1 to n therefore we gonna add a column to refrence 
-- the order in orderitem
ALTER TABLE Order_Item ADD OID INT NOT NULL FOREIGN KEY REFERENCES [Order](Order_Id);
