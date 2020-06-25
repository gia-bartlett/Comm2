--JOINS--
/*Combine matched rows from two or more tables.
Create a list of combined rows of matching data from different tables
There must be a PRIMARY KEY/FOREIGN KEY relationship between the tables ON which to join them
Left to right alignment unless certain columns selected in which case they will apear in order written
Use ERD diagram to traverse between tables and see ways to join them*/

--INNER JOIN--
--simple join - all matching rows are returned--

SELECT o.OrderID
    ,c.ContactName
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
ORDER BY c.ContactName;

--OUTER JOIN / FULL JOIN--
--everything is included - both tables AND all matching results--
SELECT c.ContactName
    ,o.OrderDate
    ,c.City
    ,o.RequiredDate
    ,o.ShipAddress
FROM Customers c
FULL OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
ORDER BY c.ContactName;

--LEFT JOIN (LEFT OUTER JOIN)--
--all from left table and all matching right--
SELECT c.ContactName
    ,o.OrderID
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

--RIGHT JOIN (RIGHT OUTER JOIN)--
--all matching from left and all from right table--
SELECT o.OrderID
    ,e.LastName
    ,e.FirstName
FROM Orders o
RIGHT JOIN Employees e
ON o.EmployeeID = e.EmployeeID;


--INNER JOIN v OUTER JOIN--
--INNER--
SELECT c.customerID, c.contactName, o.employeeID, o.ShipCity
FROM orders o 
INNER JOIN customers c
ON c.customerID = o.CustomerID
ORDER BY EmployeeID;

--OUTER--
SELECT c.customerID, c.contactName, o.employeeID, o.ShipCity
FROM orders o 
FULL OUTER JOIN customers c
ON c.customerID = o.CustomerID
ORDER BY EmployeeID;

--SELF JOIN / UNARY RELATIONSHIP--
/*Join a table with itself*/

SELECT o.customerID, o.employeeID, b.ShipCity, b.CustomerID
FROM orders o, orders b
WHERE o.customerID = b.CustomerID;
 

-- Select rows from a Ta
SELECT *
FROM Orders o, Orders b
WHERE o.CustomerID = b.CustomerID;

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
include company name as customer name and first/last name as employee name*
from the orders table include orderID, order date and freight*/

SELECT o.OrderID
    ,o.Freight
    ,c.CompanyName AS "Customer Name"
    ,CONCAT(e.FirstName, ' ', e.LastName) AS "Employee Name"
FROM Employees e
INNER JOIN Orders o
ON o.EmployeeID = e.EmployeeID
INNER JOIN Customers c
ON c.CustomerID = o.CustomerID;
