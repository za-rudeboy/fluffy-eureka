FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["FluffyEureka/FluffyEureka.Web/FluffyEureka.Web.csproj", "FluffyEureka.Web/"]
COPY ["FluffyEureka/FluffyEureka.ServiceDefaults/FluffyEureka.ServiceDefaults.csproj", "FluffyEureka.ServiceDefaults/"]
COPY ["FluffyEureka/FluffyEureka.ApiService/FluffyEureka.ApiService.csproj", "FluffyEureka.ApiService/"]
RUN dotnet restore "FluffyEureka.Web/FluffyEureka.Web.csproj"
COPY FluffyEureka/ .
RUN dotnet build "FluffyEureka.Web/FluffyEureka.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "FluffyEureka.Web/FluffyEureka.Web.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "FluffyEureka.Web.dll"]