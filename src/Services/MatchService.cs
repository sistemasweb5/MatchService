using MatchService.Domain.Entities;
using MatchService.Repositories.Interfaces;
using MatchService.Services.Interfaces;

namespace MatchService.Services;

public class MatchServices : IMatchServices
{

  private readonly IMatchRepository _matchRepository;

  public MatchServices(IMatchRepository matchRepository)
  {
    _matchRepository = matchRepository;
  }

  public async Task<IEnumerable<Client>> GetAllAsync(string jobType, double radius)
  {
    return await _matchRepository.GetAllAsync(jobType, radius);;
  }

}
