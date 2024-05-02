-- window functions pt2 and views

-- WINDOW FUNCTIONS: GROUP WORK QUERY FROM LAST WEEK

-- Return a list of the top 5 dealerships that includes the top employee from each dealership
-- WITH top5_dealerships AS 
-- 	(
-- 		SELECT d.dealership_id, d.business_name, SUM(s.price) AS Money_Made 
--         FROM dealerships d 
-- 		JOIN sales s ON d.dealership_id = s.dealership_id 
-- 		WHERE s.price IS NOT NULL
-- 		GROUP BY d.dealership_id, d.business_name 
-- 		ORDER BY Money_Made DESC
-- 		LIMIT 5
		
-- 	),
-- 	employee_salespeople AS 
-- 	(
-- 		--For the top 5 dealerships, which employees made the most sales?
-- 		SELECT 
--             e.first_name,
--             e.last_name,
--             de.dealership_id, 
--             COUNT(s.sale_id) AS Number_of_Sales,
--             RANK() OVER(PARTITION BY de.dealership_Id ORDER BY COUNT(s.sale_id) DESC ) as TopEmployeeRank, 
--             ROW_NUMBER() OVER(PARTITION BY de.dealership_Id ORDER BY COUNT(s.sale_id) DESC ) as TopEmployeeRow  
        
--         FROM dealershipemployees de 
-- 		JOIN employees e ON e.employee_id = de.employee_id 
-- 		JOIN sales s ON s.employee_id = de.employee_id 
-- 		GROUP BY de.dealership_id, e.first_name, e.last_name  
-- 		ORDER BY Number_of_Sales DESC
   
-- 	)
	
-- 	SELECT td.business_name,
--      td.Money_Made, 
--      es.first_name, 
--      es.last_name, 
--      es.Number_of_Sales
-- 	FROM top5_dealerships td
-- 	INNER JOIN employee_salespeople AS es ON td.dealership_id = es.dealership_id -- AND TopEmployee = 1
--     WHERE TopEmployeeRow < 3
-- 	ORDER BY   td.dealership_id, es.number_of_sales DESC 

-- simpler window function example
-- SELECT DISTINCT
--     COUNT(s.dealership_id) OVER(PARTITION BY s.dealership_id) as NumSalesPerDealership,
--     s.dealership_id,
--     d.city,
--     e.first_name,
--     e.last_name
-- FROM sales s
-- JOIN dealerships d ON d.dealership_id = s.dealership_id
-- JOIN employees e ON e.employee_id = s.employee_id

-- VIEWS


-- CREATE VIEW vehicle_make_model_body AS
-- select 
-- make,
-- model,
-- body_type
-- from vehicletypes

-- select * from vehicle_make_model_body

-- create view number_of_employees_per_job_title AS
-- select 
-- count(e.employee_id) as number_of_employees,
-- et.employee_type_name
-- from employees e
-- join employeetypes et ON et.employee_type_id = e.employee_type_id
-- GROUP BY et.employee_type_name
-- order by number_of_employees desc

-- select * from number_of_employees_per_job_title
-- where number_of_employees > 140 and number_of_employees < 150

-- create view customer_list_sin_private_info as 
-- select 
-- customer_id,
-- concat(first_name, ' ', last_name) as employee_name
-- from customers

-- select * from customer_list_sin_private_info

-- create view sales2023 AS
-- select distinct
-- count(s.sale_id) over(partition by s.sales_type_id) as total_number_of_sales,
-- st.sales_type_name
-- from sales s
-- join salestypes st on st.sales_type_id = s.sales_type_id
-- where extract(year from s.purchase_date) = 2023

-- select * from sales2023


-- GROUP WORK:

-- Create a view showing the employee at each dealership with the highest number of sales.

-- with cte as 
-- (SELECT distinct
-- d.dealership_id,
-- d.business_name,
-- concat(e.last_name,', ', e.first_name) as employee_name,
-- rank() over(partition by d.dealership_id order by count(s.sale_id) desc) as employee_Rank,
-- count(s.sale_id)  as number_of_sales_per_employee
-- from dealerships d
-- join sales s on s.dealership_id = d.dealership_id
-- join employees e on s.employee_id = e.employee_id
-- group by d.dealership_id, d.business_name, e.employee_id)
-- select distinct
-- * from 
-- cte 
-- where employee_rank = 1

-- create view top_employee_per_dealership as


with cte as 
(SELECT distinct
d.dealership_id,
d.business_name,
concat(e.last_name,', ', e.first_name) as employee_name,
rank() over(partition by d.dealership_id order by count(s.sale_id) desc) as employee_Rank
from dealerships d
join sales s on s.dealership_id = d.dealership_id
join employees e on s.employee_id = e.employee_id
group by d.dealership_id, d.business_name, e.employee_id)
select distinct
cte.dealership_id,
cte.business_name,
cte.employee_name,
cte.employee_Rank,
count(s.sale_id) over(partition by employee_id) as number_of_sales_per_employee
from cte 
join sales s on s.dealership_id = cte.dealership_id
where employee_rank = 1
order by cte.dealership_id;


