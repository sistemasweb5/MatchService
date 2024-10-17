using MatchService.Infrastructure;
using MatchService.RequestPipeline;

var builder = WebApplication.CreateBuilder(args);

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
