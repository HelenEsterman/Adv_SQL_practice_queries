-- transactions:
-- transaction format:
-- -- start a transaction
-- BEGIN;
-- -- You can also use BEGIN TRANSACTION; or BEGIN WORK;

-- -- insert a new row into the sales type table
-- INSERT INTO salestypes(name)
-- VALUES('Lease to Own');

-- -- commit the change
-- COMMIT;--- change to ROLLBACK; to undo essentially
-- -- You can also use COMMIT TRANSACTION; or COMMIT WORK;


-- can basically add a "stopping point" with save point and save your place in transaction
-- -- start a transaction
-- BEGIN;
-- -- You can also use BEGIN TRANSACTION; or BEGIN WORK;

-- -- insert a new row into the sales type table
-- INSERT INTO salestypes(name)
-- VALUES('Lease to Own');

-- SAVEPOINT foo;

-- -- insert a new row into the employees table
-- INSERT INTO employees(name)
-- VALUES('Accountant');

-- -- roll back to the savepoint
-- ROLLBACK TO SAVEPOINT foo;

DO $$
DECLARE 
    meeler_auto_id INTEGER;
    meadly_auto_id INTEGER;
    major_autos_id INTEGER;
    new_employee_type_id INTEGER;
    new_employee_id_1 INTEGER;
    new_employee_id_2 INTEGER;
    new_employee_id_3 INTEGER;
    new_employee_id_4 INTEGER;
    new_employee_id_5 INTEGER;
BEGIN
    -- Execute SELECT INTO statements to assign dealership IDs to variables
    SELECT dealership_id INTO meeler_auto_id
    FROM dealerships
    WHERE business_name ILIKE 'Meeler Autos of San Diego';

    SELECT dealership_id INTO meadly_auto_id
    FROM dealerships
    WHERE business_name ILIKE 'Meadley Autos of California';

    SELECT dealership_id INTO major_autos_id
    FROM dealerships
    WHERE business_name ILIKE 'Major Autos of Florida';
    SAVEPOINT after_defining_dealership_id;



    INSERT INTO employeetypes(employee_type_name)
    VALUES('Automotive Mechanic')
    RETURNING employee_type_id INTO new_employee_type_id;
    SAVEPOINT after_creating_mechanics;



    INSERT INTO employees(first_name, last_name, email_address, phone, employee_type_id)
    VALUES ('John', 'Doe', 'john.doe@example.com', '120-456-3890', new_employee_type_id)
    RETURNING employee_id INTO new_employee_id_1;


    INSERT INTO employees(first_name, last_name, email_address, phone, employee_type_id)
    VALUES('Joanne', 'Doe', 'joanne.doe@example.com', '103-156-7890', new_employee_type_id)
    RETURNING employee_id INTO new_employee_id_2;


    INSERT INTO employees(first_name, last_name, email_address, phone, employee_type_id)
    VALUES('Jolene', 'Doe', 'jolene.doe@example.com', '523-456-2890', new_employee_type_id)
    RETURNING employee_id INTO new_employee_id_3;


    INSERT INTO employees(first_name, last_name, email_address, phone, employee_type_id)
    VALUES('Jake', 'Doe', 'jake.doe@example.com', '923-436-7890', new_employee_type_id)
    RETURNING employee_id INTO new_employee_id_4;


    INSERT INTO employees(first_name, last_name, email_address, phone, employee_type_id)
    VALUES('Josh', 'Doe', 'josh.doe@example.com', '173-456-7290', new_employee_type_id)
    RETURNING employee_id INTO new_employee_id_5;
    SAVEPOINT after_adding_mechanics;



    INSERT INTO dealershipemployees(dealership_id, employee_id)
    VALUES (meeler_auto_id, new_employee_id_1),
    (meadly_auto_id, new_employee_id_1),
    (major_autos_id, new_employee_id_1),
    (meeler_auto_id, new_employee_id_2),
    (meadly_auto_id, new_employee_id_2),
    (major_autos_id, new_employee_id_2),
    (meeler_auto_id, new_employee_id_3),
    (meadly_auto_id, new_employee_id_3),
    (major_autos_id, new_employee_id_3),
    (meeler_auto_id, new_employee_id_4),
    (meadly_auto_id, new_employee_id_4),
    (major_autos_id, new_employee_id_4),
    (meeler_auto_id, new_employee_id_5),
    (meadly_auto_id, new_employee_id_5),
    (major_autos_id, new_employee_id_5);
    SAVEPOINT after_adding_dealership_employees;



EXCEPTION WHEN others THEN 
-- NONE OF THESE STATEMENTS ARE NEEDED!!! POSTGRESQL KNOWS TO ROLLBACK TO SAVEPOINTS AUTOMATICALLY WITH EXECPTION COMMAND
    -- ROLLBACK TO SAVEPOINT after_adding_dealership_employees;
    -- ROLLBACK TO SAVEPOINT after_adding_mechanics;      
    -- ROLLBACK TO SAVEPOINT after_creating_mechanics;
    -- ROLLBACK TO SAVEPOINT after_defining_dealership_id;
    -- rollback;
     COMMIT;
END;
$$;


select * from employees
order by employee_id DESC
limit 5;