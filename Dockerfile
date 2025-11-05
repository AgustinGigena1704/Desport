# Dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar archivos de proyecto
COPY ["src/CCC.Shared/CCC.Shared.csproj", "src/CCC.Shared/"]
COPY ["src/CCC.Api/CCC.Api.csproj", "src/CCC.Api/"]

# Restaurar dependencias
RUN dotnet restore "src/CCC.Api/CCC.Api.csproj"

# Copiar todo el código fuente
COPY . .

# Build y Publish
WORKDIR "/src/src/CCC.Api"
RUN dotnet build "CCC.Api.csproj" -c Release -o /app/build
RUN dotnet publish "CCC.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Imagen final
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Instalar certificados SSL
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

COPY --from=build /app/publish .

# Variables de entorno
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

ENTRYPOINT ["dotnet", "CCC.Api.dll"]