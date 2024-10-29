using MatchService.Domain.Entities;
using MatchService.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace MatchService.Controllers;

[ApiController]
[Route("api/v1/client")]

public class MatchController : ControllerBase
{
  private readonly IMatchServices _matchServices;
  
  public MatchController(IMatchServices matchServices)
  {
    _matchServices = matchServices;
  }

  [HttpGet("match")]
    [ProducesResponseType(typeof(IEnumerable<Client>), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetAll(string jobType, double radius)
    {
        var matchClient = await _matchServices.GetAllAsync(jobType, radius);
      
        return Ok(matchClient);
    }
}
