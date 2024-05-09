-- triggers:

-- Create a trigger for when a new Sales record is added, set the purchase date to 3 days from the current date.

-- CREATE FUNCTION set_purchase_date()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- UPDATE sales
-- SET purchase_date = NEW.purchase_date + INTEGER '3'
-- WHERE sales.sale_id = NEW.sale_id;
-- RETURN NULL;
-- END;
-- $$

-- CREATE TRIGGER new_purchase_made
-- AFTER INSERT
-- ON sales
-- FOR EACH ROW
-- EXECUTE PROCEDURE set_purchase_date();

-- select * from sales 
-- order by sale_id desc 
-- limit 5;

-- INSERT INTO sales(sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method, sale_returned) VALUES (1, 5, 13, 11, 1, 20005.23, 10065, CURRENT_DATE, CURRENT_DATE, 23835168302, 'visa', FALSE);