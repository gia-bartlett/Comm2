SELECT PostalCode AS "Post Code",
LEFT(PostalCode, (CHARINDEX(' ',PostalCode))-1) AS "Post Code Region",
        CHARINDEX(' ',PostalCode) AS "Space Found", Country
FROM Customers
WHERE Country = 'UK';

SELECT p.ProductName,
CHARINDEX('''', p.ProductName) AS "Index of Quote"
FROM Products AS "p"
WHERE CHARINDEX('''', p.ProductName) > 0;

SELECT ProductName
FROM Products;