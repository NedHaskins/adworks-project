INSERT INTO SalesFact

SELECT SV.SalesID
	,SV.CustomerID
	,SV.ProductID
	,CV.BillToAddressID
	,CV.ShipToAddressID
	,SV.SalesPersonID
	,SV.FinalPrice

	FROM dbo.SalesView SV

	LEFT JOIN CustomerInfoView CV
		ON CV.CustomerID = SV.CustomerID