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