using MatchService.Data;
using MatchService.Data.Concretes;
using MatchService.Data.Interfaces;
using MatchService.Repositories;
using MatchService.Repositories.Interfaces;

namespace MatchService.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfraestructure(this IServiceCollection services, IConfiguration configuration)
    {
        services
            .AddDataBase(configuration)
            .AddRepositories();

        return services;
    }
    private static IServiceCollection AddDataBase(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<DatabaseOptions>(configuration.GetSection(DatabaseOptions.ConnectionStrings));
        services.AddScoped<IDbConnectionFactory, DbConnection>();
        services.AddScoped<IDbInitializer, DbInitializer>();
        return services;
    }

    private static IServiceCollection AddRepositories(this IServiceCollection services)
    {
        services.AddScoped<IMatchRepository, MatchRepository>();
        return services;
    }
}
