with top_five_dealerships as 
(SELECT
d.business_name,
d.dealership_id,
sum(s.price) as total_sales_dollars
from dealerships d
full join sales s ON s.dealership_id = d.dealership_id
group by d.business_name, d.dealership_id
order by total_sales_dollars desc
limit 5)
--  which vehicle models were the most popular in sales
--  vehicle_popularity_desc as 
select
v2.make,
v2.model,
tfd.dealership_id,
s.vehicle_id,
tfd.business_name,
count(*) as number_of_sales
from sales s
full join vehicles v on v.vehicle_id = s.vehicle_id
full join vehicletypes v2 on v2.vehicle_type_id = v.vehicle_type_id
inner join top_five_dealerships tfd on tfd.dealership_id = s.dealership_id
GROUP BY v2.make, v2.model, s.vehicle_id, tfd.business_name, tfd.dealership_id
order by tfd.dealership_id desc




-- with top_five_dealerships as 
-- (SELECT
-- d.business_name,
-- s.vehicle_id,
-- sum(s.price) as total_sales_dollars
-- from dealerships d
-- full join sales s ON s.dealership_id = d.dealership_id
-- group by d.business_name, s.vehicle_id
-- order by total_sales_dollars desc
-- limit 5)
