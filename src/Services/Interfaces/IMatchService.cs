using MatchService.Domain.Entities;

namespace MatchService.Services.Interfaces;
public interface IMatchServices
{
    Task<IEnumerable<Client>> GetAllAsync(string jobType, double radius);
}
