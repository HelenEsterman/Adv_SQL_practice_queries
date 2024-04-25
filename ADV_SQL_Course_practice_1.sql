-- select 
-- MAX(s.deposit)
-- from sales s
-- full join dealerships d on d.dealership_id = s.dealership_id
-- where d.business_name IN('Mitkov Autos of California');

-- SELECT 
-- count(*)
-- from sales s
-- full join employees e on e.employee_id = s.employee_id
-- where e.first_name IN('Tadeas') AND e.last_name In('Mannagh');

-- select 
-- avg(price)
-- from sales;

SELECT DISTINCT
count(*)
from vehicles v
full join vehicletypes vt on vt.vehicle_type_id = v.vehicle_type_id
where vt.make In('Mazda') AND vt.model IN('CX-5') AND v.is_sold = FALSE
GROUP BY vt.make, vt.model

