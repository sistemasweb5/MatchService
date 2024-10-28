namespace MatchService.Repositories.Interfaces;

public interface IRepository<T> where T : class
{
    Task<IEnumerable<T>> GetAllAsync(string jobType, double radius, double longitude, double latitude);
}
