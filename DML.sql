/*
*
=> SQL Project: Automobile Shop Management System (ASMSDB)
=> Project By: A.K.M Mainul Hasan
=> Batch ID: ESAD-CS/PNTL-A/49/01
=> Trainee ID: 1267181
=> Project Submission Date: 02/12/2021
*
*/

/*
Table of Contents: DML
    => SECTION 01: INSERTING DATA INTO TABLE (Normal Insert Into)
    => SECTION 02: INSERTING DATA INTO TABLE (Through Store Procedure)
    => SECTION 03: TEST (View, Trigger, Function, Transaction)
    => SECTION 04: Query to retrieve data from database 
*/


-- USE DATABASE

USE ASMSDB
GO


/*SECTION 01: INSERTING DATA INTO TABLE (Normal Insert Into)*/

-- INSERT DATA INTO TABLE [tblCity]

INSERT INTO tblCity
VALUES
    (1, 'Dhaka'),
    (2, 'Chittagong'),
    (3, 'Khulna'),
    (4, 'Rajshahi'),
    (5, 'Sylhet'),
    (6, 'Barisal'),
    (7, 'Mymensingh'),
    (8, 'Rangpur')
GO

-- INSERT DATA INTO TABLE [tblShop]

INSERT INTO tblShop
VALUES
    (1, 1, 'Auto Zone BD', 'Pragati Ave, Dhaka 1212', '01978057390', 'dhk@azbd.com')           
GO

-- INSERT DATA INTO TABLE [tblEmpDepartment]

INSERT INTO tblEmpDepartment
VALUES
    (1, 'HR'),
    (2, 'Marketing'),
    (3, 'Operation'),
    (4, 'Support'),
    (5, 'Accounts')
GO

-- ISERT DATA INTO TABLE [tblEmpposition]

INSERT INTO tblEmpposition
VALUES
    (1, 'Manager', 50000),
    (2, 'Sales Representative', 25000),
    (3, 'Technician', 20000),
    (4, 'Support Staff', 15000),
    (5, 'Accounts Officer', 25000)
GO


-- Insert Data into tblEmployee

INSERT INTO tblEmployee
VALUES
    (1,1, 'Raihan', 'Sabbir', 1, 1, '2016-1-01', NULL, 1, '01855516567', 'raihan@mail.net'),

    (2,1, 'Al-Amin', 'Hoq', 2, 2, '2016-2-01', NULL, 1, '01555532236', 'amin@mail.net'),
    (3, 1,'Ruhul', 'Tarikul', 2, 2, '2016-3-10', NULL, 1, '01155516012', 'ruhul@mail.net'),
    (4, 1, 'Musharraf', 'Ariful', 2, 2,'2016-9-13', NULL, 1,'01711464671', 'ariful@mail.net'),
    (5, 1, 'Karim', 'Kalam',2, 2, '2016-10-20', NULL, 1, '01155512246', 'kalam@mail.net'),

    (6, 1, 'Biswas', 'Malek', 3, 3, '2016-10-21', NULL, 1, '01555599787', 'malek@mail.net'),
    (7, 1, 'Abedin', 'Mohammad', 3, 3, '2016-10-22', NULL, 1, '01711362608', 'zakir@mail.net'),
    (8, 1, 'Karim', 'Zakir', 3, 3, '2016-10-25', NULL, 1, '01711362608', 'zakir@mail.net'),
    (9, 1, 'Mahmudul', 'Sabbir', 3, 3, '2016-10-26', NULL, 1, '01155559567', 'sabbir@mail.net'),
    (10, 1, 'Tahsin', 'Liaquat', 3, 3, '2016-12-10', NULL, 1, '01855569798', 'tahsin@mail.net'),

    (11, 1, 'Fazle', 'Aminul', 4, 4, '2020-9-21', NULL, 1, '01711868140', 'fazle@mail.net'),
    (12, 1, 'Abdus', 'Maruf', 4, 4, '2021-7-15', NULL, 1, '01955572170', 'maruf@mail.net'),
    (13, 1, 'Mokhlechur', 'Karim', 4, 4, '2015-1-23', NULL, 1, '01155570180', 'karim@mail.net'),
    (14, 1, 'Salik', 'Rabiul', 4, 4, '2016-4-22', NULL, 1, '01988740025', 'rabiul@mail.net'),
    (15, 1, 'Sirajul', 'Islam', 4, 4, '2016-12-22', NULL, 1, '01855584658', 'sirajul@mail.net')
    GO

	-- Insert Data into spInsertEmployee

EXEC spInsertEmployee @eId=16,
                      @eshopId=1,
                      @eFName='Mahmoud',
                      @eLName='Saeed',
                      @ePId=5,@eDId=5,
                      @eStartDate='2017-4-23',
                      @eEndDate=NULL,
                      @eIsActive=1,
                      @ephone='01655588828',
                      @eEmail='saeed@mail.net'

EXEC spInsertEmployee @eId=17,
                      @eshopId=1,
                      @eFName='Russell',
                      @eLName='Mahmoud',
                      @ePId=5,
                      @eDId=5,
                      @eStartDate='2017-6-22',
                      @eEndDate=NULL,
                      @eIsActive=1,
                      @ephone='01741721776',
                      @eEmail='saeed@mail.net'
GO

-- INSERT DATA INTO TABLE [tblBrand]

INSERT INTO tblBrand
VALUES
    (1, 'Toyota'),
    (2, 'Suzuki'),
    (3, 'Mitsubishi'),
    (4, 'Honda'),
    (5, 'Audi') 
GO

-- INSERT DATA INTO TABLE [tblModel]

INSERT INTO tblModel
VALUES
    (1, 'Toyota Corolla Cross', '2020'),
    (1, 'Toyota RAV4', '2020'),
    (1, 'Toyota Hilux', '2020'),
    (1, 'Toyota Yaris 1.3L', '2020'),
    (1, 'Toyota Rush', '2020'),

    (2, 'Suzuki Alto 800', '2020'),
    (2, 'Suzuki APV Microbus', '2020'),
    (2, 'Suzuki Ciaz', '2020'),
    (2, 'Suzuki Dzire', '2020'),
    (2, 'Suzuki Ertiga', '2020'),

    (3, 'Mitsubishi ASX', '2020'),
    (3, 'Mitsubishi Attrage', '2020'),
    (3, 'Mitsubishi L200', '2020'),
    (3, 'MITSUBISHI LANCER EX', '2020'),
    (3, 'Mitsubishi Outlander', '2020'),

    (4, 'Honda Accord Turbo', '2020'),
    (4, 'Honda City', '2020'),
    (4, 'Honda Civic Turbo', '2020'),
    (4, 'Honda CR-V Turbo', '2020'),
    (4, 'Honda Fit', '2020')
GO

-- Set Identity OFF
SET IDENTITY_INSERT tblModel OFF

-- Insert Data into spInsertModel                 
EXEC spInsertModel 5, 'Audi A3', '2020'
EXEC spInsertModel 5, 'Audi A4', '2020'
EXEC spInsertModel 5, 'Audi A5', '2020'
EXEC spInsertModel 5, 'Audi A6', '2020'
EXEC spInsertModel 5, 'Audi A7', '2020'
EXEC spInsertModel 5, 'Audi A8L', '2021'
GO


-- Insert Into tblProduct List
INSERT INTO tblProductList
(Shop_ID, Brand_ID, Model_ID, Stock_Quantity, Available)
VALUES
    (1, 1, 101, 5, 1),
    (1, 1, 102, 5, 1),
    (1, 1, 103, 5, 1),
    (1, 1, 104, 5, 1),
    (1, 1, 105, 5, 1),

    (1, 2, 106, 5, 1),
    (1, 2, 107, 5, 1),
    (1, 2, 108, 5, 1),
    (1, 2, 109, 5, 1),
    (1, 2, 110, 5, 1),

    (1, 3, 111, 5, 1),
    (1, 3, 112, 5, 1),
    (1, 3, 113, 5, 1),
    (1, 3, 114, 5, 1),
    (1, 3, 115, 5, 1),

    (1, 4, 116, 5, 1),
    (1, 4, 117, 5, 1),
    (1, 4, 118, 5, 1),
    (1, 4, 119, 5, 1),
    (1, 4, 120, 5, 1)
GO
-- Insert Data into spInsertProduct

EXEC spInsertProduct 1, 5, 121, 5, 1
EXEC spInsertProduct 1, 5, 122, 5, 1
EXEC spInsertProduct 1, 5, 123, 5, 1
EXEC spInsertProduct 1, 5, 124, 5, 1
EXEC spInsertProduct 1, 5, 125, 5, 1
EXEC spInsertProduct 1, 5, 126, 5, 1
GO


-- INSERT DATA INTO TABLE [tblPrice]

INSERT INTO tblPrice
(Brand_ID, Model_ID, Actual_Price, VAT, Discount)
VALUES 
    (1, 101, 4300000, 200, 0),
    (1, 102, 2825000, 200, 0),
    (1, 103, 1425000, 200, 0),
    (1, 104, 2000000, 200, 0),
    (1, 105, 2750000, 200, 0),

    (2, 106, 425000, 200, 0),
    (2, 107, 1425000, 200, 0),
    (2, 108, 1200000, 200, 0),
    (2, 109, 850000, 200, 0),
    (2, 110, 1225000, 200, 0),

    (3, 111, 2500000, 200, 0),
    (3, 112, 1200000, 200, 0),
    (3, 113, 3000000, 200, 0),
    (3, 114, 2900000, 200, 0),
    (3, 115, 1425000, 200, 0),

    (4, 116, 2400000, 200, 0),
    (4, 117, 4800000, 200, 0),
    (4, 118, 5600000, 200, 0),
    (4, 119, 6000000, 200, 0),
    (4, 120, 7500000, 200, 0),

    (5, 121, 2800000, 200, 0),
    (5, 122, 1425000, 200, 0),
    (5, 123, 2200000, 200, 0),
    (5, 124, 2750000, 200, 0),
    (5, 125, 1600000, 200, 0),
    (5, 126, 120000000, 200, 0)
GO



-- INSERT DATA INTO TABLE [tblCustomerType]

INSERT INTO tblCustomerType
VALUES
    (1, 'Individua'),
    (2, 'Corporate')
GO

-- INSERT DATA INTO TABLE [tblCustomer]
INSERT INTO tblCustomer
VALUES
-- Individual Customer

    (1, 1, 'Shila', 'Babaji', NULL, '36/7, Humyun Road, (Ground floor), Mohammadpur', '01517811238', 'shila@email.net', '8983730188', NULL),

    (1, 1, 'Darpana', 'Mandal', NULL, '80/a, indira road, earth lotus, 1215', '01553287272', 'darpana@email.net', '2729515065', NULL),

    (1, 1, 'Bansari', 'Ray', NULL, 'block-e, bashundhara r/a, apollo hospitals dhaka, 1252', '01713047627', 'ray@email.net', '7746824293', NULL),

    (1, 1, 'Anshuman', 'Ojha', NULL, '80/a, indira road, earth lotus, 1215', '01796654674', 'Ojha@email.net', '5815544489', NULL)
GO

-- Insert Data into spInsertCustomer

EXEC spInsertCustomer 2, 1, NULL, NULL, 'Izabella Ltd.', '19/2, north dhanmondi, kalabagan, 1205', '01711031197', 'info@zabella.com', NULL, '79885721896201547'
EXEC spInsertCustomer 2, 1, NULL, NULL, 'Elver Ltd.', 'sher-e-bangla nagar, dhaka shishu hospital, 12052', '01819104709', 'info@elver.com', NULL, '54716585293449440'
GO

-- Insert Into Table tllSells

INSERT INTO tblSell
VALUES
(1, 4, 1,5,125,125, '2017-5-15'),
(1, 5, 2, 4, 118,118, '2017-6-25'),
(1, 6, 3, 2, 107, 107, '2018-2-16'),
(1, 3, 4, 1, 105, 105, '2018-7-19'),
(1, 7, 6,3, 112, 112, '2019-9-12'),
(1, 12, 5, 2, 108, 108, '2021-11-25' )
GO


-- Insert Data into spCreateSellsInvoice (Invoice_ID, Customer_ID, Invoice_Date, Invoice_Total, Receive_Total)

EXEC spCreateSellsInvoice 1, 1, '2017-05-15', 4800000, 4800000
EXEC spCreateSellsInvoice 2, 2, '2017-06-25', 16800000, 16800000
EXEC spCreateSellsInvoice 3, 3, '2018-02-16', 4275000, 4275000
EXEC spCreateSellsInvoice 4, 4, '2018-07-19', 8250000, 8250000
EXEC spCreateSellsInvoice 5, 6, '2019-09-12', 3600000, 3600000
EXEC spCreateSellsInvoice 6, 5, '2021-11-25', 3600000, 3000000
GO 




-- Insert Data into tblBankAccount

INSERT INTO tblBankAccounts
VALUES
(1111, 'Main Account', 55000000.00),
(1444, 'ASM HR', 150000.00),
(1555, 'ASM Marketing', 55000.00),
(1666, 'ASM Operation', 50000.00),
(1777, 'ASM Support', 100000.00),
(1888, 'ASM Accuonts', 500000.00)
GO



/*SECTION 02: INSERTING DATA INTO TABLE (Through Store Procedure)*/









/*SECTION 03: TEST (View, Trigger, Function, Transaction)*/


-- Search Employee Details By Department

EXEC spSearchEmployeesByDepartment 'Accounts'
GO
----------------------------------------------

-- Search Products Details By Brand
EXEC spSearchProductsByBrand 'Mitsubishi'
GO

------------------------------------------------

-- DECLARE Stored Procedure  To Count Employee Number

DECLARE @TotalEmployee INT 
    EXEC dbo.spCountEmployee @TotalEmployee OUTPUT
    PRINT @TotalEmployee 
GO

-----------------------------------------------------------

-- Test Customer Wise total sales
SELECT dbo.fnCustomerWisetotalsales(5) 'Amount Of Total Sales'
GO

----------------------------------------------------------

-- Test Transaction Transfer Balance

EXEC transferBalance 1111, 1444, 50000.00
GO
-- Select tblBankAccounts
SELECT * FROM tblBankAccounts

--------------------------------------------------

-- Test fnSalesDetailsByMonth

SELECT * FROM fnSalesDetailsByMonth (2017,06)

-------------------------------------------------

-- Update Sales Date (Roll Back Transaction)

UPDATE tblSell
    SET Sales_Date = '2018-7-19'
WHERE Sell_ID =4
GO
---------------------------------------------------

-- Insert Data into [tblStockIn]

INSERT INTO tblStockIn
(Shop_ID, Brand_ID, Model_ID, Quantity)
VALUES
(1,1,101,5)
GO

SELECT * FROM tblStockIn -- Insert 5 
SELECT * FROM tblproductList -- It will Update 5 to 10

-----------------------------------------------------


-- Insert Data into tblEmpDailyTask(Assigne More Than two job is not possible)

INSERT INTO tblEmpDailyTask VALUES(1,4,1,'SUN')
INSERT INTO tblEmpDailyTask VALUES(2,4,2,'SUN')
--INSERT INTO tblEmpDailyTask VALUES(2,4,2,'SUN')
GO

----------------------------------------------------------


/*SECTION 04: Query to retrieve data from database*/

-- Select all information from tblCustomer

SELECT * FROM tblCustomer 

-- Find out the customer whos company name IS NULL

SELECT * FROM tblCustomer
WHERE Company_Name IS NULL
GO

-- Use SPACE() Find Out The Customer (Full Name) As 'Name'and Their Mobile number Where CustomerType_ID = 1
--  

SELECT 
    (Customer_FName + SPACE(1) + Customer_LName) As 'Name',
    Customer_Phone AS 'Phone'
FROM tblCustomer
WHERE CustomerType_ID = 1
GO


-- Find total number of employee who works in Operation Department 

SELECT 
COUNT(Employee_ID) AS 'Total Employee In Operation' 
FROM tblEmployee
WHERE Department_ID = 'Operation'
GO

-- Sort Employee Name ascending order

SELECT 
    Emp_First_Name,
    Emp_Last_Name 
FROM tblEmployee
ORDER BY 
    Emp_First_Name
GO

-- Sort Employee Name descending  order

SELECT 
    Emp_First_Name,
    Emp_Last_Name 
FROM tblEmployee
ORDER BY 
    Emp_First_Name DESC
GO

-- Sort Employee Name by an expression USE LEN()

SELECT 
    Emp_First_Name,
    Emp_Last_Name 
FROM tblEmployee
ORDER BY 
    LEN (Emp_First_Name) DESC
GO

-- Sort by ordinal positions of columns

SELECT 
    Emp_First_Name,
    Emp_Last_Name 
FROM tblEmployee
ORDER BY 
   1,
   2
GO

--  select the OFFSET 10 ROWS 

SELECT
    BR.Brand_Name,
    MO.Model_Name
FROM
   tblModel MO
JOIN tblBrand BR ON MO.Brand_ID = BR.Brand_ID
ORDER BY
    BR.Brand_Name,
    MO.Model_Name
OFFSET 10 ROWS 
GO

--  select the OFFSET 10 ROWS 
SELECT
    BR.Brand_Name,
    MO.Model_Name
FROM
   tblModel MO
JOIN tblBrand BR ON MO.Brand_ID = BR.Brand_ID
ORDER BY
    BR.Brand_Name,
    MO.Model_Name
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY
GO

--  select the OFFSET 0 ROWS 

SELECT
    BR.Brand_Name,
    MO.Model_Name
FROM
   tblModel MO
JOIN tblBrand BR ON MO.Brand_ID = BR.Brand_ID
ORDER BY
    BR.Brand_Name,
    MO.Model_Name
OFFSET 0 ROWS 
FETCH FIRST 10 ROWS ONLY
GO

-- Find Out The customers from invoice table who have a Payment Due

SELECT * FROM tblInvoice
WHERE Total_Due !=0
GO

-- Write a Join Query To find out the employee Details who work in Marketing Department

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
WHERE DEP.Department_Name = 'Marketing'



-- Using Like Operator

SELECT
    Emp_First_Name,
    Emp_Last_Name 
From tblEmployee
WHERE
    Emp_First_Name LIKE '%ul'
ORDER BY
    Emp_First_Name
GO

-- Using NOT Like Operator
SELECT
    Emp_First_Name,
    Emp_Last_Name 
From tblEmployee
WHERE
    Emp_First_Name NOT LIKE '%ul'
ORDER BY
    Emp_First_Name
GO

-- SQL Server GROUP BY clause and aggregate functions

SELECT
    Customer_ID AS 'Customer',
    Sales_Date AS 'Date',
    SUM (Selling_Price) AS 'Total'
FROM
    vSellsDetails
WHERE
    customer_id IN (1, 2)
GROUP BY
    Customer_ID, Sales_Date
ORDER BY
    Sales_Date; 

-- Using GROUP BY clause with the MIN and MAX functions example

SELECT
    Brand_Name,
    Model_Name,
    MIN(Unit_Price) AS 'min_price',
    MAX(Unit_Price) AS 'max_price'
FROM
    vProductDetails
WHERE Brand_Name IN ('Audi', 'Honda')
GROUP BY
    Brand_Name,
    Model_Name
ORDER BY
    Brand_Name
GO

-- Using GROUP BY clause with the AVG() function example

SELECT
    Brand_Name,
    AVG(Unit_Price) AS 'Avg_price'
   
FROM
    vProductDetails
WHERE Brand_Name IN ('Audi', 'Honda')
GROUP BY
    Brand_Name
ORDER BY
    Brand_Name
GO
    
-- Sub Queary to find out the customer whos Type_ID =2

SELECT
    Sell_ID,
    Sales_Date,
    Customer_ID
FROM
        vSellsDetails
WHERE
    Customer_ID IN (
        SELECT
            Customer_ID
        FROM
            tblCustomer
        WHERE
            CustomerType_ID = 2
    )
ORDER BY
    Sales_Date DESC;


-- Using RollUp

SELECT
    Brand_ID,
    Model_ID,
    SUM (Sell_ID) 
FROM
    vSellsDetails
GROUP BY
    ROLLUP(Brand_ID, Model_ID)
GO

-- Using CUBE

SELECT
    Brand_ID,
    Model_ID,
    SUM (Sell_ID) 
FROM
    vSellsDetails
GROUP BY
    CUBE(Brand_ID, Model_ID)
GO


-- CTE

WITH
 Cte_Operation_Employee
AS 
(
SELECT 
   E.Emp_First_Name,
   E.Emp_Last_Name,
   E.Emp_Email,
   D.Department_Name
FROM tblEmployee E
JOIN tblEmpDepartment D ON D.Department_ID = E.Department_ID
WHERE D.Department_Name = 'Operation'
),
Cte_Support_Employee
AS
(
SELECT 
   E.Emp_First_Name,
   E.Emp_Last_Name,
   E.Emp_Email,
   D.Department_Name
FROM tblEmployee E
JOIN tblEmpDepartment D ON D.Department_ID = E.Department_ID
WHERE D.Department_Name = 'Support'
)
SELECT * FROM Cte_Operation_Employee
UNION ALL
SELECT * FROM Cte_Support_Employee
GO

-----------------------------------------------

