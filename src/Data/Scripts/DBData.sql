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
  (gen_random_uuid(), 'Location A', ST_GeomFromText('POINT(-66.156800 -17.389500)', 4326)),
  (gen_random_uuid(), 'Location B', ST_GeomFromText('POINT(-66.170000 -17.500000)', 4326)),
  (gen_random_uuid(), 'Location C', ST_GeomFromText('POINT(-66.190000 -17.983333)', 4326)),
  (gen_random_uuid(), 'Location D', ST_GeomFromText('POINT(-66.158000 -17.389000)', 4326)),
  (gen_random_uuid(), 'Location E', ST_GeomFromText('POINT(-66.157500 -17.388000)', 4326)),
  (gen_random_uuid(), 'Location F', ST_GeomFromText('POINT(-66.155000 -17.390500)', 4326)),
  (gen_random_uuid(), 'Location G', ST_GeomFromText('POINT(-66.154500 -17.392000)', 4326)), 
  (gen_random_uuid(), 'Location H', ST_GeomFromText('POINT(-66.159000 -17.391000)', 4326)),
  (gen_random_uuid(), 'Location I', ST_GeomFromText('POINT(-66.160000 -17.389800)', 4326)),
  (gen_random_uuid(), 'Location J', ST_GeomFromText('POINT(-66.161000 -17.387500)', 4326)),
  (gen_random_uuid(), 'Location K', ST_GeomFromText('POINT(-66.162000 -17.390000)', 4326)),
  (gen_random_uuid(), 'Location L', ST_GeomFromText('POINT(-66.158500 -17.388500)', 4326)),
  (gen_random_uuid(), 'Location M', ST_GeomFromText('POINT(-66.157000 -17.389200)', 4326)),
  (gen_random_uuid(), 'Location N', ST_GeomFromText('POINT(-66.156500 -17.391000)', 4326)),
  (gen_random_uuid(), 'Location O', ST_GeomFromText('POINT(-66.155500 -17.392500)', 4326)), 
  (gen_random_uuid(), 'Location P', ST_GeomFromText('POINT(-66.159500 -17.390200)', 4326)),
  (gen_random_uuid(), 'Location Q', ST_GeomFromText('POINT(-66.160500 -17.388800)', 4326)),
  (gen_random_uuid(), 'Location R', ST_GeomFromText('POINT(-66.161500 -17.387800)', 4326)),
  (gen_random_uuid(), 'Location Q', ST_GeomFromText('POINT(-66.160500 -17.238800)', 4326));

INSERT INTO client (id, localization_id, name, emailAddress, categoryId, workScheduleId) VALUES
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location A' LIMIT 1), 'John Doe', 'john@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location B' LIMIT 1), 'Jane Smith', 'jane@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location C' LIMIT 1), 'Mike Brown', 'mike@example.com', (SELECT id FROM category WHERE rol = 'worker'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location D' LIMIT 1), 'Alice Blue', 'alice.blue@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location E' LIMIT 1), 'Bob Green', 'bob.green@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location F' LIMIT 1), 'Charlie Black', 'charlie.black@example.com', (SELECT id FROM category WHERE rol = 'worker'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location G' LIMIT 1), 'Diana White', 'diana.white@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location H' LIMIT 1), 'Evan Red', 'evan.red@example.com', (SELECT id FROM category WHERE rol = 'worker'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location I' LIMIT 1), 'Fiona Pink', 'fiona.pink@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location J' LIMIT 1), 'George Yellow', 'george.yellow@example.com', (SELECT id FROM category WHERE rol = 'worker'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location K' LIMIT 1), 'Hannah Gray', 'hannah.gray@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location L' LIMIT 1), 'Ian Orange', 'ian.orange@example.com', (SELECT id FROM category WHERE rol = 'worker'), '550e8400-e29b-41d4-a716-446655440006'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location M' LIMIT 1), 'Julia Purple', 'julia.purple@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440006');


INSERT INTO specialty (id, name, user_client_id) VALUES 
    (gen_random_uuid(), 'Plumber', 'd37d0729-1e6c-47a4-80ec-3e28a2d2b9ed'),
    (gen_random_uuid(), 'Electrician', 'f1b7d156-2833-4e2c-b426-b59bf60f894c'),
    (gen_random_uuid(), 'Painter', '3c2c628f-53c2-4d40-8478-929a60405369'),
    (gen_random_uuid(), 'Carpenter', '40216a9e-ac20-4d0b-9ad1-bb128ec00397'),
    (gen_random_uuid(), 'Locksmith', '57857d88-c082-44f7-8982-5085f149fabb');

INSERT INTO jobs (id, user_client_id, user_worker_id, localization_id, created_at, job_type, status, description, price) VALUES
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'John Doe' LIMIT 1), (SELECT id FROM client WHERE name = 'Mike Brown'), (SELECT id FROM localization WHERE name = 'Location A'), NOW(), 'electrician', 'assigned', 'Job description for Job 1', 100.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Jane Smith' LIMIT 1), (SELECT id FROM client WHERE name = 'Mike Brown'), (SELECT id FROM localization WHERE name = 'Location B'), NOW(), 'plumber', 'working', 'Job description for Job 2', 200.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Alice Blue' LIMIT 1), (SELECT id FROM client WHERE name = 'Charlie Black'), (SELECT id FROM localization WHERE name = 'Location D'), NOW(), 'carpenter', 'working', 'Job description for Job 3', 150.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Bob Green' LIMIT 1), (SELECT id FROM client WHERE name = 'Evan Red'), (SELECT id FROM localization WHERE name = 'Location E'), NOW(), 'painter', 'working', 'Job description for Job 4', 120.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Diana White' LIMIT 1), (SELECT id FROM client WHERE name = 'George Yellow'), (SELECT id FROM localization WHERE name = 'Location G'), NOW(), 'gardener', 'assigned', 'Job description for Job 5', 90.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Fiona Pink' LIMIT 1), (SELECT id FROM client WHERE name = 'Charlie Black'), (SELECT id FROM localization WHERE name = 'Location I'), NOW(), 'electrician', 'working', 'Job description for Job 6', 110.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Hannah Gray' LIMIT 1), (SELECT id FROM client WHERE name = 'Ian Orange'), (SELECT id FROM localization WHERE name = 'Location K'), NOW(), 'plumber', 'working', 'Job description for Job 7', 200.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Ian Orange' LIMIT 1), (SELECT id FROM client WHERE name = 'Charlie Black'), (SELECT id FROM localization WHERE name = 'Location L'), NOW(), 'cleaner', 'working', 'Job description for Job 8', 80.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Julia Purple' LIMIT 1), (SELECT id FROM client WHERE name = 'Evan Red'), (SELECT id FROM localization WHERE name = 'Location M'), NOW(), 'mechanic', 'assigned', 'Job description for Job 9', 130.00);

    