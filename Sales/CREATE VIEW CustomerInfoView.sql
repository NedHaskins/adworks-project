CREATE VIEW CustomerInfoView AS

SELECT DISTINCT

--ROW_NUMBER() OVER(
	--ORDER BY SOH.SalesOrderID
	--) SalesID
	
	

	SOH.CustomerID
	,CI.PersonID
	,BA.BillToAddressID
	,BA.StateProvinceID AS BillingProvinceID
	,SA.ShipToAddressID
	,SA.StateProvinceID AS ShippingProvinceID
	,SOH.TerritoryID

	,BA.AddressLine1 AS BillingAddressLine1
	,ISNULL(BA.AddressLine2, 'No value') AS BillingAddressLine2
	,BA.City AS BillingCity
	,BA.BillingProvinceName
	,BA.BillingCountryName
	,BA.PostalCode AS BillingPostalCode

	,SA.AddressLine1 AS ShippingAddressLine1
	,ISNULL(SA.AddressLine2, 'No value') AS ShippingAddressLine2
	,SA.City AS ShippingCity
	,SA.ShippingProvinceName
	,SA.ShippingCountryName
	,SA.PostalCode AS ShippingPostalCode
	,SST.Name AS TerritoryName
	,CI.CustomerFirstName
	,CI.CustomerLastName
	
	FROM Sales.SalesOrderHeader SOH

	LEFT JOIN Sales.SalesOrderDetail SOD
		ON SOD.SalesOrderID = SOH.SalesOrderID
	
	LEFT JOIN

		(SELECT SOH.SalesOrderID
			,SOH.BillToAddressID
			,PA.StateProvinceID
			,CR.CountryRegionCode
			,PA.AddressLine1
			,PA.AddressLine2
			,PA.City
			,SP.Name AS BillingProvinceName
			,CR.Name AS BillingCountryName
			,PA.PostalCode
			FROM Sales.SalesOrderHeader SOH

			INNER JOIN Person.BusinessEntityAddress BEA
					ON SOH.BillToAddressID = BEA.AddressID
			INNER JOIN Person.Address PA
					ON BEA.AddressID = PA.AddressID
			INNER JOIN Person.StateProvince SP
				ON SP.StateProvinceID = PA.StateProvinceID
			INNER JOIN Person.CountryRegion CR
				ON CR.CountryRegionCode = SP.CountryRegionCode

		) AS BA
		ON	BA.SalesOrderID = SOH.SalesOrderID
				
	
	LEFT JOIN

		(SELECT SOH.SalesOrderID
			,SOH.ShipToAddressID
			,PA.StateProvinceID
			,CR.CountryRegionCode
			,PA.AddressLine1
			,PA.AddressLine2
			,PA.City
			,SP.Name AS ShippingProvinceName
			,CR.Name AS ShippingCountryName
			,PA.PostalCode
			FROM Sales.SalesOrderHeader SOH

			INNER JOIN Person.BusinessEntityAddress BEA
					ON SOH.ShipToAddressID = BEA.AddressID
			INNER JOIN Person.Address PA
					ON BEA.AddressID = PA.AddressID
			INNER JOIN Person.StateProvince SP
				ON SP.StateProvinceID = PA.StateProvinceID
			INNER JOIN Person.CountryRegion CR
				ON CR.CountryRegionCode = SP.CountryRegionCode

		) AS SA
		ON	SA.SalesOrderID = SOH.SalesOrderID
	
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

	LEFT JOIN Sales.SalesTerritory SST
		ON SST.TerritoryID = SOH.TerritoryID

