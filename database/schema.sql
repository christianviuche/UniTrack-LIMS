-- FILE: database/schema.sql
-- UniTrack LIMS Schema for PostgreSQL (Supabase)

-- 1. FACULTIES Table 
CREATE TABLE faculties (
    faculty_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    dean_name VARCHAR(100)
);

-- 2. ACADEMIC_PROGRAMS Table
CREATE TABLE academic_programs (
    program_id SERIAL PRIMARY KEY,
    faculty_id INTEGER NOT NULL REFERENCES faculties(faculty_id),
    name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. LABORATORIES Table 
CREATE TABLE laboratories (
    lab_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    location_description VARCHAR(255)
);

-- 4. PROGRAM_LAB_RELATIONSHIP
-- Permite que un Programa use muchos Labs, y un Lab sirva a muchos Programas.
CREATE TABLE program_lab_relationship (
    program_lab_id SERIAL PRIMARY KEY,
    program_id INTEGER NOT NULL REFERENCES academic_programs(program_id) ON DELETE CASCADE,
    lab_id INTEGER NOT NULL REFERENCES laboratories(lab_id) ON DELETE CASCADE, 
    -- Restricción para asegurar que no haya duplicados
    UNIQUE (program_id, lab_id) 
);

-- 5. LOCATIONS Table 
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    lab_id INTEGER NOT NULL REFERENCES laboratories(lab_id),
    code VARCHAR(50) NOT NULL UNIQUE, -- Ej., FRIDGE-A-SHELF-3
    description TEXT
);

-- 6. RESEARCH_PROJECTS Table 
CREATE TABLE research_projects (
    project_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    principal_investigator VARCHAR(100),
    start_date DATE
);

-- 7. SAMPLES Table 
CREATE TABLE samples (
    sample_id SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES research_projects(project_id),
    location_id INTEGER NOT NULL REFERENCES locations(location_id),

    sample_type VARCHAR(50) NOT NULL, 
    status VARCHAR(50) NOT NULL DEFAULT 'Available',
    date_acquired DATE,
    notes TEXT
);

-- Índices para mejorar el rendimiento en búsquedas por FK
CREATE INDEX idx_samples_project ON samples(project_id);
CREATE INDEX idx_samples_location ON samples(location_id);
