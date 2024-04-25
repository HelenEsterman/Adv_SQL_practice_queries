-- For the Top 5 dealerships, return a list of all the employee's first and last names, the total amount in sales from the dealership, the dealership name, and the number of sales each employee made.

with top_five_dealerships as 
(SELECT
d.business_name,
d.dealership_id,
sum(s.price) as total_sales_dollars
from dealerships d
full join sales s ON s.dealership_id = d.dealership_id
group by d.business_name, d.dealership_id
order by total_sales_dollars desc
limit 5),
employee_sales as (
    SELECT
    e.employee_id,
    concat(e.first_name,' ', e.last_name) as employee_name,
    count(*) as total_number_of_sales_per_employee
    from employees e
    full join sales s on e.employee_id = s.employee_id
    GROUP BY e.first_name, e.last_name, e.employee_id
) SELECT
tfd.business_name,
tfd.dealership_id,
tfd.total_sales_dollars,
es.employee_name,
es.total_number_of_sales_per_employee
from top_five_dealerships tfd
inner join dealershipemployees de on de.dealership_id = tfd.dealership_id
inner join employee_sales es on es.employee_id = de.employee_id
order by tfd.total_sales_dollars desc;