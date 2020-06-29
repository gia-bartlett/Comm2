--A subquery is a SQL query nested inside a larger query. Acts as a column name--

/*A subquery may occur in :
- A SELECT clause
- A FROM clause
- A WHERE clause
Can be nested inside a SELECT, INSERT, UPDATE, or DELETE statement or inside another subquery.
A subquery is also called an inner query or inner select, while the statement containing a subquery is also called an outer query or outer select.
The inner query executes first before its parent query so that the results of an inner query can be passed to the outer query.

You can use a subquery in a SELECT, INSERT, DELETE, or UPDATE statement to perform the following tasks:
- Compare an expression to the result of the query.
- Determine if an expression is included in the results of the query.
- Check whether the query selects any rows.*/

--A subquery is usually added within the WHERE Clause of another SQL SELECT statement.--
SELECT c.CompanyName AS "Customer"
FROM Customers c
WHERE c.CustomerID NOT IN
    (SELECT o.CustomerID FROM Orders o);

--You can use the comparison operators, such as >, <, or =. The comparison operator can also be a multiple-row operator, such as IN, ANY, or ALL.--

SELECT od.OrderID
    ,od.ProductID
    ,od.UnitPrice
    ,od.Quantity
    ,od.Discount
FROM [Order Details] od
WHERE od.ProductID IN (SELECT p.ProductID
        FROM Products p
        WHERE p.Discontinued = '1');

--Can be used with aggregate functions--
SELECT od.OrderID
    ,od.ProductID
    ,od.UnitPrice
    ,od.Quantity
    ,od.Discount
    ,(SELECT MAX(UnitPrice) FROM [Order Details]) AS "max_price"
FROM [Order Details] od

--subquery becoming a table called sq1--
SELECT od.ProductID
    ,sq1.totalamt AS "total sold"
    ,od.UnitPrice
    ,((od.UnitPrice*od.Quantity)/sq1.totalamt)*100 AS "% of total"
FROM [Order Details] od
INNER JOIN
(SELECT ProductID
    ,SUM(o.UnitPrice*o.Quantity) AS "totalamt"
FROM [Order Details] o
GROUP BY o.ProductID) sq1 ON sq1.ProductID=od.ProductID



