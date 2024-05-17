CREATE TABLE vehicletransfers(
    transfer_id SERIAL PRIMARY KEY,
    transfer_date DATE DEFAULT CURRENT_DATE,
    vehicle_id INT,
    CONSTRAINT fk_vehicle_vehicleTransfer FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id),
    from_dealership_id INT,
    CONSTRAINT fk_fromDealership_vehicleTransfer FOREIGN KEY (from_dealership_id)
        REFERENCES dealerships(dealership_id),
    to_dealership_id INT,
    CONSTRAINT fk_toDealership_vehicleTransfer FOREIGN KEY (to_dealership_id)
        REFERENCES dealerships(dealership_id),
    customer_id INT,
    CONSTRAINT fk_customer_vehicleTransfer FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
    );


    CREATE PROCEDURE new_vehicle_transfer(IN new_vehicle_id INT, IN new_from_dealership_id INT, IN new_to_dealership_id INT, IN new_customer_id INT)
    LANGUAGE plpgsql
    AS $$
    BEGIN

    INSERT INTO vehicletransfers(vehicle_id, from_dealership_id, to_dealership_id, customer_id) VALUES(new_vehicle_id, new_from_dealership_id, new_to_dealership_id, new_customer_id);

    END
    $$;

CALL new_vehicle_transfer(5, 22, 11, 3);

select * from vehicletransfers;


CREATE FUNCTION update_dealership_on_vehicle_after_transfer()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
UPDATE vehicles
SET dealership_location_id = NEW.to_dealership_id
WHERE vehicles.vehicle_id = NEW.vehicle_id;
RETURN NULL;
END;
$$;

CREATE TRIGGER new_vehicle_transfer_made
AFTER INSERT
ON vehicletransfers
FOR EACH ROW 
EXECUTE PROCEDURE update_dealership_on_vehicle_after_transfer();

select * from vehicles where vehicle_id = 6;

-- CALL new_vehicle_transfer(5, 22, 11, 3);
CALL new_vehicle_transfer(6, 44, 11, 3);
CALL new_vehicle_transfer(7, 13, 11, 3);
CALL new_vehicle_transfer(8, 30, 13, 3);
CALL new_vehicle_transfer(9, 16, 13, 3);
CALL new_vehicle_transfer(82, 11, 13, 3);

-- create views for these: ---!!! tip on how to approach would be create views getting all vehicles and then create functions pulling the specific data you need for these requests//

-- A list of vehicles transferred to the selected dealership.
-- A list of vehicles transferred from the selected dealership.
-- A list of transfers that occurred in the last month or any specified month.
-- The number of transfers that have occurred each month.
-- The number of transfers that have occurred for each dealership (both to and from).


-- selected dealership 11, 13

SELECT 
vt.vehicle_id,
CONCAT(vty.make, ' ', vty.model) AS vehicle
FROM vehicletransfers vt
JOIN vehicles v on v.vehicle_id = vt.vehicle_id
JOIN vehicletypes vty on vty.vehicle_type_id = v.vehicle_type_id
WHERE vt.to_dealership_id = 13 --selected dealership
;

SELECT 
vt.vehicle_id,
CONCAT(vty.make, ' ', vty.model) AS vehicle
FROM vehicletransfers vt
JOIN vehicles v on v.vehicle_id = vt.vehicle_id
JOIN vehicletypes vty on vty.vehicle_type_id = v.vehicle_type_id
WHERE vt.from_dealership_id = 13 --selected dealership
;


SELECT 
*
FROM vehicletransfers
WHERE extract(MONTH from transfer_date) = 5 --specified month;