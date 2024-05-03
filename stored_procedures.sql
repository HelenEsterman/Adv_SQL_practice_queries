--stored procedures

-- Create a Stored Procedure to add a vehicle to the table.

-- CREATE PROCEDURE new_vehicle(IN vin varchar, IN engine varchar, IN v_type INTEGER, IN ex_color varchar, IN in_color varchar, IN floor_price INTEGER, IN msr INTEGER, IN miles INTEGER, IN car_year INTEGER, IN is_sold boolean, IN is_new boolean, IN dealership INTEGER)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN

-- INSERT INTO vehicles(vin, engine_type, vehicle_type_id, exterior_color, interior_color, floor_price, msr_price, miles_count, year_of_car, is_sold, is_new, dealership_location_id) VALUES (vin, engine, v_type, ex_color, in_color, floor_price, msr, miles, car_year, is_sold, is_new, dealership);

-- END$$;


-- CALL new_vehicle(
--     'CXJ703556789', 
--     'V6',           
--     3,       
--     'Green',        
--     'Black',       
--     20000,     
--     25000,      
--     5000,        
--     2023,         
--     FALSE,      
--     TRUE,        
--     5    
-- );


-- Bonus: Modify the Stored Procedure to return the new vehicleId. !!!!! the call syntax is messed up, issue with Azure?? everyone else couldn't figure out bonus either


-- CREATE PROCEDURE new_vehicle_id_output(IN vin varchar, IN engine varchar, IN v_type INTEGER, IN ex_color varchar, IN in_color varchar, IN floor_price INTEGER, IN msr INTEGER, IN miles INTEGER, IN car_year INTEGER, IN is_sold boolean, IN is_new boolean, IN dealership INTEGER, OUT new_vehicle_id INTEGER)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN

-- INSERT INTO vehicles(vin, engine_type, vehicle_type_id, exterior_color, interior_color, floor_price, msr_price, miles_count, year_of_car, is_sold, is_new, dealership_location_id) VALUES (vin, engine, v_type, ex_color, in_color, floor_price, msr, miles, car_year, is_sold, is_new, dealership)

-- RETURNING vehicle_id INTO new_vehicle_id;

-- END$$;


-- CALL new_vehicle_id_output(
--     'DFR219756789', 
--     'V6',           
--     3,       
--     'Purple',        
--     'Black',       
--     20000,     
--     25000,      
--     5000,        
--     2023,         
--     FALSE,      
--     TRUE,        
--     13,
--     0
-- );


-- check testing:


-- select * from vehicles
-- order by vehicle_id DESC
-- limit 20

-- delete from vehicles where vehicle_id = 10057



-- group work:

-- create PROCEDURE selling_vehicle(id INTEGER)
-- LANGUAGE plpgsql
-- as $$
-- BEGIN
-- UPDATE vehicles v
-- SET is_sold = TRUE
-- WHERE v.vehicle_id = id;

-- END$$;

-- CALL selling_vehicle(1)


-- Create PROCEDURE returning_vehicle(id INTEGER)
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- UPDATE vehicles v
-- SET is_sold = FALSE
-- WHERE v.vehicle_id = id;
-- INSERT INTO oilchangelogs(date_occured, vehicle_id) VALUES(CURRENT_DATE, id);

-- END$$;


-- CALL returning_vehicle(1)

-- select * from vehicles where vehicle_id = 1;
-- select * from oilchangelogs where vehicle_id = 1;