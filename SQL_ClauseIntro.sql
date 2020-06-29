/*Covers:
-DISTINCT
-WHERE
-AND/OR
-IN/NOT IN
-BETWEEN
-WILDCARDS (LIKE)
-ORDER BY
-GROUP BY
-HAVING
-ALIASING
*/

--DISTINCT--
--removes duplicates, only unique values--
SELECT DISTINCT Country FROM Customers
WHERE ContactTitle ='Owner';

SELECT DISTINCT c.country
FROM customers c;


--WHERE--
--to filter the data--
SELECT * FROM Customers
WHERE City = 'Paris';

SELECT COUNT(*) AS 'NumEmployeesInLondon' FROM Employees
WHERE City='London';

SELECT COUNT(*) AS 'NumEmployeesWithTitleDoctor' FROM Employees
WHERE TitleOfCourtesy='Dr.'

SELECT * FROM Employees;

SELECT COUNT(*) FROM Products
WHERE Discontinued != 0;

SELECT * FROM products
WHERE Discontinued != 0;

SELECT COUNT(*) FROM Customers WHERE Country='France';


--AND/OR--
/*AND all the criteria need to be fulfilled
OR - either of the criteria need to be fulfilled
column name MUST be repeated for each criteria even if both are the same (WHERE <column_1>=<criterion1> AND <column_1>=<criterion2>;)*/

SELECT p.ProductName, p.UnitPrice 
FROM Products p
WHERE CategoryID=1 AND Discontinued=0;


--IN/NOT IN--
/*The IN operator allows you to specify multiple values in a WHERE clause.
The IN operator is a shorthand for multiple OR conditions.
IN allows multiple results on subquery, = will generate error if you have more than one result on the subquery*/

--If we want to find customers in two specific named regions--
SELECT * 
FROM Customers
WHERE Region IN ('WA','SP');

--Without IN statement using OR operator--
SELECT * 
FROM Customers
WHERE Region = 'WA'OR Region ='SP';

--Find Region WA or SP, AND Brazil. Place query in brackets to avoid complications and make it explicit for SQL to process the correct query--
SELECT * 
FROM Customers
WHERE (Region = 'WA'OR Region ='SP')
AND country ='Brazil'; --Should only return customers from Brazil where region is WA or SP--

--NOT IN--
SELECT e.TitleOfCourtesy
    ,e.FirstName
    ,e.LastName
FROM Employees e
WHERE e.TitleOfCourtesy NOT IN ('Ms.','Mrs.');


--BETWEEN--
-- includes values between and as well as the boundary values--
SELECT * 
FROM EmployeeTerritories
WHERE TerritoryID BETWEEN 06800 AND 09999;


--WILDCARDS--

/*Wildcards can be used as a substitute for any other characters in a string when using the LIKE operator
% = any character (any amount)
_ = substitutes a single character
^ = NOT
LIKE = used with % and _ to search for specific pattern
*/

--Begins with U but followed by any characters--
SELECT DISTINCT c.country
FROM customers c WHERE country LiKE 'U%';

--Begins with BR but followed by any characters--
SELECT DISTINCT c.country
FROM customers c WHERE country LIKE 'BR%';

--Ends with A but begins with any characters--
SELECT DISTINCT c.country
FROM customers c WHERE country LIKE '%A';

--Countries starting with U, ending with letter 'A' with any characters in between--
SELECT DISTINCT c.country
FROM customers c WHERE country LIKE 'U%A';

--Products that begin with Ch--
SELECT p.ProductName AS 'ProductName'
FROM Products p 
WHERE ProductName LIKE 'Ch%';

--Countries either starting with U or A in descending order--
SELECT DISTINCT c.country
FROM customers c WHERE country LIKE '[UA]%'
ORDER BY c.country DESC;

--Countries whose 3rd letter is A--
SELECT DISTINCT c.Country
FROM customers c 
WHERE country LIKE '__A%';

--Select all columns from customer table where regions only contain two characters, end in A or where the second letter is A--
SELECT * 
FROM Customers
WHERE Region LIKE '_A';

--Countries NOT starting with U or A or M--
SELECT DISTINCT c.country
FROM customers c WHERE country LIKE '[^UAM]%';

--Countries NOT ending with A or E but begins with any characters--
SELECT DISTINCT c.country
FROM customers c WHERE country LIKE '%[^AE]';

--Countries with second letter A but ends with any characters--
SELECT * 
FROM Customers
WHERE Country LIKE '_A%';

--ORDER BY--
--sort results ASC is default--

--select all employees but order results by title--
SELECT *
FROM Employees
ORDER BY Title;

--select all employees but order results by title in reverse alphabetical order--
SELECT *
FROM Employees
ORDER BY Title DESC;

--select all employees but order results by title in alphabetical order and last name in alphbetical order--
SELECT *
FROM Employees
ORDER BY Title, LastName;

/*Use ORDER BY to identify the highest Net Total in the Order Details table
What are the two order numbers with the highest total?*/

SELECT TOP 2
OrderID,
Unitprice AS 'UnitPrice',
Quantity,
Discount,
ROUND((UnitPrice * Quantity * (1.00- Discount)),2) AS 'NetTotal'
FROM [Order Details]
ORDER BY 'NetTotal' DESC;


--GROUP BY--
--follows the FROM--

SELECT ShipCountry
    ,SUM(Freight) AS "TotalFreight"
FROM Orders
GROUP BY ShipCountry;

--Use GROUP BY to calculate the AVERAGE reorder level for all products by category ID--
SELECT p.CategoryID, AVG(p.ReorderLevel)
FROM Products p
GROUP BY p.CategoryID;


--HAVING--
/*Used instead of WHERE when filtering aggregates
Used AFTER GROUP BY
WHERE will filter the initial set of data
HAVING will filter after you've grouped everything*/

--I only want to see suppliers who have an average of 5 or more orders. Can't use the WHERE clause here so must use HAVING--
SELECT SupplierID,
SUM(UnitsOnOrder) AS "total_on_order",
AVG(UnitsOnOrder) AS "average_on_order"
FROM Products
GROUP BY SupplierID
HAVING AVG(UnitsOnOrder) > 5;


--ALIASING--
/*Using table Alias. MUST use AS for columuns.  Do the table alias after FROM first then you can use it to easily identify columns in that table
You must alias new columns - ones you create using aggregates or concats*/

--single letter for table--
SELECT c.CompanyName, c.City, c.Country, c.Region
FROM Customers c
WHERE c.Region='BC';

--AS for columns--
SELECT o.ShipCountry
    ,SUM(o.Freight) AS "TotalFreightbyCountry"
FROM Orders o
GROUP BY o.ShipCountry;




/*Using Operators
Where units in stock are greater than 0 AND greater than 29.99*/
SELECT p.ProductName, p.UnitPrice
FROM Products p
WHERE UnitsInStock > 0 AND UnitPrice > 29.99;

--What are names and product IDs of the products with a unit price below 5.00--

SELECT * FROM Products

SELECT p.ProductName, p.productID, p.UnitPrice
FROM Products p
WHERE UnitPrice < 5.00;


--Which categories have a category name with initials beginning with B or S--
SELECT * FROM Categories;

--Option 1--
SELECT c.CategoryName, c.DESCRIPTION
FROM Categories c
WHERE c.CategoryName LIKE 'B%' OR c.CategoryName LIKE 'S%';

--Option 2-
SELECT c.CategoryName, c.DESCRIPTION
FROM categories c
WHERE c.CategoryName LIKE '[BS]%';



SELECT o.orderID, o.EmployeeID
FROM orders o 
WHERE EmployeeID IN (5, 7);

--Restricted--
--Apostrophe--
'O''''Brien'


--TOP and LIMIT--
--TOP comes immediately after the SELECT. LIMIT after the selection--
SELECT TOP 10 CompanyName, City FROM Customers
WHERE Country = 'France';


/*Using Operators
Where units in stock are greater than 0 AND greater than 29.99*/
SELECT p.ProductName, p.UnitPrice
FROM Products p
WHERE UnitsInStock > 0 AND UnitPrice > 29.99;

--CONCATENATION--

--'City' select city and country in one column using concat operator +--
--Option 1--
SELECT c.companyName AS 'CompanyName', c.city + ', ' + ' '+  Country As 'City'
FROM Customers c;

--Option 2--
SELECT c.CompanyName AS 'CompanyName',
CONCAT(c.city, ', ',c.country) AS City
FROM Customers c;

/*Write a select using the Employees table and concat First Name and Last Name together. Use column alias to rename the column to Employee Name*/
SELECT * FROM Employees;

SELECT e.EmployeeID as 'EmployeeID', CONCAT(e.FirstName,' ', e.LastName) AS 'EmployeeName'
FROM Employees e;  -- Should return First Name and Last Name in the same columm called Employee Name

/*IS NULL*/
SELECT c.CompanyName AS 'CompanyName', CONCAT(c.City, ' ', c.Country) AS 'City', c.Region
FROM Customers c
WHERE Region IS NULL;

--IS NOT NULL--
SELECT c.CompanyName AS 'CompanyName', CONCAT(c.City, ' ', c.Country) AS 'City', c.Region
FROM Customers c
WHERE Region IS NOT NULL;

/*Write a SELECT statement to list the six countries that have Region Codes in the Customers Table*/
SELECT * FROM Customers;

SELECT TOP 6 c.Country, c.Region
FROM Customers c
WHERE Region IS NOT NULL;

--ARITHMETIC OPERATORS--
SELECT UnitPrice, Quantity, Discount, UnitPrice * Quantity AS 'GrossTotal'
FROM [Order Details];

SELECT * FROM [Order Details];

/*Apples--> Price--> 2 Pounds, quantity=10, Discount -25% = (2*10)*0.75
Gross Total(The cost apple excluding the discount) = £20
Net Total (The amount I pay the shopkeeper) = £15*/

--Add a new column to the SQL below to show the 'Net Total' which has the discount column applied to it.--
SELECT 
UnitPrice,
Quantity, 
Discount, 
UnitPrice * Quantity AS 'GrossTotal', 
ROUND((UnitPrice * Quantity * (1.00-Discount)),2) AS 'NetTotal'
FROM [Order Details]
ORDER BY 'GrossTotal' DESC;

--CHARINDEX PRACTICE--
USE Northwind

SELECT PostalCode 'Postcode', 
LEFT(PostalCode, CHARINDEX(' ', PostalCode)-1) AS 'PostcodeRegion',
    CHARINDEX(' ',PostalCode) AS 'SpaceFound', 
Country
FROM Customers 
WHERE country ='UK';

/*Without -1 it will give index 4 
-1 will extract the post code region that reaches the first space then eliminate the white space*/

/*Use CHARINDEX to list only Product Names that contain a single quote*/
/*Note:Column Alias cannot be used in a WHERE*/
/*For single quote use two single quotes to 'escape' it*/

SELECT * FROM  Products;

SELECT p.ProductName "Product Names",
CHARINDEX('''', p.ProductName) AS "Index of Quote"
FROM Products p
WHERE CHARINDEX('''', p.productName) > 0;


--SELECT * FROM TableName WHERE CHARINDEX('''',ColumnName) > 0--

/*Option 2 with LIKE*/
SELECT p.ProductName 
FROM Products p
WHERE p.productName LIKE '%''%';
--Finds single quotes--
