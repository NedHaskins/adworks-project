INSERT INTO SalesPerformanceFact

SELECT SPV.BusinessEntityID AS SalesPersonID
	,SST.TerritoryID
	,ISNULL(SPV.SalesQuota, 0) AS SalesQuota
	,SPV.SalesYTD
	,SPV.SalesLastYear
	,ISNULL(
		(SPV.SalesYTD / NULLIF(SPV.SalesLastYear, 0)-1)*100
		
		,0) AS PercentChange

FROM SalesPersonView SPV

LEFT JOIN Sales.SalesTerritory SST
	ON SPV.TerritoryID = SST.TerritoryID