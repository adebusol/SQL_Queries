--Practicing with the Adventureworks2017 sample database from Microsoft

-- recruitment in the company started from year 2006. Need to find
--postions filled before 2008

select * from HumanResources.Employee

select JobTitle, HireDate from HumanResources.Employee
order by HireDate asc

select JobTitle, HireDate from HumanResources.Employee
where Year(HireDate) < 2008
order by HireDate asc;

--or you can
select JobTitle, HireDate from HumanResources.Employee
where Year(HireDate) between 2007 and  2008 -- this just brings 2007 and 2008
order by HireDate asc;

-- display location in the format [state, country code]. 
--example:Alaska,US
--List the product names and the product quantity
-- in stock for each product
-- solution

select * from person.StateProvince

select Name, CountryRegionCode from person.StateProvince

--to join two columns? use '+', 
--use the ALIAS 'AS' function to give the column a name
select Name+ ','+ CountryRegionCode 
AS Location from person.StateProvince;

---
select * from production.Product
select * from production.ProductInventory


select ProductID, Name from production.Product;
select ProductID, Quantity from production.ProductInventory;

--join both tables, we willl also use
--ALIAS to avoid the 'product ID' being dupilcated
select production.Product.ProductID as ProductID, production.Product.Name,
production.ProductInventory.ProductID as InventoryProductID, 
production.ProductInventory.Quantity from production.Product
inner join Production.ProductInventory
on production.Product.ProductID = production.ProductInventory.ProductID;

--rewrite the query in a simpler way, with less code using ALIAS
select A.ProductID as ProductID, A.Name,
B.ProductID as InventoryProductID, 
B.Quantity from production.Product A
inner join Production.ProductInventory B
on A.ProductID = B.ProductID;

-----------------
--using the date function
--find the age of employees at the time of starting employment
select* from HumanResources.employee; 

select LoginID, BirthDate, HireDate from HumanResources.Employee;
--using the Datdiff function to get the age they joined
--use ALIAS to give the new column a name

select LoginID, BirthDate, HireDate, 
DATEDIFF(year,BirthDate,HireDate) as AgeAtJoining
from HumanResources.Employee;

--calculate the job anniversary date for each hire
--using date add function, increment of '1' year
select LoginID, HireDate, dateadd(year,1,HireDate) 
as JobAnniversaryDate
from Humanresources.employee

--find sales orders that totals more than $10,000
select * from Sales.salesorderdetail

 --using the aggregate funtion 'sum'
 --using having and not where since we're using the the sum function
select SalesOrderID, sum(linetotal) as salesorderamount
 from sales.salesorderdetail
group by SalesOrderID
having sum(linetotal) > 10000

--list out the quarters in a year when the pay rate changed
select * from humanresources.employeepayhistory

--use date part to extract quarter from the date
select Ratechangedate, rate, DATEPART(quarter,Ratechangedate)
as  quarter
from humanresources.employeepayhistory

--use datepart to extract year or month or month
select Ratechangedate, rate, 
    DATEPART(quarter,Ratechangedate) as  quarter,
    DATEPART(year,Ratechangedate) as YEAR,
    DATEPART(month,Ratechangedate) as month,
    DATEPART(day,Ratechangedate) as DAY
from humanresources.employeepayhistory

--compute New 'end date' for null values 
--in the table Productcosthistory. The new end date value
--needs to be the last day of the month in 'startdate'.
Select * from production.productcosthistory 

-- using the eom function: end of month function
--  start with case and  end with end, inbetween will be the condition
Select startdate, enddate,
    CASE   
      when enddate is null THEN eomonth(startdate)
      else enddate
    END as newenddate
     from production.productcosthistory

--need to list the location details in this format:
--state name-state code, country code. e.g California-CA,US
select * from person.stateprovince
--using the concatenate, concat function
select concat(Name,'-',stateprovincecode,',',countryregioncode)
as location
from person.stateprovince

--find the postion of the symbol '@' in the email adddress
select * from person.emailaddress
-- use the charindex function to find the positon of a substring
select emailaddress, CHARINDEX('@', emailaddress) as postion
from person.emailaddress

--extract the username from all email addresses
--use the substring function to get username just before the @ symbol
select emailaddress, SUBSTRING(emailaddress,1, charindex('@', emailaddress)-1)
as username
from person.emailaddress

--find the product name having more than 30 characters in length
select * from production.Product
--use the len function with the where function
select name, LEN(name) as product_characters
from production.product
where len(name) > 30

--find the position of spaces in postal code
select * from person.address
--using patindex, it looks for  a particular 
--pattern in our specified column and returns the postion
select postalcode, PATINDEX('% %',Postalcode) as position
from person.address
order by len(postalcode) desc

--display hire date in this specific fomat: yy/mm/dd
select * from humanresources.employee
--using the replace function
select jobtitle, hiredate, REPLACE(hiredate,'-','/')
as formattedhiredate
from humanresources.employee

--create the product category code as below:
select * from production.productcategory
--using replicate function to
select name, upper(concat(REPLICATE(0, len(name)-5),SUBSTRING(name, 1, 3)))
 as categorycodes
 from production.productcategory

 --remove any spaces before and after email addresses
 select * from person.emailaddress
--using ltrim: removes spaces from the left side and 
--rtrim: removes spaces from the right side, functions
select emailaddress,
    ltrim(rtrim(emailaddress))
    as new_column
 from person.emailaddress

 --mask email addresses in the report. Mask name with X
 --reveal only the character after the @ symbol
 select emailaddress, REPLACE(emailaddress, 
 SUBSTRING(emailaddress,1, charindex('@', emailaddress)-1), 'x')
 as masked_emailaddress
 from person.emailaddress
--but you can also do this using the stuff function
--stuff(string, start, length, new_string)
select emailaddress,
stuff(emailaddress, 1,len(SUBSTRING(emailaddress,1, charindex('@', emailaddress)-1)),
replicate('x',len(SUBSTRING(emailaddress,1, charindex('@', emailaddress)-1))))
as new_column
from person.emailaddress


-- comapany has 3 main sales regions: US, India and China
--display the products and date to start selling 
--them in a format specific to each country

select * from production.product

--using format function to change the date according to country needed
-- format(value, format[,culture])
select name, sellstartdate,
FORMAT(sellstartdate, 'd', 'en-us') as us_sellstartdate
from production.product
--
select name, sellstartdate,
FORMAT(sellstartdate, 'd', 'hi-in') as India_sellstartdate
from production.product
--
select name, sellstartdate,
FORMAT(sellstartdate, 'd', 'en-us') as us_sellstartdate
from production.product
--
select name, sellstartdate,
FORMAT(sellstartdate, 'd', 'zh-cn') as us_sellstartdate
from production.product


--if some products display null change it to NA
select * from production.Product
--use the coalesce function, if null values are present it will change it to NA
select productnumber,name, coalesce(productline, 'N/A') as productline,
coalesce(discontinueddate, sellenddate, 'Ongoing sale')
from production.Product
 --we got an error when running the code above
 -- need to convert date string to character string
 select productnumber,name, coalesce(productline, 'N/A') as productline,
coalesce(convert(varchar,discontinueddate), convert(varchar,sellenddate), 'Ongoing sale')
as sale_status
from production.Product

-- provide a description for the product's listing price as shown below
select * from production.product

--using case statements
select productid, name, listprice,
CASE
WHEN listprice < 20 THEN 'low'
WHEN listprice < 40 and listprice > 20 THEN 'medium'
when listprice >=40 then'high'
END as "price.range"
from production.product

---find the number of customers having the
--same billing and shipping address
--using nullif function, if the values are the same it will return null
select * from sales.salesorderheader

--using nullif function, if the values are the same
-- it is null, which means they have the 
--same billing and shipping address and if not the same, it 
--will return the value of the first arguement
select count(customerid)
from sales.salesorderheader
where NULLIF(billtoaddressid, shiptoaddressid) is NULL

--display name of the person for the report, if no data is available
-- display them as an empty string
select * from person.person
--use isnull function to replace middlenames with "null"
--with an empty string
select isnull(firstname,'') as firstname, isnull(middlename,'') as middlename, 
isnull(lastname, '') as lastname
from person.person
order by firstname








 

























