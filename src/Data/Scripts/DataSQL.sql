CREATE TABLE IF NOT EXISTS category (
    id UUID PRIMARY KEY,
    rol VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS localization (
    id UUID PRIMARY KEY,
    name varchar(100)
);

CREATE TABLE IF NOT EXISTS client (
    id UUID PRIMARY KEY,
    localization_id UUID NOT NULL,
    name VARCHAR NOT NULL,
    emailAddress VARCHAR NOT NULL,
    categoryId UUID NOT NULL
);

CREATE TABLE IF NOT EXISTS jobs (
    id UUID PRIMARY KEY,
    user_client_id UUID NOT NULL,
    user_worker_id UUID NOT NULL,
    localization_id UUID NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    job_type VARCHAR(50) NOT NULL, 
    status VARCHAR(20) NOT NULL CHECK (status IN ('not assigned', 'assigned', 'on the way', 'working', 'done')),
    description TEXT,
    price DECIMAL(10, 2),
    CONSTRAINT fk_localization FOREIGN KEY (localization_id) REFERENCES localization(id) 
);

INSERT INTO category (id, rol) VALUES
    (gen_random_uuid(), 'user'),
    (gen_random_uuid(), 'worker');

INSERT INTO localization (id, name) VALUES
    (gen_random_uuid(), 'Location 1'),
    (gen_random_uuid(), 'Location 2'),
    (gen_random_uuid(), 'Location 3');

INSERT INTO client (id, localization_id ,name, emailAddress, categoryId) VALUES
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location 1') ,'John Doe', 'john@example.com', (SELECT id FROM category WHERE rol = 'user')),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location 2') ,'Jane Smith', 'jane@example.com', (SELECT id FROM category WHERE rol = 'user')),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location 3') ,'Mike Brown', 'mike@example.com', (SELECT id FROM category WHERE rol = 'worker'));

INSERT INTO jobs (id, user_client_id, user_worker_id, localization_id, created_at, job_type, status, description, price) VALUES
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'John Doe'), (SELECT id FROM client WHERE name = 'Mike Brown'), (SELECT id FROM localization WHERE name = 'Location 1'), NOW(), 'electrician', 'assigned', 'Job description for Job 1', 100.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Jane Smith'), (SELECT id FROM client WHERE name = 'Mike Brown'), (SELECT id FROM localization WHERE name = 'Location 2'), NOW(), 'plumber', 'working', 'Job description for Job 2', 200.00);