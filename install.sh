#!/usr/bin/env bash
# Fireline Installation Script
# Copyright (c) 2024 Orizon - https://orizon.one
#
# Usage:
#   curl -sSL https://orizon.one/fireline/install.sh | bash
#   wget -qO- https://orizon.one/fireline/install.sh | bash

set -e

# Configuration
INSTALL_DIR="${FIRELINE_INSTALL_DIR:-$HOME/.fireline}"
BIN_DIR="${FIRELINE_BIN_DIR:-$HOME/.local/bin}"
GITHUB_REPO="Orizon-eu/fireline"
VERSION="${FIRELINE_VERSION:-latest}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
print_banner() {
    echo -e "${CYAN}"
    cat << "EOF"
  _____ _          _ _
 |  ___(_)_ __ ___| (_)_ __   ___
 | |_  | | '__/ _ \ | | '_ \ / _ \
 |  _| | | | |  __/ | | | | |  __/
 |_|   |_|_|  \___|_|_|_| |_|\___|
     🧪 ALPHA VERSION 🧪
EOF
    echo -e "${NC}"
    echo -e "${BLUE}AI-Powered Penetration Testing CLI${NC}"
    echo -e "${BLUE}Developed by Orizon | https://orizon.one${NC}"
    echo -e "${YELLOW}⚠️  ALPHA SOFTWARE - FOR AUTHORIZED TESTERS ONLY${NC}"
    echo ""
}

# Logging functions
info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Detect OS and Architecture
detect_platform() {
    local os arch

    # Detect OS
    case "$(uname -s)" in
        Linux*)     os="linux";;
        Darwin*)    os="darwin";;
        MINGW*|MSYS*|CYGWIN*) os="windows";;
        *)          error "Unsupported operating system: $(uname -s)";;
    esac

    # Detect Architecture
    case "$(uname -m)" in
        x86_64|amd64)   arch="x86_64";;
        aarch64|arm64)  arch="aarch64";;
        armv7l)         arch="armv7";;
        *)              error "Unsupported architecture: $(uname -m)";;
    esac

    echo "${os}-${arch}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Download file
download() {
    local url="$1"
    local output="$2"

    if command_exists curl; then
        curl -fsSL "$url" -o "$output"
    elif command_exists wget; then
        wget -q "$url" -O "$output"
    else
        error "Neither curl nor wget is available. Please install one of them."
    fi
}

# Verify checksum
verify_checksum() {
    local file="$1"
    local expected="$2"

    if command_exists sha256sum; then
        local actual=$(sha256sum "$file" | cut -d' ' -f1)
    elif command_exists shasum; then
        local actual=$(shasum -a 256 "$file" | cut -d' ' -f1)
    else
        warn "Unable to verify checksum (sha256sum/shasum not found)"
        return 0
    fi

    if [ "$actual" != "$expected" ]; then
        error "Checksum verification failed!\n  Expected: $expected\n  Got: $actual"
    fi
}

# Main installation function
install_fireline() {
    print_banner

    info "Detecting platform..."
    local platform=$(detect_platform)
    success "Detected platform: $platform"

    # Fetch version FIRST, before building any URLs
    if [ "$VERSION" = "latest" ]; then
        info "Fetching latest alpha version..."
        if command_exists curl; then
            local latest_version=$(curl -sL "https://api.github.com/repos/${GITHUB_REPO}/releases/latest" | grep '"tag_name"' | cut -d'"' -f4 | sed 's/^v//')
            if [ -n "$latest_version" ]; then
                VERSION="$latest_version"
                success "Latest version: $VERSION"
            else
                VERSION="0.1.0"
                warn "Unable to fetch latest version, using default $VERSION"
            fi
        else
            VERSION="0.1.0"
            warn "curl not available, using default version $VERSION"
        fi
    fi

    # Now build URLs with the resolved VERSION
    local binary_name="fireline"
    local ext="tar.gz"
    
    if [[ "$platform" == windows-* ]]; then
        binary_name="fireline.exe"
        ext="zip"
    fi

    local archive_name="fireline-${VERSION}-${platform}.${ext}"
    local download_url="https://github.com/${GITHUB_REPO}/releases/download/v${VERSION}/${archive_name}"
    local checksum_url="https://github.com/${GITHUB_REPO}/releases/download/v${VERSION}/${archive_name}.sha256"

    info "Downloading Fireline v${VERSION} for ${platform}..."

    # Create temporary directory
    local tmp_dir=$(mktemp -d)
    trap "rm -rf $tmp_dir" EXIT

    # Download archive
    if ! download "$download_url" "$tmp_dir/$archive_name"; then
        error "Failed to download Fireline.\nThis could mean:\n1. The release assets are not published yet\n2. Your platform is not supported\n3. Network connection issues\n\nPlatform requested: $platform\nRelease version: v${VERSION}\n\nContact: info@orizon.one"
    fi

    # Download and verify checksum (optional but recommended)
    if download "$checksum_url" "$tmp_dir/$archive_name.sha256" 2>/dev/null; then
        local expected_checksum=$(cat "$tmp_dir/$archive_name.sha256")
        info "Verifying checksum..."
        verify_checksum "$tmp_dir/$archive_name" "$expected_checksum"
        success "Checksum verified"
    else
        warn "Checksum verification skipped (checksum file not available)"
    fi

    # Extract archive
    info "Extracting archive..."
    if [[ "$ext" == "zip" ]]; then
        unzip -q "$tmp_dir/$archive_name" -d "$tmp_dir"
    else
        tar -xzf "$tmp_dir/$archive_name" -C "$tmp_dir"
    fi

    # Create directories
    mkdir -p "$BIN_DIR"
    mkdir -p "$INSTALL_DIR"

    # Install binary
    info "Installing to $BIN_DIR/$binary_name..."
    mv "$tmp_dir/$binary_name" "$BIN_DIR/$binary_name"
    chmod +x "$BIN_DIR/$binary_name"

    # Install additional files if present
    if [ -f "$tmp_dir/.env.example" ]; then
        cp "$tmp_dir/.env.example" "$INSTALL_DIR/.env.example"
    fi

    success "Fireline installed successfully!"
    echo ""

    # Check if bin directory is in PATH
    case ":$PATH:" in
        *":$BIN_DIR:"*) ;;
        *)
            warn "$BIN_DIR is not in your PATH"
            echo ""
            echo "Add this line to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
            echo ""
            echo -e "  ${GREEN}export PATH=\"\$PATH:$BIN_DIR\"${NC}"
            echo ""
            echo "Then reload your shell:"
            echo ""
            echo -e "  ${GREEN}source ~/.bashrc${NC}  # or ~/.zshrc"
            echo ""
            ;;
    esac

    # Next steps
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}🎉 Installation Complete!${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "Next steps:"
    echo ""
    echo "1. Get your Fireline API key:"
    echo -e "   ${BLUE}https://orizon.one/fireline${NC}"
    echo ""
    echo "2. Configure your environment:"
    echo -e "   ${GREEN}cp $INSTALL_DIR/.env.example ~/.fireline/.env${NC}"
    echo -e "   ${GREEN}nano ~/.fireline/.env${NC}"
    echo ""
    echo "3. Start using Fireline:"
    echo -e "   ${GREEN}fireline --version${NC}"
    echo -e "   ${GREEN}fireline --help${NC}"
    echo -e "   ${GREEN}fireline${NC}"
    echo ""
    echo -e "Documentation: ${BLUE}https://docs.orizon.one/fireline${NC}"
    echo -e "Support: ${BLUE}support@orizon.one${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  AUTHORIZED USE ONLY${NC}"
    echo -e "This tool is for authorized penetration testing only."
    echo -e "Unauthorized use is illegal and may result in prosecution."
    echo ""
}

# Run installation
install_fireline
