SELECT TOP (1000) [CustomerID]
      ,[CompanyName]
      ,CHARINDEX(' ',[ContactName]) AS Location_of_space -- This will return the number of the whole string up until and including the gap
      ,LEFT([ContactName],CHARINDEX(' ',[ContactName])) AS Trimmed -- This will give you what you want but with the space, which you dont want
      ,LEFT([ContactName],CHARINDEX(' ',[ContactName])-1) AS Trimmed -- This will give you what you want without the space
      ,[ContactName]  
      ,[ContactTitle]
      ,[Address]
      ,[City]
      ,[Region]
      ,[PostalCode]
      ,[Country]
      ,[Phone]
      ,[Fax]
  FROM [Northwind].[dbo].[Customers]