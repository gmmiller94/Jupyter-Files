#Insert a new actor into the database
INSERT INTO actor (first_name, last_name) VALUES ("Emma", "Stone");
#View all information for that specific actor
SELECT * FROM actor WHERE first_name = "Emma" AND last_name = "Stone";

#Update the actor that you just inserted, first_name of Emmy and a last_name of Rock
UPDATE actor SET first_name = "Emmy", last_name = "Rock" WHERE actor_id = 202;
#see your updated employee
SELECT * FROM actor WHERE actor_id = 202;

#find all staff that do not have a value specified for password
SELECT * FROM staff WHERE password IS NULL;

#find all staff's information that has a value for first_name and store_id
SELECT * FROM staff WHERE first_name IS NOT NULL AND store_id IS NOT NULL;

#update all people with a Null value in the address2 column, If the district is Alberta, put address2 as Canada, and if the district is QLD, put Australia
UPDATE address
SET address2 = "Canada"
WHERE district = "Alberta";

UPDATE address
SET address2 = "Australia"
WHERE district = "QLD";
