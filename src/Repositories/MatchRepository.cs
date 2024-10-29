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

    public async Task<IEnumerable<Client>> GetAllAsync(string idJob, double radius)
    {
        const string sql = @"
        WITH job_info AS (
        SELECT j.id AS job_id, j.job_type, j.localization_id AS job_location
        FROM jobs j
        WHERE j.id = @idJob
        ),
        workers_with_specialty AS (
            SELECT c.id AS worker_id, c.localization_id AS worker_location
            FROM client c
            JOIN specialty s ON c.id = s.user_client_id
            WHERE s.name = (SELECT job_type FROM job_info)
        )
        SELECT
            w.worker_id,
            ST_DistanceSphere(l.geom, jl.geom) AS distance_meters
        FROM workers_with_specialty w
        JOIN localization l ON w.worker_location = l.id
        JOIN localization jl ON jl.id = (SELECT job_location FROM job_info)
        WHERE ST_DWithin(
            l.geom::geography,jl.geom::geography,@radius);    
        ";

        using var connection = await _dbConnection.CreateConnectionAsync();
        return await connection.QueryAsync<Client>(sql, new { idJob, radius });
    }
}
