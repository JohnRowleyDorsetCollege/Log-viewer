#!/bin/bash
set -e

echo "🚀 Setting up Blazor Log Viewer..."

# Trust the dev cert
dotnet dev-certs https --trust 2>/dev/null || true

# Only scaffold if the solution doesn't already exist
if [ ! -f "LogViewer.sln" ]; then
  echo "📦 Scaffolding solution..."

  # Create solution
  dotnet new sln -n LogViewer

  # Create Blazor Server project
  dotnet new blazorserver -n LogViewer.Web -f net8.0 --no-restore

  # Add to solution
  dotnet sln LogViewer.sln add LogViewer.Web/LogViewer.Web.csproj

  # Add NuGet packages
  echo "📥 Installing packages..."
  cd LogViewer.Web

  dotnet add package Microsoft.EntityFrameworkCore.Sqlite
  dotnet add package Microsoft.EntityFrameworkCore.Design
  dotnet add package MudBlazor
  dotnet add package Microsoft.Extensions.Http

  cd ..

  echo "✅ Scaffold complete."
else
  echo "✅ Solution already exists, restoring packages..."
  dotnet restore
fi

echo ""
echo "✅ Ready! Run: cd LogViewer.Web && dotnet watch run"
