namespace MatchService.Domain;

public class Match
{
    public Guid Id { get; set; }
    public required Guid User { get; set; }
    public required Guid Worker { get; set; }
    public required string JobType { get; set; } 
}
