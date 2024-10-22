namespace MatchService.Domain;

public class Match
{
    public Guid Id { get; set; }
    public required string User { get; set; }
    public required string Worker { get; set; }
    public required string JobType { get; set; } 
}
