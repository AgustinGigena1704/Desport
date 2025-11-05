# Dockerfile.Blazor
# Stage 1: Build the Blazor WebAssembly app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia el archivo de la solución y los proyectos relevantes para Blazor
COPY *.sln .
COPY src/CCC.Shared/*.csproj src/CCC.Shared/
COPY src/CCC/*.csproj src/CCC/

# Restaura dependencias
RUN dotnet restore

# Copia todo el código fuente
COPY . .

# Publica la aplicación Blazor WebAssembly con la base href correcta
WORKDIR /app/src/CCC # Cambia a la carpeta de tu proyecto Blazor
RUN dotnet publish -c Release -o /app/output --no-build /p:BasePath=/