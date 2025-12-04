#!/usr/bin/env bash
# Fireline Alpha Installation Script
# Copyright (c) 2024 Orizon - https://orizon.one
#
# This script is for ALPHA TESTERS ONLY with GitHub collaborator access

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="${FIRELINE_INSTALL_DIR:-$HOME/.fireline}"
BIN_DIR="${FIRELINE_BIN_DIR:-$HOME/.local/bin}"
GITHUB_REPO="Orizon-eu/fireline"
VERSION="${FIRELINE_VERSION:-latest}"

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
    echo ""
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

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check GitHub CLI
check_gh_cli() {
    if ! command_exists gh; then
        error "GitHub CLI (gh) is not installed. Please install it first:

macOS:     brew install gh
Linux:     See https://cli.github.com/
Windows:   winget install --id GitHub.cli

Then run: gh auth login"
    fi
}

# Check GitHub authentication
check_gh_auth() {
    info "Checking GitHub authentication..."

    if ! gh auth status >/dev/null 2>&1; then
        error "You are not authenticated with GitHub CLI.

Please run:    gh auth login

Then try this installation script again."
    fi

    success "GitHub authenticated"
}

# Check repository access
check_repo_access() {
    info "Verifying access to private repository..."

    if ! gh repo view "$GITHUB_REPO" >/dev/null 2>&1; then
        error "You don't have access to $GITHUB_REPO

This could mean:
1. You haven't accepted the GitHub invitation yet
2. You haven't been invited to the alpha program
3. Your invitation has expired

To request alpha access, contact: info@orizon.one"
    fi

    success "Repository access confirmed"
}

# Detect OS and Architecture
detect_platform() {
    local os arch

    # Detect OS
    case "$(uname -s)" in
        Linux*)     os="linux";;
        Darwin*)    os="darwin";;
        *)          error "Unsupported operating system: $(uname -s)";;
    esac

    # Detect Architecture
    case "$(uname -m)" in
        x86_64|amd64)   arch="x86_64";;
        aarch64|arm64)  arch="aarch64";;
        *)              error "Unsupported architecture: $(uname -m)";;
    esac

    echo "${os}-${arch}"
}

# Get latest version
get_latest_version() {
    info "Fetching latest alpha version..."

    local version
    version=$(gh release list --repo "$GITHUB_REPO" --limit 1 | awk '{print $1}' | sed 's/^v//')

    if [ -z "$version" ]; then
        error "No releases found. The alpha version may not be published yet.

Contact: info@orizon.one"
    fi

    echo "$version"
}

# Download and install
install_fireline() {
    print_banner

    # Prerequisites checks
    check_gh_cli
    check_gh_auth
    check_repo_access

    info "Detecting platform..."
    local platform
    platform=$(detect_platform)
    success "Detected platform: $platform"

    # Get version
    if [ "$VERSION" = "latest" ]; then
        VERSION=$(get_latest_version)
        success "Latest version: $VERSION"
    fi

    # Determine file extension
    local ext="tar.gz"
    local archive_name="fireline-${VERSION}-${platform}.${ext}"

    info "Downloading Fireline v${VERSION} for ${platform}..."

    # Create temporary directory
    local tmp_dir
    tmp_dir=$(mktemp -d)
    trap "rm -rf $tmp_dir" EXIT

    # Download using gh CLI (handles private repo authentication)
    cd "$tmp_dir"

    if ! gh release download "v${VERSION}" --repo "$GITHUB_REPO" --pattern "${archive_name}*"; then
        error "Failed to download Fireline.

This could mean:
1. The release assets are not published yet
2. Your platform is not supported
3. Network connection issues

Platform requested: $platform
Release version: v${VERSION}

Contact: info@orizon.one"
    fi

    # Verify download
    if [ ! -f "$archive_name" ]; then
        error "Downloaded file not found: $archive_name"
    fi

    # Verify checksum if available
    if [ -f "${archive_name}.sha256" ]; then
        info "Verifying checksum..."

        local expected
        expected=$(cat "${archive_name}.sha256")

        if command_exists sha256sum; then
            local actual
            actual=$(sha256sum "$archive_name" | cut -d' ' -f1)

            if [ "$actual" != "$expected" ]; then
                error "Checksum verification failed!
  Expected: $expected
  Got: $actual"
            fi
        elif command_exists shasum; then
            local actual
            actual=$(shasum -a 256 "$archive_name" | cut -d' ' -f1)

            if [ "$actual" != "$expected" ]; then
                error "Checksum verification failed!
  Expected: $expected
  Got: $actual"
            fi
        else
            warn "Unable to verify checksum (sha256sum/shasum not found)"
        fi

        success "Checksum verified"
    fi

    # Extract archive
    info "Extracting archive..."
    tar -xzf "$archive_name"

    # Create directories
    mkdir -p "$BIN_DIR"
    mkdir -p "$INSTALL_DIR"

    # Install binary
    info "Installing to $BIN_DIR/fireline..."
    mv fireline "$BIN_DIR/fireline"
    chmod +x "$BIN_DIR/fireline"

    # Install additional files if present
    if [ -f ".env.example" ]; then
        cp ".env.example" "$INSTALL_DIR/.env.example"
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
    echo -e "${YELLOW}🧪 ALPHA TESTER NEXT STEPS:${NC}"
    echo ""
    echo "1. Configure your API key (from your invitation email):"
    echo -e "   ${GREEN}mkdir -p ~/.fireline${NC}"
    echo -e "   ${GREEN}nano ~/.fireline/.env${NC}"
    echo ""
    echo "   Add:"
    echo -e "   ${BLUE}FIRELINE_API_KEY=fl_alpha_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx${NC}"
    echo -e "   ${BLUE}FIRELINE_MODEL=fireline-assault${NC}"
    echo ""
    echo "2. Verify installation:"
    echo -e "   ${GREEN}fireline --version${NC}"
    echo ""
    echo "3. Read the alpha tester guide:"
    echo -e "   ${BLUE}https://github.com/Orizon-eu/fireline/blob/main/ALPHA_TESTER_GUIDE.md${NC}"
    echo ""
    echo "4. Start using Fireline:"
    echo -e "   ${GREEN}fireline${NC}"
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}📞 ALPHA SUPPORT:${NC}"
    echo -e "   Email: ${BLUE}info@orizon.one${NC}"
    echo -e "   Issues: ${BLUE}https://github.com/Orizon-eu/fireline/issues${NC}"
    echo -e "   Docs: ${BLUE}https://github.com/Orizon-eu/fireline${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  IMPORTANT REMINDERS:${NC}"
    echo "   • This is ALPHA software - expect bugs"
    echo "   • Test ONLY in isolated lab environments"
    echo "   • Report all bugs and feedback"
    echo "   • NEVER use on production systems"
    echo "   • ALWAYS have written authorization"
    echo ""
    echo -e "${GREEN}Thank you for being an alpha tester! 🔥${NC}"
    echo ""
}

# Run installation
install_fireline
