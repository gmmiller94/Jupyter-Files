#CREATE TABLE
CREATE TABLE AppUsers (
    AppUserID INTEGER,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    SignUpDate DATETIME
);

#Constraints
#NOT NULL will force that column not to accept null values
#You are adding the NOT NULL constraint to the FirstName, LastName and SignUpDate columns. 
#This will ensure that each of those rows in the AppUsers table will have data
CREATE TABLE AppUsers1 (
AppUserID INTEGER,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
SignUpDate DATETIME NOT NULL);

#UNIQUE
#making sure that the AppUserID is going to be unique for each user
CREATE TABLE AppUsers2 (
AppUserID INTEGER UNIQUE,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
SignUpDate DATETIME NOT NULL);

#PRIMARY KEY
#replace UNIQUE with PRIMARY KEY. This will now ensure that the AppUserID is unique to every row and also is required to have a value
CREATE TABLE AppUsers3 (
AppUserID INTEGER PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
SignUpDate DATETIME NOT NULL);

#AUTOINCREMENT
#your query will now automatically produce an AppUserID when a new row is generated
CREATE TABLE AppUsers4 (
AppUserID INTEGER PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
SignUpDate DATETIME NOT NULL)

#FOREIGN KEY
#using FOREIGN KEY to call out the column "State" in your customers table, so it references the Abbreviation column in the states table.
CREATE TABLE customerExample(
  FirstName NVARCHAR(40),
  LastName NVARCHAR(30),
  State NVARCHAR(2),
  FOREIGN KEY(State) REFERENCES states(Abbreviation)
);

#CHECK
#CHECK is used to ensure that PostalCode is equal to 5. To do this, you needed to use length(), a function that will return the length 
#of whatever is inside the parenthesis
CREATE TABLE customerExample(
  FirstName NVARCHAR(40),
  LastName NVARCHAR(30),
  State NVARCHAR(10),
  PostalCode INTEGER,
  FOREIGN KEY(State) REFERENCES states(Abbreviation),
  CHECK (length(PostalCode) = 5)
);

#DEFAULT
#defines default values that you can assign to a column, in the case where an insert statement does not include a value for that column
CREATE TABLE customerExample(
  FirstName NVARCHAR(40),
  LastName NVARCHAR(30),
  State NVARCHAR(10),
  PostalCode INTEGER,
  SignUpDate datetime DEFAULT current_timestamp,
  FOREIGN KEY(State) REFERENCES states(Abbreviation),
  CHECK (length(PostalCode) = 5)
);


#INSERT
CREATE TABLE actorExample(
	actor_id smallint(5) unsigned,
    first_name varchar(45),
    last_name varchar(45),
    last_update timestamp);
    
INSERT INTO actorExample
values (200, "Jamie", "Thomas", "2020-01-23 12:16:34");

#insert all columns from one table to another
INSERT INTO table2
SELECT * FROM table1
WHERE condition;

INSERT INTO actorExample (actor_id, first_name, last_name, last_update)
SELECT actor_id, first_name, last_name, last_update
FROM actor;


#DROP
DROP TABLE actorExample;

#A View is a virtual table based on the result of a SQL statement
#CREATE VIEW view_name AS
#SELECT column1, column2, ...
#FROM table_name
#WHERE condition;

CREATE VIEW CurrentCustomers AS
SELECT customer_id, first_name, last_name
FROM customer
WHERE active = 1
#see view
SELECT * FROM CurrentCustomers;

#CREATE VIEW WITH JOIN
CREATE VIEW ActorFilms as
SELECT first_name, last_name, film_id
FROM sakila.actor
INNER JOIN sakila.film_actor
ON sakila.actor.actor_id = sakila.film_actor.actor_id;

#view query
SELECT * FROM ActorFilms;

#drop view
DROP VIEW CurrentCustomers;