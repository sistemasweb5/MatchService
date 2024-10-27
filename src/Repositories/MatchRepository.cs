using Dapper;
using MatchService.Data.Interfaces;
using MatchService.Domain.Entities;
using MatchService.Repositories.Interfaces;

namespace MatchService.Repositories;

public class MatchService : IMatchRepository
{
    private readonly IDbConnectionFactory _dbConnection;

    public MatchService(IDbConnectionFactory dbConnection)
    {
        _dbConnection = dbConnection;
    }
    public async Task<IEnumerable<Client>> GetAllAsync(string jobType, double radius, double longitude, double latitude)
    {
        const string sql = "";

        using var connection = await _dbConnection.CreateConnectionAsync();
        return await connection.QueryAsync<Client>(sql);
    }
}
