SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/01/01';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

START TRANSACTION;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

START TRANSACTION;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species='pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

START TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

START TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT POINTONE;
UPDATE animals SET weight_kg=weight_kg * -1;
ROLLBACK TO POINTONE;
UPDATE animals SET weight_kg=weight_kg * -1 WHERE weight_kg < 1;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'  GROUP BY species;

SELECT name FROM animals JOIN owners ON owners.id=animals.owner_id WHERE owner_id='4';
SELECT animals.name FROM animals JOIN species ON species.id=animals.species_id WHERE species_id='1';
SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON owners.id=animals.owner_id;
SELECT species.name, COUNT(species.name) FROM animals JOIN species ON species.id=animals.species_id GROUP BY species.name;
SELECT species.name, species.id FROM species JOIN animals ON species.id=animals.species_id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
SELECT * FROM animals JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT full_name, COUNT(*) FROM owners LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT DESC LIMIT 1;