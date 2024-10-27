CREATE TABLE IF NOT EXISTS category (
    id UUID PRIMARY KEY,
    rol VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS localization (
    id UUID PRIMARY KEY,
    name varchar(100),
    geom GEOMETRY(Point, 4326)
);

CREATE TABLE IF NOT EXISTS specialty (
    id UUID PRIMARY KEY,
    name VARCHAR NOT NULL,
    user_client_id UUID NOT NULL
);

CREATE TABLE IF NOT EXISTS workSchedule (
    id UUID PRIMARY KEY,
    startTime VARCHAR NOT NULL,
    endTime VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS client (
    id UUID PRIMARY KEY,
    localization_id UUID NOT NULL,
    name VARCHAR NOT NULL,
    emailAddress VARCHAR NOT NULL,
    categoryId UUID NOT NULL,
    workScheduleId UUID NOT NULL
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

INSERT INTO localization (id, name, geom) VALUES 
  (gen_random_uuid(), 'Location E', ST_GeomFromText('POINT(-66.156800, -17.389500)', 4326)),
  (gen_random_uuid(), 'Location F', ST_GeomFromText('POINT(-66.170000, -17.500000)', 4326)),
  (gen_random_uuid(), 'Location D', ST_GeomFromText('POINT(-66.190000, -17.983333)', 4326));

INSERT INTO workSchedule (id, startTime, endTime) VALUES 
  ('550e8400-e29b-41d4-a716-446655440006', '08:00', '17:00'), 
  ('550e8400-e29b-41d4-a716-446655440007', '09:00', '18:00'), 
  ('550e8400-e29b-41d4-a716-446655440008', '22:00', '06:00'), 
  ('550e8400-e29b-41d4-a716-446655440009', '12:00', '20:00'), 
  ('550e8400-e29b-41d4-a716-446655440010', '07:00', '15:00');

INSERT INTO client (id, localization_id ,name, emailAddress, categoryId, workScheduleId) VALUES
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location A') ,'John Doe', 'john@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location B') ,'Jane Smith', 'jane@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location C') ,'Mike Brown', 'mike@example.com', (SELECT id FROM category WHERE rol = 'worker'), '550e8400-e29b-41d4-a716-446655440006');

INSERT INTO jobs (id, user_client_id, user_worker_id, localization_id, created_at, job_type, status, description, price) VALUES
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'John Doe'), (SELECT id FROM client WHERE name = 'Mike Brown'), (SELECT id FROM localization WHERE name = 'Location A'), NOW(), 'electrician', 'assigned', 'Job description for Job 1', 100.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Jane Smith'), (SELECT id FROM client WHERE name = 'Mike Brown'), (SELECT id FROM localization WHERE name = 'Location B'), NOW(), 'plumber', 'working', 'Job description for Job 2', 200.00);
    