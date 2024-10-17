FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

COPY src/*.csproj ./src/
RUN dotnet restore ./src/MatchService.csproj

COPY src/ ./src/
RUN dotnet publish ./src/MatchService.csproj -c Release -o /out


FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /out .

EXPOSE 8080

CMD ["dotnet", "MatchService.dll"]