CREATE VIEW [dbo].[PurchasingView]
AS

SELECT ROW_NUMBER() OVER(
ORDER BY PPOH.PurchaseOrderID
) PurchasingID
,PPOH.PurchaseOrderID
,PPOD.PurchaseOrderDetailID
,PPOH.VendorID
,PPOH.EmployeeID
,PP.ProductID
,PPOH.OrderDate
,PPOH.ShipDate
,PP.NAME AS Product_Name
,PPOD.OrderQty
,PV.Name AS Vendor_Name
,PSM.Name AS Shipping_Company
,PPOH.SubTotal
FROM Purchasing.PurchaseOrderHeader AS PPOH

INNER JOIN Purchasing.PurchaseOrderDetail AS PPOD
ON PPOH.PurchaseOrderID = PPOD.PurchaseOrderID

INNER JOIN Production.Product AS PP
ON PPOD.ProductID = PP.ProductID

INNER JOIN Purchasing.Vendor AS PV
ON PPOH.VendorID = PV.BusinessEntityID

INNER JOIN Purchasing.ShipMethod AS PSM
ON PPOH.ShipMethodID = PSM.ShipMethodID
GO


