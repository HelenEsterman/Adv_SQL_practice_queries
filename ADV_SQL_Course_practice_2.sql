-- select 
-- e.first_name,
-- e.last_name,
-- (SELECT count(*) from sales where sales.employee_id = e.employee_id) AS total_sales
-- from employees e

-- SELECT
-- e.first_name,
-- e.last_name,
-- (select avg(price) from sales where sales.employee_id = e.employee_id) AS avg_in_sales
-- from employees e;

-- SELECT
-- price
-- from sales 
-- where price < (select avg(price) from sales)


-- SELECT
-- s.price,
-- e.first_name,
-- e.last_name,
-- (select avg(price) from sales where sales.employee_id = e.employee_id) AS avg_in_sales
-- from employees e
-- full join sales s on s.employee_id = e.employee_id;

-- SELECT first_name, last_name
-- FROM employees
-- WHERE employee_id NOT IN (
--     SELECT employee_id
--     FROM sales
-- );

-- select 
-- e.first_name,
-- e.last_name
-- from employees e
-- where NOT EXISTS (
--     SELECT employee_id
--     FROM sales s 
--     WHERE e.employee_id = s.employee_id
-- )

-- SELECT
--     e.first_name,
--     e.last_name,
--     s.numberOfSales
-- FROM employees e
-- LEFT JOIN (
--         SELECT count(sale_id) as numberOfSales, employee_id
--         FROM sales 
--         GROUP BY employee_id
--     ) AS s ON s.employee_id = e.employee_id
-- WHERE s.numberOfSales IS NULL;


-- SELECT v2.vehicle_id, v2.msr_price, vt2.make, vt2.model, msr.AveMsr
-- FROM vehicles v2
-- JOIN vehicletypes vt2 ON vt2.vehicle_type_id = v2.vehicle_type_id
-- JOIN (
--     SELECT 
--         AVG(v3.msr_price) as AveMsr, 
--         v3.vehicle_type_id 
--     FROM vehicles v3 
--     GROUP BY v3.vehicle_type_id
-- ) AS msr ON v2.vehicle_type_id = msr.vehicle_type_id
-- WHERE v2.is_sold = 'False'
-- ORDER BY v2.vehicle_type_id



-- EXAMPLE of using subquery in FROM clause

SELECT 
    s.sale_id, 
    s.employee_id, 
    ROUND(ap.price, 2),
    s.price as "Sale Price", 
    s.purchase_date,
    CONCAT(e.first_name, ' ', e.last_name) as employee
FROM sales s 
JOIN (
    SELECT 
        AVG(s2.price) as price, 
        s2.employee_id 
    FROM sales s2 
    GROUP BY s2.employee_id
) ap ON ap.employee_id = s.employee_id
JOIN employees e ON s.employee_id = e.employee_id
ORDER BY s.employee_id, s.purchase_date DESC;