CREATE VIEW VendorInfoView AS

SELECT PV.BusinessEntityID AS VendorID
	,PA.AddressID

,PV.Name AS VendorName
,PA.AddressLine1
,PA.AddressLine2
,PA.City AS VendorCity
,PSP.Name AS VendorProvinceName
,PCR.Name AS VendorCountryName
,PA.PostalCode AS VendorPostalCode

FROM Purchasing.Vendor PV

INNER JOIN Person.BusinessEntityAddress BEA
	ON BEA.BusinessEntityID = PV.BusinessEntityID

INNER JOIN Person.Address PA
	ON PA.AddressID = BEA.AddressID

INNER JOIN Person.StateProvince PSP
	ON PSP.StateProvinceID = PA.StateProvinceID

INNER JOIN Person.CountryRegion PCR
	ON PCR.CountryRegionCode = PSP.CountryRegionCode

--It's not necessary to put StateProvinceID here because we're not trying to "separate out dimensions" at this
--point -- just connecting needed info, and we can put that info directly into this table.

--When you're making views it's not the same goal as when you're trying to normalize data.