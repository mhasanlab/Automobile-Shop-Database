/*
*
=> SQL Project: Automobile Shop Management System (ASMSDB)
=> Project By: A.K.M Mainul Hasan
=> Batch ID: ESAD-CS/PNTL-A/49/01
=> Trainee ID: 1267181
=> Project Submission Date: 02/12/2021
*/

/*
Table of Contents: DDL
    => SECTION 01: Created a Database Name [ASMSDB]
    => SECTION 02: Created Appropriate Tables For The Database
        -- Table Section 2.1: City & Shop
        -- Table Section 2.2: Employee & Related Tables
        -- Table Section 2.3: Product, StockIn & Price
        -- Table Section 2.4: Customers, Sells & Invoice
        -- Table Section 2.5: Accounts & Transactions 
    => SECTION 03: Apply Some Modifying Statement (ALTER, ADD, DELET, UPDATE)
    => SECTION 04: Created Some Clustered & Non-Clustered Index
    => SECTION 05: CREATING VIEWS
    => SECTION 06: STORE PROCEDURE (INSERT, DELETE, UPDATE)
    => SECTION 07: CREATING FUNCTION (Scalar Value, Table  Value )
    => SECTION 08: CREATING TRIGGER (FOR TRIGGER, INSTEAD OF TRIGGER )
    => SECTION 09: CREATING TRANSACTION
*/


--===SECTION 01: CREATED A DATABASE NAME [ASMSDB]===

USE master
GO

DROP DATABASE IF EXISTS ASMSDB
GO

CREATE DATABASE ASMSDB
ON
(
    NAME = 'ASMSDB_Data',
    FILENAME = 'F:\MHasan\Project\ASMSDB_Data.mdf',
    SIZE = 50MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 10%
)
LOG ON
(
    NAME = 'ASMSDB_Log',
    FILENAME = 'F:\MHasan\Project\ASMSDB_Log.ldf',
    SIZE = 25MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 1MB
)
GO

-- USE DATABASE

USE ASMSDB
GO

/*SECTION 02: Created Appropriate Tables For The Database*/


/*===Table Section 2.1: City & Shop===*/

-- Table Created Name [tblCity]

CREATE TABLE tblCity
(
    City_ID INT PRIMARY KEY NOT NULL,
    City_Name NVARCHAR (50) NOT NULL
)
GO

-- Table Created Name [tblShop]

CREATE TABLE tblShop
(
    Shop_ID INT PRIMARY KEY NOT NULL,
    City_ID INT REFERENCES tblCity (City_ID),
    Shop_Name NVARCHAR (125) NOT NULL,
    Shop_Address NVARCHAR (125) NOT NULL,
    Shop_Phone NVARCHAR (20) NOT NULL,
    shop_Email NVARCHAR (50),
)
GO


/*===Table Section 2.2: Employee & Related Tables===*/

-- Table Created Name [tblEmpDepartment (Employee Department)]

CREATE TABLE tblEmpDepartment
(
    Department_ID INT PRIMARY KEY NOT NULL,
    Department_Name NVARCHAR (50) NOT NULL
)
GO

-- Table Created Name [tblEmpposition (Employee Position)]

CREATE TABLE tblEmpposition
(
    Poisition_ID INT PRIMARY KEY NOT NULL,
    Position_Name NVARCHAR (50) NOT NULL, 
    Basic_Salary MONEY
)
GO

-- Table Created Name [tblEmployee]

CREATE TABLE tblEmployee
(
    Employee_ID INT PRIMARY KEY NOT NULL,
    Shop_ID INT REFERENCES tblShop (Shop_ID) NOT NULL,
    Emp_First_Name NVARCHAR (75) NOT NULL,
    Emp_Last_Name NVARCHAR (75) NOT NULL,
    Poisition_ID INT REFERENCES tblEmpposition (Poisition_ID) NOT NULL,
    Department_ID INT REFERENCES tblEmpDepartment (Department_ID) NOT NULL,
    Employment_Start_Date DATE NOT NULL,
    Employment_End_Date DATE NULL,
    IS_Active BIT,
    Emp_Phone NVARCHAR (20) NOT NULL,
    Emp_Email NVARCHAR (50) NOT NULL
)
GO

-- Table Created Name [tblEmpDailyTask (Employee Daily Task)]

CREATE TABLE tblEmpDailyTask

(
    ID INT PRIMARY KEY NOT NULL,
    Employee_ID INT REFERENCES tblEmployee (Employee_ID) NOT NULL,
    Task_ID INT NOT NULL,
    [Day] NVARCHAR (10) NOT NULL CHECK ([Day] IN ('SUN', 'MON', 'TUE', 'WED', 'THR'))
)
GO



/*===Table Section 2.3: Product, StockIn & Price===*/

-- Table Created Name [tblBrand]

CREATE TABLE tblBrand
(
    Brand_ID INT PRIMARY KEY NOT NULL,
    Brand_Name NVARCHAR (50) NOT NULL
)
GO 


-- Table Created Name [tblModel]

CREATE TABLE tblModel
(
    Model_ID INT PRIMARY KEY IDENTITY (101,1) NOT NULL,
    Brand_ID INT REFERENCES tblBrand (Brand_ID) NOT NULL,
    Model_Name NVARCHAR (120) NOT NULL,
    Manufacture_Year INT,
)
GO

-- Table Created Name [tblProductList]-(Linking Table)

CREATE TABLE tblProductList
(
    Shop_ID INT REFERENCES tblShop (Shop_ID)  NOT NULL,
    Brand_ID INT REFERENCES tblBrand (Brand_ID) NOT NULL,
    Model_ID INT REFERENCES tblModel (Model_ID) NOT NULL,
    Stock_Quantity INT DEFAULT 0,
    Available BIT
    PRIMARY KEY (Shop_ID, Brand_ID, Model_ID)
)
GO

--------------------------------------

-- Table Created name [tblStockIn]

CREATE TABLE tblStockIn
(
    Stock_Id INT PRIMARY KEY IDENTITY NOT NULL,
    Shop_ID INT REFERENCES tblShop (Shop_ID) NOT NULL,
    Brand_ID INT REFERENCES tblBrand (Brand_ID) NOT NULL,
    Model_ID INT REFERENCES tblModel (Model_ID) NOT NULL,
    Stock_Date DATETIME DEFAULT GETDATE (),
    Quantity INT

)
GO

----------------------------------------

-- Table Created Name [tblPrice]

CREATE TABLE tblPrice
(
    Price_ID INT PRIMARY KEY IDENTITY (101,1) NOT NULL,
    Brand_ID INT REFERENCES tblBrand (Brand_ID) NOT NULL,
    Model_ID INT REFERENCES tblModel (Model_ID) NOT NULL,
    Actual_Price MONEY NOT NULL,
    VAT FLOAT NOT NULL,
    Unit_Price As (Actual_Price * (1+VAT/100)),
    Discount FLOAT,
    Selling_Price AS ((Actual_Price * (1+VAT/100))) * (1-Discount/100)

)
GO


/*===Table Section 2.4: Customers, Sells & Invoice===*/

-- Table Created Name [tblCustomerType]

CREATE TABLE tblCustomerType
(
    CustomerType_ID INT PRIMARY KEY NOT NULL,
    CustomerType_Name NVARCHAR (50) NOT NULL
)
GO

-- Table Created Name [tblCustomer]

CREATE TABLE tblCustomer
(
    Customer_ID INT PRIMARY KEY IDENTITY NOT NULL,
    CustomerType_ID INT REFERENCES tblCustomerType(CustomerType_ID),
    Shop_ID INT REFERENCES tblShop (Shop_ID) NOT NULL,
    Customer_FName NVARCHAR (50) NULL,
    Customer_LName NVARCHAR (50) NULL,
    Company_Name NVARCHAR (50) NULL,
    Customer_Address NVARCHAR (120) NOT NULL,
    Customer_Phone NVARCHAR (20) NOT NULL,
    Customer_Email NVARCHAR (50) UNIQUE NOT NULL,
    Customer_NID NVARCHAR (30) NULL,
    Customer_TIN NVARCHAR (30) NULL,
)
GO

------------------------------------------

--Create Table Name (tblSell)

CREATE TABLE tblSell
(
    Sell_ID INT PRIMARY KEY IDENTITY NOT NULL,
    Shop_ID INT REFERENCES tblShop (Shop_ID) NOT NULL,
    Employee_ID INT REFERENCES tblEmployee (Employee_ID),
    Customer_ID INT REFERENCES tblCustomer (Customer_ID),
    Brand_ID INT REFERENCES tblBrand (Brand_ID) NOT NULL,
    Model_ID INT REFERENCES tblModel (Model_ID) NOT NULL,
    Price_ID INT REFERENCES tblPrice (Price_ID) NOT NULL,
    Sales_Date DATETIME DEFAULT GETDATE()
)
GO

------------------------------------------------

--Create Table Name (tblInvoice)

CREATE TABLE tblInvoice
(
    Invoice_ID INT PRIMARY KEY,
    Invoice_Number INT IDENTITY (1110, 1),
    Customer_ID INT REFERENCES tblCustomer (Customer_ID),
    Invoice_Date DATETIME DEFAULT GETDATE(),
    Invoice_Total MONEY,
    Receive_Total MONEY,
    Total_Due AS (Invoice_Total - Receive_Total)
)
GO


/*===Table Section 2.5: Accounts & Transactions===*/

-- Table Created Name ([tblBankAccounts] Shop Bank Accounts)

CREATE TABLE tblBankAccounts
(
    Account_Number INT PRIMARY KEY NOT NULL,
    Account_Name NVARCHAR (50) NOT NULL,
    Current_Balance MONEY NOT NULL CHECK (Current_Balance>=50000)
)
GO


/*SECTION 03: Apply Some Modifying Statement (ALTER, ADD, DROP, UPDATE)*/

-- SQL Server Add New Column

ALTER Table tblBankAccounts
    ADD Account_Type NVARCHAR (50) NULL
GO  

-- SQL Server Delete Column

ALTER TABLE tblBankAccounts
    DROP COLUMN Account_Type
GO

-- SQL Server Modify Column Data Type

ALTER TABLE tblModel
ALTER COLUMN  
Model_Name NVARCHAR (125) NOT NULL
GO


/*SECTION 04: Created Some Clustered & Non-Clustered Index*/

-- Drop Index If Exists
DROP INDEX IF EXISTS IX_Car_Model_Id
ON   tblModel
GO

-- Creating NonClustered Index

CREATE NONCLUSTERED INDEX IX_Car_Model_Name
ON tblModel (Model_Name)
GO
 
-- Creating NonClustered Index

CREATE NONCLUSTERED INDEX IX_Invoice_Number
ON tblInvoice (Invoice_Number)
GO


/*SECTION 05: Creating Views*/

-- View Created Name [vProductDetails]

CREATE VIEW vProductDetails AS
SELECT 
    S.Shop_Name,
    B.Brand_Name,
    M.Model_Name,
    PR.Unit_Price,
    PR.Selling_Price,
    PL.Stock_Quantity,
    PL.Available
FROM tblProductList PL
    JOIN tblBrand B ON B.Brand_ID = PL.Brand_ID
    JOIN tblModel M ON M.Model_ID = PL.Model_ID
    JOIN tblShop S ON S.Shop_ID = PL.Shop_ID
    JOIN tblPrice PR ON PR.Model_ID = M.Model_ID
GO

-- View Created Name [vSellsDetails]

CREATE VIEW vSellsDetails AS
SELECT 
    S.Sell_ID,
    S.Shop_ID,
    S.Employee_ID,
    S.Customer_ID,
    S.Brand_ID,
    S.Model_ID,
    PR.Selling_Price,
    S.Sales_Date
FROM tblSell S
    JOIN tblPrice PR ON PR.Price_ID = S.Price_ID
GO

-- View Created Name (vEmployeeDetails)

CREATE VIEW vEmployeeDetails AS
SELECT 
    EMP.Employee_ID,
    S.Shop_Name,
    EMP.Emp_First_Name,
    Emp.Emp_Last_Name,
    EP.Position_Name,
    DEP.Department_Name,
    EP.Basic_Salary,
    EMP.Employment_Start_Date,
    EMP.Employment_End_Date,
    EMP.IS_Active,
    EMP.Emp_Phone,
    EMP.Emp_Email
FROM tblEmployee EMP
    JOIN tblShop S ON EMP.Shop_ID = S.Shop_ID
    JOIN tblEmpposition EP ON EP.Poisition_ID = EMP.Poisition_ID
    JOIN tblEmpDepartment DEP ON DEP.Department_ID = EMP.Department_ID
GO


/*SECTION 07: STORE PROCEDURE (INSERT, DELETE, UPDATE)*/

/******************************************************/
-- INSERT STORE PROCEDURE
/******************************************************/

-- Procedure Created For Inserting Data into Table [tblEmployee]
-- Procedure Name [spInsertEmployee]

CREATE PROC spInsertEmployee
                @eId INT,
                @eshopId INT,
                @eFName NVARCHAR (75),
                @eLName NVARCHAR (75),
                @ePId INT,
                @eDId INT,
                @eStartDate DATE,
                @eEndDate DATE,
                @eIsActive BIT=0,
                @ephone NVARCHAR (20),
                @eEmail NVARCHAR (50)
AS
INSERT INTO tblEmployee 
                (Employee_ID, Shop_ID, 
                 Emp_First_Name, Emp_Last_Name,
                 Poisition_ID, Department_ID,
                 Employment_Start_Date, Employment_End_Date,
                 IS_Active, Emp_Phone, Emp_Email)
VALUES
                (@eId,@eshopId,@eFName,@eLName,@ePId,@eDId,
                 @eStartDate,@eEndDate,@eIsActive,@ephone,@eEmail)
GO


-- Procedure Created for Inserting Data Into Table [tblModel]

CREATE PROC spInsertModel
            @BrandId INT,
            @ModelName NVARCHAR (50),
            @ManufacYear INT
AS
    INSERT INTO tblModel 
        (Brand_ID, Model_Name, Manufacture_Year)
    VALUES
        (@BrandId, @ModelName, @ManufacYear)
GO

/*
Procedure Created By Using
(TRY CATCH, Error Message and RAISERROR) 
For the Table [tblCustomeer]
*/

CREATE PROC spInsertCustomer
                    @CTid INT,
                    @sid INT,
                    @CFName NVARCHAR (50) = NULL,
                    @CLName NVARCHAR (50) = NULL,
                    @cCompany NVARCHAR (50) = NULL,
                    @CAddress NVARCHAR (120),
                    @Cphone NVARCHAR (20),
                    @cEmail NVARCHAR (50),
                    @cNid NVARCHAR (25) =NULL,
                    @cTin NVARCHAR (25) = NULL
AS
    BEGIN TRY
    INSERT INTO tblCustomer 
    VALUES 
        (@CTid,@sid,@CFName,@CLName,@cCompany,@CAddress,
        @Cphone,@cEmail,@cNid,@cTin)
        RETURN 0
    END TRY
    BEGIN CATCH
        DECLARE @Message NVARCHAR (150)
        SET @Message =ERROR_MESSAGE()
        RAISERROR (@Message,10, 1)
        RETURN ERROR_MESSAGE()
    END CATCH
GO

-- Procedure Created For Inserting Data into Table [tblproductList]
-- Procedure Name [spProductInsert]

CREATE PROC spInsertProduct
                    @ShopId INT,
                    @BranId INT,
                    @ModelId INT,
                    @StockQuantity INT,
                    @Available BIT
AS
BEGIN
    INSERT INTO tblProductList 
        (Shop_ID, Brand_ID, Model_ID, Stock_Quantity, Available)
    VALUES 
        (@ShopId, @BranId, @ModelId, @StockQuantity, @Available)
END
GO

--CREATE Store procedure name [spCreateSellsInvoice]

CREATE PROC spCreateSellsInvoice
                    @IID INT,
                    @CustID INT, 
                    @IDate DATETIME,
                    @ITotal MONEY,
                    @RTotal MONEY
AS
BEGIN
    INSERT INTO tblInvoice 
        (Invoice_ID, Customer_ID, Invoice_Date, Invoice_Total, Receive_Total)
    VALUES 
        (@IID, @CustID, @IDate, @ITotal,  @RTotal)
END
GO

/******************************************************/
-- DELETE STORE PROCEDURE
/******************************************************/

-- Stored Procedure for Deleting data from [tblEmployee]

CREATE PROC SpDeleteEmployee
                @EMP_ID INT
AS
BEGIN
    DELETE FROM tblEmployee
    WHERE Employee_ID = @EMP_ID
END
GO

/******************************************************/
-- SEARCH THROUGH STORE PROCEDURE
/******************************************************/

/*
Store Procedure for Serch Employee Details
By department from [vEmployeeDetails ]
*/

CREATE PROC spSearchEmployeesByDepartment
            @DepartmentName NVARCHAR (50)
AS
SELECT 
    EMP.Employee_ID AS 'ID',
    S.Shop_Name AS 'Shop',
    (EMP.Emp_First_Name + SPACE (1) + Emp.Emp_Last_Name) AS 'Name', 
    DEP.Department_Name AS 'Department',
    EMP.Emp_Phone AS 'Phone',
    EMP.Emp_Email AS 'Email'
FROM tblEmployee EMP
    JOIN tblShop S ON EMP.Shop_ID = S.Shop_ID
    JOIN tblEmpposition EP ON EP.Poisition_ID = EMP.Poisition_ID
    JOIN tblEmpDepartment DEP ON DEP.Department_ID = EMP.Department_ID
WHERE DEP.Department_Name =@DepartmentName
GO

/*
--Procedure Created for Search Products By Brands 
-From View [vProductDetails]
*/

CREATE PROC spSearchProductsByBrand 
            @BrandName NVARCHAR (50)
AS
SELECT 
    Shop_Name,
    Brand_Name,
    Model_Name,
    Unit_Price,
    Selling_Price,
    Stock_Quantity,
    Available
FROM vProductDetails
    WHERE Brand_Name = @BrandName
GO

-- Count Total Employee Through Output Parameters in Stored Procedure

CREATE PROC spCountEmployee (@CountEmployee INT OUTPUT)
AS
BEGIN
    SELECT @CountEmployee = COUNT(Employee_ID) FROM tblEmployee
END
GO

-- DECLARE THE Above Stored Procedure --

DECLARE @TotalEmployee INT 
    EXEC dbo.spCountEmployee @TotalEmployee OUTPUT
    PRINT @TotalEmployee
GO


/*SECTION 07: Creating FUNCTION (Scalar Value, Table  Value )*/


-- Scalar Function Crreated
-- To Return Customer Wise total sales Amount From [vSalesDetails]

CREATE FUNCTION fnCustomerWisetotalsales (@customerId INT)
RETURNS MONEY
AS 
    BEGIN 
        DECLARE @CustomerWisesales MONEY
        SELECT @CustomerWisesales  = SUM(Selling_Price) FROM vSellsDetails
        WHERE Customer_ID = @customerId
        RETURN @CustomerWisesales
    END
GO

-- Single Statement Table Valued Function Created

CREATE FUNCTION fnProductUnitPrice (
    @BrandName NVARCHAR (50)
)
RETURNS TABLE
AS
RETURN
    SELECT 
        Brand_Name,
        Model_Name,
        Unit_Price
    FROM
        vProductDetails
    WHERE
        Brand_Name = @BrandName;
GO

-- Test
SELECT * FROM fnProductUnitPrice ('Toyota')
GO

-- Multiple Statement Table Valued Function Created
-- To Return Sales Details by Year & Months From [vSalesDetails]

CREATE FUNCTION fnSalesDetailsByMonth (@year INT, @Month INT)
RETURNS @SalesDetails TABLE
(
    Sell_ID INT,
    Shop_ID INT,
    Employee_ID INT,
    Customer_ID INT,
    Brand_ID INT,
    Model_ID INT,
    Price_ID INT
)
AS 
    BEGIN
        INSERT INTO @SalesDetails
        SELECT 
            Sell_ID,
            Shop_ID,
            Employee_ID,
            Customer_ID,
            Brand_ID,
            Model_ID,
            SUM(Selling_Price) 
            FROM vSellsDetails
        WHERE YEAR(Sales_Date)=@year AND MONTH(Sales_Date)=@Month
        GROUP BY
            Sell_ID, Shop_ID, Employee_ID,
            Customer_ID, Brand_ID, Model_ID
        RETURN
    END
GO


/*SECTION 08: CREATING TRIGGER (FOR TRIGGER, INSTEAD OF TRIGGER )*/

-- Create an AFTER TRIGGER for  Prevent update or delete

CREATE TRIGGER trPreventUnexectedSellsUpdateDelete
ON tblSell
AFTER UPDATE,DELETE
AS
BEGIN
    PRINT 'Update Or delete sells is not possible'
    ROLLBACK TRANSACTION
END
GO

/*
Trigger Created for automatically update product quentity
When data insert into stockIn Table.
*/

CREATE TRIGGER trStockIn
ON tblStockIn
FOR INSERT
AS
BEGIN
    DECLARE @mid INT,
            @qnt INT
    SELECT @mid =Model_ID, @qnt =Quantity FROM inserted
    
    UPDATE tblProductList
    SET Stock_Quantity = Stock_Quantity + @qnt
    WHERE Model_ID =@mid

END
GO

-- Trigger For Delete Stock

CREATE TRIGGER trStockDelete
ON tblStockIn
FOR DELETE
AS
BEGIN
    DECLARE @mid INT,
            @qnt INT
    SELECT @mid =Model_ID, @qnt =Quantity FROM inserted
    
    UPDATE tblProductList
    SET Stock_Quantity = Stock_Quantity + @qnt
    WHERE Model_ID =@mid

END
GO

-- Trigger Created for Preventing Delete Employee From [tblEmployee]

CREATE TRIGGER trPreventUnexpectedEmployeeDelete
    ON tblEmployee
    FOR DELETE
AS
    PRINT 'You can''t delete employee from employee table'
	ROLLBACK TRANSACTION
GO

-- Trigger Created for Preventing Delete Product Price From [tblPrice]

CREATE TRIGGER trPreventUnexpectedPriceDelete
    ON tblPrice
    FOR DELETE
AS
    PRINT 'You can''t delete price from price table'
	ROLLBACK TRANSACTION
GO

-- Trigger Created for Preventing Delete Product From [tblProductList]

CREATE TRIGGER trPreventUnexpectedProductDelete
    ON tblProductList
    FOR DELETE
AS
    PRINT 'You can''t delete product from Product List'
	ROLLBACK TRANSACTION
GO

-- Instead of Trigger
-- Create Trigger For Chacking Employee maximum number of task in a day

CREATE TRIGGER trChckEmployeeDailyTask
ON tblEmpDailyTask
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @eid INT,
            @tid INT,
            @d NVARCHAR (10),
            @c INT
    SELECT @eid =Employee_ID, @tid = Task_ID, @d = [Day] FROM inserted
    SELECT @c = COUNT (Task_ID) FROM tblEmpDailyTask
    WHERE Employee_ID =@eid AND [Day] =@d

    IF @c<2
        BEGIN
            INSERT INTO tblEmpDailyTask
            SELECT ID, Employee_ID, Task_ID, [Day] FROM inserted
        END

    ELSE
        BEGIN
            RAISERROR ('Alrady two Job assigned for the employee',10, 1)
        END
END
GO

/*SECTION 09: CREATING TRANSACTION*/

-- Created A Transaction Name [transferBalance]

-- It will Automatically Update Bank Account Balance when a transaction occur
-- Also It will check avaiable balance of the specific account before commit     transaction if account balance does not full fill the minumum balance then it will Rollback the transaction. 

CREATE PROC transferBalance @from INT,
                            @to INT,
                            @amount MONEY
AS
BEGIN TRY
        BEGIN TRANSACTION
        UPDATE tblBankAccounts
        SET Current_Balance =Current_Balance + @amount
        WHERE Account_Number= @to
        
        UPDATE tblBankAccounts
        SET Current_Balance =Current_Balance - @amount
        WHERE Account_Number= @from
        COMMIT TRANSACTION
END TRY

BEGIN CATCH
        ROLLBACK TRANSACTION
END CATCH
GO



