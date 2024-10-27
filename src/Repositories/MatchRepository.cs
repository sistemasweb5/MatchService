using Dapper;
using MatchService.Data.Interfaces;
using MatchService.Domain.Entities;
using MatchService.Repositories.Interfaces;

namespace MatchService.Repositories;

public class MatchRepository : IMatchRepository
{
    private readonly IDbConnectionFactory _dbConnection;

    public MatchRepository(IDbConnectionFactory dbConnection)
    {
        _dbConnection = dbConnection;
    }

    public async Task<IEnumerable<Client>> GetAllAsync(string jobType, double radius)
    {
        const string sql = @"
            WITH WorkerSpecialties AS (
                SELECT 
                    c.id AS worker_id,
                    c.name AS worker_name,
                    s.name AS specialty_name,
                    l.geom AS worker_location
                FROM 
                    client c
                INNER JOIN specialty s ON c.id = s.user_client_id
                INNER JOIN localization l ON c.localization_id = l.id
                WHERE 
                    c.categoryId = (SELECT id FROM category WHERE rol = 'worker')
            )
            SELECT 
                j.id AS job_id,
                j.job_type,
                j.status,
                j.description,
                j.price,
                j.created_at,
                ws.worker_id,
                ws.worker_name,
                ws.specialty_name,
                ST_Distance(l.geom, ws.worker_location) AS distance_meters
            FROM 
                jobs j
            INNER JOIN localization l ON j.localization_id = l.id
            INNER JOIN WorkerSpecialties ws ON j.job_type = ws.specialty_name
                AND ST_DWithin(l.geom, ws.worker_location, @radius)  
            WHERE 
                j.status IN ('not assigned')
                AND j.job_type = @jobType;    
        ";

        using var connection = await _dbConnection.CreateConnectionAsync();
        return await connection.QueryAsync<Client>(sql, new { jobType, radius });
    }
}
