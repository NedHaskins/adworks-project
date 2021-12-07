CREATE TABLE [SalesFact](
	[SalesID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[BillToAddressID] [int] NOT NULL,
	[ShipToAddressID] [int] NOT NULL,
	[SalesPersonID] [int] NOT NULL,
	[FinalPrice] [numeric](38, 6) NULL
)


