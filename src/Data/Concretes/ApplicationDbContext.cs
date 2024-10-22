using Microsoft.EntityFrameworkCore;
using MatchService.Domain;

namespace MatchService.Data.Concretes;

public class ApplicationDbContext : DbContext
{
    public DbSet<Match> Match { get; set; }

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }
}
