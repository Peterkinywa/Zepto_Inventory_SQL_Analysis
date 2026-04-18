drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
Category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

---data exploration

---count of rows
select count(*) from zepto;

--Sample data
select * from zepto
limit 10;

--null values
select * from zepto
where name is NULL or category is null or mrp is null or discountpercent is null
or availablequantity is null or discountedsellingprice is null or weightingms is null or outofstock is null or quantity is null;

--- different product categories
select distinct category from zepto
order by category;

---products in stock vs out of stock
select outofstock, count (sku_id) from zepto
group by outofstock;

---product name present multiple times
select name, count(sku_id) as Number_of_SKUs from zepto
group by name
having count(sku_id) > 1
order by count(sku_id) desc;

--data cleaning

----products with price = 0
select * from zepto
where mrp = 0 or discountedsellingprice = 0;

delete from zepto
where mrp = 0;

---convert price to Rupee
update zepto
set mrp = mrp/100.00,
discountedsellingprice = discountedsellingprice/100.00;

select mrp, discountedsellingprice
from zepto
limit 10;

--data analysis

--Q1. Find the top 10 best-value products based on the discount percentage.
select distinct name, discountpercent
from zepto
order by discountpercent desc
limit 10;

--Q2.What are the Products with High MRP but Out of Stock - for stock planning

select distinct name, mrp
from zepto
where outofstock = true and mrp > 300
order by mrp desc;

--Q3.Calculate Estimated Revenue for each category - best performing product categories
select category,
sum (discountedsellingprice * availablequantity) as total_revenue
from zepto
group by category
order by total_revenue desc;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
select distinct name, mrp, discountpercent
from zepto
where mrp > 500 and discountpercent < 10
order by mrp desc, discountpercent desc;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
select category,
round(avg(discountpercent), 2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
select distinct name, weightingms, discountedsellingprice,
round(discountedsellingprice / weightingms, 2) as price_per_gram
from zepto
where weightingms >= 100
order by price_per_gram;

--Q7.Group the products into categories like Low, Medium, Bulk. - for product packaging
select distinct name, weightingms,
case 
    when weightingms < 1000 then 'low'
    when weightingms < 5000 then 'medium'
    else 'bulk'
end as weight_category
from zepto;

--Q8.What is the Total Inventory Weight Per Category - for warehouse planning
select category,
sum(weightingms * availablequantity) as total_weight
from zepto
group by category
order by total_weight desc;

