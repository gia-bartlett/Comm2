/*AGREGATE FUNCTIONS:
Must give them a column name (AS "<column_name>") other a new column is created with no name
-Discount:
Apples--> Price--> £2, quantity=10, Discount -25% = (2*10)*0.75
Gross Total(The cost apple excluding the discount) = £20
Net Total (The amount I pay the shopkeeper) = £15

100% =1*price
Discount of 20% =0.2*price
Price after discount = (1-Discount)*price

-SUM:
for the total of a column for all rows selected

-AVG:
for the average of a column for all rows selected
Does NOT include NULL values

-MIN:
for the minimus value of a column for all rows selected

-MAX:
for the maximium of a column for all rows selected

-COUNT:
<column_name> for the number of NOT NULL rows selected. If * is used then ALL rows are counted.

-ROUND:
rounds a number to a specified number of decimal places
*/



--SUM--

SELECT SUM(Freight) AS "TotalFreightFromGermany"
FROM Orders
WHERE ShipCountry = 'Germany';


SELECT SUM(p.UnitsOnOrder) AS "total_order"
,AVG(p.UnitsOnOrder) AS "average_on_order"
,MIN(p.UnitsOnOrder) AS "min_on_order"
,MAX(p.UnitsOnOrder) AS "max_on_order"
FROM Products p

/*Doesn't make much sense. BUT if we group by the Supplier ID it will allow each calculation to be grouped by their invididual supplier.
SELECT clause must match the GROUP BY clause apart from any aggregates*/

SELECT p.SupplierID, SUM(p.UnitsOnOrder) AS "total_order"
,AVG(p.UnitsOnOrder) AS "average_on_order"
,MIN(p.UnitsOnOrder) AS "min_on_order"
,MAX(p.UnitsOnOrder) AS "max_on_order"
FROM Products p
GROUP BY p.SupplierID;

--AVG--
SELECT AVG(Quantity) AS "AverageQuantity"
FROM [Order Details];


--What was the highest reorder level?--
SELECT p.CategoryID, AVG(p.ReorderLevel)
FROM Products p
GROUP BY p.CategoryID
ORDER BY AVG(p.ReorderLevel) DESC;

--What was the highest reorder level? This time using column alias--
SELECT p.CategoryID, AVG(p.ReorderLevel) AS "average_reorder"
FROM Products p
GROUP BY p.CategoryID
ORDER BY "average_reorder" DESC;

--
SELECT SupplierID,
SUM(UnitsOnOrder) AS "total_on_order",
AVG(UnitsOnOrder) AS "average_on_order"
FROM Products
GROUP BY SupplierID


--MIN/MAX--
Select MIN(Quantity) AS "Minimum"
    ,MAX(Quantity) AS "Maximum"
FROM [Order Details];

SELECT MAX(Freight) AS "MaxFreight"
FROM Orders
WHERE ShipCountry = 'France';

SELECT MIN(Freight) AS "MinFreight"
FROM Orders
WHERE ShipCountry = 'Germany';

SELECT *
FROM Orders

--COUNT--
--How many individaul roles are there in the organisation--
SELECT COUNT(DISTINCT Title) AS "NumberOfRoles"
FROM Employees;

--How many orders are there for EmployeeIDs 5 and 7(Total for both)--
SELECT * FROM Orders;

SELECT o.EmployeeID 
    ,COUNT(*) AS 'NumOrdersByEmployeesWithEmployeeID5or7' 
FROM Orders o
WHERE EmployeeID IN (5, 7)
GROUP BY o.EmployeeId;


--ROUND--

SELECT AVG(UnitPrice) AS "AveragePrice"
FROM [Order Details];

SELECT ROUND(AVG(UnitPrice),2) AS "AveragePriceRounded"
FROM [Order Details];


/*Use ORDER BY to identify the highest Net Total in the Order Details table
What are the two order numbers with the highest total?*/

SELECT TOP 2
OrderID,
Unitprice AS 'UnitPrice',
Quantity,
Discount,
ROUND((UnitPrice * Quantity * (1.00-Discount)),2) AS 'NetTotal'
FROM [Order Details]
ORDER BY 'NetTotal' DESC;


--Add a new column to the SQL below to show the 'Net Total' which has the discount column applied to it.--
SELECT 
UnitPrice,
Quantity, 
Discount, 
UnitPrice * Quantity AS 'GrossTotal', 
ROUND((UnitPrice * Quantity * (1.00-Discount)),2) AS 'NetTotal'
FROM [Order Details]
ORDER BY 'GrossTotal' DESC;





