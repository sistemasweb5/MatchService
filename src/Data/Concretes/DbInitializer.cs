using System.Reflection;
using DbUp;
using MatchService.Data.Interfaces;
using Microsoft.Extensions.Options;

namespace MatchService.Data.Concretes
{
    public class DbInitializer : IDbInitializer
    {
        private readonly DatabaseOptions _options;
        
        public DbInitializer(IOptions<DatabaseOptions> options)
        {
            _options = options.Value;
        }
        public void InitializeDatabase()
        {
            EnsureDatabase.For.PostgresqlDatabase(_options.DefaultConnection);
            var dpUp = DeployChanges.To
            .PostgresqlDatabase(_options.DefaultConnection)
            .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly())
            .WithTransaction()
            .LogToConsole()
            .Build();
            var result = dpUp.PerformUpgrade();
            if (!result.Successful)
            {
                Console.WriteLine("Invalid Migrations");
            }
        }
    }
}
