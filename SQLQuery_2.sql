USE Northwind;

--count number of employees in each country and group results by country--

SELECT COUNT(EmployeeID), Country FROM Employees
GROUP BY
    Country;

SELECT EmployeeID
FROM Employees;

SELECT COUNT(EmployeeID), Country
FROM Employees
GROUP BY Country
HAVING COUNT(EmployeeID) > 5;