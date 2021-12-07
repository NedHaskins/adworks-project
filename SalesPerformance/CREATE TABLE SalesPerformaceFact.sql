CREATE TABLE SalesPerformanceFact(
	SalesPersonID INT NOT NULL,
	TerritoryID INT NOT NULL,
	SalesQuota MONEY NOT NULL,
	SalesYTD MONEY NOT NULL,
	SalesLastYear MONEY NOT NULL,
	PercentChange NUMERIC(38,6)
	)