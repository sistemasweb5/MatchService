using System.Data;

namespace MatchService.Data.Interfaces;

public interface IDbConnectionFactory
{
    Task<IDbConnection> CreateConnectionAsync();
}
