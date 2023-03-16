CREATE DATABASE clinic;
CREATE TABLE patients(
    id BIGSERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE medical_histories(
    id BIGSERIAL NOT NULL,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(100)
);
CREATE TABLE invoices (
    id BIGSERIAL NOT NULL,
    total_amount DECIMAL NOT NULL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_history(id),
    PRIMARY KEY(id)
);
CREATE TABLE treatments (
    id BIGSERIAL NOT NULL,
    type VARCHAR(100) NOT NULL
    name VARCHAR(100) NOT NULL,
    treatments(id) INT REFERENCES medical_history(id),
    treatment_id INT REFERENCES treatments(id),
    PRIMARY KEY(id)
)