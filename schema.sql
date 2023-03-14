/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id BIGSERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN,
    weight_kg DECIMAL NOT NULL,
    PRIMARY KEY(id)
);
ALTER TABLE animals
ADD COLUMN species VARCHAR;
CREATE TABLE owners (
    id BIGSERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);
ALTER TABLE owners ADD COLUMN email VARCHAR(120);
CREATE TABLE species (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255)
);
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals
ADD species_id INT;
ALTER TABLE animals
ADD CONSTRAINT foreign_key_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals
ADD owner_id INT;
ALTER TABLE animals
ADD CONSTRAINT foreign_key_owners FOREIGN KEY (owner_id) REFERENCES owners(id);
CREATE TABLE vets (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(225) NOT NULL,
    age INT,
    date_of_graduation DATE
);
CREATE TABLE specializations(
    vet_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id),
    PRIMARY KEY(vet_id, species_id)
);
CREATE TABLE visits (
    id BIGSERIAL PRIMARY KEY,
    animal_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    visit_date DATE NOT NULL
);
CREATE INDEX visits_animal_id_index ON visits (animal_id);
CREATE INDEX visits_vets_id_index ON visits (vets_id);