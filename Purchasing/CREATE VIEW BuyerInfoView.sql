CREATE VIEW BuyerInfoView AS

select DISTINCT POH.EmployeeID
	,PP.FirstName
	,PP.LastName
	,HRE.JobTitle
	,PEMA.EmailAddress

FROM Purchasing.PurchaseOrderHeader POH

INNER JOIN HumanResources.Employee HRE
	ON HRE.BusinessEntityID = POH.EmployeeID

INNER JOIN Person.Person PP
	ON HRE.BusinessEntityID = PP.BusinessEntityID

INNER JOIN Person.BusinessEntityAddress BEA
	ON BEA.BusinessEntityID = PP.BusinessEntityID

INNER JOIN Person.EmailAddress PEMA
	ON PEMA.BusinessEntityID = PP.BusinessEntityID
--Chose to drive with PurchaseOrderHeader instead of HumanResources because
--in this case we are only interested in the buyers listed
--in orders created.

--Only provide office address from AddressType if it's available. (not available)