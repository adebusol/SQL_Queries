--practicing joins; inner, left, right and full join

--find the product name of each productid along witht the workerorderid
select * from production.workorder
select workorderid,productid from production.workorder
--get the product name
select * from production.product
select name, productid from production.product 
--using inner join
select A.workorderID, A.productID, B.name from production.workorder
as a inner join production.product as B
on A.productID = B.ProductID


--find the sales orders for all productID along the with the ProductID and name
select productID, name from production.Product
select * from sales.salesorderdetail
select productid, salesorderid from sales.SalesOrderDetail
--using left join
select A.productid, A.name, B.SalesOrderID from production.Product
as a left join sales.salesorderdetail as B
on A.productID = B.productID

--find the reviews of products along with the product name
select productID, name from production.Product
select * from production.productreview
select productID, comments from production.productreview
--using right join
select B.productID, A.name, B.comments from production.Product
as a right join production.productreview as B 
on A.productID = B.productID

--full join
--select all records from the two tables whether there is a match or not 
 
 --find the subcategory name to which each product belongs and 
 --also find if any subcategory name is not assigned to a product name
 select * from production.Product
 select productid, name, productsubcategoryid from production.product
 select  name, productsubcategoryid 
 from production.productsubcategory
 --using full join
 select A.productID, A.name, A.ProductSubcategoryID, B.name from production.product
 as a full join production.productsubcategory as B 
 on A.productsubcategoryid = B.productsubcategoryid 







 






