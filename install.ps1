# Fireline Installation Script for Windows
# Copyright (c) 2024 Orizon - https://orizon.one
#
# Usage:
#   PowerShell (Admin):
#   irm https://orizon.one/fireline/install.ps1 | iex
#
#   Or:
#   Invoke-WebRequest -Uri "https://orizon.one/fireline/install.ps1" -OutFile "install.ps1"
#   .\install.ps1

$ErrorActionPreference = "Stop"

# Configuration
$InstallDir = if ($env:FIRELINE_INSTALL_DIR) { $env:FIRELINE_INSTALL_DIR } else { "$env:USERPROFILE\.fireline" }
$BinDir = if ($env:FIRELINE_BIN_DIR) { $env:FIRELINE_BIN_DIR } else { "$env:LOCALAPPDATA\Programs\Fireline" }
$GitHubRepo = "Orizon-eu/fireline"
$Version = if ($env:FIRELINE_VERSION) { $env:FIRELINE_VERSION } else { "latest" }

# Colors
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Write-Info {
    param([string]$Message)
    Write-ColorOutput "[INFO] $Message" "Cyan"
}

function Write-Success {
    param([string]$Message)
    Write-ColorOutput "[SUCCESS] $Message" "Green"
}

function Write-Warning {
    param([string]$Message)
    Write-ColorOutput "[WARNING] $Message" "Yellow"
}

function Write-Error {
    param([string]$Message)
    Write-ColorOutput "[ERROR] $Message" "Red"
    exit 1
}

# Banner
function Show-Banner {
    Write-Host ""
    Write-ColorOutput "  _____ _          _ _" "Cyan"
    Write-ColorOutput " |  ___(_)_ __ ___| (_)_ __   ___" "Cyan"
    Write-ColorOutput " | |_  | | '__/ _ \ | | '_ \ / _ \" "Cyan"
    Write-ColorOutput " |  _| | | | |  __/ | | | | |  __/" "Cyan"
    Write-ColorOutput " |_|   |_|_|  \___|_|_|_| |_|\___|" "Cyan"
    Write-Host ""
    Write-ColorOutput "AI-Powered Penetration Testing CLI" "Blue"
    Write-ColorOutput "Developed by Orizon | https://orizon.one" "Blue"
    Write-Host ""
}

# Detect platform
function Get-Platform {
    $arch = if ([Environment]::Is64BitOperatingSystem) { "x86_64" } else { "i686" }
    return "windows-$arch"
}

# Download file
function Download-File {
    param(
        [string]$Url,
        [string]$OutFile
    )

    try {
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $Url -OutFile $OutFile -UseBasicParsing
    } catch {
        Write-Error "Failed to download from $Url"
    }
}

# Verify checksum
function Verify-Checksum {
    param(
        [string]$File,
        [string]$ExpectedHash
    )

    $actualHash = (Get-FileHash -Path $File -Algorithm SHA256).Hash

    if ($actualHash -ne $ExpectedHash) {
        Write-Error "Checksum verification failed!`n  Expected: $ExpectedHash`n  Got: $actualHash"
    }
}

# Add to PATH
function Add-ToPath {
    param([string]$Directory)

    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

    if ($currentPath -notlike "*$Directory*") {
        Write-Info "Adding $Directory to PATH..."
        $newPath = "$currentPath;$Directory"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        $env:Path = "$env:Path;$Directory"
        Write-Success "Added to PATH (restart terminal to apply)"
    }
}

# Main installation
function Install-Fireline {
    Show-Banner

    Write-Info "Detecting platform..."
    $platform = Get-Platform
    Write-Success "Detected platform: $platform"

    # Fetch latest version from GitHub API
    if ($Version -eq "latest") {
        Write-Info "Fetching latest release from GitHub..."
        try {
            $apiUrl = "https://api.github.com/repos/$GitHubRepo/releases/latest"
            $release = Invoke-RestMethod -Uri $apiUrl -UseBasicParsing
            $Version = $release.tag_name -replace '^v', ''
            Write-Success "Latest version: $Version"
        } catch {
            $Version = "0.1.0"
            Write-Warning "Unable to fetch latest version, using $Version"
        }
    }

    # Construct GitHub Releases URLs
    $archiveName = "fireline-$Version-$platform.zip"
    $downloadUrl = "https://github.com/$GitHubRepo/releases/download/v$Version/$archiveName"
    $checksumUrl = "https://github.com/$GitHubRepo/releases/download/v$Version/$archiveName.sha256"

    Write-Info "Downloading Fireline v$Version for $platform..."

    # Create temporary directory
    $tmpDir = New-Item -ItemType Directory -Path "$env:TEMP\fireline-install-$(Get-Random)" -Force

    try {
        # Download archive
        $archivePath = "$tmpDir\$archiveName"
        Download-File -Url $downloadUrl -OutFile $archivePath

        # Download and verify checksum
        try {
            $checksumPath = "$tmpDir\$archiveName.sha256"
            Download-File -Url $checksumUrl -OutFile $checksumPath
            $expectedChecksum = (Get-Content $checksumPath).Trim()
            Write-Info "Verifying checksum..."
            Verify-Checksum -File $archivePath -ExpectedHash $expectedChecksum
            Write-Success "Checksum verified"
        } catch {
            Write-Warning "Checksum verification skipped (checksum file not available)"
        }

        # Extract archive
        Write-Info "Extracting archive..."
        Expand-Archive -Path $archivePath -DestinationPath $tmpDir -Force

        # Create directories
        New-Item -ItemType Directory -Path $BinDir -Force | Out-Null
        New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null

        # Install binary
        Write-Info "Installing to $BinDir\fireline.exe..."
        Copy-Item "$tmpDir\fireline.exe" "$BinDir\fireline.exe" -Force

        # Install additional files
        if (Test-Path "$tmpDir\.env.example") {
            Copy-Item "$tmpDir\.env.example" "$InstallDir\.env.example" -Force
        }

        # Add to PATH
        Add-ToPath -Directory $BinDir

        Write-Success "Fireline installed successfully!"
        Write-Host ""

        # Next steps
        Write-ColorOutput "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "Cyan"
        Write-ColorOutput "🎉 Installation Complete!" "Green"
        Write-ColorOutput "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "Cyan"
        Write-Host ""
        Write-Host "Next steps:"
        Write-Host ""
        Write-Host "1. Get your Fireline API key:"
        Write-ColorOutput "   https://orizon.one/fireline" "Blue"
        Write-Host ""
        Write-Host "2. Configure your environment:"
        Write-ColorOutput "   Copy-Item '$InstallDir\.env.example' '$env:USERPROFILE\.fireline\.env'" "Green"
        Write-ColorOutput "   notepad '$env:USERPROFILE\.fireline\.env'" "Green"
        Write-Host ""
        Write-Host "3. Restart your terminal and run:"
        Write-ColorOutput "   fireline --version" "Green"
        Write-ColorOutput "   fireline --help" "Green"
        Write-ColorOutput "   fireline" "Green"
        Write-Host ""
        Write-ColorOutput "Documentation: https://docs.orizon.one/fireline" "Blue"
        Write-ColorOutput "Support: support@orizon.one" "Blue"
        Write-Host ""
        Write-ColorOutput "⚠️  AUTHORIZED USE ONLY" "Yellow"
        Write-Host "This tool is for authorized penetration testing only."
        Write-Host "Unauthorized use is illegal and may result in prosecution."
        Write-Host ""

    } finally {
        # Cleanup
        Remove-Item -Path $tmpDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Run installation
Install-Fireline
