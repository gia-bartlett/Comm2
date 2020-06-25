--set a status for orders if the days between shipped and ordered is less than 10 then they are on time, anything else then they are overdue.  Call the column Status--

SELECT CASE
WHEN DATEDIFF(d, o.OrderDate, o.ShippedDate) < 10 THEN 'On Time'
ELSE 'Overdue'
END AS "Status"
FROM Orders o;

--CASE statements can be used when you need varying results output based on differing data--
--Single quotes for data and doubel quotes for column names--


--
