CREATE DATABASE vet_clinic;
CREATE TABLE animals(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(250), date_of_birth DATE, escape_attempts INT, neutered BOOLEAN, weight_kg DECIMAL(5,2), PRIMARY KEY(id));
ALTER TABLE animals ADD species VARCHAR(250);

CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY, full_name VARCHAR(250), age INT, PRIMARY KEY(id));
CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(250), PRIMARY KEY(id));

AlTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

