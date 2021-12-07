INSERT INTO PurchasingFact

SELECT DP.PurchasingID
	,VIV.VendorID
	,DP.ProductID
	,BIV.EmployeeID
	,DP.SubTotal
	,SUM(SubTotal) OVER(PARTITION BY DP.PurchaseOrderID) AS PurchaseOrderTotal

	FROM DimPurchasing DP

	INNER JOIN VendorInfoView VIV
		ON VIV.BusinessEntityID = DP.VendorID

	INNER JOIN BuyerInfoView BIV
		ON BIV.EmployeeID = DP.EmployeeID