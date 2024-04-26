-- Review of GROUP BY and Including with CTE from last class

-- SELECT s.employee_id , COUNT(s.employee_id)
-- FROM sales s
-- WHERE employee_id = 2
-- GROUP BY s.employee_id
-- ;

-- SELECT s.employee_id , COUNT(s.employee_id), s.dealership_id
-- FROM sales s
-- WHERE employee_id = 2
-- GROUP BY s.employee_id, s.dealership_Id
-- ORDER BY s.employee_id;


-- WITH employee_sales_count AS (
--     SELECT s.employee_id , COUNT(s.employee_id) AS NumberSales
--     FROM sales s
--     GROUP BY s.employee_id
-- )
-- SELECT DISTINCT s.employee_id, esc.NumberSales, s.dealership_id
-- FROM employee_sales_count esc 
-- JOIN sales s ON s.employee_id = esc.employee_id
-- WHERE s.employee_id = 2
-- ORDER BY s.employee_id;


-- WITH top_five_cte AS (
--      SELECT 
--           s.dealership_id, 
--           SUM(s.price) AS total_sales
--      FROM sales s 
--      GROUP BY s.dealership_id
--      ORDER BY total_sales DESC
--      LIMIT 5
-- )

-- select COUNT(vt.make) as "Number Sold", vt.make, s.dealership_id
-- from sales s
-- join vehicles v ON v.vehicle_id = s.vehicle_id 
-- join vehicletypes vt on vt.vehicle_type_id  = v.vehicle_type_id 
-- JOIN top_five_cte tf ON tf.dealership_id = s.dealership_id
-- group by vt.make , vt.vehicle_type_id , s.dealership_id
-- order by s.dealership_id, COUNT(vt.make) desc;


-- WITH top_five_cte AS (
--     SELECT 
--         sales.dealership_id, 
--         SUM(price) AS total_sales 
--     FROM 
--         sales
       
--     GROUP BY 
--         sales.dealership_id
--     ORDER BY 
--         total_sales DESC 
--     LIMIT 5
-- ),

-- top_make_as AS (
--     SELECT DISTINCT ON (s.dealership_id)
--         COUNT(vt.make) as numberSold,
--         vt.make,
--         s.dealership_id
--     FROM 
--         sales s 
--     JOIN 
--         vehicles v ON v.vehicle_id = s.vehicle_id
--     JOIN 
--         vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
--     JOIN 
--         top_five_cte tf ON tf.dealership_id = s.dealership_id
--     GROUP BY 
--         s.dealership_id, vt.make, vt.vehicle_type_id
--     ORDER BY 
--         s.dealership_id, COUNT(vt.make) DESC
--         LIMIT 5
-- )
-- SELECT DISTINCT
--     tm.numberSold AS "Number Sold", 
--     tm.make, 
--     s.dealership_id ,
--     d.business_name
-- FROM sales s 
-- JOIN top_make_as tm ON tm.dealership_id = s.dealership_id 
-- JOIN dealerships d ON d.dealership_id = tm.dealership_Id;


-- window functions
-- example:
-- select distinct
-- 	employees.last_name || ', ' || employees.first_name employee_name,
-- 	sales.employee_id,
-- 	sum(sales.price) over() total_sales,
-- 	sum(sales.price) over(partition by employees.employee_id) total_employee_sales
-- from
-- 	employees
-- join
-- 	sales
-- on
-- 	sales.employee_id = employees.employee_id
-- order by employee_name


-- What is the most popular vehicle make in terms of number of sales?

-- select distinct 
-- v2.make,
-- count(*) over( partition by v2.make) as number_of_sales
-- from sales s
-- inner join vehicles v on v.vehicle_id = s.vehicle_id
-- inner join vehicletypes v2 on v2.vehicle_type_id = v.vehicle_type_id
-- order by number_of_sales desc
-- limit 1;



-- Write a query that shows the total purchase sales income per dealership
-- select distinct
-- d.business_name,
-- d.dealership_id,
-- sum(s.price) over(partition by d.dealership_id) as total_sales_per_dealership
-- from dealerships d
-- join sales s on s.dealership_id = d.dealership_id
-- order by total_sales_per_dealership desc;


-- Write a query that shows the purchase sales income per dealership for the current month.
-- select DISTINCT
-- d.dealership_id,
-- d.business_name,
-- sum(s.price) over(partition by d.dealership_id) as total_sales_per_dealership_for_current_month
-- from dealerships d
-- join sales s on s.dealership_id = d.dealership_id
-- where EXTRACT(MONTH FROM s.purchase_date) = 7 and EXTRACT(year from s.purchase_date) = 2020
-- order by total_sales_per_dealership_for_current_month desc;

-- Write a query that shows the total lease income per dealership.
--  select DISTINCT
-- d.dealership_id,
-- d.business_name,
-- sum(s.price) over(partition by d.dealership_id) as total_lease_income_per_dealership
-- from dealerships d
-- join sales s on s.dealership_id = d.dealership_id
-- join salestypes s2 on s2.sales_type_id = s.sales_type_id
-- where s2.sales_type_name ilike 'lease';

-- Write a query that shows the lease income per dealership for Jan of 2020.
--  select DISTINCT
-- d.dealership_id,
-- d.business_name,
-- sum(s.price) over(partition by d.dealership_id) as total_lease_income_per_dealership_for_1_2020
-- from dealerships d
-- join sales s on s.dealership_id = d.dealership_id
-- where s.sales_type_id = 2 and extract(month from s.purchase_date) = 1 and extract(year from s.purchase_date) = 2020;