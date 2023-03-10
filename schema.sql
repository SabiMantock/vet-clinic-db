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