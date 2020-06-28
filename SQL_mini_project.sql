--CREATE--
--SQL DATA types--
--INSERT INTO--
--SELECT--
--WHERE--
--LIKE--
--wildcards--
--CONCAT--
--formatting dates--
--AS/alias--
--JOINs--
--subqueries--

/*Remember to apply all the following standards:
•	Use consistent capitalisation and indentation of SQL Statements
•	Use concise and consistent table alias names
•	Use column aliases to ensure tidy column headings (spaces and consistent capitalisation)
•	Concatenate any closely related columns e.g. First Name and Last Name or Address and City etc
•	Put comments throughout
*/


--Excercise 1--
/*1.1	Write a query that lists all Customers in either Paris or London.
        Include Customer ID, Company Name and all address fields.*/

SELECT c.CustomerID
    ,c.CompanyName
    ,CONCAT(c.Address, ', ', c.City, ', ', c.PostalCode, ', ', c.Country) AS "Full Address"
FROM Customers c
WHERE c.City IN ('Paris', 'London');

SELECT Region
FROM Customers
/*how do I add Region when some places don't have it and it leaves floating comma.
Paris and London don't have a Region so could just leave out but what if half the data did have a region?*/

SELECT c.CustomerID
    ,c.CompanyName
    ,CASE
        WHEN c.Region IS NULL THEN CONCAT(c.Address, ', ', c.City, ', ', c.PostalCode, ', ', c.Country)
        ELSE CONCAT(c.Address, ', ', c.City, ', ', c.Region, ', ',  c.PostalCode, ', ', c.Country)
        END AS "Full Address"
FROM Customers c
WHERE c.City IN ('Paris', 'London');

--WOOHOO--

/*1.2	List all products stored in bottles.*/

SELECT p.ProductID
    ,p.ProductName
    ,p.QuantityPerUnit
FROM Products p
WHERE p.QuantityPerUnit LIKE '%bottle%';

/*1.3	Repeat question above but add in the Supplier Name and Country.*/

SELECT p.ProductID
    ,p.ProductName
    ,p.QuantityPerUnit
    ,s.CompanyName AS "Supplier Name", s.Country
FROM Products p
INNER JOIN Suppliers s
    ON p.SupplierID = s.SupplierID
WHERE p.QuantityPerUnit LIKE '%bottle%';

/*1.4	Write a SQL Statement that shows how many products there are in each category.
        Include Category Name in result set and list the highest number first.*/

SELECT c.CategoryName
    ,SUM(c.CategoryID) AS "Number of Products in the Category"
FROM Products p
INNER JOIN Categories c
    ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY SUM(c.CategoryID) DESC;

/*1.5	List all UK employees using concatenation to join their title of courtesy, first name and last name together.
        Also include their city of residence.*/

SELECT CONCAT(e.TitleOfCourtesy, ' ', e.FirstName, ' ', e.LastName) AS "Employee Name"
    ,e.City AS "City of Residence"
FROM Employees e
WHERE e.Country = 'UK';

/*1.6	List Sales Totals for all Sales Regions (via the Territories table using 4 joins) with a Sales Total greater than 1,000,000.
        Use rounding or FORMAT to present the numbers. */

SELECT r.RegionID
    ,r.RegionDescription
    ,ROUND(SUM(od.UnitPrice*od.Quantity),2) AS "Sales Totals"
FROM Region r
INNER JOIN Territories t
    ON r.RegionID = t.RegionID
INNER JOIN EmployeeTerritories et
    ON t.TerritoryID = et.TerritoryID
INNER JOIN Orders o
    ON o.EmployeeID = et.EmployeeID
INNER JOIN [Order Details] od
    ON od.OrderID = o.OrderID
GROUP BY r.RegionID, r.RegionDescription
HAVING ROUND(SUM(od.UnitPrice*od.Quantity),2) >= 1000000

/*instructions unclear regarding value but just returning od.Quantity did not return any values higher than 1,000,000
so looked at total as price instead*/

/*1.7	Count how many Orders have a Freight amount greater than 100.00 and either USA or UK as Ship Country.*/

SELECT COUNT(o.Freight) AS "Freight Total"
    ,o.ShipCountry
FROM Orders o
WHERE (o.ShipCountry = 'USA' OR o.ShipCountry = 'UK') AND o.Freight > 100
GROUP BY o.ShipCountry

/*1.8	Write a SQL Statement to identify the Order Number of the Order with the highest amount(value) of discount applied to that order.*/

SELECT TOP 1 od.Discount 
    ,od.OrderID AS "Order Number"
    ,ROUND((od.UnitPrice * od.Quantity * (od.Discount)),2) AS "Highest Net Discount" 
FROM [Order Details] od
ORDER BY "Highest Net Discount" DESC

--Excercise 2--
/*2.1 Write the correct SQL statement to create the following table:
    Spartans Table – include details about all the Spartans on this course. Separate Title, First Name and Last Name into separate columns,
    and include University attended, course taken and mark achieved.
    Add any other columns you feel would be appropriate. 
    IMPORTANT NOTE: For data protection reasons do NOT include date of birth in this exercise.*/
IF OBJECT_ID('Sparta Table', 'U') IS NOT NULL
DROP TABLE [Sparta Table];

/*added in DROP TABLE but madeit fancy after some reseach.
'U' stands for only table names*/

CREATE TABLE [Sparta Table](
    StudentID INT IDENTITY(1,1)
    ,Title VARCHAR(12) NOT NULL
    ,FirstName VARCHAR(50) NOT NULL
    ,LastName VARCHAR(50) NOT NULL
    ,University VARCHAR(40) DEFAULT NULL
    ,Course VARCHAR(40) DEFAULT NULL
    ,Grade VARCHAR(4) DEFAULT NULL
    ,PRIMARY KEY (StudentID) );

/*2.2 Write SQL statements to add the details of the Spartans in your course to the table you have created.*/
INSERT INTO [Sparta Table](Title, FirstName, LastName, University, Course, Grade)
VALUES ('Miss', 'Georgina', 'Bartlett', 'Newcastle University', 'Archaeology', '2:1')
,('Mr', 'Humza', 'Malak', 'University of Kent', 'Computer Science', '2:2')
,('Mr', 'Ibrahim', 'Bocus', 'University of Leicester', 'Mechanical Engineering', '2:1')
,('Mr', 'Bari', 'Allali', 'Lancaster University', 'Business Economics', '2:1')
,('Mr', 'Mehdi', 'Shamaa', 'University of Nottingham', 'Philosophy and Economics', '2:2')
,('Miss', 'Anais', 'Tang', 'Edinburgh University', 'Modern Languages', '2:1')
,('Mr', 'Saheed', 'Lamina', 'University of Warwick', 'Politics and International Studies ', '2.1')
,('Mr', 'Man-Wai', 'Tse', 'University of Hertfordshire', 'Aerospace Engineering ', '2:1')
,('Mr', 'Sohaib ', 'Sohail', 'Brunel University London', 'Communications and Media Studies', '2:1')
,('Miss', 'Ugne', 'Okmanaite', 'Aston University', 'International Business & Management ', '2:1')
,('Mr', 'John', 'Byrne', 'University of Greenwich', 'Computing with Games development', NULL)
,('Mr', 'Daniel', 'Teegan', 'University of Brighton', 'Product Design', '2:2')
,('Mr ', 'Max ', 'Palmer', 'University of Birmingham', 'Ancient History', '2:1');

--TEST--
SELECT *
FROM [Sparta Table]

--Excercise 3--
/*Write SQL statements to extract the data required for the following charts (create these in Excel):*/

/*3.1 List all Employees from the Employees table and who they report to. No Excel required. (5 Marks)*/

SELECT e.EmployeeID
    ,CONCAT(e.FirstName, ' ', e.LastName) AS "Employee Name"
    ,e.ReportsTo
    ,CONCAT(e2.FirstName, ' ', e2.LastName) AS "Reports to Name"
FROM Employees e
LEFT JOIN Employees e2
ON e2.EmployeeID = e.ReportsTo;

/*Calling reports to only give an employee ID which is not clear
Numeric terminology is not explicit and therefore not very helpful
Employee 2 does not report to anyone therefore an INNER JOIN would leave him out*/

/*3.2 List all Suppliers with total sales over $10,000 in the Order Details table. Include the Company Name from the Suppliers Table and present as a bar chart*/

SELECT s.CompanyName
    ,ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)),2) AS "Total Sales"
FROM [Order Details] od
INNER JOIN Products p
ON od.ProductID = p.ProductID
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY s.CompanyName
HAVING SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) > 10000
ORDER BY 2 DESC;

/*3.3 List the Top 10 Customers YTD for the latest year in the Orders file. Based on total value of orders shipped. No Excel required.*/

SELECT TOP 10
    YEAR(o.OrderDate) AS "Year of Order"
    ,c.CompanyName AS "Company Name"
    ,ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)),2) AS "Total Sale Price"
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = 1998
GROUP BY YEAR(o.OrderDate)
    ,c.CompanyName
ORDER BY YEAR(o.OrderDate)
        ,ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)),2)  DESC

/*
This script will only work while we're in 1998 as the year is hardcoded
Using (SELECT YEAR(MAX(OrderDate)) FROM Orders) allows this field to become dynamic
*/

/*3.4 Plot the Average Ship Time by month for all data in the Orders Table using a line chart as below.*/

SELECT MONTH(o.OrderDate) AS "Order Month"
    ,YEAR(o.OrderDate) AS "Order Year"
    ,AVG(DATEDIFF(d, o.OrderDate, o.ShippedDate)*1.0) AS "Ship Days"
FROM Orders o
GROUP BY MONTH(o.OrderDate)
    ,YEAR(o.OrderDate)

/*Must include YEAR as well as MONTH as 1996, 1997 and 1998 all have July's etc*/

/*SELECT MONTH(o.OrderDate) AS "Order Month"
    ,YEAR(o.OrderDate) AS "Order Year"
    ,FORMAT(o.OrderDate,'MM-yyyy') AS "Order Month"
    ,AVG(DATEDIFF(d, o.OrderDate, o.ShippedDate)*1.0) AS "Ship Days"
FROM Orders o
GROUP BY MONTH(o.OrderDate)
    ,YEAR(o.OrderDate)
    ,FORMAT(o.OrderDate,'MM-yyyy')
ORDER BY 2,1*/