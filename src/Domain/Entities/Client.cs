namespace MatchService.Domain.Entities;
public class Client
{
    public Guid Id { get; set; }
    public Guid LocalizationId { get; set; }
    public required string Name { get; set; }
    public required string EmailAddress { get; set; }
    public Guid CategoryId { get; set; }
    public Guid WorkScheduleId { get; set; }
}
