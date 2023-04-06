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

SELECT visits.animal_id, visits.date_of_visit , animals.name FROM visits JOIN vets ON visits.vets_id = vets.id JOIN animals ON animals.id = visits.animal_id WHERE visits.vets_id = vets.id AND vets.name  = 'William Tatcher' ORDER BY  animal_id DESC LIMIT 1;
SELECT animals.name, visits.date_of_visit  FROM visits JOIN vets ON visits.vets_id=vets.id JOIN animals ON animals.id=visits.animal_id  WHERE visits.vets_id = 3 AND vets.name='Stephanie Mendez';
SELECT vets.name, species.name AS specialty FROM vets LEFT JOIN specializations ON vets.id=specializations.vets_id LEFT JOIN species ON species.id=specializations.vets_id;
SELECT animals.name, visits.date_of_visit FROM visits JOIN vets ON visits.vets_id=vets.id JOIN animals ON animals.id=visits.animal_id WHERE visits.vets_id = vets.id and vets.name='Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-03';
SELECT animal_name,COUNT(animal_name) AS total_visit_count FROM (SELECT vets.name AS vets_name,animals.name AS animal_name FROM visits FULL JOIN vets ON vets.id = visits.vets_id JOIN animals ON animals.id = visits.animal_id) AS subby GROUP BY animal_name ORDER BY total_visit_count DESC LIMIT 1;
SELECT date_of_visit,animals.name FROM visits JOIN vets ON visits.vets_id = vets.id JOIN animals ON animals.id = visits.animal_id WHERE vets.id = visits.vets_id AND vets.name = 'Maisy Smith' ORDER BY date_of_visit ASC LIMIT 1;
SELECT animals.id,animals.name,date_of_birth,weight_kg,neutered,escape_attempts,vets.id AS vets_id,vets.name AS vets_name,date_of_visit FROM visits JOIN vets ON visits.vets_id = vets.id JOIN animals ON animals.id = visits.animal_id ORDER BY date_of_visit DESC LIMIT 1;
SELECT count(*) FROM visits LEFT JOIN animals ON animals.id = visits.animal_id LEFT JOIN vets ON vets.id = visits.vets_id WHERE animals.species_id NOT IN (SELECT species_id FROM specializations WHERE vets_id = vets.id);
