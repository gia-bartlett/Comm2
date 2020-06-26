/*1. Create a report showing the title of courtesy and the first and last name
of all employees whose title of courtesy is not "Ms." or "Mrs.".*/

SELECT e.TitleOfCourtesy
    ,e.FirstName
    ,e.LastName
FROM Employees e
WHERE e.TitleOfCourtesy NOT IN ('Ms.','Mrs.');

--correct but has issue to in with using != OR--

/*2. Create a report that shows the company name, contact title, city and country of all customers 
in Mexico or in any city in Spain except Madrid(in Spain).*/

SELECT c.CompanyName
    ,c.ContactTitle
    ,c.City
    ,c.Country
FROM Customers c
WHERE c.Country IN ('Mexico','Spain') AND c.City NOT IN ('Madrid');

--correct except I first spelled Mexico wrong!--

/*3. Create a report showing the title of courtesy and the first and
last name of all employees whose title of courtesy begins with "M" and
is followed by any character and a period (.).*/

SELECT e.TitleOfCourtesy
    ,e.FirstName
    ,e.LastName
FROM Employees e
WHERE e.TitleOfCourtesy LIKE 'M_.';

--correct - no issues but didn't use brackets around the LIKE argument?--

/*4. Create a report showing the first and last names of
all employees whose region is defined.*/

SELECT e.FirstName
    ,e.LastName
FROM Employees e
WHERE e.Region IS NOT NULL;

--correct - no issues--

/*5. Select the Title, FirstName and LastName columns from the Employees table.
Sort first by Title in ascending order and then by LastName 
in descending order.*/

SELECT e.Title
    ,e.FirstName
    ,LastName
FROM Employees e
ORDER BY e.Title, e.LastName DESC;

--correct - but used Title instead of Title of Courtesy which is in answer because that's what the question is asking?--

/*6. Write a query to get the number of employees with the same job title.*/

SELECT e.Title
    ,COUNT(e.EmployeeID) AS "Number of Employees"
FROM Employees e
GROUP BY e.Title;

--used title in distinct first but only returned 1s and after selecting all I could see more than 1 rep so tried EmployeeID)



/*7.
Create a report showing the Order ID, the name of the company that placed the order,
and the first and last name of the associated employee.
Only show orders placed after January 1, 1998 that shipped after they were required.
Sort by Company Name.
*/

SELECT o.OrderID
    ,c.CompanyName
    ,e.FirstName
    ,e.LastName
FROM Employees e
INNER JOIN Orders o
ON e.EmployeeID = o.EmployeeID
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE o.ShippedDate > o.RequiredDate AND o.OrderDate > '1998-01-01'
ORDER BY c.CompanyName;

/*correct but took a while and forgot to ORDER BY company name.
Guessed using LEFT JOIN - need more practice to get more familiar with which one to use.
Getting better working out joins with the ERD
Took a while to reread the question to get the dates organised
USE INNER JOIN*/


/*8.
Create a report that shows the total quantity per product (from the OrderDetails table) ordered. Only show records for products for which the quantity ordered is fewer than 200. 
The report should return*/

SELECT p.ProductName
    ,SUM(od.Quantity) AS "total_products_ordered"
FROM [Order Details] od
INNER JOIN Products p
ON od.ProductID = p.ProductID
GROUP BY p.ProductName
HAVING SUM(od.Quantity) < 200;

/*Tried to ORDER BY instead of GROUP BY.
Still guessing which join to use - again went left to right using left join
Checked answer and missed out grouping by ProductID but got a similar answer so not sure what the relevance was?*/

/*9.Create a report that shows the total number of orders by Customer since December 31, 1996. The report should only return rows for which the NumOrders is greater than 15. 
*/

SELECT c.CustomerID
    ,COUNT(o.OrderID) AS "NumOrders"
FROM Customers c
INNER JOIN Orders o
ON c.customerID = o.CustomerID
WHERE o.OrderDate >= '1996-12-31'
GROUP BY c.CustomerID
HAVING COUNT(o.OrderID) > 15
ORDER BY "NumOrders" DESC;

/*Used a right join as was working right to left from ERD
Did not initially ORDER BY but still got correct answer - tidied it up with checking*/

/*10.  SQL statement will return all customers, and number of orders they might have placed. 
Include those customers as well who have not placed any orders.*/

SELECT c.CustomerID
    ,COUNT(o.OrderID) AS "all_orders"
FROM Customers c
LEFT JOIN Orders o
ON c.customerID = o.CustomerID
GROUP BY c.CustomerID;

/*correct but slightly different from answer page
did a LEFT JOIN to ensure I included any NULL values
included order by*/