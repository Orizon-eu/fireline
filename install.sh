#!/usr/bin/env bash
# Fireline Installation Script
# Copyright (c) 2024 Orizon - https://fireline.orizon.one
#
# Simple installation script for public releases

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
INSTALL_DIR="${FIRELINE_INSTALL_DIR:-$HOME/.fireline}"
BIN_DIR="${FIRELINE_BIN_DIR:-$HOME/.local/bin}"
GITHUB_REPO="Orizon-eu/fireline"
VERSION="${FIRELINE_VERSION:-latest}"
BASE_URL="https://github.com/${GITHUB_REPO}/releases"

# Banner
print_banner() {
    echo -e "${CYAN}"
    cat << "EOF"
  _____ _          _ _
 |  ___(_)_ __ ___| (_)_ __   ___
 | |_  | | '__/ _ \ | | '_ \ / _ \
 |  _| | | | |  __/ | | | | |  __/
 |_|   |_|_|  \___|_|_|_| |_|\___|

EOF
    echo -e "${NC}"
    echo -e "${BLUE}AI-Powered Penetration Testing Assistant${NC}"
    echo -e "${BLUE}https://fireline.orizon.one${NC}"
    echo ""
}

# Logging
info() { echo -e "${CYAN}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# Check command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect OS and architecture
detect_platform() {
    local os arch
    
    # Detect OS
    case "$(uname -s)" in
        Linux*)  os="linux";;
        Darwin*) os="darwin";;
        *)       error "Unsupported OS: $(uname -s)";;
    esac
    
    # Detect architecture
    case "$(uname -m)" in
        x86_64|amd64)   arch="x86_64";;
        aarch64|arm64)  arch="aarch64";;
        *)              error "Unsupported architecture: $(uname -m)";;
    esac
    
    echo "${os}-${arch}"
}

# Get latest version from GitHub
get_latest_version() {
    info "Fetching latest version..."
    
    local version
    if command_exists curl; then
        version=$(curl -sL "${BASE_URL}/latest" | grep -oP 'tag/v\K[0-9]+\.[0-9]+\.[0-9]+-?[a-z]*' | head -1)
    else
        error "curl is required but not installed"
    fi
    
    if [ -z "$version" ]; then
        error "Could not determine latest version"
    fi
    
    echo "$version"
}

# Download and install
install_fireline() {
    print_banner
    
    # Detect platform
    info "Detecting platform..."
    local platform
    platform=$(detect_platform)
    success "Detected: $platform"
    
    # Get version
    if [ "$VERSION" = "latest" ]; then
        VERSION=$(get_latest_version)
        success "Latest version: v$VERSION"
    fi
    
    # Build download URL
    local archive_name="fireline-${VERSION}-${platform}.tar.gz"
    local download_url="${BASE_URL}/download/v${VERSION}/${archive_name}"
    
    info "Downloading Fireline v${VERSION}..."
    
    # Create temp directory
    local tmp_dir
    tmp_dir=$(mktemp -d)
    trap "rm -rf $tmp_dir" EXIT
    
    # Download
    cd "$tmp_dir"
    if ! curl -fsSL -o "$archive_name" "$download_url"; then
        error "Failed to download from: $download_url"
    fi
    
    # Download and verify checksum if available
    if curl -fsSL -o "${archive_name}.sha256" "${download_url}.sha256" 2>/dev/null; then
        info "Verifying checksum..."
        
        if command_exists sha256sum; then
            echo "$(cat ${archive_name}.sha256)  ${archive_name}" | sha256sum -c - || error "Checksum verification failed"
        elif command_exists shasum; then
            echo "$(cat ${archive_name}.sha256)  ${archive_name}" | shasum -a 256 -c - || error "Checksum verification failed"
        else
            warn "Cannot verify checksum (sha256sum/shasum not found)"
        fi
        
        success "Checksum verified"
    fi
    
    # Extract
    info "Extracting archive..."
    tar -xzf "$archive_name"
    
    # Create directories
    mkdir -p "$BIN_DIR"
    mkdir -p "$INSTALL_DIR"
    
    # Install binary
    info "Installing to $BIN_DIR/fireline..."
    mv fireline "$BIN_DIR/fireline"
    chmod +x "$BIN_DIR/fireline"
    
    success "Fireline installed successfully!"
    echo ""
    
    # Check PATH
    case ":$PATH:" in
        *":$BIN_DIR:"*) ;;
        *)
            warn "$BIN_DIR is not in your PATH"
            echo ""
            echo "Add this to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
            echo ""
            echo -e "  ${GREEN}export PATH=\"\$PATH:$BIN_DIR\"${NC}"
            echo ""
            echo "Then reload: ${GREEN}source ~/.bashrc${NC}"
            echo ""
            ;;
    esac
    
    # Next steps
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}🎉 Installation Complete!${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}📝 Next Steps:${NC}"
    echo ""
    echo "1. Get your API key from:"
    echo -e "   ${BLUE}https://fireline.orizon.one${NC}"
    echo ""
    echo "2. Run Fireline:"
    echo -e "   ${GREEN}fireline${NC}"
    echo ""
    echo "3. Follow the first-run setup wizard"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  Important Reminders:${NC}"
    echo "   • ONLY use for authorized security testing"
    echo "   • Docker/Podman required for full functionality"
    echo "   • Get written authorization before testing"
    echo ""
    echo -e "${BLUE}📚 Documentation: https://fireline.orizon.one${NC}"
    echo -e "${BLUE}📧 Support: info@orizon.one${NC}"
    echo ""
}

# Run installation
install_fireline
