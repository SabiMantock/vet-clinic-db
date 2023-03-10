/*Queries that provide answers to the questions from all projects.*/
SELECT *
from animals
WHERE name LIKE '%mon';
SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name
FROM animals
WHERE neutered = 'TRUE'
    AND escape_attempts < 3;
SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');
SELECT name,
    escape_attempts
FROM animals
WHERE weight_kg > 10.5;
SELECT *
FROM animals
WHERE neutered = 'TRUE';
SELECT *
FROM animals
WHERE NOT name = 'Gabumon';
SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;
BEGIN TRANSACTION;
UPDATE animals
SET species = 'unspecified';
SELECT species
FROM animals;
ROLLBACK;
SELECT species
FROM animals;
BEGIN TRANSACTION;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
SELECT species
FROM animals;
BEGIN TRANSACTION;
DELETE FROM animals;
SELECT COUNT(*)
FROM animals;
ROLLBACK;
SELECT COUNT(*)
FROM animals;
BEGIN TRANSACTION;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT vet_clinic;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;
SELECT *
FROM animals;
SELECT COUNT(*)
FROM animals;
SELECT COUNT(*)
FROM animals
WHERE escape_attempts = 0;
SELECT AVG(weight_kg)
FROM animals;
SELECT neutered,
    AVG(escape_attempts) AS avg_escape_attempts
FROM animals
GROUP BY neutered;
SELECT species,
    MIN(weight_kg) AS min_weight_kg,
    MAX(weight_kg) AS max_weight_kg
FROM animals
GROUP BY species;
SELECT species,
    AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
SELECT animals.name,
    species.name AS species
FROM animals
    JOIN owners ON animals.owner_id = owners.id
    JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Melody Pond';
SELECT animals.name,
    owners.full_name
FROM animals
    JOIN owners ON animals.owner_id = owners.id
    JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';
SELECT owners.full_name,
    animals.name AS animal_name,
    species.name AS species_name
FROM owners
    LEFT JOIN animals ON owners.id = animals.owner_id
    LEFT JOIN species ON animals.species_id = species.id
ORDER BY owners.full_name;
SELECT species.name AS species_name,
    COUNT(*) AS num_animals
FROM animals
    JOIN species ON animals.species_id = species.id
GROUP BY species.id,
    species.name
ORDER BY num_animals DESC;
SELECT animals.name AS animal_name,
    species.name AS species_name,
    owners.full_name
FROM animals
    JOIN species ON animals.species_id = species.id
    JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon'
    AND owners.full_name = 'Jennifer Orwell';
SELECT name AS non_esc_animals
FROM animals
    INNER JOIN owners ON animals.owner_id = owners.id
WHERE animals.owner_id = (
        SELECT id
        FROM owners
        WHERE full_name = 'Dean Winchester'
    )
    AND animals.escape_attempts = 0;
SELECT owners.full_name,
    COUNT(*) AS num_animals_owned
FROM animals
    JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY num_animals_owned DESC
LIMIT 1;
SELECT animals.name
FROM animals
    JOIN visits ON visits.animal_id = animals.id
    JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;
SELECT COUNT(DISTINCT animal_id)
FROM visits
    JOIN vets ON vets.id = visits.vet_id
    JOIN animals ON animals.id = visits.animal_id
WHERE vets.name = 'Stephanie Mendez';
SELECT vets.name,
    species.name AS specialty
FROM vets
    LEFT JOIN specializations ON vets.id = specializations.vet_id
    LEFT JOIN species ON specializations.species_id = species.id
ORDER BY vets.name;
SELECT animals.*
FROM animals
    INNER JOIN visits ON animals.id = visits.animal_id
    INNER JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
    AND visits.visit_date >= '2020-04-01'
    AND visits.visit_date <= '2020-08-30';
SELECT animals.name,
    COUNT(visits.animal_id) AS num_visits
FROM animals
    JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.id
ORDER BY num_visits DESC
LIMIT 1;
SELECT animals.name,
    MIN(visits.visit_date) AS first_visit_date
FROM animals
    JOIN visits ON animals.id = visits.animal_id
    JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name
ORDER BY first_visit_date ASC
LIMIT 1;
SELECT animals.name,
    vets.name,
    visits.visit_date
FROM visits
    JOIN animals ON visits.animal_id = animals.id
    JOIN vets ON visits.vet_id = vets.id
WHERE visits.visit_date = (
        SELECT MAX(visit_date)
        FROM visits
    );
SELECT COUNT(*)
FROM visits
    JOIN vets ON visits.vet_id = vets.id
    JOIN animals ON visits.animal_id = animals.id
    JOIN specializations ON vets.id = specializations.vet_id
WHERE specializations.species_id != animals.species_id;
SELECT species.name
FROM visits
    JOIN vets ON visits.vet_id = vets.id
    JOIN animals ON visits.animal_id = animals.id
    JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;