--SUM--
--for the total of a column for all rows selected--


--AVG--
--for the average of a column for all rows selected--

--MIN--
--for the minimus value of a column for all rows selected--

--MAX--
--for the maximium of a column for all rows selected--

--COUNT--
--for the number of NOT NULL rows selected. If * is used then ALL rows are counted--

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

--Use GROUP BY to calculate the AVERAGE reorder level for all products by category ID--
SELECT p.CategoryID, AVG(p.ReorderLevel)
FROM Products p
GROUP BY p.CategoryID;

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

--I only want to see suppliers who have an average of 5 or more orders. Can't use the WHERE clause here so must use HAVING--
SELECT SupplierID,
SUM(UnitsOnOrder) AS "total_on_order",
AVG(UnitsOnOrder) AS "average_on_order"
FROM Products
GROUP BY SupplierID
HAVING AVG(UnitsOnOrder) > 5;


