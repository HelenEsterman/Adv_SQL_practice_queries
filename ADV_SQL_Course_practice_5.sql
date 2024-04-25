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


SELECT
sum(st.sales_type_name) as number_purchased
from sales s
inner join salestypes st on s.sales_type_id = st.sales_type_id
where st.sales_type_name IN('Purchase')
GROUP BY s.sale_id, st.sales_type_name;
