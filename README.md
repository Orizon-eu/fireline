# 🔥 Fireline

### AI-Powered Penetration Testing CLI

[![License: Proprietary](https://img.shields.io/badge/License-Proprietary-red.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20Windows-blue.svg)](#supported-platforms)
[![Latest Release](https://img.shields.io/github/v/release/Orizon-eu/fireline)](https://github.com/Orizon-eu/fireline/releases/latest)
[![Status](https://img.shields.io/badge/Status-Alpha%20%7C%20Invite%20Only-orange.svg)](#alpha-access)

**Fireline** is an intelligent CLI tool developed by **[Orizon](https://orizon.one)** for authorized penetration testing and red team operations. It combines advanced AI reasoning with containerized security tools to provide an adaptive assistant for security professionals.

> ⚠️ **AUTHORIZED USE ONLY** - This tool is designed exclusively for authorized security testing with explicit written permission. Unauthorized use is illegal and may result in criminal prosecution.

---

## 🚧 Alpha Access - Invite Only

**Fireline is currently in private alpha testing.**

- 🔒 This repository is private and access is by invitation only
- 📧 To request alpha access, contact: **info@orizon.one**
- ✅ Approved testers will receive a GitHub invitation
- 📚 See [ALPHA_TESTER_GUIDE.md](ALPHA_TESTER_GUIDE.md) after receiving access

**Why Alpha?**
- We're actively testing core features
- Gathering feedback from security professionals
- Refining AI models and tool integrations
- Ensuring stability before public release

**Alpha Program Benefits:**
- Early access to cutting-edge AI pentesting capabilities
- Direct input on features and roadmap
- Priority support from the Orizon team
- Free API usage during alpha period
- Recognition as an alpha contributor

---

## 🚀 Quick Installation (Alpha Testers Only)

### Prerequisites

1. **GitHub Access**: You must have been invited as a collaborator
2. **GitHub CLI**: Install `gh` if you haven't already
   ```bash
   # macOS
   brew install gh

   # Linux (Debian/Ubuntu)
   curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
   sudo apt update && sudo apt install gh

   # Windows (PowerShell)
   winget install --id GitHub.cli
   ```

3. **Authenticate**: `gh auth login`

### Installation Commands

#### Linux / macOS

```bash
# Download and run installation script
gh release download --repo Orizon-eu/fireline --pattern 'install.sh'
chmod +x install.sh
./install.sh
```

Or use our helper script:
```bash
curl -sSL https://raw.githubusercontent.com/Orizon-eu/fireline/main/alpha-install.sh | bash
```

#### Windows (PowerShell as Administrator)

```powershell
# Download and run installation script
gh release download --repo Orizon-eu/fireline --pattern 'install.ps1'
.\install.ps1
```

**📖 Detailed Instructions**: See [ALPHA_TESTER_GUIDE.md](ALPHA_TESTER_GUIDE.md)

---

## 📦 Manual Download (Alpha Testers)

Download binaries directly from releases:

```bash
# List available releases
gh release list --repo Orizon-eu/fireline

# Download specific version
gh release download v0.1.0-alpha --repo Orizon-eu/fireline --pattern '*linux-x86_64*'
```

Available platforms:
- **Linux**: x86_64, ARM64
- **macOS**: Intel (x86_64), Apple Silicon (ARM64)
- **Windows**: x64

All downloads include SHA256 checksums for verification.

---

## 🔧 Requirements

### System Requirements
- **Docker** or **Podman** - Required for containerized security tools
- **4GB RAM minimum** (8GB+ recommended)
- **10GB free disk space**
- **Internet connection** for AI model access

### Account Requirements
- **Fireline API Key** - Provided during alpha (free)
- **GitHub Account** - With collaborator access to this repository

### Supported Platforms

- ✅ Linux (x86_64, aarch64) - Ubuntu 20.04+, Debian 11+, Fedora 36+
- ✅ macOS (Intel, Apple Silicon) - macOS 12.0+
- ✅ Windows (x64) - Windows 10/11 with WSL2

---

## 🎯 Features

- **🤖 AI-Powered Analysis** - Advanced reasoning for complex penetration testing scenarios
- **🛠️ 20+ Security Tools** - Nmap, Nuclei, SQLMap, Metasploit, and more
- **🐳 Container Isolation** - Sandboxed execution of security tools
- **📊 Engagement Management** - Organized sessions with notes, findings, and evidence
- **🔄 Full Kill Chain** - Recon → Scanning → Exploitation → Post-Exploitation → Reporting
- **💼 Enterprise Ready** - Usage tracking, cost management, centralized billing

---

## 🚀 Getting Started (Alpha Testers)

### 1. Verify Access

Ensure you have been added as a collaborator:
```bash
gh repo view Orizon-eu/fireline
```

If you see "permission denied", contact info@orizon.one

### 2. Install Fireline

Follow the installation commands above.

### 3. Get Your API Key

During alpha, API keys are provided free of charge:
- Check your invitation email for your personal API key
- Or contact info@orizon.one to request one

### 4. Configure

```bash
# Configuration will be created automatically on first run
fireline

# Or manually create config
mkdir -p ~/.fireline
cat > ~/.fireline/.env << EOF
FIRELINE_API_KEY=fl_alpha_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
FIRELINE_MODEL=fireline-assault
EOF
```

### 5. Run Fireline

```bash
fireline --version
fireline --help
fireline  # Start interactive mode
```

---

## 📖 Documentation

- **Alpha Tester Guide**: [ALPHA_TESTER_GUIDE.md](ALPHA_TESTER_GUIDE.md)
- **Website**: [orizon.one/fireline](https://orizon.one/fireline)
- **Support**: info@orizon.one (Alpha testers only)
- **Issues**: Report bugs and feedback via [GitHub Issues](https://github.com/Orizon-eu/fireline/issues)

---

## 🐛 Reporting Issues (Alpha Testers)

As an alpha tester, your feedback is crucial:

1. **Check Existing Issues**: Avoid duplicates
2. **Use Issue Templates**: Bug report, feature request, or tool request
3. **Be Detailed**: Include logs, screenshots, steps to reproduce
4. **Tag Appropriately**: Use `alpha`, `bug`, `enhancement` labels

**Priority Support**: Alpha testers get priority responses within 24 hours.

---

## 🗺️ Roadmap to Public Release

**Current Status**: Alpha (Private, Invite Only)

**Upcoming Phases**:
- [ ] **Alpha** (Q4 2024) - Invite only, core features, feedback gathering
- [ ] **Closed Beta** (Q1 2025) - Expanded testing, stability improvements
- [ ] **Open Beta** (Q2 2025) - Public access, pricing introduction
- [ ] **General Availability** (Q3 2025) - Full public release

**Alpha Focus Areas**:
- Core AI reasoning and decision-making
- Tool integration and containerization
- Engagement workflow and reporting
- API stability and performance
- Documentation and user experience

---

## 🔒 Security Notice

**⚠️ AUTHORIZED USE ONLY - LEGAL REQUIREMENTS ⚠️**

Fireline is developed for **authorized** penetration testing and security research only.

**YOU MUST:**
- ✅ Obtain explicit **written authorization** before testing
- ✅ Define clear **scope boundaries**
- ✅ Comply with **GDPR, CCPA**, and applicable regulations
- ✅ Maintain **comprehensive activity logs**
- ✅ Follow **responsible disclosure** practices

**CRIMINAL PENALTIES:**

Unauthorized access is a **criminal offense** under:
- 🇺🇸 Computer Fraud and Abuse Act (CFAA) - 18 U.S.C. § 1030
- 🇬🇧 Computer Misuse Act 1990
- 🇪🇺 EU Directive 2013/40/EU
- 🌍 Similar laws worldwide

**By using Fireline, you acknowledge full understanding and acceptance of these terms.**

---

## 📝 License

**Proprietary Software** - See [LICENSE](LICENSE) for full terms.

This is proprietary software owned by Orizon. All rights reserved.
Use requires a valid Fireline API key and acceptance of license terms.

---

## 🌟 About Orizon

**Fireline** is developed and maintained by **[Orizon](https://orizon.one)**

*Cybersecurity company specializing in AI-powered security solutions*

### Contact

- **Alpha Access Requests**: info@orizon.one
- **Technical Support**: info@orizon.one
- **Security Issues**: info@orizon.one
- **Website**: https://orizon.one

---

## 🙏 Alpha Testers

Thank you to our alpha testers for their valuable feedback and contributions.

Alpha contributors will be recognized in the public release.

---

**⚠️ ALPHA SOFTWARE DISCLAIMER**

This is alpha software under active development. Features may change, break, or be removed without notice. Use in production environments is not recommended. Always test in isolated lab environments.

---

**Made with ❤️ by the Orizon Security Team**
