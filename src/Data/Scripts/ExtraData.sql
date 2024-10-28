INSERT INTO specialty (id, name, user_client_id)
SELECT 
    gen_random_uuid(),          
    'electrician',              
    id                         
FROM 
    client
WHERE 
    categoryId = (SELECT id FROM category WHERE rol = 'worker');

INSERT INTO localization (id, name, geom) VALUES 
  (gen_random_uuid(), 'Location D', ST_GeomFromText('POINT(-66.160000 -17.400000)', 4326)),
  (gen_random_uuid(), 'Location E', ST_GeomFromText('POINT(-66.155000 -17.389000)', 4326)),
  (gen_random_uuid(), 'Location F', ST_GeomFromText('POINT(-66.169000 -17.501000)', 4326));

INSERT INTO workSchedule (id, startTime, endTime) VALUES 
  ('550e8400-e29b-41d4-a716-446655440011', '10:00', '19:00'), 
  ('550e8400-e29b-41d4-a716-446655440012', '11:00', '20:00'), 
  ('550e8400-e29b-41d4-a716-446655440013', '06:00', '14:00');

INSERT INTO client (id, localization_id, name, emailAddress, categoryId, workScheduleId) VALUES
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location D'), 'Alice Green', 'alice@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440011'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location E'), 'Carlos Santos', 'carlos@example.com', (SELECT id FROM category WHERE rol = 'user'), '550e8400-e29b-41d4-a716-446655440012'),
    (gen_random_uuid(), (SELECT id FROM localization WHERE name = 'Location F'), 'Eva Thompson', 'eva@example.com', (SELECT id FROM category WHERE rol = 'worker'), '550e8400-e29b-41d4-a716-446655440013');

INSERT INTO jobs (id, user_client_id, user_worker_id, localization_id, created_at, job_type, status, description, price) VALUES
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Alice Green'), (SELECT id FROM client WHERE name = 'Eva Thompson'), (SELECT id FROM localization WHERE name = 'Location D'), NOW(), 'electrician', 'not assigned', 'Electrician work needed in Location D', 150.00),
    (gen_random_uuid(), (SELECT id FROM client WHERE name = 'Carlos Santos'), (SELECT id FROM client WHERE name = 'Eva Thompson'), (SELECT id FROM localization WHERE name = 'Location E'), NOW(), 'electrician', 'assigned', 'Electrician maintenance work at Location E', 250.00);


INSERT INTO specialty (id, name, user_client_id)
SELECT 
    gen_random_uuid(),          
    'electrician',              
    id                         
FROM 
    client
WHERE 
    categoryId = (SELECT id FROM category WHERE rol = 'worker')
    AND name IN ('Eva Thompson');
