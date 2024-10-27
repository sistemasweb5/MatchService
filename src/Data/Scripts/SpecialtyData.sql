INSERT INTO specialty (id, name, user_client_id)
SELECT 
    gen_random_uuid(),          
    'electrician',              
    id                         
FROM 
    client
WHERE 
    categoryId = (SELECT id FROM category WHERE rol = 'worker');

