using MatchService.Data.Interfaces;

namespace MatchService.RequestPipeline;
public static class WebApplicationExtensions
{
    public static WebApplication InitializeDatabase(this WebApplication app)
    {
        using (var scope = app.Services.CreateScope())
        {
            var dbInitializer = scope.ServiceProvider.GetRequiredService<IDbInitializer>();
            dbInitializer.InitializeDatabase();
            return app;
        }
    }
}
