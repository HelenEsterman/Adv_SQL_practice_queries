-- normalization of the vehicle types table

CREATE TABLE bodytypes(
    body_type_id SERIAL PRIMARY KEY,
    body_type_name VARCHAR
);

CREATE TABLE makes(
    make_id SERIAL PRIMARY KEY,
    make_name VARCHAR
);

CREATE TABLE models(
    model_id SERIAL PRIMARY KEY,
    model_name VARCHAR,
    make_id INT,
    body_type_id INT,
    CONSTRAINT fk_make_model FOREIGN KEY (make_id)
        REFERENCES makes(make_id),
    CONSTRAINT fk_bodyType_model FOREIGN KEY (body_type_id)
        REFERENCES bodytypes(body_type_id)
);


INSERT INTO bodytypes (body_type_name)
SELECT distinct body_type
FROM vehicletypes;

select * from bodytypes;

INSERT INTO makes(make_name)
SELECT DISTINCT make
FROM vehicletypes;

select * from makes;


INSERT INTO models (model_name, make_id, body_type_id)
select distinct 
vt.model as model_name, 
m.make_id As make_id,
bt.body_type_id AS body_type_id
from vehicletypes vt
join bodytypes bt on bt.body_type_name = vt.body_type
join makes m on m.make_name = vt.make;


-- select distinct 
-- -- select
-- vt.model, 
-- vt.make, 
-- vt.body_type,
-- bt.body_type_id,
-- m.make_id 
-- from vehicletypes vt
-- join bodytypes bt on bt.body_type_name = vt.body_type
-- join makes m on m.make_name = vt.make
-- order by model;


select * from models;


ALTER TABLE vehicletypes
ADD model_id INT, 
ADD CONSTRAINT fk_model_vehicleType FOREIGN KEY (model_id) REFERENCES models(model_id);

UPDATE vehicletypes vt
SET model_id = (
    SELECT DISTINCT
    m.model_id
    from models m
    WHERE vt.model = m.model_name
    LIMIT 1); 

select distinct * from vehicletypes;

-- next step would be to drop the columns: body_type, make, and model from vehicletypes table, but not ready yet cause i want to make sure the data is 100% correct to ensure I don't lose data