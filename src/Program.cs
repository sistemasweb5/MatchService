using MatchService.Infrastructure;
using MatchService.RequestPipeline;
using Microsoft.EntityFrameworkCore;
using MatchService.Data.Concretes;
using MatchService.Domain;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<ApplicationDbContext>(options =>
        options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddInfraestructure(builder.Configuration);

var app = builder.Build();
app.InitializeDatabase();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c => {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Match Service - API V1 ");
        c.RoutePrefix = string.Empty;
    });
}
app.UseHttpsRedirection();
app.Run();
