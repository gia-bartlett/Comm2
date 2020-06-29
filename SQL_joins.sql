--JOINS--
/*Combine matched rows from two or more tables.
Create a list of combined rows of matching data from different tables
There must be a PRIMARY KEY/FOREIGN KEY relationship between the tables ON which to join them
Left to right alignment unless certain columns selected in which case they will apear in order written
Use ERD diagram to traverse between tables and see ways to join them
You can put the columns in the order you want them to appear in the SELECT*/

/*
-INNER:
Only selects matching records from both tables
-LEFT:
Joins ALL in LEFT table to matching records from RIGHT
-RIGHT:
Joins ALL in RIGHT table to matching records from LEFT
-FULL OUTER:
Joins EVERYTHING - will place NULLs in each side where there isn't a matching value
*/

--UNION/UNION ALL--

--INNER JOIN (830 rows)--
--simple join - all matching rows are returned--

SELECT *
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
ORDER BY c.ContactName;

--LEFT JOIN (LEFT OUTER JOIN) (832 rows)--
--all from left table and all matching right--
SELECT *
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

--RIGHT JOIN (RIGHT OUTER JOIN) (830 rows)--
--all matching from left and all from right table--
SELECT *
FROM Orders o
RIGHT JOIN Employees e
ON o.EmployeeID = e.EmployeeID;

--OUTER JOIN / FULL OUTER JOIN (832 rows)--
--everything is included - both tables AND all matching results (there will be NULLs on both sides where there weren't matching values)--
SELECT *
FROM Customers c
FULL OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
ORDER BY c.ContactName;

--INNER JOIN v OUTER JOIN--
--INNER (830 rows)--
SELECT *
FROM orders o 
INNER JOIN customers c
ON c.customerID = o.CustomerID
ORDER BY EmployeeID;

--OUTER (832 rows)--
--2 people who are contacts have not had orders placed--
SELECT *
FROM orders o 
FULL OUTER JOIN customers c
ON c.customerID = o.CustomerID
ORDER BY EmployeeID;

--SELF JOIN / UNARY RELATIONSHIP--
/*Join a table with itself*/

SELECT o.customerID, o.employeeID, b.ShipCity, b.CustomerID
FROM orders o, orders b
WHERE o.customerID = b.CustomerID;
 

--CROSS JOIN / CARTESIAN PRODUCT--
/*paired combination of each row of the first table with each row of the second table
number of rows in theoutput is the number of rows in table 1 multiplied by number of rows in table 2*/
SELECT *
FROM Orders o
CROSS JOIN customers c;


--further examples--
--joining more than one table--
SELECT e.EmployeeID
    ,e.FirstName
    ,o.OrderID
    ,et.TerritoryID
FROM Orders o
INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID
INNER JOIN EmployeeTerritories et
ON et.EmployeeID = e.EmployeeID;


SELECT AVG(p.UnitsOnOrder) AS "avg_orders"
    ,s.CompanyName AS "Supplier Name"
FROM Products p
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierID
    ,s.CompanyName
ORDER BY "avg_orders" DESC;

/*list orders from orders table and join to the customers and employees table.
include company name as customer name and first/last name as employee name
from the orders table include orderID, order date and freight*/

SELECT o.OrderID
    ,o.Freight
    ,o.OrderDate
    ,c.CompanyName AS "Customer Name"
    ,CONCAT(e.FirstName, ' ', e.LastName) AS "Employee Name"
FROM Employees e
INNER JOIN Orders o
ON o.EmployeeID = e.EmployeeID
INNER JOIN Customers c
ON c.CustomerID = o.CustomerID;

/*
You started with employees, not order -why? Because it was the leftmost table on the ERD
INNER will exclude anything which does not have a match in BOTH tables
The real world has bad data in it, good practice is to start with the table you want everything from
LEFT join means that you keep everything in the FROM table
So if you want to ensure that we capture ALL orders (even ones which people may have forgotten to include an employee in)
This does happen in the real world - lots of NULLs sadly is normal!
Start with the table you want to know EVERYTHING about (Orders) ie give me ALL orders (not just orders which are declared properly)
Then LEFT join the additional tables
INNER works only when you want fields which match in both tables
What if someone forgets to enter an employee? This will slip through the cracks with an INNER but not with a LEFT
*/

SELECT o.OrderID
    ,o.Freight
    ,o.OrderDate
    ,c.CompanyName AS "Customer Name"
    ,CONCAT(e.FirstName, ' ', e.LastName) AS "Employee Name"
FROM Orders o
LEFT JOIN Employees e
ON o.EmployeeID = e.EmployeeID
LEFT JOIN Customers c
ON c.CustomerID = o.CustomerID;

/*
In all likelihood this will give EXACTLY the same results in your set
However you are probably dealing with a dataset which is designed perfectly
In the real world be VERY wary of missing data when using INNER joins over left joins!!
An INNER join serves as a filter - if the data does NOT exist in the joined table, you will lose it!
*/

/*We're looking for all the customer IDs from the from the customer table which are not there in the Orders table:
there will be no NULLs in the customer table but some customers might not have made orders so might not exist in the orders table.*/

--using a subquery to narrow down our result--
SELECT c.CompanyName AS "Customer"
FROM Customers c
WHERE c.CustomerID NOT IN
    (SELECT o.CustomerID FROM Orders o);

--We can do this with a FULL JOIN--
SELECT c.CompanyName
FROM Customers c
FULL OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

--we can also do this with a LEFT JOIN because we want all records from the customer table and are bringing in info from the right--
SELECT c.CompanyName
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

--this won't work because
SELECT c.CompanyName
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;

--further examples--
SELECT od.OrderID
    ,od.ProductID
    ,od.UnitPrice
    ,od.Quantity
    ,od.Discount
FROM [Order Details] od
INNER JOIN  Products p
    ON od.ProductID=p.ProductID
        WHERE p.Discontinued = 1;


--UNION and UNION ALL--

--UNION--
/*combine data from multiple tables into one result leaving out duplicates*/
SELECT e.EmployeeID AS "Employee/Supplier"
FROM Employees e
UNION
SELECT s.SupplierID
FROM Suppliers s --29 rows returned--

--UNION ALL--
/*combine data from multiple tables into one result even if there are duplicates*/

SELECT e.EmployeeID AS "Employee/Supplier"
FROM Employees e
UNION ALL
SELECT s.SupplierID
FROM Suppliers s --38 rows--

