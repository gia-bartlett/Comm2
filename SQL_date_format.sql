SELECT o.OrderID
    ,CONVERT(varchar(10), o.OrderDate, 103) AS [dd/MM/yyyy]
FROM Orders o; /*Before 2012*/

SELECT o.OrderID
    ,FORMAT(o.OrderDate, 'dd/MM/yyyy')
FROM Orders o; /*After 2012*/