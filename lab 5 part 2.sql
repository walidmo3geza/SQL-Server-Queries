-- AdventureWorks DB
-- 1
select SalesOrderID, ShipDate
from Sales.SalesOrderHeader
where OrderDate between '7/28/2002' and '7/29/2014'

-- 2
select ProductID, Name
from Production.Product
where StandardCost < 110

-- 3
select ProductID
from Production.Product
where weight is null

-- 4
select *
from Production.Product
where Color in('Silver', 'Black', 'Red')

-- 5
select *
from Production.Product
where Name like 'B%'

-- 6
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select *
from Production.ProductDescription
where Description like '%[_]%' --  '%/_%' escape'/'


-- 7 
select sum(TotalDue)
from Sales.SalesOrderHeader
where OrderDate between '7/1/2001' and '7/31/2014'
--group by 

-- 8
select distinct HireDate
from HumanResources.Employee

-- 9  
select avg(distinct ListPrice)
from Production.Product

-- 10
select 'The ' + Name + ' is only! ' + CONVERT(varchar,ListPrice) 
from Production.Product
where ListPrice between 100 and 120

-- 11
	-- a
	Select rowguid,Name,SalesPersonID,Demographics into Sales.store_Archive
	from Sales.Store

	Select rowguid,Name,SalesPersonID,Demographics
	from Sales.store_Archive   --701 row

	-- b
	Select rowguid,Name,SalesPersonID,Demographics into Sales.store_Archive1
	from Sales.Store
	where 1=2

	Select rowguid,Name,SalesPersonID,Demographics
	from Sales.store_Archive1   --0 row

-- 12
select convert(varchar(20),getdate(),101)
union
select convert(varchar(20),getdate(),103)
union
select convert(varchar(20),getdate(),111)
union
select convert(varchar(20),getdate(),110)
union
select convert(varchar(20),getdate(),107)