SELECT ROW_NUMBER() OVER(
	ORDER BY SOH.SalesOrderID
	) SalesID
	,SOH.SalesOrderID
	,SOD.SalesOrderDetailID
	,SOH.CustomerID
	,SOD.ProductID
	,SOH.CreditCardID
	,ISNULL(SOH.CurrencyRateID, 0) AS CurrencyRateID
	,ISNULL(SOH.SalesPersonID, 0) AS SalesPersonID
	,CI.StoreName
	,P.Name AS ProductName
	,ISNULL(SCR.ToCurrencyCode, '') AS CurrencyConversion
	,SOH.OrderDate
	,SOH.ShipDate
	,SOD.LineTotal AS FinalPrice
	,PSM.Name AS ShipMethodName
	,SSO.Description AS SpecialOfferDescription
	
	FROM Sales.SalesOrderHeader SOH

	LEFT JOIN Sales.SalesOrderDetail SOD
		ON SOD.SalesOrderID = SOH.SalesOrderID

	LEFT JOIN Sales.CurrencyRate SCR
			ON SCR.CurrencyRateID = SOH.CurrencyRateID
	
	LEFT JOIN Production.Product AS P
		ON SOD.ProductID = P.ProductID

	LEFT JOIN Sales.SpecialOffer SSO
		ON SOD.SpecialOfferID = SSO.SpecialOfferID
	
	LEFT JOIN
		(SELECT SC.CustomerID
				,SC.PersonID
				,ISNULL(SS.Name, 'No store name') AS StoreName
				,PP.FirstName AS CustomerFirstName
				,PP.LastName AS CustomerLastName

					FROM Sales.Customer SC
						LEFT JOIN Sales.Store SS
							ON SC.StoreID = SS.BusinessEntityID
						LEFT JOIN Person.Person PP
							ON PP.BusinessEntityID = SC.PersonID

					--It's actually possible to take out SOH here because the other joins in this code
					--will eliminate any entities that didn't place orders (because there's no salesorderID
					--for the isolated stores, even though the stores have CustomerIDs).
					--It's possible the join could have been done differently for creation of this view.
					--Left joins have to be used here.  Not all CustomerIDS have SalesOrderIDs! (standalone stores)
		) AS CI
		ON CI.CustomerID = SOH.CustomerID
		--The main purpose of creating CI was to confirm that the standalone
		--stores are not customers.

	LEFT JOIN Purchasing.ShipMethod PSM
		ON PSM.ShipMethodID = SOH.ShipMethodID

	LEFT JOIN Sales.SalesTerritory SST
		ON SST.TerritoryID = SOH.TerritoryID
GO


