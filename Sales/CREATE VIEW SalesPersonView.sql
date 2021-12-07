CREATE VIEW SalesPersonView AS

SELECT HRE.BusinessEntityID AS SalesPersonID
	,SSP.TerritoryID
	,PP.FirstName
	,PP.LastName
	,HRE.JobTitle
	,SST.Name AS TerritoryName
	,SST.CountryRegionCode
	,SSP.SalesLastYear
	,SSP.SalesQuota
	,SSP.SalesYTD

FROM HumanResources.Employee HRE

LEFT JOIN Person.Person PP
	ON HRE.BusinessEntityID = PP.BusinessEntityID

LEFT JOIN Sales.SalesPerson SSP
	ON SSP.BusinessEntityID = HRE.BusinessEntityID

LEFT JOIN Sales.SalesTerritory SST
	ON SST.TerritoryID = SSP.TerritoryID

WHERE HRE.JobTitle = 'Sales Representative'